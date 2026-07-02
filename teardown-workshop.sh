#!/bin/bash
#
# teardown-workshop.sh
# Entfernt alle mit setup-workshop.sh angelegten Benutzer samt
# Home-Verzeichnissen sowie die Uebungsdaten - rueckstandslos.
# Aufruf: sudo ./teardown-workshop.sh

set -euo pipefail

GRUPPE="workshop"

if [[ $EUID -ne 0 ]]; then
  echo "Bitte mit sudo ausfuehren: sudo $0" >&2
  exit 1
fi

if ! getent group "$GRUPPE" >/dev/null; then
  echo "Gruppe '$GRUPPE' existiert nicht - nichts zu tun."
  exit 0
fi

echo "Folgende Benutzer werden mitsamt Home-Verzeichnis GELOESCHT:"
MITGLIEDER=$(getent group "$GRUPPE" | cut -d: -f4 | tr ',' ' ')
echo "  ${MITGLIEDER:-'(keine)'}"
read -rp "Fortfahren? (ja/nein) " ANTWORT
[[ "$ANTWORT" == "ja" ]] || { echo "Abgebrochen."; exit 0; }

for USERNAME in $MITGLIEDER; do
  # laufende Sitzungen des Benutzers beenden, sonst verweigert userdel
  pkill -u "$USERNAME" 2>/dev/null || true
  sleep 0.2
  userdel --remove "$USERNAME" 2>/dev/null && echo "  $USERNAME entfernt" \
    || echo "  $USERNAME konnte nicht entfernt werden (bitte manuell pruefen)"
done

groupdel "$GRUPPE"
rm -rf /srv/workshop
echo "Aufraeumen abgeschlossen."
