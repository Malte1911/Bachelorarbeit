# CLAUDE.md – Bachelorarbeit ECPD-Integration in Desigo CC

## Projektkontext

Bachelorarbeit über die Entwicklung eines Datenmodells (Integrationsvorlage). Hierbei sollen die Daten der SENTRON Electronic Circuit Protection Devices (ECPD) und des SENTRON Powercenters über ein im Rahmen der Arbeit entwickeltes Datenmodell (JSON-Template) in die Gebäudemanagementplattform Desigo CC der Firma Siemens integriert werden. Das Datenmodell wird an einem Hardware-Testaufbau validiert. Die Anmeldung der Arbeit liegt in `doc\TES23_Schröter_Malte_AnmeldungBachelorarbeit_2026-1.pdf` ab.

- Sprache: Deutsch
- Betreuer (dualer Partner): Johannes Otto (Siemens AG); Gutachter/Evaluator: siehe `config/constants.typ`
- Schreibstil: formal-akademisch und technisch präzise

## Schreibstil

- Fließtext in vollständigen Sätzen, keine Stichpunkte in fertigen Abschnitten
- Sachlicher, akademischer Ton – keine wertenden Aussagen ohne Beleg
- Technische Bezeichnungen werden beim ersten Auftreten ausgeschrieben, danach abgekürzt
- Stichpunkte im Dokument sind Notizen des Autors, die in Fließtext überführt werden sollen – nicht als fertigen Text behandeln
- Neue Absätze werden im Code mit einer doppelten Leerzeile eingefügt
- Kritische Bewertungen (Stärken/Schwächen) werden sachlich und begründet formuliert
- Keine Beschreibungen mit dicker Schrift am Anfang von Absätzen machen. Das ist idealerweise zu vermeiden und es werden volle Sätze verwendet (und nicht dick geschrieben). Alternativ für kleine Zwischenüberschriften kannst du `====` verwenden
- Bitte keine Spiegelstriche `--` verwenden und die Verwendung von Doppelpunkte `:` und Semikolons `;`reduzieren
- so wenig Füllwörter wie möglich
- bei Zahlen >999 keine Punkte zwischen die Ziffern (1234, nicht 1.234)

## Typst-Syntax

- Abkürzungen ausschließlich über das Makro `#acro("KÜRZEL")` aus `config/acronyms.typ` – **keine** Abkürzung ohne dieses Makro verwenden, wenn sie im Akronym-Dictionary definiert ist
- Zitationen als `@citationkey` – nur Keys verwenden, die in `resources/quellen.bib` definiert sind
- Abbildungen mit `#figure(image("../../resources/img/datei.png", width: X%), caption: [Beschriftung @quelle])`
- Formeln in Displaymode: `$ formel $`, Inline: `$formel$`
- Verweise auf andere Abschnitte: `@label`, Labels werden mit `<label>` gesetzt
- Zahlen mit Einheiten werden im folgenden Format notiert – **ohne jedes Leerzeichen** im Quelltext, da ein Leerzeichen im Mathe-Modus mitgesetzt wird und dann eine doppelte Lücke entsteht. Das Einheitenzeichen steht in Anführungszeichen, sonst wird es als Produkt kursiver Variablen gesetzt (`mA` würde zu m·A):
```typst
  Lorem ipsum $Zahlspace.thin"Einheitenzeichen"$ Lorem ipsum
  Richtig: $230space.thin"V"$, $22,5space.thin"mA"$, $2,4space.thin"GHz"$
  Falsch:  $230 space.thin "V"$, $230space.thin "V"$   (beide erzeugen eine zu breite Lücke)
```
- Bereits vom Autor eingefügte Kommentare werden auskommentiert mit /* Text */, niemals entfernt
- Sichtbare Arbeitskommentare (rot und fett im PDF) über `#kommentar[Text]` aus `config/functions.typ` – funktioniert inline im Satz und als eigener Absatz. Der Schalter `show_comments` in `config/constants.typ` blendet für die Abgabe alle auf einmal aus. Diese Kommentare sind Notizen des Autors und werden **nicht** entfernt oder in Fließtext überführt, solange sie nicht ausdrücklich abgearbeitet wurden
- IDE-Fehler wie `label does not exist` bei `@citationkey` in Einzeldateien sind erwartet – die Bibliographie wird nur im Hauptdokument eingebunden und kompiliert korrekt

