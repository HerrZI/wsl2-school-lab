#!/bin/bash
#
# wsl-setup-workshop.sh
# Bereitet eine WSL-Instanz (z. B. frisch installiertes Ubuntu) fuer das
# Arbeitsblatt "Linux-Kommandozeile zum Anfassen" vor - ohne SSH-Server.
# Es werden nur Uebungsbenutzer und die Uebungsdatei angelegt.
#
# Aufruf:   sudo ./wsl-setup-workshop.sh [ANZAHL]     (Standard: 2)
# Beispiel: sudo ./wsl-setup-workshop.sh 2
#
# Benutzer:     user01 .. userNN
# Passwoerter:  akademie01 .. akademieNN
# Uebungsdatei: /srv/workshop/server.log
#
# Danach arbeitet man wie im Workshop als Uebungsbenutzer, z. B.:
#   su - user01                      (innerhalb der laufenden WSL-Shell)
#   wsl -d <Distro> -u user01        (aus der PowerShell heraus)
#
# Aufraeumen: sudo ./wsl-teardown-workshop.sh

set -euo pipefail

ANZAHL="${1:-2}"
GRUPPE="workshop"
LOGQUELLE="$(dirname "$0")/server.log"

if [[ $EUID -ne 0 ]]; then
  echo "Bitte mit sudo ausfuehren: sudo $0 [ANZAHL]" >&2
  exit 1
fi

if [[ ! "$ANZAHL" =~ ^[0-9]+$ ]] || (( ANZAHL < 1 || ANZAHL > 99 )); then
  echo "ANZAHL muss eine Zahl zwischen 1 und 99 sein." >&2
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

echo "==> $ANZAHL Uebungsbenutzer anlegen"
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

  # Home-Verzeichnis abschotten: andere Uebungsbenutzer koennen nicht hineinschauen.
  chmod 700 "/home/$USERNAME"

  echo "    $USERNAME angelegt (Passwort: $PASSWORT)"
done

echo
echo "=========================================================="
echo " Fertig. Die Uebungsumgebung fuer das Arbeitsblatt steht:"
echo "   Uebungsdatei:  /srv/workshop/server.log"
echo "   Benutzer:      user01 .. user$(printf "%02d" "$ANZAHL")   Passwort: akademieNN"
echo
echo " So wird man zum Uebungsbenutzer:"
echo "   su - user01                   # in dieser Shell"
echo "   wsl -d <Distro> -u user01     # aus der PowerShell"
echo
echo " Teil I des Arbeitsblatts braucht nur das Home-Verzeichnis,"
echo " Teil II holt sich die Logdatei mit:"
echo "   cp /srv/workshop/server.log ~/workshop/logs/"
echo
echo " Wieder alles entfernen: sudo ./wsl-teardown-workshop.sh"
echo "=========================================================="
