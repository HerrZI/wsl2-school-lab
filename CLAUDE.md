# CLAUDE.md

Diese Datei wird von Claude Code beim Start in diesem Ordner automatisch gelesen.

## Beim nächsten Start

**Dem Nutzer zu Beginn sagen: Folie 6 ist abgestimmt, Folie 7 bis 13 wurden am 04.11.2026 auf das neue Konzept „Weg A eigenes WSL, Weg B Übungsserver“ umgebaut und warten auf seine Durchsicht.** Folien 1 bis 5 sind final (Folie 2 zusätzlich gesperrt). Folie 3 (Station „Selbst machen“) wurde mit Freigabe des Nutzers ebenfalls auf Weg A/Weg B angepasst. Offen ist außerdem der Praxistest der `wsl-*`-Skripte auf einer frischen WSL-Instanz.

## Worum es hier geht

Unterlagen für einen 60-minütigen Workshop für Lehrkräfte: **"Linux unterrichten mit WSL2"**.
Ziel ist, Linux-Inhalte auf Windows-Geräten (Schulrechner) mit WSL2 zu unterrichten.
Die Teilnehmer arbeiten in Partnerarbeit. **Hauptweg (Weg A):** jeder installiert WSL und Ubuntu auf dem eigenen Gerät und führt `wsl-setup-workshop.sh` aus. **Ausweichweg (Weg B):** wer das nicht darf (keine Admin-Rechte), arbeitet per SSH auf einem gemeinsamen Übungsserver. Das Arbeitsblatt ist für beide Wege identisch.

Sprache des Projekts: **Deutsch**. Antworten, Commit-Messages und neue Dateien bitte auf Deutsch.

## Dateien

| Datei | Zweck |
|---|---|
| `Dokumente/Workshop_WSL2_Linux_unterrichten_neu.pptx` | Präsentation (13 Folien mit Notizen, Fahrplan: Einstieg, Demo, Hands-on I/II, Transfer). Nutzt Master, Layouts und Theme der offiziellen MMBBS-Vorlage (`MMBBS_PPT_Vorlage_092025_Ansicht.pptx`, liegt bewusst nicht im Repo, da ihre Metadaten Namen und E-Mail von Kollegen enthalten); Folienformat 16:9 mit 33,87 × 19,05 cm. Die Roboto-Schrift ist **nicht mehr eingebettet** (ging beim Speichern in OnlyOffice verloren). |
| `Dokumente/Arbeitsblatt_Linux_Kommandozeile.docx` | Arbeitsblatt für Teilnehmer, 2 Seiten. Einstieg mit Weg A (WSL: `wsl -d Ubuntu-26.04`, `git clone`, `sudo ./wsl-setup-workshop.sh`, `su - user01`) und Weg B (`ssh userNN@<IP>`). Teil A: Mini-Rallye (pwd, ls, mkdir, cd, touch, mv, man). Teil B: Pipes-Challenge "Server-Krimi" mit `server.log`. |
| `Dokumente/Loesungsblatt_fuer_Workshopleitung.docx` | Lösungen zum Arbeitsblatt inkl. Zahlenwerten, die zur mitgelieferten `server.log` passen müssen. |
| `Dokumente/Handout_WSL2_im_Schulkontext.docx` | Handout für Lehrkräfte, **2 Seiten (Doppelseite zum Drucken)**, fünf Abschnitte: 1 Installation in acht Minuten (siehe Zusammenhänge), 2 Alltag, 3 Klassen-Image, 4 Übungsumgebung Weg A/B, 5 Links (Repo, WSL-Doku, LPI). Stolperstellen und LPI-Themen stehen nur noch auf den Folien. |
| `server.log` | Übungsdatei (210 Zeilen, fiktiver Schulserver `srv-schule01`). Wird vom Setup-Skript nach `/srv/workshop/` kopiert. |
| `setup-workshop.sh` | Legt auf dem Übungsserver Benutzer `user01..userNN` (Passwort `akademieNN`), Gruppe `workshop` und `/srv/workshop/server.log` an, startet SSH. Aufruf: `sudo ./setup-workshop.sh [ANZAHL]`, Standard 40. |
| `teardown-workshop.sh` | Entfernt alle Workshop-Benutzer, die Gruppe und `/srv/workshop` wieder. Fragt vor dem Löschen nach. |
| `wsl-setup-workshop.sh` | Variante für die eigene WSL-Instanz der Teilnehmer: legt nur Übungsbenutzer (Standard 2, `user01..userNN`, Passwort `akademieNN`), Gruppe `workshop` und `/srv/workshop/server.log` an. **Kein SSH.** Aufruf: `sudo ./wsl-setup-workshop.sh [ANZAHL]`. Danach `su - user01` oder `wsl -d <Distro> -u user01`. |
| `wsl-teardown-workshop.sh` | Räumt die WSL-Variante wieder ab (Benutzer, Gruppe, `/srv/workshop`). Fragt vor dem Löschen nach. |
| `UEBERGABE.md` | Übergabedokument mit Stand, Checkliste und offenen Punkten. Bei größeren Änderungen mitpflegen. |
| `Videos/` | Drei Bildschirmaufnahmen des Installationspfads (WSL installieren, Ubuntu installieren, Ubuntu starten), zusammen ca. 35 MB. Sicherheitsnetz für die Live-Demo. Liegen im Repo. |
| `Dokumente/Workshop_WSL2_Linux_unterrichten_neu (org).pptx` | Vom Nutzer abgelegte Sicherungskopie der Präsentation. **Nicht anfassen, nicht ändern, nicht löschen, nicht in Prüfungen einbeziehen.** Per `.gitignore` ausgeschlossen. |
| `README.md` | Kurzbeschreibung des Repos. |

