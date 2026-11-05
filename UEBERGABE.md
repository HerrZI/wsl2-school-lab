# Übergabe: Workshop „Linux unterrichten mit WSL2“

Stand: 05.11.2026

## Worum es geht

Ein 60-minütiger Workshop für Lehrkräfte am Regionalen Cisco-Akademietag 2026 Niedersachsen. Ziel: Linux-Kommandozeile auf Windows-Schulrechnern unterrichten. **Hauptweg (Weg A):** Jede Teilnehmerin, jeder Teilnehmer installiert WSL und Ubuntu auf dem eigenen Gerät und legt mit `wsl-setup-workshop.sh` die Übungsumgebung an. **Ausweichweg (Weg B):** Wer auf dem Gerät kein WSL installieren darf, arbeitet per SSH auf dem gemeinsamen Übungsserver. Beide Wege führen zum selben Arbeitsblatt.

Der Workshop hat vier Abschnitte (Folie 3 zeigt sie als Zeitstrahl):

| Station | Minuten | Inhalt |
|---|---|---|
| Einstieg | 0–5 | Linux ist in der IT überall, Schulrechner laufen meist mit Windows, Ausweg VMs oder WSL; Blitzumfrage per QR-Code |
| Demo | 5–20 | Installationspfad aus Handout Abschnitt 1 entlang der fünf Videos (rund 8 Minuten): Folie 4 Video 1 und 2 (`wsl --install`, `wsl --install Ubuntu-26.04`), Folie 5 Video 3 plus Live-Teil (`wsl -d Ubuntu-26.04`, cowsay, `/mnt/c`), Folie 6 Video 4 und 5 (Skript, Export, Import des Klassen-Images), Folie 7 Stolperstellen |
| Hands-on | 20–55 | Teilnehmende arbeiten zu zweit, Weg A im eigenen WSL oder Weg B per SSH auf dem Übungsserver: Teil A Mini-Rallye, Teil B Pipes-Challenge „Server-Krimi“ |
| Transfer | 55–60 | LPI-Materialien, Murmelrunde, Exit-Ticket |

## Dateien

