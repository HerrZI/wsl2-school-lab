# Übergabe: Workshop „Linux unterrichten mit WSL2“

Stand: 28.10.2026

## Worum es geht

Ein 60-minütiger Workshop für Lehrkräfte am Regionalen Akademietag der Cisco Networking Academy. Ziel: Linux-Kommandozeile auf Windows-Schulrechnern unterrichten, entweder per WSL2 auf jedem Gerät oder über einen gemeinsamen Übungsserver, auf den sich die Klasse per SSH einloggt.

Der Workshop hat drei Stationen:

| Station | Minuten | Inhalt |
|---|---|---|
| Einstieg | 0–5 | Dilemma „Lehrplan verlangt Linux, Schule hat Windows“, Blitzumfrage |
| Demo | 5–20 | WSL2 live: Installation, `/mnt/c`, `explorer.exe .`, Klassen-Image per Export/Import, Stolperstellen |
| Hands-on | 20–49 | Teilnehmende arbeiten zu zweit per SSH auf dem Übungsserver: Teil A Mini-Rallye, Teil B Pipes-Challenge „Server-Krimi“ |
| Transfer | 49–60 | LPI-Materialien, Murmelrunde, Exit-Ticket |

## Dateien im Repo

| Datei | Zweck | Status |
|---|---|---|
| `Workshop_WSL2_Linux_unterrichten_neu.pptx` | Präsentation, 13 Folien mit Sprechernotizen, im MMBBS-Design | fertig, geprüft |
| `Arbeitsblatt_Linux_Kommandozeile.docx` | Arbeitsblatt für die Teilnehmenden, Teil A und B | fertig, geprüft |
| `Loesungsblatt_fuer_Workshopleitung.docx` | Lösungen inkl. Zahlen, die zur `server.log` passen | fertig, geprüft |
| `Handout_WSL2_im_Schulkontext.docx` | Handout zum Mitnehmen: Installation, Klassen-Image, Übungsserver, Stolperstellen, LPI, Links | fertig, Link/QR-Code fehlt noch |
| `server.log` | Übungsdatei, 210 Zeilen, fiktiver Server `srv-schule01` | fertig |
| `setup-workshop.sh` | Legt Benutzer, Gruppe, Übungsdatei und SSH auf dem Übungsserver an | fertig |
| `teardown-workshop.sh` | Räumt alles wieder ab | fertig |
| `README.md`, `CLAUDE.md`, `notes.txt`, `.gitignore` | Beschreibung, Arbeitshinweise für Claude Code, lose Notizen, Ignore-Regeln | aktuell |

Die alte Präsentation `Workshop_WSL2_Linux_unterrichten.pptx` wurde entfernt, ihr Text war mit der neuen Version identisch.

## Wichtige Zusammenhänge

- **Die Zahlen im Lösungsblatt hängen an der `server.log`.** Wer die Logdatei ändert, muss das Lösungsblatt nachziehen. Aktuell gültig: 210 Zeilen, 90 ERROR-Zeilen, 66 fehlgeschlagene SSH-Logins, Angreifer-IPs 203.0.113.42 (28), 198.51.100.7 (24), 192.0.2.99 (14), Benutzernamen pi 15, test 14, admin 13, root 13, oracle 11. Prüfen mit:

  ```bash
  wc -l server.log
  grep -c ERROR server.log
  grep -c 'Failed password' server.log
  grep 'Failed password' server.log | cut -d' ' -f14 | sort | uniq -c
  grep 'Failed password' server.log | cut -d' ' -f12 | sort | uniq -c
  ```

- **Feldnummern bei `cut`.** IP steht in Feld 14, Benutzername in Feld 12. Das gilt nur, weil alle Failed-Zeilen die Form „for invalid user NAME from IP“ haben. Das Arbeitsblatt verrät die Feldnummer bewusst nicht, die Teilnehmenden sollen selbst abzählen.
- **Das Setup-Skript erwartet `server.log` neben sich selbst** und kopiert sie nach `/srv/workshop/server.log`.
- **Festgelegte Werte:** 40 Teilnehmerkonten `user01` bis `user40` mit Passwort `akademieNN`, Image-Pfad `C:\Images\fisi-uebung.tar`, Kommentare in Befehlsblöcken mit `#`.

## Übungsserver vorbereiten

Auf einem Ubuntu-System (WSL2-Instanz, Raspberry Pi oder Mini-PC) im Veranstaltungsnetz:

```bash
sudo ./setup-workshop.sh 40      # Benutzer, Gruppe "workshop", Logdatei, SSH
```

