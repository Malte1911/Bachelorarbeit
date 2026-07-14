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

## Typst-Syntax

- Abkürzungen ausschließlich über das Makro `#acro("KÜRZEL")` aus `config/acronyms.typ` – **keine** Abkürzung ohne dieses Makro verwenden, wenn sie im Akronym-Dictionary definiert ist
- Zitationen als `@citationkey` – nur Keys verwenden, die in `resources/quellen.bib` definiert sind
- Abbildungen mit `#figure(image("../../resources/img/datei.png", width: X%), caption: [Beschriftung @quelle])`
- Formeln in Displaymode: `$ formel $`, Inline: `$formel$`
- Verweise auf andere Abschnitte: `@label`, Labels werden mit `<label>` gesetzt
- Zahlen mit Einheiten werden im folgenden Format notiert:
```typst
  Lorem ipsum $Zahl space.thin Einheitenzeichen$ Lorem ipsum
```
- Bereits vom Autor eingefügte Kommentare werden auskommentiert mit /* Text */, niemals entfernt
- IDE-Fehler wie `label does not exist` bei `@citationkey` in Einzeldateien sind erwartet – die Bibliographie wird nur im Hauptdokument eingebunden und kompiliert korrekt

## Dateistruktur

Der Inhalt liegt in `content/`. Jedes Kapitel hat eine **Integrationsdatei** (z. B. `700_fazit.typ`), die per `#include` die Unterkapitel-Dateien aus dem **gleichnamigen Ordner** (z. B. `700_Fazit/`) einbindet. Die Reihenfolge der Kapitel steht in `content/999_chapters.typ`.

```
content/
  999_chapters.typ      ← bindet alle Kapitel in Reihenfolge ein
  100_problemstellung/  ← Einleitung, Problemstellung, Ziel, Vorgehensweise (Aufbau der Arbeit)
  200_Grundlagen/       ← ECPD/Schaltkreisschutzgeräte, Powercenter, Desigo CC, Modbus, Vorgehensweise
  300_Anforderungen/    ← Analyse (System, Stakeholder), Anforderungen, Testfälle
  400_Systemumgebung/   ← Testaufbau, Gerätekonfiguration, Anbindung
  500_Entwicklung/      ← Einführung PDE, Auswahl der Daten, Mapping (JSON-Template)
  600_Validierung/      ← Strategie, Durchführung, Ergebnisse
  700_Fazit/            ← Zusammenfassung, Bewertung Praxistauglichkeit, Kritische Würdigung, Weiterentwicklung
config/
  constants.typ         ← Dokumentvariablen (Titel, Autor, Betreuer, Typ …)
  config.typ, cover.typ, functions.typ  ← Layout, Titelblatt, Hilfsfunktionen
  acronyms.typ          ← Akronym-Dictionary (immer prüfen vor Verwendung)
resources/
  quellen.bib           ← BibTeX-Quellenverzeichnis (immer prüfen vor Verwendung)
  img/                  ← Abbildungen
  datasheets/           ← Datenblätter der Geräte als Quellenmaterial
Requirements.xlsx / Requirements_EP.xlsx  ← Anforderungskatalog (Quelle für Kapitel 300)
```

Jede **Unterkapiteldatei** beginnt mit:
```typst
#import "../../config/acronyms.typ": *
#include "../../config/config.typ"
```
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
