# Übergabe: Workshop „Linux unterrichten mit WSL2“

Stand: 04.11.2026

## Worum es geht

Ein 60-minütiger Workshop für Lehrkräfte am Regionalen Akademietag der Cisco Networking Academy. Ziel: Linux-Kommandozeile auf Windows-Schulrechnern unterrichten. **Hauptweg (Weg A):** Jede Teilnehmerin, jeder Teilnehmer installiert WSL und Ubuntu auf dem eigenen Gerät und legt mit `wsl-setup-workshop.sh` die Übungsumgebung an. **Ausweichweg (Weg B):** Wer auf dem Gerät kein WSL installieren darf, arbeitet per SSH auf dem gemeinsamen Übungsserver. Beide Wege führen zum selben Arbeitsblatt.

Der Workshop hat drei Stationen:

| Station | Minuten | Inhalt |
|---|---|---|
| Einstieg | 0–5 | Linux ist in der IT überall, Schulrechner laufen meist mit Windows; Blitzumfrage per QR-Code |
| Demo | 5–20 | Folie 4 mit den drei Kernbefehlen, dann Live-Demo des Installationspfads aus Handout Abschnitt 1 (rund 8 Minuten), `/mnt/c`, Klassen-Image per Export/Import, Stolperstellen |
| Hands-on | 20–55 | Teilnehmende arbeiten zu zweit, Weg A im eigenen WSL oder Weg B per SSH auf dem Übungsserver: Teil A Mini-Rallye, Teil B Pipes-Challenge „Server-Krimi“ |
| Transfer | 55–60 | LPI-Materialien, Murmelrunde, Exit-Ticket |

## Dateien

| Datei | Zweck | Status |
|---|---|---|
| `Dokumente/Workshop_WSL2_Linux_unterrichten_neu.pptx` | Präsentation, 13 Folien mit Sprechernotizen, im MMBBS-Design | fertig, geprüft; Folie 2 final |
| `Dokumente/Arbeitsblatt_Linux_Kommandozeile.docx` | Arbeitsblatt für die Teilnehmenden, Einstieg über Weg A/Weg B, Teil A und B | umgebaut 04.11.2026, 2 Seiten |
| `Dokumente/Loesungsblatt_fuer_Workshopleitung.docx` | Lösungen inkl. Zahlen, die zur `server.log` passen, Zeitpuffer-Tipp für klemmende WSL-Vorbereitung | fertig, geprüft |
| `Dokumente/Handout_WSL2_im_Schulkontext.docx` | Handout zum Mitnehmen, 2 Seiten als Doppelseite: Installation in acht Minuten, Alltag, Klassen-Image, Übungsumgebung (Weg A/B), Links | fertig; vom Nutzer gekürzt; Seite 1 eingefroren |
| `server.log` | Übungsdatei, 210 Zeilen, fiktiver Server `srv-schule01` | fertig |
| `setup-workshop.sh` | Legt Benutzer, Gruppe, Übungsdatei und SSH auf dem Übungsserver an | fertig |
| `teardown-workshop.sh` | Räumt alles wieder ab | fertig |
| `wsl-setup-workshop.sh`, `wsl-teardown-workshop.sh` | Weg A: Übungsbenutzer und Logdatei in der eigenen WSL-Instanz, ohne SSH | neu, mit `bash -n` geprüft, noch nicht auf einer WSL-Instanz getestet |
| `Videos/` | Vier Bildschirmaufnahmen (ca. 53 MB): 1 WSL installieren, 2 Ubuntu installieren, 3 Ubuntu starten und verwenden, 4 Skript ausführen und exportieren. Folie 4 (Video 1 und 2), Folie 5 (Video 3), Folie 6 (Video 4) | im Repo |
| `Dokumente/Workshop_WSL2_Linux_unterrichten_neu (org).pptx` | Sicherungskopie des Nutzers, wird nicht bearbeitet | nur lokal, per `.gitignore` ausgeschlossen |
| `README.md`, `CLAUDE.md`, `.gitignore` | Beschreibung, Arbeitshinweise für Claude Code, Ignore-Regeln | aktuell |

Nicht im Repo und bewusst ignoriert: `Dokumente/zrXL.png` (QR-Code-Quelle, steckt in der Präsentation), `Dokumente/poll.txt` (DirectPoll-Links inkl. Admin-Link), die MMBBS-Vorlage (Metadaten mit Namen und E-Mail von Kollegen).

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
- **Repo-Link als Übungspaket:** `https://github.com/HerrZI/wsl2-school-lab` steht im Arbeitsblatt, Handout Abschnitt 5, Folie 8 und 13 und README. Das Repo muss öffentlich bleiben.
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

