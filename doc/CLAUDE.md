# CLAUDE.md – Studienarbeit DVPC

## Projektkontext

Typst-Studienarbeit über die Entwicklung des Driverless Vehicle PC (DVPC) für ein Formula-Student-Fahrzeug. Sprache: Deutsch. Der Schreibstil ist formal-akademisch und technisch präzise.

## Schreibstil

- Fließtext in vollständigen Sätzen, keine Stichpunkte in fertigen Abschnitten
- Sachlicher, akademischer Ton – keine wertenden Aussagen ohne Beleg
- Technische Bezeichnungen werden beim ersten Auftreten ausgeschrieben, danach abgekürzt
- Stichpunkte im Dokument sind Notizen des Autors, die in Fließtext überführt werden sollen – nicht als fertigen Text behandeln
- neue Zeilen im Dokument werden mit doppelter neuer Zeile im Code eingefügt
- Kritische Bewertungen (Stärken/Schwächen) werden sachlich und begründet formuliert, wie in den Abschnitten `=== Mounting` und `=== Kühlung` zu sehen

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

## Dateistruktur

```
content/
  100_Problemstellung/  ← Einleitung, Ziel, Vorgehensweise
  200_Grundlagen/       ← Technische Grundlagen, DVPC-Definition
  300_Anforderungen/    ← Analyse Vorjahres-DVPC, Anforderungen
  400_Entwicklung/      ← Gehäuse, Kühlung, Mounting, Elektronik
  500_Ausblick/         ← Zusammenfassung, Fazit
config/
  acronyms.typ          ← Akronym-Dictionary (immer prüfen vor Verwendung)
resources/
  quellen.bib           ← BibTeX-Quellenverzeichnis (immer prüfen vor Verwendung)
```

Jede Unterkapiteldatei beginnt mit:
```typst
#import "../../config/acronyms.typ": *
#include "../../config/config.typ"
```

IDE-Fehler wie `label does not exist` bei `@citationkey` in Einzeldateien sind erwartet – die Bibliographie wird nur im Hauptdokument eingebunden und kompiliert korrekt.

## Wichtige Regeln

- **Keine Halluzinationen bei Zitationskeys** – nur Keys aus `quellen.bib` verwenden; bei unbekannten Quellen einen Platzhalter wie `[TODO Quelle]` setzen
- **Keine erfundenen Typst-Funktionen** – nur Syntax verwenden, die im Projekt bereits vorkommt
- **Keine neuen Akronyme** ohne Ergänzung in `config/acronyms.typ`
- Produktnamen werden exakt so geschrieben wie im bestehenden Text, z. B. „Zotac", „RECOM RPMGH12-40", „TRACO TSR 2-24120"
- Komponentenbezeichnung „Casing" (nicht „Gehäuse") wird als etablierter Projektbegriff beibehalten, ebenso „Mounting", „LidarPCB", „Lidarplatine"
- bei Bildern wird ein Placeholder wir folgt eingefügt
```typst
#figure(
  image("../../resources/img/placeholder.png", width: 60%, format: "png"),
  caption: [PLACEHOLDER: Beispielcaption] 
)<kurzbeschreibung>
```
- Bilder werden wo es für sinnvoll gehalten wird eingefügt
- Quellen werden wo es gefordert ist rausgesucht und mit einem Kommentar markiert, dass sie von Claude stammen
- Steht im Text "Claude:" mach das was dahinter steht, dafür darfst du auch ins Web und so weiter