| Datei | Zweck | Status |
|---|---|---|
| `dokumente/Workshop_WSL2_Linux_unterrichten_neu.pptx` | Präsentation, 13 Folien mit Sprechernotizen, im MMBBS-Design | Folien 1–6 abgestimmt, Folie 2 final; Folien 7–13 warten auf Durchsicht |
| `dokumente/Arbeitsblatt_Linux_Kommandozeile.docx` | Arbeitsblatt für die Teilnehmenden, Einstieg über Weg A/Weg B, Teil A und B | Weg A am 05.11.2026 gekürzt, 2 Seiten |
| `dokumente/Zugangsdaten_Uebungsserver.docx` | Schnittbogen für Weg B: 40 Streifen, jede Zelle mit Beschriftung „SSH Login (PowerShell): ssh userNN@172.31.4.47“ und „Passwort: akademieNN“, 20 je Seite, Zeilen 1,16 cm hoch zum Ausschneiden; erzeugt mit `server/zugangsdaten-erzeugen.py` | neu 05.11.2026, 2 Seiten, geprüft; **nur lokal, per `.gitignore` ausgeschlossen** |
| `dokumente/Loesungsblatt_fuer_Workshopleitung.docx` | Lösungen inkl. Zahlen, die zur `server.log` passen, Zeitpuffer-Tipp für klemmende WSL-Vorbereitung | fertig, geprüft |
| `dokumente/Handout_WSL2_im_Schulkontext.docx` | Handout zum Mitnehmen, 2 Seiten als Doppelseite: 1 WSL2 und Ubuntu installieren (mit Alltags-Handgriffen), 2 Klassen-Image entlang Video 4 und 5, 3 Hands-on: zwei Wege zur Übungsumgebung, 4 Links | fertig; Seite 1 eingefroren; Seite 2 am 05.11.2026 umgebaut |
| `server.log` | Übungsdatei, 210 Zeilen, fiktiver Server `srv-schule01` | fertig |
| `server/setup-workshop.sh` | Legt Benutzer, Gruppe, Übungsdatei und SSH auf dem Übungsserver an | am 05.11.2026 nach `server/` verschoben; **findet `server.log` dort nicht mehr**, siehe Offene Punkte |
| `server/teardown-workshop.sh` | Räumt alles wieder ab | fertig, in `server/` |
| `server/zugangsdaten-erzeugen.py` | Erzeugt den Schnittbogen mit SSH-Zugangsdaten aus dem Arbeitsblatt als Style-Vorlage | neu 05.11.2026 |
| `wsl-setup-workshop.sh`, `wsl-teardown-workshop.sh` | Weg A: Übungsbenutzer und Logdatei in der eigenen WSL-Instanz, ohne SSH | neu, mit `bash -n` geprüft, noch nicht auf einer WSL-Instanz getestet |
| `videos/` | Fünf Bildschirmaufnahmen (ca. 54 MB, Ordner seit 05.11.2026 kleingeschrieben): 1 WSL installieren, 2 Ubuntu installieren, 3 Ubuntu starten und verwenden, 4 Skript ausführen und exportieren, 5 Klassenimage importieren (neu 05.11.2026). Folie 4 (Video 1 und 2), Folie 5 (Video 3), Folie 6 (Video 4 und 5) | Video 5 noch nicht committet |
| `dokumente/Workshop_WSL2_Linux_unterrichten_neu (org).pptx` | Sicherungskopie des Nutzers, wird nicht bearbeitet | nur lokal, per `.gitignore` ausgeschlossen |
| `README.md`, `CLAUDE.md`, `.gitignore` | Beschreibung, Arbeitshinweise für Claude Code, Ignore-Regeln | aktuell (05.11.2026 auf die neuen Ordnernamen umgestellt) |

**Ordnerstruktur seit 05.11.2026** (vom Nutzer umbenannt, noch nicht committet): Office-Dateien in `dokumente/`, Videos in `videos/`, Server-Skripte und Generator in `server/`; `server.log` und die `wsl-*`-Skripte liegen im Wurzelverzeichnis. Git zeigt die alten Pfade als gelöscht und die neuen als untracked, `git add -A` erkennt die Umbenennungen, die Videos werden nicht neu hochgeladen.

Nicht im Repo und bewusst ignoriert: `dokumente/zrXL.png` (QR-Code-Quelle, steckt in der Präsentation), `dokumente/poll.txt` (DirectPoll-Links inkl. Admin-Link), `dokumente/Zugangsdaten_Uebungsserver.docx` (Schnittbogen mit interner IP und Passwörtern, lässt sich mit `server/zugangsdaten-erzeugen.py` jederzeit neu erzeugen), die MMBBS-Vorlage (Metadaten mit Namen und E-Mail von Kollegen).

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
- **Der Installationspfad steht an drei Stellen und muss übereinstimmen:** Handout Abschnitt 1 (vollständig, 14 Zeilen von `wsl --version` bis `exit`), Folie 4 (verkürzt auf `wsl --install`, `wsl --install Ubuntu-26.04`) und Folie 5 (`wsl -d Ubuntu-26.04`, `sudo apt install cowsay`, `cd /mnt/c/...`) sowie die Sprechernotizen zu Folie 4 und 5 (seit 05.11.2026 Stichworte mit Handout-Verweisen). Die Videos zeigen denselben Pfad, Gesamtdauer rund acht Minuten.
- **Beide Setup-Skripte erwarten `server.log` neben sich selbst** und kopieren sie nach `/srv/workshop/server.log`. Für `wsl-setup-workshop.sh` im Wurzelverzeichnis passt das; `server/setup-workshop.sh` findet die Datei seit der Verschiebung nicht mehr (offener Punkt).
- **Repo-Link als Übungspaket:** `https://github.com/HerrZI/wsl2-school-lab` steht im Arbeitsblatt, Handout Abschnitt 2 (git clone) und 4 (Links) sowie auf Folie 8 und 13. Das Repo muss öffentlich bleiben. Die README nennt den Link seit 05.11.2026 nicht mehr (vom Nutzer auf drei Zeilen gekürzt).
- **Festgelegte Werte:** 40 Teilnehmerkonten `user01` bis `user40` mit Passwort `akademieNN`, Image-Pfad `C:\Images\fisi-uebung.tar`, Kommentare in Befehlsblöcken mit `#`.