- [ ] Repo ist öffentlich und `git clone https://github.com/HerrZI/wsl2-school-lab.git` funktioniert aus einer frischen WSL-Instanz; `wsl-setup-workshop.sh` einmal durchgespielt
- [ ] Übungsserver für Weg B trotzdem aufgesetzt, SSH von einem Windows-Rechner aus getestet (`ssh user01@<IP>`)
- [ ] IP-Adresse auf Folie 8 eingetragen
- [ ] Zugangsdaten-Zettel je Team gedruckt
- [ ] Arbeitsblatt für alle, Lösungsblatt nur für die Leitung gedruckt
- [ ] Handout als Doppelseite gedruckt (2 Seiten, beidseitig) oder als PDF bereit
- [x] Videos der WSL2-Installation als Sicherheitsnetz für die Demo (vier Stück in `Videos/`, Reihenfolge wie auf Folie 4 und 6)
- [ ] Demo-Gerät: WSL vorher deinstallieren oder Plan B aus der Notiz zu Folie 4 nutzen (bei `wsl -d Ubuntu-26.04` einsteigen)
- [ ] Zwei Leihgeräte für Teilnehmende mit gesperrtem Port 22
- [ ] Präsentation einmal in PowerPoint geöffnet, Roboto-Darstellung und Pfeil auf Folie 5 geprüft (Datum steht fest auf 16.11.2026)
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

**Konzeptwechsel (04.11.2026): Hauptweg eigenes WSL, Ausweichweg Übungsserver.**

- Arbeitsblatt: Einstieg in Weg A (WSL starten, `git clone`, `sudo ./wsl-setup-workshop.sh`, `su - user01`) und Weg B (SSH). Prompt-Satz, Logdatei-Hinweis und Transfer-Absatz auf beide Wege angepasst.
- Lösungsblatt: Aufgabe 1 gilt für beide Umgebungen, Zeitpuffer-Tipp „WSL-Vorbereitung klemmt → auf Weg B umleiten“.
- Handout Abschnitt 4 heißt „Die Übungsumgebung aus dem Workshop: zwei Wege“ mit Befehlsblock für Weg A und gekürztem Block für Weg B; Abschnitt 5 verweist bei fehlenden Admin-Rechten auf Weg B; Abschnitt 7 trägt den Repo-Link. Seite 1 unverändert.
- Präsentation: Folie 6 um `wsl -d FISI-Uebung` ergänzt (Karten nach unten, Notiz mit Demo-Anschluss). Folie 7 Schlusszeile und Notiz auf den Übungsserver als Ausweichweg. Folie 8 komplett auf Weg A/Weg B mit WSL-Terminal (git clone, Skript, su). Folie 9 und 11 Prompts `user01@PC`. Folie 12 Karten „Heute erlebt: WSL plus Skript“ und „Plan B: der Übungsserver“ mit getauschten Icons. Folie 13 Repo-Link und Skripte in der Übungen-Zeile, oben links Tux und Windows-PC wie auf Folie 1 (vom Nutzer). Folie 3 Station 2 „Hands-on im eigenen WSL oder auf dem Übungsserver“ (mit Freigabe). Notizen zu 3, 7, 8, 9, 12 neu.
- README neu geschrieben: beide Wege mit Befehlen, Dateitabelle.
- Arbeitsblatt von der Ihr-Form auf die Sie-Form umgestellt; alle anderen Materialien waren bereits in der Sie-Form.
- Handout vom Nutzer auf zwei Seiten gekürzt (Stolperstellen und LPI-Abschnitt raus, Links jetzt Abschnitt 5); Folie 13 vom Nutzer angepasst, Notiz zu Folie 7 nachgezogen.

**Inhaltliche Überarbeitung (03.11.2026):**

