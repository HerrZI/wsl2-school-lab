#!/usr/bin/env python3
# Erzeugt den Schnittbogen mit SSH-Zugangsdaten fuer Weg B (ein Streifen je Konto).
# Als Style-Vorlage dient das Arbeitsblatt, der Inhalt wird komplett neu geschrieben.
#
# Aufruf (im Repo-Wurzelverzeichnis):
#   python3 server/zugangsdaten-erzeugen.py dokumente/Arbeitsblatt_Linux_Kommandozeile.docx \
#           dokumente/Zugangsdaten_Uebungsserver.docx 172.31.4.47 40
#
# Argumente: Vorlage.docx  Ziel.docx  IP-Adresse  Anzahl Konten (user01..userNN, Passwort akademieNN)
import re, sys, zipfile
from xml.sax.saxutils import escape
src, dst, ip, n = sys.argv[1], sys.argv[2], sys.argv[3], int(sys.argv[4])
z = zipfile.ZipFile(src)
doc = z.read("word/document.xml").decode("utf-8")
head = doc[:doc.index("<w:body>") + len("<w:body>")]
sect = re.search(r"<w:sectPr.*?</w:sectPr>", doc, re.S).group(0)
FONT = '<w:rFonts w:ascii="Calibri" w:hAnsi="Calibri" w:eastAsia="Calibri" w:cs="Calibri" />'
MONO = '<w:rFonts w:ascii="Courier New" w:hAnsi="Courier New" w:eastAsia="Courier New" w:cs="Courier New" />'
def run(text, sz=24, bold=False, color=None, mono=False):
    return '<w:r><w:rPr>%s%s%s<w:sz w:val="%d" /><w:szCs w:val="%d" /></w:rPr><w:t xml:space="preserve">%s</w:t></w:r>' % (
        MONO if mono else FONT, "<w:b/><w:bCs/>" if bold else "", '<w:color w:val="%s" />' % color if color else "", sz, sz, escape(text))
def cell_p(r): return '<w:p><w:pPr><w:spacing w:after="0" /><w:ind /><w:rPr></w:rPr></w:pPr>%s<w:r></w:r></w:p>' % r
W = [6200, 3160]
ROW_H = 660   # 1,16 cm – bequem mit der Schere zu schneiden
B = []
B.append('<w:p><w:pPr><w:spacing w:after="120" /><w:ind /><w:rPr></w:rPr></w:pPr>%s<w:r></w:r></w:p>' %
         run("Zugangsdaten Übungsserver (Weg B) – Streifen entlang der Linien abschneiden, ein Streifen je Team (Passwort beim Tippen unsichtbar, Fingerprint-Frage mit yes beantworten)", sz=18, color="6b7280"))
tbl = ['<w:tbl><w:tblPr><w:tblW w:w="%d" w:type="dxa"/><w:tblBorders>' % sum(W) +
       "".join('<w:%s w:val="single" w:color="6b7280" w:sz="8" w:space="0" />' % s for s in ("top", "left", "bottom", "right", "insideH", "insideV")) +
       '</w:tblBorders><w:tblLook w:val="04A0"/></w:tblPr><w:tblGrid>%s</w:tblGrid>' % "".join('<w:gridCol w:w="%d"/>' % w for w in W)]
def row(cells, header=False):
    trpr = '<w:trPr><w:cantSplit/><w:trHeight w:val="%d" w:hRule="atLeast"/>%s</w:trPr>' % (ROW_H if not header else 420, "<w:tblHeader/>" if header else "")
    out = ["<w:tr>%s" % trpr]
    for i, r in enumerate(cells):
        shd = '<w:shd w:val="clear" w:color="auto" w:fill="f3f4f6" />' if header else ""
        out.append('<w:tc><w:tcPr><w:tcW w:w="%d" w:type="dxa"/>%s<w:tcMar><w:left w:w="160" w:type="dxa"/><w:right w:w="160" w:type="dxa"/></w:tcMar><w:vAlign w:val="center"/></w:tcPr>%s</w:tc>' % (W[i], shd, cell_p(r)))
    out.append("</w:tr>")
    return "".join(out)
for i in range(1, n + 1):
    # Beschriftung steht in jeder Zelle, damit jeder abgeschnittene Streifen fuer sich verstaendlich ist
    tbl.append(row([run("SSH Login (PowerShell):  ", sz=18, color="6b7280") + run("ssh user%02d@%s" % (i, ip), sz=22, mono=True, color="1f2937"),
                    run("Passwort:  ", sz=18, color="6b7280") + run("akademie%02d" % i, sz=22, mono=True, color="1f2937")]))
tbl.append("</w:tbl>")
B.append("".join(tbl))
body = head + "".join(B) + sect + "</w:body></w:document>"
core = re.sub(r"<dc:title>[^<]*</dc:title>", "<dc:title>Zugangsdaten Übungsserver (Weg B)</dc:title>", z.read("docProps/core.xml").decode("utf-8"))
with zipfile.ZipFile(dst, "w", zipfile.ZIP_DEFLATED) as zout:
    for item in z.infolist():
        data = z.read(item.filename)
        if item.filename == "word/document.xml": data = body.encode("utf-8")
        if item.filename == "docProps/core.xml": data = core.encode("utf-8")
        zout.writestr(item, data)
print("ok")