## Übungsserver vorbereiten

Auf einem Ubuntu-System (WSL2-Instanz, Raspberry Pi oder Mini-PC) im Veranstaltungsnetz:

```bash
sudo ./server/setup-workshop.sh 40   # Benutzer, Gruppe "workshop", Logdatei, SSH
```

**Achtung:** Das Skript sucht `server.log` im eigenen Ordner `server/`, die Datei liegt aber im Wurzelverzeichnis. Bis das Skript angepasst ist, vorher `cp server.log server/` ausführen oder das Skript aus einem Ordner starten, in dem beide nebeneinander liegen.

Das Skript gibt am Ende die IP-Adressen aus. Diese IP muss vor dem Workshop auf Folie 8 eingetragen werden, dort steht der Platzhalter `10.0.0.5`. Unter WSL2 zusätzlich in `.wslconfig` den gespiegelten Netzwerkmodus aktivieren (`[wsl2] networkingMode=mirrored`, ab Windows 11 22H2) oder eine Portweiterleitung einrichten. Nach dem Workshop:

```bash
sudo ./server/teardown-workshop.sh   # fragt nach, löscht Benutzer, Gruppe und /srv/workshop
```

Die Passwörter sind bewusst trivial. Der Server gehört nur ins lokale Netz und wird danach abgebaut.

## Checkliste vor dem Workshop

- [ ] Repo ist öffentlich und `git clone https://github.com/HerrZI/wsl2-school-lab.git` funktioniert aus einer frischen WSL-Instanz; `wsl-setup-workshop.sh` einmal durchgespielt
- [ ] Übungsserver für Weg B trotzdem aufgesetzt, SSH von einem Windows-Rechner aus getestet (`ssh user01@<IP>`)
- [ ] IP-Adresse auf Folie 8 eingetragen
- [ ] Schnittbogen `dokumente/Zugangsdaten_Uebungsserver.docx` gedruckt und in Streifen geschnitten (IP 172.31.4.47 eingebaut; bei anderer IP mit `python3 server/zugangsdaten-erzeugen.py dokumente/Arbeitsblatt_Linux_Kommandozeile.docx dokumente/Zugangsdaten_Uebungsserver.docx <IP> 40` neu erzeugen)
- [ ] Arbeitsblatt für alle, Lösungsblatt nur für die Leitung gedruckt
- [ ] Handout als Doppelseite gedruckt (2 Seiten, beidseitig) oder als PDF bereit
- [x] Videos der WSL2-Installation als Sicherheitsnetz für die Demo (fünf Stück in `videos/`, Reihenfolge wie auf Folie 4 bis 6)
- [ ] Umbenannte Ordner und Video 5 committen und pushen (`git add -A`; Push-Prüfung vom 05.11.2026 war unauffällig)
- [ ] Demo-Gerät für den Live-Teil nach Video 3: WSL mit `Ubuntu-26.04` installiert, `cowsay` vorhanden, Testdatei `aufgabe.txt` auf dem Windows-Desktop (die Installation selbst läuft über die Videos)
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

**Umstrukturierung und Push-Prüfung (05.11.2026):**

