# CLAUDE.md

Diese Datei wird von Claude Code beim Start in diesem Ordner automatisch gelesen.

## Worum es hier geht

Unterlagen für einen 60-minütigen Workshop für Lehrkräfte: **"Linux unterrichten mit WSL2"**.
Ziel ist, Linux-Inhalte auf Windows-Geräten (Schulrechner) mit WSL2 zu unterrichten.
Die Teilnehmer arbeiten in Partnerarbeit per SSH auf einem gemeinsamen Übungsserver.

Sprache des Projekts: **Deutsch**. Antworten, Commit-Messages und neue Dateien bitte auf Deutsch.

## Dateien

| Datei | Zweck |
|---|---|
| `Workshop_WSL2_Linux_unterrichten_neu.pptx` | Präsentation (13 Folien mit Notizen, Fahrplan: Einstieg, Demo, Hands-on I/II, Transfer). Nutzt Master, Layouts, Theme und eingebettete Roboto-Schrift der offiziellen MMBBS-Vorlage (`MMBBS_PPT_Vorlage_092025_Ansicht.pptx`, liegt bewusst nicht im Repo, da ihre Metadaten Namen und E-Mail von Kollegen enthalten); Folienformat 16:9 mit 33,87 × 19,05 cm. |
| `Arbeitsblatt_Linux_Kommandozeile.docx` | Arbeitsblatt für Teilnehmer. Teil A: Mini-Rallye (pwd, ls, mkdir, cd, touch, mv, man). Teil B: Pipes-Challenge "Server-Krimi" mit `server.log`. |
| `Loesungsblatt_fuer_Workshopleitung.docx` | Lösungen zum Arbeitsblatt inkl. Zahlenwerten, die zur mitgelieferten `server.log` passen müssen. |
| `Handout_WSL2_im_Schulkontext.docx` | Handout für Lehrkräfte zu WSL2 im Schulkontext. |
| `server.log` | Übungsdatei (210 Zeilen, fiktiver Schulserver `srv-schule01`). Wird vom Setup-Skript nach `/srv/workshop/` kopiert. |
| `setup-workshop.sh` | Legt auf dem Übungsserver Benutzer `user01..userNN` (Passwort `akademieNN`), Gruppe `workshop` und `/srv/workshop/server.log` an, startet SSH. Aufruf: `sudo ./setup-workshop.sh [ANZAHL]`, Standard 40. |
| `teardown-workshop.sh` | Entfernt alle Workshop-Benutzer, die Gruppe und `/srv/workshop` wieder. Fragt vor dem Löschen nach. |
| `notes.txt` | Lose Ideen und offene Punkte. |
| `README.md` | Kurzbeschreibung des Repos. |

LibreOffice-Sperrdateien (`.~lock.*#`) sind per `.gitignore` ausgeschlossen.

## Wichtige Zusammenhänge

- Die Zahlen im Lösungsblatt (z. B. 90 ERROR-Zeilen, 66 fehlgeschlagene SSH-Logins, Angreifer-IPs 203.0.113.42 / 198.51.100.7 / 192.0.2.99) sind **aus `server.log` abgeleitet**. Wer `server.log` ändert, muss das Lösungsblatt nachziehen und umgekehrt. Die Werte vor dem Übernehmen mit `grep`/`cut`/`sort`/`uniq` gegen die Datei prüfen.
- Das Lösungsblatt nutzt `cut -d' ' -f14` für die IP und `-f12` für den Benutzernamen. Das Arbeitsblatt verrät die Feldnummer bewusst nicht (Teilnehmer sollen selbst abzählen). Die Nummern gelten nur, weil alle Failed-Zeilen die Form "for invalid user NAME from IP" haben.
- Das Setup-Skript sucht `server.log` **neben sich selbst** (`$(dirname "$0")/server.log`).
- Die Passwörter sind bewusst trivial. Der Server ist nur fürs lokale Veranstaltungsnetz gedacht.
- WSL2-Besonderheiten im Setup-Skript: systemd nur, wenn in `/etc/wsl.conf` aktiviert; für Zugriff aus dem Netz gespiegelter Netzwerkmodus (`networkingMode=mirrored`) oder `netsh portproxy`.

## Festgelegte Konventionen

- Teilnehmerkonten im Workshop: 40 (user01 bis user40), passend zum Skript-Standard.
- Pfad für das Klassen-Image in Handout und Folien: `C:\Images\fisi-uebung.tar`.
- Kommentare in Befehlsblöcken mit `#` (PowerShell), nicht `REM`.
- Design der Präsentation: MMBBS-Palette (Gelb `FAE55F`, Beere `954161`, Dunkelblau `14508D`, Hellblau `1F87C9`/`BADCF6`, Text `1E1E1E`), Schrift Roboto, Code in Courier New. Titel- und Abschlussfolien (1, 8, 13) liegen auf Layout 1 (blauer Verlauf mit Logo), Inhaltsfolien auf Layout 3 (weiß, Logo unten rechts, Datum, Foliennummer, gelbe Linie). Inhalte sind freie Textfelder, keine Platzhalter.
- Auf Inhaltsfolien muss der Bereich unten rechts (ab ca. 29 cm × 16 cm) für das Logo frei bleiben; unten links sitzt die Foliennummer, rechts das Datum.
- Zeitplan: Einstieg 5, Demo 15, Hands-on 30, Transfer 10 Minuten.

## Offene Punkte (aus notes.txt)

- Idee: eine Konsole mit Minimal-Linux auf CloudStack bereitstellen.

## Arbeitsweise

- Office-Dateien (.docx/.pptx) sind Binärdateien. Zum Lesen den Text aus dem XML extrahieren (`unzip -p datei.docx word/document.xml`) oder die passenden Skills (docx/pptx) nutzen. Nicht blind überschreiben, vorher Inhalt ansehen. Kleine Textkorrekturen gehen am sichersten per Python-Zipfile direkt im XML; Textläufe sind oft in mehrere `<w:t>`/`<a:t>` aufgeteilt. Nach dem Ändern mit `soffice --headless --convert-to pdf` prüfen, ob die Datei noch öffnet.
- Shell-Skripte vor Änderungen mit `bash -n` und nach Möglichkeit mit `shellcheck` prüfen. Beide Skripte benötigen root und verändern das System (Benutzer anlegen/löschen). **Niemals auf diesem Entwicklungsrechner ausführen**, nur auf dem Übungsserver.
- Commits nur auf Nachfrage.
