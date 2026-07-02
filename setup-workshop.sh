#!/bin/bash
#
# setup-workshop.sh
# Legt Workshop-Benutzer an, verteilt die Uebungsdatei und startet SSH.
# Aufruf:   sudo ./setup-workshop.sh [ANZAHL]     (Standard: 40)
# Beispiel: sudo ./setup-workshop.sh 40
#
# Benutzer:   user01 .. user40
# Passwoerter: akademie01 .. akademie40
# Uebungsdatei: /srv/workshop/server.log
#
# ACHTUNG: Die Passwoerter sind bewusst simpel. Diesen Server NUR im
# lokalen Veranstaltungsnetz betreiben und nach dem Workshop mit
# teardown-workshop.sh wieder aufraeumen.

set -euo pipefail

ANZAHL="${1:-40}"
GRUPPE="workshop"
LOGQUELLE="$(dirname "$0")/server.log"

if [[ $EUID -ne 0 ]]; then
  echo "Bitte mit sudo ausfuehren: sudo $0 [ANZAHL]" >&2
  exit 1
fi

if [[ ! -f "$LOGQUELLE" ]]; then
  echo "server.log nicht gefunden (erwartet neben dem Skript: $LOGQUELLE)" >&2
  exit 1
fi

echo "==> Gruppe '$GRUPPE' anlegen (dient spaeter dem sauberen Aufraeumen)"
getent group "$GRUPPE" >/dev/null || groupadd "$GRUPPE"

echo "==> Uebungsdatei nach /srv/workshop kopieren"
mkdir -p /srv/workshop
cp "$LOGQUELLE" /srv/workshop/server.log
chmod 755 /srv/workshop
chmod 644 /srv/workshop/server.log

echo "==> $ANZAHL Benutzer anlegen"
for n in $(seq 1 "$ANZAHL"); do
  i=$(printf "%02d" "$n")
  USERNAME="user$i"
  PASSWORT="akademie$i"

  if id "$USERNAME" &>/dev/null; then
    echo "    $USERNAME existiert bereits - uebersprungen"
    continue
  fi

  useradd --create-home --shell /bin/bash --groups "$GRUPPE" "$USERNAME"
  echo "$USERNAME:$PASSWORT" | chpasswd

  # Home-Verzeichnis abschotten: Teams arbeiten nur im eigenen Bereich.
  # (Fuer den "ls /home"-Gag am Ende bewusst auf 755 aendern.)
  chmod 700 "/home/$USERNAME"

  echo "    $USERNAME angelegt (Passwort: $PASSWORT)"
done

echo "==> SSH-Server pruefen/starten"
if ! command -v sshd >/dev/null && [[ ! -x /usr/sbin/sshd ]]; then
  echo "    openssh-server fehlt - versuche Installation ..."
  if ! (apt-get update -qq && apt-get install -y -qq openssh-server); then
    echo "    WARNUNG: Installation fehlgeschlagen. Bitte manuell nachholen:"
    echo "      sudo apt install openssh-server"
  fi
fi
# Unter WSL2 laeuft systemd nur, wenn in /etc/wsl.conf aktiviert ([boot] systemd=true).
if [[ -x /usr/sbin/sshd ]] || command -v sshd >/dev/null; then
  if pidof systemd >/dev/null; then
    systemctl enable --now ssh || echo "    WARNUNG: ssh-Dienst konnte nicht gestartet werden."
  else
    (service ssh start || /usr/sbin/sshd) \
      && echo "    Hinweis (ohne systemd): SSH wurde direkt gestartet." \
      || echo "    WARNUNG: SSH konnte nicht gestartet werden - bitte manuell starten."
  fi
else
  echo "    SSH-Server nicht verfuegbar - Benutzer sind angelegt, Dienst fehlt noch."
fi

echo
echo "=========================================================="
echo " Fertig. Zugangsdaten fuer die Teilnehmer:"
echo "   ssh userNN@<IP>        Passwort: akademieNN"
echo
echo " IP-Adressen dieses Rechners:"
hostname -I | tr ' ' '\n' | grep -v '^$' | sed 's/^/   /'
echo
echo " WSL2-Hinweis: Damit andere Rechner im Netz den SSH-Dienst"
echo " erreichen, unter Windows den gespiegelten Netzwerkmodus"
echo " aktivieren (.wslconfig: [wsl2] networkingMode=mirrored)"
echo " oder eine Portweiterleitung einrichten:"
echo "   netsh interface portproxy add v4tov4 listenport=22 connectport=22 connectaddress=<WSL-IP>"
echo "=========================================================="