Das Skript gibt am Ende die IP-Adressen aus. Diese IP muss vor dem Workshop auf Folie 8 eingetragen werden, dort steht der Platzhalter `10.0.0.5`. Unter WSL2 zusätzlich in `.wslconfig` den gespiegelten Netzwerkmodus aktivieren (`[wsl2] networkingMode=mirrored`, ab Windows 11 22H2) oder eine Portweiterleitung einrichten. Nach dem Workshop:

```bash
sudo ./teardown-workshop.sh      # fragt nach, löscht Benutzer, Gruppe und /srv/workshop
```

Die Passwörter sind bewusst trivial. Der Server gehört nur ins lokale Netz und wird danach abgebaut.

## Checkliste vor dem Workshop

- [ ] Übungsserver aufgesetzt, SSH von einem Windows-Rechner aus getestet (`ssh user01@<IP>`)
- [ ] IP-Adresse auf Folie 8 eingetragen
- [ ] Zugangsdaten-Zettel je Team gedruckt
- [ ] Arbeitsblatt für alle, Lösungsblatt nur für die Leitung gedruckt
- [ ] Handout gedruckt oder als PDF bereit, Link/QR-Code zum Übungspaket eingetragen (Handout Abschnitt 7 und Folie 13)
- [ ] Screenshots oder Video der WSL2-Installation als Sicherheitsnetz für die Demo
- [ ] Zwei Leihgeräte für Teilnehmende mit gesperrtem Port 22
- [ ] Präsentation einmal in PowerPoint geöffnet und Datumsfelder geprüft

## Was zuletzt gemacht wurde

**Inhaltliche Korrekturen** nach einer Konsistenzprüfung aller Dokumente:

- Handout: kaputtes Zeichen in „Übungspaket“ repariert, Image-Pfad an die Folien angeglichen.
- Arbeitsblatt: `REM` durch `#` ersetzt, Feldnummer aus dem Werkzeugkasten entfernt, Nummerierung in Teil B beginnt wieder bei 1 (zählte vorher von 7 bis 12 weiter).
- Lösungsblatt: Hinweis ergänzt, warum die Feldnummern 12 und 14 nur für diese Logdatei gelten.
- Präsentation: Notiz zu Folie 3 sprach fälschlich von „im Browser“, jetzt „per SSH aus der PowerShell“. Kontenzahl, Prompts, Kernel-Version und Zeitplan vereinheitlicht.
- Skripte: irreführender Kommentar im Setup entfernt, Teardown bricht bei einem fehlgeschlagenen `groupdel` nicht mehr ab.

**Design der Präsentation** auf die MMBBS-Vorlage umgestellt:

- Master, Layouts, Theme, Logos und eingebettete Roboto-Schrift stammen aus der offiziellen Schulvorlage `MMBBS_PPT_Vorlage_092025_Ansicht.pptx`. Die Vorlage selbst liegt bewusst nicht im Repo: Ihr Änderungsverlauf enthält Namen und eine E-Mail-Adresse von Kollegen. Sie ist über die Schule zu beziehen.
- Folie 1, 8 und 13 auf dem blauen Verlaufs-Layout mit Logo, Inhaltsfolien auf dem weißen Layout mit M-Logo, Datum, Foliennummer und gelber Linie.
- Farben auf die Schulpalette abgebildet: Gelb `FAE55F`, Beere `954161`, Dunkelblau `14508D`, Hellblau `1F87C9`/`BADCF6`, Text `1E1E1E`.
- Folieninhalte sind freie Textfelder, keine Platzhalter. Unten rechts muss Platz für das Logo bleiben.

## Offene Punkte

- Link oder QR-Code zum Übungspaket im Handout und auf Folie 13 eintragen, sobald das Material online liegt.
- Alle Änderungen sind noch nicht committet.
- Idee aus `notes.txt`: eine Browser-Konsole mit Minimal-Linux auf CloudStack als Plan B ohne jede Installation.
- `shellcheck` war auf dem Entwicklungsrechner nicht installiert, die Skripte wurden nur mit `bash -n` geprüft.

## Arbeitshinweise

- Office-Dateien sind ZIP-Archive mit XML. Text zum Prüfen extrahieren mit `unzip -p datei.docx word/document.xml`. Kleine Korrekturen gehen am sichersten direkt im XML per Python; Textläufe sind oft in mehrere `<w:t>` bzw. `<a:t>` aufgeteilt.
- Nach jeder Änderung an einer Office-Datei prüfen, ob sie noch öffnet: `soffice --headless --convert-to pdf datei.pptx`.
- Die Setup- und Teardown-Skripte brauchen root und verändern das System. Niemals auf dem Entwicklungsrechner ausführen.
- Für Arbeit mit Claude Code liest `CLAUDE.md` die Projektkonventionen automatisch ein.
