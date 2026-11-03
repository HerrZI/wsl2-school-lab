# Übergabe: Workshop „Linux unterrichten mit WSL2“

Stand: 03.11.2026

## Worum es geht

Ein 60-minütiger Workshop für Lehrkräfte am Regionalen Akademietag der Cisco Networking Academy. Ziel: Linux-Kommandozeile auf Windows-Schulrechnern unterrichten, entweder per WSL2 auf jedem Gerät oder über einen gemeinsamen Übungsserver, auf den sich die Klasse per SSH einloggt.

Der Workshop hat drei Stationen:

| Station | Minuten | Inhalt |
|---|---|---|
| Einstieg | 0–5 | Linux ist in der IT überall, Schulrechner laufen meist mit Windows; Blitzumfrage per QR-Code |
| Demo | 5–20 | Folie 4 mit den drei Kernbefehlen, dann Live-Demo des Installationspfads aus Handout Abschnitt 1 (rund 8 Minuten), `/mnt/c`, Klassen-Image per Export/Import, Stolperstellen |
| Hands-on | 20–49 | Teilnehmende arbeiten zu zweit per SSH auf dem Übungsserver: Teil A Mini-Rallye, Teil B Pipes-Challenge „Server-Krimi“ |
| Transfer | 49–60 | LPI-Materialien, Murmelrunde, Exit-Ticket |

## Dateien

| Datei | Zweck | Status |
|---|---|---|
| `Workshop_WSL2_Linux_unterrichten_neu.pptx` | Präsentation, 13 Folien mit Sprechernotizen, im MMBBS-Design | fertig, geprüft; Folie 2 final |
| `Arbeitsblatt_Linux_Kommandozeile.docx` | Arbeitsblatt für die Teilnehmenden, Teil A und B | fertig, geprüft |
| `Loesungsblatt_fuer_Workshopleitung.docx` | Lösungen inkl. Zahlen, die zur `server.log` passen | fertig, geprüft |
| `Handout_WSL2_im_Schulkontext.docx` | Handout zum Mitnehmen, 3 Seiten: Installation in acht Minuten, Alltag, Klassen-Image, Übungsserver, Stolperstellen, LPI, Links | fertig; Seite 1 eingefroren; Link/QR-Code fehlt noch |
| `server.log` | Übungsdatei, 210 Zeilen, fiktiver Server `srv-schule01` | fertig |
| `setup-workshop.sh` | Legt Benutzer, Gruppe, Übungsdatei und SSH auf dem Übungsserver an | fertig |
| `teardown-workshop.sh` | Räumt alles wieder ab | fertig |
| `Videos/` | Drei Bildschirmaufnahmen des Installationspfads (ca. 35 MB), Sicherheitsnetz für die Demo | im Repo |
| `Workshop_WSL2_Linux_unterrichten_neu (org).pptx` | Sicherungskopie des Nutzers, wird nicht bearbeitet | nur lokal, per `.gitignore` ausgeschlossen |
| `README.md`, `CLAUDE.md`, `notes.txt`, `.gitignore` | Beschreibung, Arbeitshinweise für Claude Code, lose Notizen, Ignore-Regeln | aktuell |

Nicht im Repo und bewusst ignoriert: `zrXL.png` (QR-Code-Quelle, steckt in der Präsentation), `poll.txt` (DirectPoll-Links inkl. Admin-Link), die MMBBS-Vorlage (Metadaten mit Namen und E-Mail von Kollegen).

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
- **Der Installationspfad steht an drei Stellen und muss übereinstimmen:** Handout Abschnitt 1 (vollständig, 14 Zeilen von `wsl --version` bis `exit`), Folie 4 (verkürzt auf `wsl --install`, `wsl --install Ubuntu`, `wsl`) und Sprechernotiz zu Folie 4 (führt den Handout-Pfad als Live-Demo). Die Videos zeigen denselben Pfad, Gesamtdauer rund acht Minuten.
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
- [x] Videos der WSL2-Installation als Sicherheitsnetz für die Demo (liegen lokal in `Videos/`)
- [ ] Demo-Gerät: WSL vorher deinstallieren oder Plan B aus der Notiz zu Folie 4 nutzen (bei `wsl -d Ubuntu-26.04` einsteigen)
- [ ] Zwei Leihgeräte für Teilnehmende mit gesperrtem Port 22
- [ ] Präsentation einmal in PowerPoint geöffnet, Datumsfelder, Roboto-Darstellung und Pfeil auf Folie 5 geprüft
- [ ] Blitzumfrage auf DirectPoll zurückgesetzt, Cockpit-Link griffbereit (steht nur in der lokalen `poll.txt`)

## Was bisher gemacht wurde

**Konsistenzprüfung und Korrekturen (28.10.2026):**

- Handout: kaputtes Zeichen in „Übungspaket“ repariert, Image-Pfad an die Folien angeglichen.
- Arbeitsblatt: `REM` durch `#` ersetzt, Feldnummer aus dem Werkzeugkasten entfernt, Nummerierung in Teil B beginnt wieder bei 1.
- Lösungsblatt: Hinweis ergänzt, warum die Feldnummern 12 und 14 nur für diese Logdatei gelten.
- Präsentation: Notiz zu Folie 3 sprach fälschlich von „im Browser“, jetzt „per SSH aus der PowerShell“. Kontenzahl, Prompts, Kernel-Version und Zeitplan vereinheitlicht.
- Skripte: irreführender Kommentar im Setup entfernt, Teardown bricht bei einem fehlgeschlagenen `groupdel` nicht mehr ab.