## Farben und schematische Abbildungen

**Für Grafiken werden ausschließlich Farbtöne aus der Farbbibliothek der Siemens AG verwendet** (`resources/sie-colors-overview-V1-4-4.pdf`). Die Bibliothek ist vollständig in `config/colors.typ` als `sie_*`-Konstanten hinterlegt – dort nachschlagen, nicht im PDF. **Keine** freien `rgb("…")`- oder `luma(…)`-Werte in Abbildungen, Tabellen oder Textauszeichnungen; wird ein Ton gebraucht, der noch fehlt, wird er aus dem PDF nach `colors.typ` übernommen.

Auf Kontrast achten – die Arbeit wird **nicht** für Schwarzweißdruck optimiert, wohl aber auf Lesbarkeit:

- Text ab 4,5 : 1 gegen den Untergrund, Linien und Flächen ab 3,0 : 1
- `sie_deep_blue` (20,4 : 1) für Haupttext und Rahmen, `sie_deep_blue_60` (5,6 : 1) für Nebentext, `sie_deep_blue_50` (3,8 : 1) für zurückgenommene Linien
- `sie_siemens_petrol` erreicht nur 3,5 : 1 und trägt deshalb Linien und Flächen, **keinen Text**; als Akzenttext dient `sie_dark_green` (6,9 : 1) aus derselben Farbfamilie
- Die Kontrastwerte gegen Weiß stehen als Tabelle am Ende von `config/colors.typ`

Schematische Abbildungen werden mit `fletcher` (`@preview/fletcher:0.5.8`, Version exakt pinnen) in `config/diagrams.typ` gezeichnet, nicht als externe Bilddatei. Die Datei hält die gemeinsame Bildsprache in `dg_*`-Konstanten und Bausteinen (`dg_geraet`, `dg_werkzeug`, `dg_notiz`, `dg_legende`) und darunter die Diagramme als benannte Werte. Neue Abbildungen verwenden diese Bausteine, damit alle Grafiken der Arbeit dieselbe Sprache sprechen:

- durchgezogene Kante = laufender Datenpfad im Betrieb
- gestrichelte Kante = Engineering- und Inbetriebnahmezugriff
- Rahmen in Petrol = Systemgrenze der Arbeit
- Sandfläche = Zusammenfassung zu einer Einheit

Am Ende von `config/diagrams.typ` steht eine Vorschauseite, damit die Datei allein kompiliert und im Editor betrachtet werden kann. `#import` verwirft diesen Teil – die Datei darf deshalb **nur importiert, nie inkludiert** werden.

## Dateistruktur

Der Inhalt liegt in `content/`. Jedes Kapitel hat eine **Integrationsdatei** (z. B. `700_fazit.typ`), die per `#include` die Unterkapitel-Dateien aus dem **gleichnamigen Ordner** (z. B. `700_fazit/`) einbindet. Die Reihenfolge der Kapitel steht in `content/999_chapters.typ`.

**Namenskonvention:** Kapitel-Container (Ordner + Integrationsdatei) tragen denselben Namen und werden **kleingeschrieben** (`NNN_thema`). Unterkapitel-Dateien werden nach ihrem Inhalt benannt, deutsche Nomen groß, mehrteilige Namen mit Unterstrich (`NNN0_Thema_Zusatz.typ`).

```
content/
  999_chapters.typ      ← bindet alle Kapitel in Reihenfolge ein
  100_einleitung/       ← Ausgangslage, Problemstellung, Zielsetzung und Abgrenzung, Aufbau der Arbeit
  200_grundlagen/       ← ECPD/Schaltkreisschutzgeräte, Powercenter, Desigo CC, Modbus, Vorgehensweise
  300_anforderungen/    ← Analyse (System, Stakeholder), Anforderungskatalog, Testfälle
  400_umgebung/         ← Testaufbau, Gerätekonfiguration, Kommunikationsstrecke, Werkzeuge
  500_entwicklung/      ← Modellaufbau, Auswahlkriterien, Datenpunkte, Umsetzung im PDE, Übernahme, Doku
  600_validierung/      ← Vorbereitung, Durchführung und Ergebnisse, Befunde, Anforderungsabgleich
  700_fazit/            ← Zusammenfassung, Bewertung Praxistauglichkeit, Kritische Würdigung, Weiterentwicklung
config/
  constants.typ         ← Dokumentvariablen (Titel, Autor, Betreuer, Typ …)
  config.typ, cover.typ, functions.typ  ← Layout, Titelblatt, Hilfsfunktionen
  acronyms.typ          ← Akronym-Dictionary (immer prüfen vor Verwendung)
  colors.typ            ← Farbbibliothek der Siemens AG (einzige Farbquelle)
  diagrams.typ          ← Bildsprache und schematische Abbildungen (fletcher)
resources/
  quellen.bib           ← BibTeX-Quellenverzeichnis (immer prüfen vor Verwendung)
  img/                  ← Abbildungen
  datasheets/           ← Datenblätter der Geräte als Quellenmaterial
  sie-colors-overview-V1-4-4.pdf  ← Original der Farbbibliothek
Requirements.xlsx / Requirements_EP.xlsx  ← Anforderungskatalog (Quelle für Kapitel 300)
```