- Der Nutzer hat `Dokumente/` in `dokumente/`, `Videos/` in `videos/` umbenannt und `setup-workshop.sh`/`teardown-workshop.sh` nach `server/` verschoben. Dadurch griffen die Ignore-Regeln für `poll.txt`, `zrXL.png` und die Sicherungskopie nicht mehr; `.gitignore` auf `dokumente/` umgestellt und mit `git check-ignore` geprüft. Zusätzlich ignoriert: `__pycache__/`, `*.pyc` und der Zugangsdaten-Schnittbogen.
- Push-Prüfung: Office-Metadaten ohne Kollegennamen (Autor „Un-named“ bzw. Workshop-Titel), nur Teilnehmer-Links der Umfrage in Folie und Notiz 2, in keiner historischen Fassung der Präsentation ein Cockpit- oder Ergebnis-Link, `poll.txt` nie committet. Einzig interne IPs 172.31.4.47/48 in Notiz 8 und die bewusst trivialen Passwörter, beides unkritisch.
- Fünftes Video `05 Klassenimage importieren.mp4` aufgenommen (Nutzer), in Folie 6 und Notiz 6 eingebaut.
- Zugangsdaten-Schnittbogen `dokumente/Zugangsdaten_Uebungsserver.docx` erstellt (erst als Informationsblatt mit IP-Feldern, dann auf Wunsch des Nutzers als Schnittbogen mit 40 Streifen, Beschriftung in jeder Zelle). Generator `server/zugangsdaten-erzeugen.py` im Repo, der Bogen selbst bleibt lokal.
- Claude duzt den Nutzer seit 05.11.2026 (Wunsch des Nutzers, in der Memory abgelegt); Materialien bleiben in der Sie-Form.
- README vom Nutzer auf drei Zeilen gekürzt (Titel, Veranstaltung, Zweck); Dateitabelle und Befehle stehen nur noch hier und in der CLAUDE.md.

**Folie 2 ergänzt (05.11.2026, Wunsch des Nutzers):** Die rechte Karte „Schulrechner: häufig Windows“ endet jetzt mit dem eigenen Absatz „Dafür gibt es VMs – oder eben WSL.“ (Fassung vom Nutzer, ursprünglich mit „und darum geht es heute“). Beide Karten dafür 0,2 Zoll nach oben geschoben und 0,25 Zoll höher, Beschreibungstexte oben verankert (1,2 Zoll hoch). Sprechernotiz unverändert. Folie 2 bleibt gesperrt. Übergabe-Tabelle und Abschnitt „Wichtige Zusammenhänge“ auf den Video-Stand von Folie 4 bis 6 nachgezogen.

**Veranstaltungstitel vereinheitlicht (05.11.2026, Wunsch des Nutzers):** „Regionaler Cisco-Akademietag 2026 Niedersachsen“ statt „Regionaler Akademietag der Cisco Networking Academy“ in der Handout-Kopfzeile (Seite 1, mit Freigabe), der Fußzeile von Folie 1 (mit Freigabe), im Autor-Feld der Präsentationsmetadaten, in README und UEBERGABE. Weitere Nutzeränderungen am selben Tag: Handout Weg A und Weg B mit Zeilenumbruch nach dem fetten Label; Präsentation Notiz 7 gekürzt (Überleitung „im eigenen WSL oder auf unserem Linux Server“), Folie 6 „z.B.“, Folie 8 „auf dem Übungsserver“.

**Weitere Änderungen an Präsentation, Handout und Arbeitsblatt (05.11.2026):**