Per `.gitignore` ausgeschlossen sind außerdem LibreOffice-Sperrdateien (`.~lock.*#`), `Dokumente/zrXL.png` (QR-Code-Quelle, steckt bereits in der Präsentation) und `Dokumente/poll.txt` (DirectPoll-Links der Blitzumfrage, enthält den Admin-Link).

## Wichtige Zusammenhänge

- Die Zahlen im Lösungsblatt (z. B. 90 ERROR-Zeilen, 66 fehlgeschlagene SSH-Logins, Angreifer-IPs 203.0.113.42 / 198.51.100.7 / 192.0.2.99) sind **aus `server.log` abgeleitet**. Wer `server.log` ändert, muss das Lösungsblatt nachziehen und umgekehrt. Die Werte vor dem Übernehmen mit `grep`/`cut`/`sort`/`uniq` gegen die Datei prüfen.
- Das Lösungsblatt nutzt `cut -d' ' -f14` für die IP und `-f12` für den Benutzernamen. Das Arbeitsblatt verrät die Feldnummer bewusst nicht (Teilnehmer sollen selbst abzählen). Die Nummern gelten nur, weil alle Failed-Zeilen die Form "for invalid user NAME from IP" haben.
- **Der Installationspfad ist an drei Stellen beschrieben und muss übereinstimmen:** Handout Abschnitt 1 (vollständig: `wsl --version`, `wsl --install`, `Restart-Computer -Force`, `wsl --version`, `wsl --list --online`, `wsl --install Ubuntu-26.04`, Benutzer anlegen, `exit`, `wsl --list`, `wsl -d Ubuntu-26.04`, `sudo apt update`, `sudo apt install cowsay`, `cowsay "Cool Linux unter Windows"`, `exit`), Folie 4 (verkürzt auf `wsl --install`, `wsl --install Ubuntu`, `wsl`) und die Sprechernotiz zu Folie 4 (führt den Handout-Pfad als Live-Demo). Die Videos in `Videos/` zeigen denselben Pfad. Gesamtdauer rund acht Minuten.
- **Der Repo-Link `https://github.com/HerrZI/wsl2-school-lab` ist das Übungspaket.** Er steht im Arbeitsblatt (git clone), im Handout Abschnitt 5, auf Folie 8 und 13 und in der README. Das Repo muss dafür öffentlich bleiben; wer den Namen ändert, muss alle fünf Stellen nachziehen.
- Beide Setup-Skripte suchen `server.log` **neben sich selbst** (`$(dirname "$0")/server.log`). Das Arbeitsblatt braucht als einzige vorbereitete Datei `/srv/workshop/server.log`, alles andere legen die Teilnehmer selbst an.
- Die `wsl-*`-Skripte sind die SSH-freie Variante für die eigene WSL-Instanz (Idee: Teilnehmer bereiten ihr frisch installiertes Ubuntu selbst für das Arbeitsblatt vor oder der Dozent exportiert es als Klassen-Image). Änderungen an Benutzerschema oder Logdatei-Pfad in allen vier Skripten nachziehen.
- Die Passwörter sind bewusst trivial. Der Server ist nur fürs lokale Veranstaltungsnetz gedacht.
- WSL2-Besonderheiten im Setup-Skript: systemd nur, wenn in `/etc/wsl.conf` aktiviert; für Zugriff aus dem Netz gespiegelter Netzwerkmodus (`networkingMode=mirrored`) oder `netsh portproxy`.
- **Sensibel:** Der DirectPoll-Cockpit- und der Ergebnis-Link der Blitzumfrage stehen nur in `Dokumente/poll.txt` (ignoriert, lokal). Die Sprechernotiz zu Folie 2 enthält bewusst nur den Teilnehmer-Link `https://etc.ch/zrXL`, den langen Teilnehmer-Link und einen Verweis auf `poll.txt`. Die Admin-Links nie in getrackte Dateien übernehmen.