- Folie 2 vom Nutzer finalisiert: „Linux überall – nur nicht im Computerraum“, Blitzumfrage mit QR-Code. Gesperrt.
- Folie 3: Station 1 heißt „Demo: WSL2 auf dem (eigenen) Windows-Rechner“.
- Folie 4: Titel „WSL2: Linux, das in Windows wohnt“, fünf Punkte (VM, `wsl --install`, `wsl --install Ubuntu` mit Kaffeepause, `wsl`, kostenlos & offiziell), Terminal zeigt `wsl --install Ubuntu`. Sprechernotiz führt den vollständigen Handout-Pfad als Live-Demo mit Plan B.
- Folie 5: zweispaltig, links Karte „Windows ⟷ Linux“, rechts „Für den Unterricht heißt das:“ mit drei Punkten.
- Handout Abschnitt 1: „WSL2 in acht Minuten installieren“ mit dem erprobten Pfad (14 Befehle inkl. `cowsay`-Test), darunter „Weitere Befehle“ (`wsl`, `wsl ~`, `wsl -d <Distro>`, `wsl --update`, `wsl --status`). Vom Nutzer abschließend überarbeitet, Seite 1 eingefroren. Abschnitt 2 gekürzt (ohne `explorer.exe` und `apt`-Punkt).
- Neue Skripte `wsl-setup-workshop.sh` und `wsl-teardown-workshop.sh` (04.11.2026): dasselbe Benutzerschema und derselbe Logdatei-Pfad wie die Server-Skripte, aber ohne SSH und mit Standard 2 Benutzern. Gedacht für Teilnehmer, die das Arbeitsblatt in ihrer eigenen WSL-Instanz nachspielen, und als Vorstufe für ein exportierbares Klassen-Image.
- Vier Videos aufgenommen (`Videos/`, im Repo): Installationspfad (1–3) und Skript plus Export (4).
- Folie 5: Sprechernotiz neu geschrieben (Anschluss an die Videos aus Folie 4, `/mnt/c` live, Pfeil in beide Richtungen, Fazit aus der rechten Spalte, Vorbereitung der Testdatei), vom Nutzer in Einzelzeilen gegliedert.
- Notiz zu Folie 2: Cockpit- und Ergebnis-Link der Umfrage entfernt, es bleiben Teilnehmer-Links und ein Verweis auf `poll.txt`. Mit dem Nutzer abgesprochen.
- Folien 4 bis 6 auf die vier Videos umgebaut (04.11.2026, Wunsch des Nutzers): Folie 4 „VIDEO 1 UND 2“ mit fünf Spiegelstrichen (WSL = Windows Subsystem for Linux, VM, kostenlos, Video 1 `wsl --install`, Video 2 `wsl --install Ubuntu`) und passendem Terminal. Folie 5 „VIDEO 3, DANN LIVE AM BEAMER“ neu auf dem Raster von Folie 4: Video 3 `wsl`, apt/cowsay, Windows ⟷ Linux über /mnt/c, „Im Unterricht:“; Terminal mit ASCII-Kuh und `cd /mnt/c/...`. Die alte Karten-Ansicht von Folie 5 ist ersetzt. Folie 6 „VIDEO 4“ zeigt im Terminal `sudo ./wsl-setup-workshop.sh` vor dem Export, Karte 1 nennt das Skript. Notizen 4 bis 6 neu geschrieben (Video 1/2, Video 3 plus Live-Teil mit Testdatei, Video 4). Alle drei Folien gerendert und geprüft.
- Office-Dateien in den Ordner `Dokumente/` verschoben (04.11.2026), `.gitignore` und Dateitabellen nachgezogen.

## Nächster Schritt

**Folien 7 bis 13 durchsehen.** Sie wurden am 04.11.2026 auf das Konzept Weg A/Weg B umgebaut, Folie 6 ist abgestimmt, Folien 1 bis 5 sind final. Folie 3 (Station „Selbst machen“) ist mit Freigabe des Nutzers auf beide Wege angepasst. Danach die `wsl-*`-Skripte auf einer frischen WSL-Instanz testen und committen.

## Offene Punkte

- Die `wsl-*`-Skripte einmal auf einer frischen WSL-Instanz durchspielen (Setup, `su - user01`, Arbeitsblatt Teil A und B, Teardown).
- Idee des Nutzers: Setup live in WSL zeigen, Instanz als TAR exportieren und den Teilnehmern zusammen mit den Skripten mitgeben. Vor dem Export Standardbenutzer in `/etc/wsl.conf` setzen und nie die persönliche Instanz exportieren. Handout Abschnitt 4 und Folie 8/13 wären dann zu ergänzen.
- Roboto wieder in die Präsentation einbetten (beim Speichern in OnlyOffice verloren gegangen). Ohne Roboto fällt PowerPoint auf eine Ersatzschrift zurück.
- QR-Code auf Folie 2 ragt in den Datums-/Logobereich. Folie 2 ist gesperrt.
- Pfeil „⟷“ auf Folie 5 einmal in PowerPoint prüfen; falls er dort fehlt, durch eine gezeichnete Pfeilform ersetzen.
- Prüfen, ob `git` im frischen Ubuntu-WSL-Image enthalten ist; sonst `sudo apt install git` ins Arbeitsblatt aufnehmen (in der Notiz zu Folie 8 steht es bereits als Hänger-Tipp).
- Idee (ehemals in `notes.txt`, Datei gelöscht): eine Browser-Konsole mit Minimal-Linux auf CloudStack als Plan B ohne jede Installation.
- `shellcheck` war auf dem Entwicklungsrechner nicht installiert, die Skripte wurden nur mit `bash -n` geprüft.

## Arbeitshinweise

- Office-Dateien sind ZIP-Archive mit XML. Text zum Prüfen extrahieren mit `unzip -p datei.docx word/document.xml`. Kleine Korrekturen gehen am sichersten direkt im XML per Python; Textläufe sind oft in mehrere `<w:t>` bzw. `<a:t>` aufgeteilt.
- Nach jeder Änderung an einer Office-Datei prüfen, ob sie noch öffnet: `soffice --headless --convert-to pdf datei.pptx`, dann die Seite rendern und ansehen.
- Präsentation und Handout werden parallel in OnlyOffice/PowerPoint/Word bearbeitet. Vor eigenen Änderungen immer den aktuellen Stand einlesen und mit dem letzten bekannten vergleichen.
- Die Setup- und Teardown-Skripte brauchen root und verändern das System. Niemals auf dem Entwicklungsrechner ausführen.
- Für Arbeit mit Claude Code liest `CLAUDE.md` die Projektkonventionen automatisch ein.