**Design der Präsentation auf die MMBBS-Vorlage umgestellt:**

- Master, Layouts, Theme und Logos aus der Schulvorlage. Folie 1, 8 und 13 auf dem blauen Verlaufs-Layout, Inhaltsfolien auf dem weißen Layout mit M-Logo, Datum, Foliennummer und gelber Linie.
- Farben: Gelb `FAE55F`, Beere `954161`, Dunkelblau `14508D`, Hellblau `1F87C9`/`BADCF6`, Text `1E1E1E`. Schrift Roboto, Code Courier New.
- Terminal-Mockups im Windows-Stil (Titelzeile, Minimieren/Maximieren/Schließen) statt macOS-Ampel.
- Folie 1: Tux in Originalfarben plus Windows-PC-Grafik, Name des Referenten in der Fußzeile.

**Inhaltliche Überarbeitung (03.11.2026):**

- Folie 2 vom Nutzer finalisiert: „Linux überall – nur nicht im Computerraum“, Blitzumfrage mit QR-Code. Gesperrt.
- Folie 3: Station 1 heißt „Demo: WSL2 auf dem (eigenen) Windows-Rechner“.
- Folie 4: Titel „WSL2: Linux, das in Windows wohnt“, fünf Punkte (VM, `wsl --install`, `wsl --install Ubuntu` mit Kaffeepause, `wsl`, kostenlos & offiziell), Terminal zeigt `wsl --install Ubuntu`. Sprechernotiz führt den vollständigen Handout-Pfad als Live-Demo mit Plan B.
- Folie 5: zweispaltig, links Karte „Windows ⟷ Linux“, rechts „Für den Unterricht heißt das:“ mit drei Punkten.
- Handout Abschnitt 1: „WSL2 in acht Minuten installieren“ mit dem erprobten Pfad (14 Befehle inkl. `cowsay`-Test), darunter „Weitere Befehle“ (`wsl`, `wsl ~`, `wsl -d <Distro>`, `wsl --update`, `wsl --status`). Vom Nutzer abschließend überarbeitet, Seite 1 eingefroren. Abschnitt 2 gekürzt (ohne `explorer.exe` und `apt`-Punkt).
- Drei Videos des Installationspfads aufgenommen (`Videos/`, im Repo).
- Folie 5: Sprechernotiz neu geschrieben (Anschluss an die Videos aus Folie 4, `/mnt/c` live, Pfeil in beide Richtungen, Fazit aus der rechten Spalte, Vorbereitung der Testdatei), vom Nutzer in Einzelzeilen gegliedert.
- Notiz zu Folie 2: Cockpit- und Ergebnis-Link der Umfrage entfernt, es bleiben Teilnehmer-Links und ein Verweis auf `poll.txt`. Mit dem Nutzer abgesprochen.

## Nächster Schritt

**Die Durchsicht der Präsentation geht ab Folie 6 weiter.** Folien 1 bis 5 sind samt Sprechernotizen abgestimmt und fertig. Für Folien 6 bis 13 steht der Abgleich mit dem neuen Installationspfad und dem aktuellen Handout noch aus (Folie 6 Klassen-Image, 7 Stolperstellen, 8 Übungsserver mit IP-Platzhalter, 9 bis 11 Hands-on, 12 Transfer, 13 Abschluss). Alle Änderungen bis hierher wurden am 03.11.2026 ins Repository gepusht.

## Offene Punkte

- Roboto wieder in die Präsentation einbetten (beim Speichern in OnlyOffice verloren gegangen). Ohne Roboto fällt PowerPoint auf eine Ersatzschrift zurück.
- QR-Code auf Folie 2 ragt in den Datums-/Logobereich. Folie 2 ist gesperrt.
- Pfeil „⟷“ auf Folie 5 einmal in PowerPoint prüfen; falls er dort fehlt, durch eine gezeichnete Pfeilform ersetzen.
- Link oder QR-Code zum Übungspaket im Handout und auf Folie 13 eintragen, sobald das Material online liegt.
- Idee aus `notes.txt`: eine Browser-Konsole mit Minimal-Linux auf CloudStack als Plan B ohne jede Installation.
- `shellcheck` war auf dem Entwicklungsrechner nicht installiert, die Skripte wurden nur mit `bash -n` geprüft.

## Arbeitshinweise

- Office-Dateien sind ZIP-Archive mit XML. Text zum Prüfen extrahieren mit `unzip -p datei.docx word/document.xml`. Kleine Korrekturen gehen am sichersten direkt im XML per Python; Textläufe sind oft in mehrere `<w:t>` bzw. `<a:t>` aufgeteilt.
- Nach jeder Änderung an einer Office-Datei prüfen, ob sie noch öffnet: `soffice --headless --convert-to pdf datei.pptx`, dann die Seite rendern und ansehen.
- Präsentation und Handout werden parallel in OnlyOffice/PowerPoint/Word bearbeitet. Vor eigenen Änderungen immer den aktuellen Stand einlesen und mit dem letzten bekannten vergleichen.
- Die Setup- und Teardown-Skripte brauchen root und verändern das System. Niemals auf dem Entwicklungsrechner ausführen.
- Für Arbeit mit Claude Code liest `CLAUDE.md` die Projektkonventionen automatisch ein.