## Festgelegte Konventionen

- **Folien 1 bis 5 sind mit dem Nutzer abgestimmt.** Änderungen dort nur auf Wunsch des Nutzers oder wenn sie beim Abgleich der späteren Folien zwingend nötig werden, und dann vorher ansprechen.
- **Folie 2 der Präsentation ist final.** Weder Folieninhalt noch Sprechernotiz ohne ausdrückliche Absprache mit dem Nutzer ändern. Das gilt auch für automatische Skripte über alle Folien hinweg: Folie 2 dabei auslassen oder vorher nachfragen.
- **Seite 1 des Handouts (Abschnitt 1 „WSL2 in acht Minuten installieren“ samt Befehlsblöcken) ist vorerst eingefroren.** Nichts daran ändern ohne ausdrückliche Absprache mit dem Nutzer; auch Korrekturen vorher ansprechen.
- Der Nutzer bearbeitet Präsentation und Handout parallel in OnlyOffice/PowerPoint/Word. **Vor jeder eigenen Änderung die Datei frisch entpacken und mit dem letzten eigenen Stand vergleichen**, Nutzeränderungen übernehmen, nie überschreiben. Nach einem Speichern durch das Office-Programm unterscheiden sich alle XML-Dateien, verglichen wird deshalb nach Inhalt (Text, Position, Formatierung), nicht byteweise.
- **Anrede in allen Materialien: Sie.** Arbeitsblatt, Handout, Lösungsblatt und Folien sprechen die Teilnehmenden durchgehend mit „Sie“ an, kein Du und kein Ihr.
- Teilnehmerkonten im Workshop: 40 (user01 bis user40), passend zum Skript-Standard. Im Handout steht als Beispiel für eine Klasse `setup-workshop.sh 30`, das ist Absicht.
- Pfad für das Klassen-Image in Handout und Folien: `C:\Images\fisi-uebung.tar`.
- Name der WSL-Instanz in den Befehlen: `Ubuntu-26.04` (so, wie `wsl --install Ubuntu-26.04` sie anlegt). Der Nutzer hat den Export-Befehl im Handout Abschnitt 3 bewusst auf `wsl --export Ubuntu-26.04 …` gesetzt; nicht auf `Ubuntu` zurückändern.
- Kommentare in Befehlsblöcken mit `#` (PowerShell), nicht `REM`.
- Design der Präsentation: MMBBS-Palette (Gelb `FAE55F`, Beere `954161`, Dunkelblau `14508D`, Hellblau `1F87C9`/`BADCF6`, Text `1E1E1E`, Fließtext grau `595959`), Schrift Roboto, Code in Courier New. Titel- und Abschlussfolien (1, 8, 13) liegen auf Layout 1 (blauer Verlauf mit Logo), Inhaltsfolien auf Layout 3 (weiß, Logo unten rechts, Datum, Foliennummer, gelbe Linie). Inhalte sind freie Textfelder, keine Platzhalter.
- Prompts in den Terminal-Mockups: Weg A zeigt `user01@PC`, Weg B `userNN@srv`. Folien 8, 9 und 11 zeigen Weg A.
- Terminal-Mockups (Folien 1, 4, 6, 8, 9, 11) sehen nach Windows aus: dunkles abgerundetes Rechteck `1E1E1E`, Fenstertitel grau `B0B0B0` 12 pt links, rechts Minimieren/Maximieren/Schließen, Trennlinie `3A3A3A` unter der Titelzeile. Wird das Fenster verschoben oder vergrößert, Titel und Trennlinie nachziehen (Titel 0,19 Zoll vom linken Rand, Trennlinie volle Fensterbreite).
- Aufzählungen mit blauen Punkten (Ellipse 14508D, 0,19 Zoll, x = 0,73 Zoll; Textfeld ab x = 1,13 Zoll, 0,96 Zoll hoch, mittig verankert): Der Punkt sitzt mittig auf der **ersten Textzeile**. Bei zweizeiligen Einträgen liegt er 0,26 Zoll unter der Textfeld-Oberkante, bei einzeiligen 0,41 Zoll. Nach Textänderungen die Zeilenzahl prüfen und den Punkt nachziehen.
- Folie 5 ist zweispaltig: links die Karte „Windows ⟷ Linux“ mit `cd /mnt/c/...`, rechts die Überschrift „Für den Unterricht heißt das:“ mit drei Punkt-Aufzählungen.
- Pfeile in Texten: den langen Textpfeil `⟷` (U+27F7) verwenden, nicht `↔` (U+2194), der wird als Emoji gerendert. Einfache Pfeile `→` sind unproblematisch.
- Das Datum auf den Inhaltsfolien ist fester Text „16.11.2026“ (Workshoptermin), kein automatisches Datumsfeld mehr. Bei einem neuen Termin alle Inhaltsfolien nachziehen.
- Auf Inhaltsfolien muss der Bereich unten rechts (ab ca. 29 cm × 16 cm) für das Logo frei bleiben; unten links sitzt die Foliennummer, rechts das Datum.
- Zeitplan (Folie 3, Stand 04.11.2026): Einstieg 5, Demo 15 (davon rund 8 für den Installationsdurchlauf), Hands-on 35 (Checkpoint und Teil A Minute 20–37, Teil B 37–55), Transfer 5 Minuten (55–60). Die Kopfzeilen auf Folie 4, 9, 10 und 12 tragen diese Minutenangaben.
- Folie 12 (Transfer): Karte 1 „Heute erlebt: WSL plus Skript“ (Windows-Icon), Karte 2 „Plan B: der Übungsserver“ (Wolken-Icon), Karte 3 LPI. Die Icon-Bilder liegen in der Zeichenreihenfolge direkt nach ihrem Kreis; beim Tauschen die `r:embed`-Verweise tauschen, nicht die Positionen.