- Folie 3: „einen Server-Krimi mit Pipes“ (Akkusativ statt „ein“); später am selben Tag „Dann zwei Linux Übungen“.
- Folie 4 und 5 (Wunsch des Nutzers, von Claude geändert): `wsl --install Ubuntu-26.04` statt `wsl --install Ubuntu` (Spiegelstrich Video 2 und Terminal), `wsl -d Ubuntu-26.04` statt `wsl` (Spiegelstrich Video 3 und Terminal), damit die Befehle dem Handout entsprechen. Beide Folien gerendert, Spiegelstriche bleiben zweizeilig.
- Folie 5: Titel „Zwei Systeme nebeneinander, ein Dateisystem“ (vorher „Zwei Welten, eine Maschine“); Label „Im Unterricht:“ schwarz fett wie die übrigen Labels, nicht mehr blau.
- Notizen 1 und 3: nur zusätzliche Zeilenumbrüche.
- Notiz 4: auf Stichworte gekürzt (drei Fakten, Video 1 mit Wartezeit-Überbrückung und Git-Bash-Abgrenzung, Video 2 mit Kaffeepause, Verweis auf Handout „Weitere nützliche Befehle“ und „Wichtige Handgriffe für den Alltag“). Der ausführliche Befehlspfad und der Plan B fürs Demo-Gerät stehen nicht mehr in der Notiz.
- Notiz 5: Video-3-Teil auf eine Zeile gekürzt, Explorer-Zugriff über `\\wsl$` wird gezeigt, wenn Zeit ist; der Vorbereitungshinweis zur Testdatei ist raus und steht jetzt in der Checkliste.
- Alle drei Folien gerendert und geprüft: einzeilige Titel, Punktausrichtung und Logozone in Ordnung.
- Folie 6 (05.11.2026, Wunsch des Nutzers, von Claude umgebaut): Die Folie sah mit breitem Terminal oben und drei Icon-Karten unten anders aus als Folie 4 und 5. Jetzt liegt sie auf demselben Raster: vier Spiegelstriche links („Video 4 ·“ `sudo ./wsl-setup-workshop.sh`, `wsl --export`, `wsl --import`, „Nach der Stunde:“ mit den Inhalten der alten Karten), Terminal rechts in der Geometrie von Folie 4 (Skript, Export, Import mit Backtick-Zeilenfortsetzung, `wsl -d FISI-Uebung`, Prompt `user01@PC`). Die drei Icon-Bilder sind aus dem Paket entfernt. Notiz 6 spricht statt von „drei Karten“ von den vier Punkten links. Gerendert und geprüft; der Nutzer hat die Folie danach selbst weiterbearbeitet, sie gilt damit als abgestimmt. Nachtrag: Der Nutzer hat die Kopfzeile auf „DEMO · VIDEO 4“ gekürzt und ein fünftes Video (`05 Klassenimage importieren.mp4`) aufgenommen; Kopfzeile jetzt „VIDEO 4 UND 5“, Marker „Video 5 ·“ vor `wsl --import`, Terminal-Kommentar „# Video 5 · Schüler-PC: Image importieren“, Notiz 6 mit Video-5-Absatz (drei Argumente von `wsl --import`, Fehlerbild bei fehlendem Ordner). Auf Wunsch des Nutzers zusätzlich `wsl --unregister FISI-Uebung` als Block „Nach der Stunde: Instanz verwerfen“ im Terminal und im vierten Spiegelstrich; Terminal dafür auf 4,14 Zoll (wie Folie 5) und Zeilenabstand 17,5 pt. Danach vom Nutzer: Notiz 6 auf Stichworte gekürzt, Ausgabezeile des Skripts im Terminal entfernt, Leerzeile vor „Nach der Stunde“. Spiegelstrich 1 auf Wunsch des Nutzers allgemeiner: „Video 4 · Schüler-Image mit Aufgaben vorbereiten“ plus grauem „z. B. mit `sudo ./wsl-setup-workshop.sh`“ (geschützte Leerzeichen, damit der Zusatz geschlossen in Zeile 2 steht).
- Handout: Überschrift „2. Wichtige Handgriffe für den Alltag“ zur unnummerierten Zwischenüberschrift (11 pt fett, wie „Weitere nützliche Befehle“) am Ende von Seite 1 gemacht und die übrigen Abschnitte auf 2 Klassen-Image, 3 Übungsumgebung, 4 Links umnummeriert. Handout bleibt bei 2 Seiten. Nachgezogen von Claude: Verweis „(Abschnitt 2)“ im Weg-A-Text, Notizen zu Folie 4 und 6, CLAUDE.md und UEBERGABE.md.
- Arbeitsblatt (05.11.2026, Wunsch des Nutzers): Im Weg-A-Block sind der Kommentar „In Ubuntu: Übungspaket holen und Übungsumgebung anlegen“, `git clone`, `cd wsl2-school-lab` und `sudo ./wsl-setup-workshop.sh` entfernt. Übrig: `wsl -d Ubuntu-26.04` und `su - user01`. Offen: Die Einleitung „WSL und Ubuntu sind installiert, siehe Handout Abschnitt 1“ und der Distributionsname passen nur, wenn die Übungsumgebung vorher im eigenen Ubuntu angelegt wurde; bei einem importierten Klassen-Image hieße der Start `wsl -d FISI-Uebung`.
- Handout Abschnitt 3 (05.11.2026, Wunsch des Nutzers): Überschrift jetzt „Hands-on: zwei Wege zur Übungsumgebung“, passend zur Station „Hands-on“ auf Folie 3 (vorher „Die Übungsumgebung aus dem Workshop: zwei Wege“). Weg A erklärt jetzt, dass das Skript aus dem Übungspaket Übungsbenutzer und Logdatei anlegt (git clone, `sudo ./wsl-setup-workshop.sh 2`, wie beim Muster-Image); Block `wsl -d Ubuntu-26.04` (PowerShell: Ubuntu starten) und `su - user01` (Teardown-Zeile vom Nutzer entfernt, Startzeile auf seinen Wunsch ergänzt). Weitere Nutzeränderungen am 05.11.2026: Überschrift Abschnitt 1 heißt „WSL2 und Ubuntu installieren“ (zwischenzeitlich mit „(ca. acht Minuten)“), Einleitung Abschnitt 2 ohne „wie unsere server.log“, Lehrer-Rechner-Zeile mit „(beispielhaft)“, Server-Beispiele „WSL2-Instanz, Mini-PC, Server“. Weg B heißt „unser Übungsserver per SSH“: Wer kein WSL installieren darf, macht die Aufgaben auf dem Server; Block mit `ssh userNN@<IP>`, Passwort- und Fingerprint-Hinweis; danach ein Absatz, dass `server/setup-workshop.sh` und `server/teardown-workshop.sh` im Übungspaket liegen. Der Setup-Block (`setup-workshop.sh 30`) und der „Wichtig“-Absatz (Passwörter, gespiegelter Netzwerkmodus) sind raus, das steht als Kommentar im Skript. Später am selben Tag auf Wunsch des Nutzers weiter gekürzt: Weg A nur noch „Abschnitt 1 ausführen, dann aus Abschnitt 2 die Zeilen bis zum Skript (ohne Export und Import). Danach:“ plus Block; Weg B „Wer kein WSL installieren kann, nutzt unseren Übungsserver. Der SSH-Client ist in Windows 10/11 enthalten (PowerShell oder Eingabeaufforderung):“ plus Block mit zwei Kommentarzeilen; Server-Hinweis auf einen Satz. Weiter zwei Seiten.
- Handout Seite 2 (05.11.2026, Wunsch des Nutzers, von Claude umgebaut): Abschnitt 2 „Klassen-Image“ folgt jetzt Video 4 und 5. Block Lehrer-Rechner: `wsl -d Ubuntu-26.04`, `git clone`, `cd wsl2-school-lab`, `sudo ./wsl-setup-workshop.sh 2`, `exit`, `wsl --export`. Block Schüler-Rechner: `wsl --import`, `wsl -d FISI-Uebung`, `wsl --unregister FISI-Uebung`. Damit das Handout bei zwei Seiten bleibt, ist Weg A in Abschnitt 3 auf einen Verweis auf Abschnitt 2 plus `su - user01` und Teardown-Skript gekürzt (git clone und Skript standen dort doppelt). Seite 1 und alles ab Weg B byteidentisch geblieben, geprüft. Nachtrag (Wunsch des Nutzers): `mkdir C:\Images` vor dem Export und `mkdir C:\WSL` vor dem Import, jeweils mit Kommentar „Zielordner muss vorhanden sein“. Für die zwei Zeilen wurden die beiden Fließtextabsätze von Abschnitt 2 gekürzt (Einleitungssatz ohne „Der für den Unterricht wertvollste Mechanismus“, Import-Absatz gestrafft, Aussage unverändert). Der Nutzer hat im LPI-Unterpunkt „LPIC-1“ entfernt.

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
- Folie 3 neu gestaltet (04.11.2026, Wunsch des Nutzers): Titel „Was Sie heute erwartet“, Zeitstrahl mit vier proportionalen Abschnitten (Einstieg, Demo, Hands-on, Transfer) und Minutenmarken, darunter drei Karten Demo/Hands-on/Transfer. Hands-on-Text auf Wunsch des Nutzers in zwei Absätzen mit Leerzeile: „WSL selbst installieren oder auf dem Übungsserver arbeiten.“ / „Dann zwei Übungen: eine Kommandozeilen-Rallye und ein Server-Krimi mit Pipes“ (unbestimmter Artikel, da erste Erwähnung). Die Begriffe „Sehen / Selbst machen / Mitnehmen“ und „60 Minuten, drei Stationen“ sind weg. Notiz unverändert.
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