Jede **Unterkapiteldatei** beginnt mit:
```typst
#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"
```
Der Import von `functions.typ` stellt die Hilfsfunktionen (u. a. `#kommentar`) bereit. Ausnahme: `content/999_appendix.typ` darf `functions.typ` **nicht** importieren, da `insertAppendix` die Datei ihrerseits inkludiert und daraus ein zyklischer Import entstünde.
Die **Integrationsdateien** beginnen stattdessen mit:
```typst
#import "../config/functions.typ" : *
```

## Struktur anpassen (Kapitel & Unterkapitel)

Die Nummerierung im PDF entsteht automatisch aus der Reihenfolge der `#include`/`#importChapter`-Aufrufe – **niemals Kapitelnummern im Text hart eintragen**. Um die Gliederung zu ändern, gilt:

**Kapitel hinzufügen / entfernen / umsortieren:**
1. In `content/999_chapters.typ` den `#importChapter("../content/NNN_name.typ")`-Eintrag ergänzen/entfernen/verschieben.
2. Für ein neues Kapitel eine Integrationsdatei `content/NNN_name.typ` anlegen: beginnt mit `#import "../config/functions.typ" : *`, dann `= Kapitelname`, danach die `#include`-Zeilen der Unterkapitel.
3. Zugehörigen Unterordner `content/NNN_Name/` anlegen.

**Unterkapitel hinzufügen / entfernen / umsortieren:**
1. Datei im Kapitelordner anlegen/umbenennen. Der Zahlen-Präfix (`NNN_`) bestimmt nur die Lesbarkeit/Sortierung im Dateisystem – die tatsächliche Reihenfolge im Dokument ergibt sich aus der `#include`-Reihenfolge in der Integrationsdatei.
2. **Immer** die zugehörige Integrationsdatei (`NNN_kapitel.typ`) anpassen: `#include`-Zeile ergänzen/entfernen/umsortieren.
3. Überschriftenebene in der Datei: Kapitel = `=`, Unterkapitel = `==`, Unterunterkapitel = `===`.

**Beim Umbenennen/Umnummerieren von Dateien** `git mv` verwenden, damit die Historie erhalten bleibt; danach den Pfad in der Integrationsdatei aktualisieren.

## Wichtige Regeln

- **Keine Halluzinationen bei Zitationskeys** – nur Keys aus `quellen.bib` verwenden; bei unbekannten Quellen einen Platzhalter wie `[TODO Quelle]` setzen
- **Keine erfundenen Typst-Funktionen**
- **Keine neuen Akronyme** ohne Ergänzung in `config/acronyms.typ`
- Bei Bildern wird ein Placeholder wie folgt eingefügt:
```typst
#figure(
  image("../../resources/img/placeholder.png", width: 60%, format: "png"),
  caption: [PLACEHOLDER: Beispielcaption]
)<img:kurzbeschreibung>
```
- Labels immer korrekt markieren: Tabellen mit `<tab:tabellenname>`, Bilder mit `<img:kurzbeschreibung>`, Formeln mit `<eqa:formelname>`, Abschnitte mit `<sec:abschnittskurzname>` usw.
- Bilder werden dort eingefügt, wo es sinnvoll ist
- Quellen werden dort, wo gefordert, recherchiert und mit einem Kommentar markiert, dass sie von Claude stammen
- Steht im Text "Claude:", wird die dahinterstehende Anweisung ausgeführt – dafür ist auch Web-Recherche erlaubt