## Offene Punkte

- Roboto wieder in die Präsentation einbetten, damit sie auf fremden Rechnern gleich aussieht.
- Der QR-Code auf Folie 2 ragt in den Datums-/Logobereich. Folie 2 ist gesperrt, nur auf Wunsch anfassen.
- Die `wsl-*`-Skripte auf einer frischen WSL-Instanz testen (Setup, `su - user01`, Arbeitsblatt, Teardown). Offen ist auch, ob `git` im frischen Ubuntu-WSL-Image enthalten ist; sonst `sudo apt install git` ins Arbeitsblatt aufnehmen.
- Idee (ehemals in `notes.txt`, Datei vom Nutzer gelöscht): eine Konsole mit Minimal-Linux auf CloudStack bereitstellen.

## Arbeitsweise

- Office-Dateien (.docx/.pptx) sind Binärdateien. Zum Lesen den Text aus dem XML extrahieren (`unzip -p datei.docx word/document.xml`) oder die passenden Skills (docx/pptx) nutzen. Nicht blind überschreiben, vorher Inhalt ansehen. Kleine Textkorrekturen gehen am sichersten per Python-Zipfile direkt im XML; Textläufe sind oft in mehrere `<w:t>`/`<a:t>` aufgeteilt. OnlyOffice schreibt `<a:off ...></a:off>` statt `<a:off .../>`, Regex entsprechend tolerant halten. Beim Neupacken die Reihenfolge der ZIP-Einträge beibehalten.
- Nach jeder Änderung prüfen: `unzip -tq datei`, dann `soffice --headless --convert-to pdf` und die betroffene Seite/Folie mit `pdftoppm -jpeg` rendern und ansehen (Zeilenumbrüche, Punktausrichtung, Logozone, Seitenzahl des Handouts bleibt 2).
- Shell-Skripte vor Änderungen mit `bash -n` und nach Möglichkeit mit `shellcheck` prüfen. Alle vier Skripte benötigen root und verändern das System (Benutzer anlegen/löschen). **Niemals auf diesem Entwicklungsrechner ausführen**, nur auf dem Übungsserver.
- Commits nur auf Nachfrage. Vor einem Push prüfen, ob die Office-Dateien Links, Namen oder Passwörter enthalten (`unzip -p datei '*.xml' | grep -o 'https\?://[^<"]*'`).