1. `server/setup-workshop.sh` so anpassen, dass es `server.log` auch im übergeordneten Ordner findet, dann die umbenannten Ordner, Video 5 und alle Änderungen vom 05.11.2026 committen und pushen (`git add -A`).
2. **Folien 7 bis 13 durchsehen.** Sie wurden am 04.11.2026 auf das Konzept Weg A/Weg B umgebaut; Folien 1 bis 6 sind abgestimmt.
3. Die `wsl-*`-Skripte auf einer frischen WSL-Instanz testen.

## Offene Punkte

- **`server/setup-workshop.sh` findet `server.log` nicht** (sucht neben sich selbst, Datei liegt im Wurzelverzeichnis). Vorschlag: im Skript zusätzlich `$(dirname "$0")/../server.log` prüfen, dann bleibt es bei einer Logdatei. Noch nicht umgesetzt, weil der Nutzer erst gefragt werden wollte.
- Umbenannte Ordner (`dokumente/`, `videos/`, `server/`) und Video 5 committen; Ignore-Regeln sind bereits umgestellt.
- Notiz zu Folie 8 enthält die internen IPs 172.31.4.47 und 172.31.4.48; vor dem Push entscheiden, ob sie drinbleiben.
- Arbeitsblatt Weg A: Einleitung und `wsl -d Ubuntu-26.04` passen nur, wenn die Übungsumgebung vorher im eigenen Ubuntu angelegt wurde; mit Klassen-Image hieße es `wsl -d FISI-Uebung`.
- Die `wsl-*`-Skripte einmal auf einer frischen WSL-Instanz durchspielen (Setup, `su - user01`, Arbeitsblatt Teil A und B, Teardown).
- Idee des Nutzers: Setup live in WSL zeigen, Instanz als TAR exportieren und den Teilnehmern zusammen mit den Skripten mitgeben. Vor dem Export Standardbenutzer in `/etc/wsl.conf` setzen und nie die persönliche Instanz exportieren. Handout Abschnitt 3 (Übungsumgebung) und Folie 8/13 wären dann zu ergänzen.
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
- Neue Office-Dokumente am einfachsten aus dem Arbeitsblatt-Paket klonen und nur `word/document.xml` neu schreiben (python-docx ist nicht installiert); Muster: `server/zugangsdaten-erzeugen.py`.
- Vor einem Push: `git ls-files --others --exclude-standard` gegen die Ignore-Liste prüfen und die Office-XML per Python auf Links, Mails, IPs und Namen durchsuchen (das lokale `grep` ist ein ugrep mit Komplexitätslimit).
