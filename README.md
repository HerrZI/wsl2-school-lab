# wsl2-school-lab

Material für den Lehrkräfte-Workshop **„Linux unterrichten mit WSL2“** (60 Minuten, Regionaler Akademietag der Cisco Networking Academy): Linux-Kommandozeile auf Windows-Schulrechnern unterrichten, ohne einen einzigen Rechner neu aufzusetzen.

## Zwei Wege zur Übungsumgebung

**Weg A – eigene WSL-Instanz (Hauptweg).** WSL und Ubuntu installieren (Anleitung im Handout, Abschnitt 1), dann in Ubuntu:

```bash
git clone https://github.com/HerrZI/wsl2-school-lab.git
cd wsl2-school-lab
sudo ./wsl-setup-workshop.sh      # legt user01, user02 und /srv/workshop/server.log an
su - user01                       # Passwort: akademie01 – jetzt das Arbeitsblatt bearbeiten
sudo ./wsl-teardown-workshop.sh   # räumt alles wieder ab
```

**Weg B – gemeinsamer Übungsserver (ohne Admin-Rechte auf dem eigenen Gerät).** Auf einem Ubuntu-System im lokalen Netz, etwa einer WSL2-Instanz auf dem Lehrerrechner oder einem Raspberry Pi:

```bash
sudo ./setup-workshop.sh 40       # user01..user40, Übungsdatei, startet SSH
sudo ./teardown-workshop.sh       # räumt alles wieder ab
```

Die Teilnehmer verbinden sich aus der PowerShell mit `ssh userNN@<IP>`. Die Passwörter sind bewusst trivial, der Server gehört nur ins lokale Veranstaltungs- oder Schulnetz.

## Dateien

| Datei | Zweck |
|---|---|
| `Workshop_WSL2_Linux_unterrichten_neu.pptx` | Präsentation mit Sprechernotizen (13 Folien) |
| `Handout_WSL2_im_Schulkontext.docx` | Handout: Installation, Alltag, Klassen-Image, Übungsumgebung, Stolperstellen, LPI-Material |
| `Arbeitsblatt_Linux_Kommandozeile.docx` | Arbeitsblatt: Mini-Rallye (Teil A) und Pipes-Challenge „Server-Krimi“ (Teil B) |
| `Loesungsblatt_fuer_Workshopleitung.docx` | Lösungen mit den Zahlen zur mitgelieferten Logdatei |
| `server.log` | Übungsdatei, 210 Zeilen eines fiktiven Schulservers |
| `wsl-setup-workshop.sh`, `wsl-teardown-workshop.sh` | Übungsumgebung in der eigenen WSL-Instanz anlegen und entfernen (ohne SSH) |
| `setup-workshop.sh`, `teardown-workshop.sh` | Gemeinsamen Übungsserver mit SSH anlegen und entfernen |
| `Videos/` | Bildschirmaufnahmen des Installationspfads (Sicherheitsnetz für die Demo) |
| `UEBERGABE.md` | Stand, Checkliste und offene Punkte für die Workshopleitung |

Alle Skripte brauchen `sudo`, legen Systembenutzer an und erwarten die `server.log` neben sich. Die Übungen bauen auf den frei verfügbaren LPIC-1-Lernmaterialien des Linux Professional Institute auf (learning.lpi.org/de).
