// Schematische Abbildungen der Arbeit.
//
// Diese Datei enthaelt zwei Teile:
//   1. die gemeinsame Bildsprache (Farben, Stricharten, Knotenformen) und
//      die einzelnen Diagramme als benannte Werte,
//   2. ganz unten eine Vorschauseite, damit die Datei allein kompiliert und
//      im Editor betrachtet werden kann.
//
// Der Vorschauteil stoert die Einbindung nicht: `#import` wertet die Datei zwar
// aus, uebernimmt daraus aber nur die Definitionen und verwirft den Inhalt.
// Die Datei darf deshalb nur per `#import` verwendet werden, niemals per
// `#include`.

#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "acronyms.typ": *
#import "colors.typ": *

// ---------------------------------------------------------------------------
// Bildsprache
// ---------------------------------------------------------------------------
// Die Kodierung ist ueber alle Abbildungen hinweg gleich:
//   durchgezogene Kante  = laufender Datenpfad im Betrieb
//   gestrichelte Kante   = Engineering- und Inbetriebnahmezugriff
//   Rahmen in Petrol     = Systemgrenze der Arbeit
//   Sandflaeche          = Zusammenfassung zu einer Einheit (z. B. Strang)
//
// Drei Abbildungen erweitern oder ersetzen diese Kodierung und weisen das
// jeweils in einer eigenen Legende aus: abb_vmodell und abb_ablauf_entwicklung
// zeigen einen Arbeitsablauf statt eines Datenpfads, abb_testaufbau traegt
// zusaetzlich den Stromkreis (dg_linie_strom).
//
// Alle Toene stammen aus config/colors.typ, also aus der Farbbibliothek der
// Siemens AG. Die Zuordnung folgt dem Kontrast gegen Weiss: Deep Blue traegt
// den Haupttext, Deep Blue 60 % den Nebentext, Deep Blue 50 % die
// zurueckgenommenen Linien. Siemens Petrol als Markenfarbe erreicht 3,5 : 1
// und traegt deshalb Linien und Flaechen, aber keinen Text -- dafuer steht
// mit Dark Green ein dunklerer Ton derselben Familie bereit.

#let dg_text = sie_deep_blue // Haupttext und Rahmen im Datenpfad
#let dg_grau = sie_deep_blue_60 // Nebentext
#let dg_zurueck = sie_deep_blue_50 // Linien der Nebenwege
#let dg_akzent = sie_siemens_petrol // Akzent in Linie und Flaeche
#let dg_akzent_text = sie_dark_green // Akzent als Text
#let dg_flaeche = sie_bright_sand // hinterlegte Flaeche
#let dg_flaeche_hell = sie_light_sand // schwaecher hinterlegte Flaeche
// Rein dekorative Hinterlegung in der Akzentfarbe. Es ist derselbe
// Bibliothekston wie `dg_akzent`, lediglich stark transparent gesetzt, damit
// Kaesten und Beschriftungen darauf ihren Kontrast behalten. Ein neuer Farbwert
// entsteht dadurch nicht.
#let dg_akzent_flaeche = sie_siemens_petrol.transparentize(86%)
#let dg_schrift = 9pt
#let dg_klein = 8pt

#let dg_linie_betrieb = 0.7pt + dg_text
#let dg_linie_engineering = 0.7pt + dg_zurueck
#let dg_rahmen_geraet = 0.7pt + dg_text
#let dg_rahmen_werkzeug = (paint: dg_zurueck, thickness: 0.7pt, dash: "dashed")
#let dg_rahmen_grenze = (paint: dg_akzent, thickness: 1pt, dash: "dashed")
// Elektrische Verbindung, also Speisung und Laststrom. Sie kommt nur in
// abb_testaufbau vor, wo neben dem Datenpfad auch der Stromkreis zu zeigen ist.
// Der Akzentton traegt hier eine Linie und keinen Text, was seinem Kontrast
// entspricht; ein neuer Farbwert entsteht nicht.
#let dg_linie_strom = 1.1pt + dg_akzent

// Beschriftung innerhalb eines Kastens: Titel fett, Erlaeuterung klein und grau
// Titel wird nicht getrennt, damit Produktnamen zusammenbleiben; die
// Erlaeuterung darf trennen, sonst sprengen die deutschen Komposita den Kasten.
#let dg_inhalt(titel, zusatz, farbe: dg_text) = {
  set align(center)
  set text(lang: "de")
  text(size: dg_schrift, weight: "bold", fill: farbe, hyphenate: false)[#titel]
  if zusatz != none {
    linebreak()
    text(size: dg_klein, fill: dg_grau, hyphenate: true)[#zusatz]
  }
}

// Geraet oder System im laufenden Datenpfad
#let dg_geraet(pos, titel, zusatz: none, name: none, breite: 60mm) = node(
  pos,
  dg_inhalt(titel, zusatz),
  name: name,
  width: breite,
  fill: white,
  stroke: dg_rahmen_geraet,
  inset: 7pt,
)

// Werkzeug: nicht Teil des laufenden Datenpfads, deshalb abgesetzt
#let dg_werkzeug(pos, titel, zusatz: none, name: none, breite: 38mm) = node(
  pos,
  dg_inhalt(titel, zusatz, farbe: dg_grau),
  name: name,
  width: breite,
  fill: white,
  stroke: dg_rahmen_werkzeug,
  inset: 6pt,
)

// Phase eines Vorgehensmodells. Eigener Baustein, weil eine Phase kein Geraet
// ist -- gleiche Schrift und gleicher Rahmen, aber schmaler, damit zwei Aeste
// nebeneinander in den Satzspiegel passen.
#let dg_phase(pos, titel, zusatz: none, name: none, breite: 47mm) = node(
  pos,
  dg_inhalt(titel, zusatz),
  name: name,
  width: breite,
  fill: white,
  stroke: dg_rahmen_geraet,
  inset: 5pt,
)

// Randbeschriftung ohne eigenen Rahmen
#let dg_notiz(pos, body, farbe: dg_grau, breite: 32mm) = node(
  pos,
  {
    set align(left)
    set par(justify: false, leading: 0.5em)
    text(size: dg_klein, fill: farbe)[#body]
  },
  width: breite,
  stroke: none,
  fill: none,
  inset: 2pt,
)

// Zeichenerklaerung, damit die Kodierung ohne Rueckgriff auf den Text lesbar ist
#let dg_legende(..eintraege) = {
  set text(size: dg_klein, fill: dg_grau)
  set align(center)
  grid(
    columns: eintraege.pos().len(),
    column-gutter: 5mm,
    ..eintraege.pos().map(((probe, beschriftung)) => box(
      inset: (y: 1pt),
      [#box(baseline: -0.15em, probe) #h(1.5mm) #beschriftung],
    ))
  )
}

// ---------------------------------------------------------------------------
// Abbildung: Systemaufbau und Systemgrenzen  (Abschnitt 3.1)
// ---------------------------------------------------------------------------
// Aufbau: Hauptpfad senkrecht von der Feldebene nach oben zur Management-
// station, die beiden Werkzeuge seitlich angetragen, rechts die Anmerkungs-
// spalte mit Systemgrenze und Strang.

#let abb_systemaufbau = {
  set text(font: "Arial", size: dg_schrift, fill: dg_text)
  align(center, diagram(
    spacing: (13mm, 15mm),
    edge-stroke: dg_linie_betrieb,
    label-size: dg_klein,
    label-sep: 4pt,
    // Beschriftungen stehen neben ihrer Kante, nicht auf ihr; ein
    // freigestanzter Hintergrund wuerde Loecher in die graue Flaeche reissen
    label-wrapper: kante => box(kante.label, inset: (x: 2pt, y: 1pt)),

    // --- Hauptpfad ---
    dg_geraet(
      (0, 0),
      [Desigo CC],
      zusatz: [Objektmodell, Archivierung, Alarmierung, Bedienung],
      name: <dcc>,
    ),
    dg_geraet(
      (0, 1),
      [SENTRON Powercenter],
      zusatz: [koppelt bis zu 24 Endgeräte an und stellt den
        Modbus-Registerraum bereit],
      name: <pc>,
    ),
    dg_geraet(
      (0, 2),
      [#acro("ECPD") 5TY1 COM],
      zusatz: [Endstromkreisschutz im\ Installationsverteiler, ohne eigene\
        Ethernet-Schnittstelle],
      name: <ecpd>,
    ),

    edge(
      <pc>,
      <dcc>,
      "<->",
      label: [Modbus #acro("TCP")\ über das Gebäudenetz],
      label-side: right,
    ),
    edge(
      <ecpd>,
      <pc>,
      "<->",
      dash: "dashed",
      stroke: dg_linie_betrieb,
      label: [proprietäre\ Funkstrecke],
      label-side: right,
    ),

    // --- Werkzeuge, nicht Teil des laufenden Datenpfads ---
    dg_werkzeug(
      (-1, 0),
      [#acro("PDE")],
      zusatz: [erzeugt die\ Gerätetypbeschreibung],
      name: <pde>,
    ),
    dg_werkzeug(
      (-1, 1.75),
      [SENTRON Powerconfig],
      zusatz: [Inbetriebnahme und\ Parametrierung, Zugriff\ nur über das Powercenter],
      name: <pcfg>,
    ),

    edge(
      <pde>,
      <dcc>,
      "->",
      dash: "dashed",
      stroke: dg_linie_engineering,
      label: text(fill: dg_grau)[#acro("JSON")],
    ),
    // Bewusst nur eine Kante von SENTRON Powerconfig, und zwar zum
    // Powercenter. Das Endgeraet besitzt ausser der Funkstrecke keine
    // Schnittstelle und ist deshalb weder ueber BLE noch ueber Ethernet
    // unmittelbar ansprechbar. Beide Zugaenge enden am Powercenter, das die
    // Parametrierung ueber die Funkstrecke an das Endgeraet weiterreicht.
    // Eine fruehere Fassung trug eine zweite Kante zum Endgeraet und legte
    // damit eine unmittelbare Inbetriebnahme nahe, die es nicht gibt.
    edge(
      <pcfg>,
      <pc>,
      "->",
      dash: "dashed",
      stroke: dg_linie_engineering,
      label: text(fill: dg_grau)[#acro("BLE") oder\ REST-#acro("API")],
      label-side: left,
      label-pos: 55%,
    ),

    // --- Zusammenfassungen ---
    // Strang: graue Flaeche hinter Powercenter und Endgeraeten
    node(
      enclose: (<pc>, <ecpd>),
      fill: dg_flaeche,
      stroke: none,
      // deutlich groesser als die Systemgrenze, damit die beiden ueberlappenden
      // Bereiche am Powercenter als zwei Formen erkennbar bleiben
      inset: 14pt,
      layer: -2,
      name: <strang>,
    ),
    // Systemgrenze: gestrichelter Rahmen um Registerraum und Objektmodell
    node(
      enclose: (<pc>, <dcc>),
      fill: none,
      stroke: dg_rahmen_grenze,
      inset: 4pt,
      layer: -1,
      name: <grenze>,
    ),

    dg_notiz(
      (1, 0.5),
      [*Gegenstand der Arbeit:* Abbildung des Modbus-Registerraums
        auf das Objektmodell],
      farbe: dg_akzent_text,
    ),
    dg_notiz(
      (1, 1.75),
      [*Strang:* ein Powercenter mit den ihm zugeordneten Endgeräten],
    ),
  ))

  v(4mm)

  dg_legende(
    (line(length: 9mm, stroke: dg_linie_betrieb), [Datenpfad im Betrieb]),
    (
      line(length: 9mm, stroke: (paint: dg_grau, thickness: 0.7pt, dash: "dashed")),
      [Engineering-Zugriff],
    ),
    (
      rect(width: 9mm, height: 3.2mm, stroke: dg_rahmen_grenze, fill: none),
      [Systemgrenze],
    ),
    (rect(width: 9mm, height: 3.2mm, stroke: none, fill: dg_flaeche), [Strang]),
  )
}


// ---------------------------------------------------------------------------
// Abbildung: V-Modell als Vorgehensmodell der Arbeit  (Abschnitt 2.6)
// ---------------------------------------------------------------------------
// ACHTUNG, abweichende Kodierung: Diese Abbildung zeigt keinen Datenpfad,
// sondern einen Ablauf. Die Kanten tragen deshalb eine eigene Bedeutung, die
// in der Legende ausgewiesen wird:
//   durchgezogene Kante  = Abfolge der Phasen
//   gestrichelte Kante   = Zuordnung einer Spezifikations- zu einer Pruefebene
//   Kante in Petrol      = Rueckkopplung aus der Erprobung in die Auswahl
// Farben, Schrift und Rahmen bleiben unveraendert, damit die Abbildung trotz
// der anderen Aussage zur uebrigen Bildsprache passt.
//
// Aufbau: linker Ast bei x = 0 absteigend, Umsetzung als Scheitel bei x = 1,
// rechter Ast bei x = 2 aufsteigend. Die waagerechten Kanten verbinden die
// einander zugeordneten Ebenen.

#let abb_vmodell = {
  set text(font: "Arial", size: dg_schrift, fill: dg_text)
  align(center, diagram(
    spacing: (4mm, 10mm),
    edge-stroke: dg_linie_betrieb,
    label-size: dg_klein,
    label-sep: 3pt,
    label-wrapper: kante => box(
      fill: white,
      inset: (x: 2pt, y: 1pt),
      text(fill: dg_grau)[#kante.label],
    ),

    // --- namensgebendes V als Hintergrund ---
    // Kein Bedeutungstraeger, sondern Schmuck: das Band zeichnet die Form nach,
    // die dem Modell seinen Namen gibt, und laeuft dazu hinter den Kaesten
    // durch. Es liegt deshalb auf der untersten Ebene und ohne Pfeilspitzen.
    // Die Endpunkte liegen bewusst etwas oberhalb der ersten Zeile, damit die
    // Aeste nicht mitten im obersten Kasten abbrechen.
    edge(
      (0, -0.4),
      (1, 3),
      stroke: (paint: dg_akzent_flaeche, thickness: 16mm, cap: "round", join: "round"),
      layer: -3,
    ),
    edge(
      (1, 3),
      (2, -0.4),
      stroke: (paint: dg_akzent_flaeche, thickness: 16mm, cap: "round", join: "round"),
      layer: -3,
    ),

    // --- absteigender Ast: zunehmende Konkretisierung ---
    dg_phase(
      (0, 0),
      [Analyse],
      zusatz: [Anwendungsfälle und bewertete Integrationswege],
      name: <analyse>,
    ),
    dg_phase(
      (0, 1),
      [Anforderungen und Testfälle],
      zusatz: [Anforderungskatalog und Testfälle],
      name: <anforderungen>,
    ),
    dg_phase(
      (0, 2),
      [Auswahl der Daten],
      zusatz: [Datenpunktauswahl je Gerätetyp mit Bilanz der Reduktion],
      name: <auswahl>,
    ),

    // --- Scheitel ---
    dg_phase(
      (1, 3),
      [Umsetzung des Mappings],
      zusatz: [zwei JSON-Typbeschreibungen und das Objektmodell],
      name: <umsetzung>,
    ),

    // --- aufsteigender Ast: zunehmende Integration und Pruefung ---
    dg_phase(
      (2, 2),
      [Durchführung der Tests],
      zusatz: [Nachweis am Testaufbau, am Artefakt und durch Begutachtung],
      name: <durchfuehrung>,
    ),
    dg_phase(
      (2, 1),
      [Ergebnisse der Tests],
      zusatz: [Anforderungsabgleich mit Erfüllungsgrad je Anforderung],
      name: <ergebnisse>,
    ),
    dg_phase(
      (2, 0),
      [Bewertung],
      zusatz: [Bewertung der Praxistauglichkeit],
      name: <bewertung>,
    ),

    // --- Phasenfolge ---
    edge(<analyse>, <anforderungen>, "->"),
    edge(<anforderungen>, <auswahl>, "->"),
    edge(<auswahl>, <umsetzung>, "->"),
    edge(<umsetzung>, <durchfuehrung>, "->"),
    edge(<durchfuehrung>, <ergebnisse>, "->"),
    edge(<ergebnisse>, <bewertung>, "->"),

    // --- Zuordnung Spezifikation und Pruefung ---
    // Alle Zuordnungskanten sind gleich gezeichnet. Die Rueckkopplung zwischen
    // Umsetzung und Pruefung traegt eine eigene Kante, siehe unten.
    edge(
      <auswahl>,
      <durchfuehrung>,
      "--",
      dash: "dashed",
      stroke: dg_linie_engineering,
      label: [verifiziert gegen],
    ),
    edge(
      <anforderungen>,
      <ergebnisse>,
      "--",
      dash: "dashed",
      stroke: dg_linie_engineering,
      label: [validiert gegen],
    ),
    edge(
      <analyse>,
      <bewertung>,
      "--",
      dash: "dashed",
      stroke: dg_linie_engineering,
      label: [bewertet gegen],
    ),
    // --- Rueckkopplung aus der Erprobung in die Auswahl ---
    // Eigene Kantenart, weil es sich weder um die Abfolge der Phasen noch um
    // eine Zuordnung von Spezifikation und Pruefung handelt. Belegt ist dieser
    // Rueckfluss in @sec:umsetzung: die Erprobung am Testaufbau waehrend der
    // Umsetzung hat Datenpunkte aus der zuvor getroffenen Auswahl gestrichen.
    // Bewusst NICHT von der Durchfuehrung auf die Umsetzung gezeichnet, denn
    // Kapitel 6 stellt Befunde fest und aendert das Modell nicht daraufhin.
    // Gebogen, damit die Kante nicht auf der Phasenfolge liegt.
    edge(
      <umsetzung>,
      <auswahl>,
      "->",
      bend: 40deg,
      stroke: 0.7pt + dg_akzent,
      label: [Erprobung ändert die Auswahl],
    ),
  ))

  v(4mm)

  dg_legende(
    (line(length: 9mm, stroke: dg_linie_betrieb), [Abfolge der Phasen]),
    (
      line(length: 9mm, stroke: (paint: dg_grau, thickness: 0.7pt, dash: "dashed")),
      [Zuordnung von Spezifikation und Prüfung],
    ),
    (
      line(length: 9mm, stroke: 0.7pt + dg_akzent),
      [Rückkopplung aus der Erprobung in die Auswahl],
    ),
  )
}


// ---------------------------------------------------------------------------
// Abbildung: Erstes Loesungskonzept  (Abschnitt 3.1.5)
// ---------------------------------------------------------------------------
// Die Kodierung folgt der gemeinsamen Bildsprache, nur auf Artefakte erweitert:
//   gestrichelter Rahmen = Engineering-Artefakt oder Werkzeug, also alles, was
//                          vor dem Betrieb entsteht und im Betrieb nicht laeuft
//   durchgezogener Rahmen = Gegenstand des laufenden Betriebs
//   gestrichelte Kante    = Engineering-Schritt
//   durchgezogene Kante   = laufender Datenpfad
// Der Aufbau liest sich von links nach rechts als Werkzeugkette und von oben
// nach unten als Weg von der Typ- auf die Instanzebene. Die Instanzliste steht
// bewusst in derselben Spalte wie die Typbeschreibung, weil sie wie diese im
// Projekt erzeugt wird, aber nicht aus dem PDE stammt.
//
// Eine zuvor hier gezeichnete "Adressbelegung" als eigenes Artefakt ist
// entfallen. Sie gehoert zum allgemeinen Importweg von Desigo CC, waehrend der
// PDE die Registeradressen in dieselbe JSON-Datei schreibt. Fuer den in der
// Arbeit gewaehlten Weg entsteht damit nur ein Artefakt.

#let abb_konzept = {
  set text(font: "Arial", size: dg_schrift, fill: dg_text)
  align(center, diagram(
    // Der waagerechte Abstand traegt die Kantenbeschriftungen "erzeugt" und
    // "Import" und darf deshalb nicht enger werden, als diese breit sind.
    spacing: (13mm, 11mm),
    edge-stroke: dg_linie_engineering,
    label-size: dg_klein,
    label-sep: 3pt,
    label-wrapper: kante => box(
      fill: white,
      inset: (x: 2pt, y: 1pt),
      text(fill: dg_grau)[#kante.label],
    ),

    // --- Werkzeugkette auf der Typebene ---
    dg_werkzeug(
      (0, 0),
      [SENTRON #acro("PDE")],
      zusatz: [erzeugt die\ Gerätetypbeschreibung],
      name: <pde>,
      breite: 36mm,
    ),
    dg_werkzeug(
      (1, 0),
      [#acro("JSON")-Typbeschreibung],
      zusatz: [Registeradresse, Datentyp und\ Skalierung je Eigenschaft],
      name: <json>,
      breite: 44mm,
    ),
    dg_geraet(
      (2, 0),
      [Gerätetyp in Desigo CC],
      zusatz: [Objektmodell als Vorlage,\ einmal je Gerätetyp],
      name: <typ>,
      breite: 48mm,
    ),

    // --- ergaenzendes Artefakt auf der Instanzebene ---
    dg_werkzeug(
      (1, 2),
      [Instanzliste],
      zusatz: [benennt die anzulegenden\ Geräte einer Anlage],
      name: <liste>,
      breite: 44mm,
    ),

    // --- Instanzebene und Feld ---
    dg_geraet(
      (2, 2),
      [Geräteinstanzen],
      zusatz: [je physischem Gerät eine, mit #acro("IP")-Adresse und Unit
        Identifier],
      name: <instanz>,
      breite: 48mm,
    ),
    dg_geraet(
      (2, 3),
      [Strang im Feld],
      zusatz: [#acro("ECPD") unter Unit Identifier\ 1 bis 24, Powercenter unter
        255],
      name: <feld>,
      breite: 48mm,
    ),

    // --- Engineering-Schritte ---
    edge(<pde>, <json>, "->", dash: "dashed", label: [erzeugt]),
    edge(<json>, <typ>, "->", dash: "dashed", label: [Import]),
    edge(<liste>, <instanz>, "->", dash: "dashed"),
    edge(
      <typ>,
      <instanz>,
      "->",
      dash: "dashed",
      label: [instanziiert],
      label-side: right,
    ),

    // --- laufender Betrieb ---
    edge(
      <instanz>,
      <feld>,
      "<->",
      stroke: dg_linie_betrieb,
      label: [Modbus #acro("TCP")],
      label-side: right,
    ),

    dg_notiz(
      (0, 2),
      [*Trennung von Typ und Instanz:* eine einzige Typbeschreibung trägt
        beliebig viele Geräte und bleibt damit über Projektgrenzen hinweg
        wiederverwendbar],
      farbe: dg_akzent_text,
      breite: 36mm,
    ),
  ))

  v(4mm)

  dg_legende(
    (
      rect(width: 9mm, height: 3.2mm, stroke: dg_rahmen_werkzeug, fill: none),
      [Engineering-Artefakt],
    ),
    (
      rect(width: 9mm, height: 3.2mm, stroke: dg_rahmen_geraet, fill: none),
      [Gegenstand des Betriebs],
    ),
    (line(length: 9mm, stroke: dg_linie_betrieb), [Datenpfad im Betrieb]),
  )
}


// ---------------------------------------------------------------------------
// Abbildung: Aufbau eines Modbus-TCP-Telegramms  (Abschnitt 2.4)
// ---------------------------------------------------------------------------
// ACHTUNG, abweichende Kodierung: Diese Abbildung zeigt keinen Datenpfad,
// sondern den Feldaufbau eines Telegramms. Kanten gibt es deshalb nicht, die
// Bedeutung liegt in der Schachtelung:
//   weisser Kasten = einzelnes Feld des Telegramms
//   Sandband       = Zusammenfassung mehrerer Felder zu einer Einheit
//   Akzentflaeche  = der darunter vergroesserte Ausschnitt
// Farben, Schrift und Rahmen bleiben unveraendert, damit die Abbildung trotz
// der anderen Aussage zur uebrigen Bildsprache passt.
//
// Alle Zusammenfassungen sind geschlossene Baender ueber genau den Feldern,
// die sie umfassen. Eine fruehere Fassung verwendete dafuer einseitig offene
// Klammern; deren senkrechte Striche standen je nach Klammer oben oder unten
// und liessen die Ausdehnung der Einheiten unklar.
//
// Die Feldbreiten sind nicht massstaeblich, weil die Datenlaenge die uebrigen
// Felder sonst unlesbar zusammendraengen wuerde. Statt der Bytezahl traegt
// deshalb jedes Feld seine Byteposition, aus der sich die Ausdehnung der
// beiden Einheiten unmittelbar ablesen laesst: Der MBAP-Kopf reicht von
// Byte 0 bis Byte 6 und ist damit sieben Byte lang (Transaction Identifier
// 2 + Protocol Identifier 2 + Length 2 + Unit Identifier 1), so wie es der
// Messaging Implementation Guide in Abschnitt 3.1.3 festlegt.
//
// Gezeichnet wird hier ohne fletcher, da die Abbildung kein Graph ist, sondern
// ein Raster fester Spaltenanteile. Farben und Schriftgroessen stammen
// unveraendert aus der gemeinsamen Bildsprache oben.

// Einzelnes Feld eines Telegramms: Name fett, Byteposition klein darunter
#let dg_feld(titel, position, fill: white, farbe: dg_text) = rect(
  width: 100%,
  height: 100%,
  fill: fill,
  stroke: dg_rahmen_geraet,
  inset: (x: 2pt, y: 3pt),
  {
    set align(center + horizon)
    set par(justify: false, leading: 0.45em)
    text(size: dg_klein, weight: "bold", fill: farbe, hyphenate: true)[#titel]
    if position != none {
      linebreak()
      text(size: 7pt, fill: dg_grau)[#position]
    }
  },
)

// Band ueber mehreren Feldern: fasst sie zu einer Einheit zusammen. Es ist
// bewusst ein geschlossener Kasten und keine Klammer, damit die Ausdehnung
// der Einheit an den senkrechten Kanten eindeutig ablesbar bleibt.
#let dg_band(titel, zusatz, fill: dg_flaeche, farbe: dg_text) = rect(
  width: 100%,
  height: 100%,
  fill: fill,
  stroke: dg_rahmen_geraet,
  inset: (x: 3pt, y: 2pt),
  {
    set align(center + horizon)
    set par(justify: false)
    text(size: dg_klein, weight: "bold", fill: farbe, hyphenate: false)[#titel]
    text(size: dg_klein, fill: farbe, hyphenate: false)[, #zusatz]
  },
)

#let abb_modbus_tcp = {
  set text(font: "Arial", size: dg_schrift, fill: dg_text)

  align(center, block(width: 100%, {
    // --- obere Reihe: Kapselung im Ethernet-Rahmen ---
    grid(
      columns: (1.4fr, 1.2fr, 1.4fr, 5.6fr, 1.8fr),
      rows: (10mm,),
      dg_feld([Ethernet-Kopf], none, fill: dg_flaeche_hell, farbe: dg_grau),
      dg_feld([#acro("IP")-Kopf], none, fill: dg_flaeche_hell, farbe: dg_grau),
      dg_feld(
        [#acro("TCP")-Kopf],
        [Zielport 502],
        fill: dg_flaeche_hell,
        farbe: dg_grau,
      ),
      dg_feld(
        [Modbus-#acro("ADU")],
        [max. 260 Byte],
        fill: dg_akzent_flaeche,
        farbe: dg_akzent_text,
      ),
      dg_feld(
        [Ethernet-Prüfsumme],
        none,
        fill: dg_flaeche_hell,
        farbe: dg_grau,
      ),
    )

    // --- Vergroesserung: Fuehrungslinien vom ADU-Feld auf die volle Breite ---
    grid(
      columns: (4fr, 5.6fr, 1.8fr),
      rows: (5mm,),
      box(
        width: 100%,
        height: 100%,
        line(
          start: (100%, 0%),
          end: (0%, 100%),
          stroke: (paint: dg_akzent, thickness: 0.7pt, dash: "dotted"),
        ),
      ),
      none,
      box(
        width: 100%,
        height: 100%,
        line(
          start: (0%, 0%),
          end: (100%, 100%),
          stroke: (paint: dg_akzent, thickness: 0.7pt, dash: "dotted"),
        ),
      ),
    )

    // --- untere Reihe: Felder der Anwendungsdateneinheit ---
    // Spaltenanteile richten sich nach der Laenge der Beschriftung, nicht nach
    // der Bytezahl; siehe Anmerkung im Kopf dieses Abschnitts.
    grid(
      columns: (2.7fr, 2.4fr, 1.4fr, 2fr, 2.5fr, 3fr),
      rows: (7mm, 14mm, 6mm),
      row-gutter: (0mm, 1.5mm),

      // Baender ueber den Feldern, die sie zusammenfassen
      grid.cell(colspan: 4, dg_band([#acro("MBAP")-Kopf], [Byte 0 bis 6, zusammen 7 Byte])),
      grid.cell(colspan: 2, dg_band([Modbus-#acro("PDU")], [ab Byte 7, max. 253 Byte])),

      // Felder
      dg_feld([Transaction Identifier], [Byte 0–1]),
      dg_feld([Protocol Identifier], [Byte 2–3]),
      dg_feld([Länge], [Byte 4–5]),
      dg_feld([Unit Identifier], [Byte 6]),
      dg_feld([Funktionscode], [Byte 7]),
      dg_feld([Daten], [ab Byte 8]),

      // Geltungsbereich des Laengenfelds, ebenfalls als geschlossenes Band
      grid.cell(colspan: 3, none),
    )
  }))

  v(4mm)

  dg_legende(
    (
      rect(width: 9mm, height: 3.2mm, stroke: dg_rahmen_geraet, fill: white),
      [Feld des Telegramms],
    ),
    (
      rect(width: 9mm, height: 3.2mm, stroke: dg_rahmen_geraet, fill: dg_flaeche),
      [Zusammenfassung zu einer Einheit],
    ),
    (
      rect(width: 9mm, height: 3.2mm, stroke: none, fill: dg_akzent_flaeche),
      [vergrößerter Ausschnitt],
    ),
  )
}

// ===========================================================================
// ---------------------------------------------------------------------------
// Abbildung: Arbeitsablauf des Entwicklungsteils  (Kapitel 5)
// ---------------------------------------------------------------------------
// ACHTUNG, abweichende Kodierung wie bei abb_vmodell: Diese Abbildung zeigt
// keinen Datenpfad, sondern einen Arbeitsablauf. Die Kanten tragen deshalb
// eine eigene Bedeutung, die in der Legende ausgewiesen wird:
//   durchgezogene Kante  = Arbeitsschritt des Entwicklungsteils
//   gestrichelte Kante   = Zulauf aus anderen Kapiteln und Ruecklauf aus der
//                          Pruefung
// Entsprechend sind die Schritte des Kapitels als dg_phase gesetzt, die
// Bausteine ausserhalb des Kapitels als dg_werkzeug.
//
// Aufbau: Hauptkette senkrecht bei x = 0, Zulauf und Nebenergebnis links bei
// x = -1, der Ruecklauf aus der Pruefung rechts bei x = 1.

#let abb_ablauf_entwicklung = {
  set text(font: "Arial", size: dg_schrift, fill: dg_text)
  align(center, diagram(
    spacing: (7mm, 9mm),
    edge-stroke: dg_linie_betrieb,
    label-size: dg_klein,
    label-sep: 3pt,
    label-wrapper: kante => box(
      fill: white,
      inset: (x: 2pt, y: 1pt),
      text(fill: dg_grau)[#kante.label],
    ),

    // --- Zulauf aus Kapitel 3 ---
    dg_werkzeug(
      (0, 0),
      [Registerkarte],
      zusatz: [5169 Datenpunkte je Strang\ mit Adressen und Formaten],
      name: <karte>,
      breite: 58mm,
    ),
    dg_werkzeug(
      (-1, 1),
      [Anwendungsfälle\ und Anforderungen],
      zusatz: [Zweck und Nachweis\ je Datenpunkt],
      name: <bedarf>,
      breite: 42mm,
    ),

    // --- Kette des Entwicklungsteils ---
    dg_phase(
      (0, 1),
      [Kriterien der Datenauswahl],
      zusatz: [sieben begründete Kriterien],
      name: <kriterien>,
      breite: 58mm,
    ),
    dg_phase(
      (0, 2),
      [Auswahl der Datenpunkte],
      zusatz: [929 gelesene Register je Strang],
      name: <auswahl>,
      breite: 58mm,
    ),
    dg_phase(
      (0, 3),
      [Typbeschreibung im #acro("PDE")],
      zusatz: [Benennung, Gruppen, Datentypen\ und Registeradressen],
      name: <typ>,
      breite: 58mm,
    ),
    dg_phase(
      (0, 4),
      [Übernahme in Desigo CC],
      zusatz: [Objekttyp und Instanz je Gerät],
      name: <uebernahme>,
      breite: 58mm,
    ),

    // --- Nebenergebnis ---
    dg_phase(
      (-1, 4),
      [Begleitende\ Unterlage],
      zusatz: [Voraussetzungen,\ Schritte, Grenzen],
      name: <doku>,
      breite: 42mm,
    ),

    // --- Pruefung aus Kapitel 6 ---
    dg_werkzeug(
      (0, 5),
      [Prüfung am Testaufbau],
      zusatz: [Testfälle des Validierungsteils],
      name: <pruefung>,
      breite: 58mm,
    ),

    // --- Arbeitsschritte ---
    edge(<karte>, <kriterien>, "->", dash: "dashed", stroke: dg_linie_engineering),
    edge(<bedarf>, <kriterien>, "->", dash: "dashed", stroke: dg_linie_engineering),
    edge(<kriterien>, <auswahl>, "->"),
    edge(<auswahl>, <typ>, "->"),
    edge(<typ>, <uebernahme>, "->"),
    edge(<uebernahme>, <doku>, "->"),
    edge(<uebernahme>, <pruefung>, "->", dash: "dashed", stroke: dg_linie_engineering),

    // --- Ruecklauf aus der Pruefung ---
    // Rechts an der Kette vorbei zurueck auf die Typbeschreibung, weil erst die
    // Pruefung Alarmzerlegung und Datentypen abschliessend geklaert hat.
    edge(
      <pruefung>,
      (1, 5),
      (1, 3),
      <typ>,
      "->",
      dash: "dashed",
      stroke: dg_linie_engineering,
      label: [Rücklauf],
      label-pos: 0.5,
    ),
  ))

  v(4mm)

  dg_legende(
    (line(length: 9mm, stroke: dg_linie_betrieb), [Arbeitsschritt des Kapitels]),
    (
      line(length: 9mm, stroke: (paint: dg_grau, thickness: 0.7pt, dash: "dashed")),
      [Zulauf aus anderen Kapiteln und Rücklauf aus der Prüfung],
    ),
  )
}



// ---------------------------------------------------------------------------
// Abbildung: Laboraufbau des Testaufbaus  (Abschnitt 4.1)
// ---------------------------------------------------------------------------
// Ergaenzt das Lichtbild um die Verschaltung, die auf einem Foto nicht zu
// erkennen ist. Neben dem Datenpfad traegt diese Abbildung als einzige auch
// den Stromkreis, weshalb die Bildsprache hier um eine dritte Kantenart
// erweitert ist:
//   durchgezogen dunkel  = Datenpfad im Betrieb
//   gestrichelt dunkel   = Funkstrecke, wie in abb_systemaufbau
//   gestrichelt grau     = Zugriff neben dem laufenden Datenpfad
//   durchgezogen petrol  = Stromversorgung und Laststrom
// Alle vier sind in der Legende ausgewiesen.
//
// Aufbau: Hauptkette senkrecht bei x = 0 von Desigo CC bis zur Last, die
// Einspeisung links bei x = -1, das unabhaengige Modbus-Werkzeug rechts.

#let abb_testaufbau = {
  set text(font: "Arial", size: dg_schrift, fill: dg_text)
  align(center, diagram(
    spacing: (12mm, 11mm),
    edge-stroke: dg_linie_betrieb,
    label-size: dg_klein,
    label-sep: 3pt,
    label-wrapper: kante => box(inset: (x: 2pt, y: 1pt), kante.label),

    // --- Datenpfad ---
    dg_geraet(
      (0, 0),
      [Desigo CC],
      zusatz: [Modbus-Treiber, Abfrageintervall $1space.thin"s"$],
      name: <dcc>,
      breite: 56mm,
    ),
    dg_geraet(
      (0, 1),
      [SENTRON Powercenter 1100],
      zusatz: [Firmware 7.3.0,\ Unit Identifier 255],
      name: <pc>,
      breite: 56mm,
    ),
    dg_geraet(
      (0, 2),
      [#acro("ECPD") 5TY1-3MF16 COM],
      zusatz: [Firmware 5.5.0, Unit Identifier 1,\ eingestellter Nennstrom $10space.thin"A"$],
      name: <ecpd>,
      breite: 56mm,
    ),
    dg_geraet(
      (0, 3),
      [Last (nicht im Bild)],
      zusatz: [zwei Wasserkocher zu je $1800space.thin"W"$,\ über eine Steckdosenleiste],
      name: <last>,
      breite: 56mm,
    ),

    edge(
      <pc>,
      <dcc>,
      "<->",
      label: [Modbus #acro("TCP")\ über Ethernet],
      label-side: right,
    ),
    edge(
      <ecpd>,
      <pc>,
      "<->",
      dash: "dashed",
      stroke: dg_linie_betrieb,
      label: [Funkstrecke],
      label-side: right,
    ),

    // --- Einspeisung und Laststrom ---
    dg_geraet(
      (-1, 2),
      [Einspeisung],
      zusatz: [Raumabsicherung $16space.thin"A"$,\ Steckdose $230space.thin"V"$],
      name: <netz>,
      breite: 38mm,
    ),
    dg_geraet(
      (-1, 1),
      [Netzteil],
      zusatz: [Hutschiene, speist\ das Powercenter],
      name: <nt>,
      breite: 38mm,
    ),

    edge(<netz>, <nt>, "->", stroke: dg_linie_strom, label: [$230space.thin"V"$], label-side: left),
    edge(<nt>, <pc>, "->", stroke: dg_linie_strom, label: [$24space.thin"V"$]),
    edge(<netz>, <ecpd>, "->", stroke: dg_linie_strom, label: [$230space.thin"V"$]),
    edge(<ecpd>, <last>, "->", stroke: dg_linie_strom, label: [rund $15class("normal", ",")7space.thin"A"$], label-side: right),

    // --- Werkzeug neben dem Datenpfad ---
    dg_werkzeug(
      (1, 1),
      [QModMaster],
      zusatz: [liest den Registerraum\ ohne das Datenmodell],
      name: <qmm>,
      breite: 38mm,
    ),

    edge(
      <qmm>,
      <pc>,
      "->",
      dash: "dashed",
      stroke: dg_linie_engineering,
    ),
  ))

  v(4mm)

  dg_legende(
    (line(length: 9mm, stroke: dg_linie_betrieb), [Datenpfad im Betrieb]),
    (
      line(length: 9mm, stroke: (paint: dg_text, thickness: 0.7pt, dash: "dashed")),
      [Funkstrecke],
    ),
    (
      line(length: 9mm, stroke: (paint: dg_grau, thickness: 0.7pt, dash: "dashed")),
      [Gegenprobe am Register],
    ),
    (line(length: 9mm, stroke: dg_linie_strom), [Stromversorgung und Last]),
  )
}

// Vorschauseite -- wird bei `#import` verworfen
// ===========================================================================

#set page(paper: "a4", margin: (x: 2.5cm, y: 2cm), numbering: none)
#set text(font: "Arial", size: 11pt, lang: "de")
#set par(justify: false, leading: 0.65em)
// entspricht den Einstellungen aus main.typ, damit die Vorschau dasselbe zeigt
#set figure.caption(separator: [: ])
#show figure.where(kind: image): set figure(supplement: [Abbildung])

#text(size: 14pt, weight: "bold")[Vorschau der schematischen Abbildungen]

#v(2mm)
#text(size: 9pt, fill: dg_grau)[
  Diese Seite dient nur der Einzelansicht von `config/diagrams.typ` und
  erscheint nicht in der Arbeit. Im Kapitel sind die folgenden Abkürzungen
  längst eingeführt, weshalb sie im Diagramm nur als Kürzel erscheinen; damit
  die Vorschau dasselbe zeigt, werden sie hier vorab genannt:
  #acro("ECPD"), #acro("TCP"), #acro("JSON"), #acro("API"), #acro("BLE"),
  #acro("PDE"), #acro("IP"), #acro("ADU"), #acro("PDU"), #acro("MBAP").
]

#v(6mm)

#figure(
  abb_systemaufbau,
  caption: [Datenpfad vom #acro("ECPD") über die Funkstrecke zum Powercenter,
    von dort über Modbus #acro("TCP") im Gebäudenetz zu Desigo CC; seitlich
    angetragen die Werkzeuge SENTRON Powerconfig und #acro("PDE") mit ihren
    jeweiligen Zugriffspunkten],
)

#v(8mm)

#figure(
  abb_vmodell,
  caption: [V-Modell als Vorgehensmodell der Arbeit, mit der Zuordnung der
    Phasen zu den Kapiteln und der beidseitigen Kopplung zwischen der Auswahl
    der Daten und deren Prüfung am Testaufbau],
)

#v(8mm)

#figure(
  abb_konzept,
  caption: [Erstes Lösungskonzept, Werkzeugkette vom #acro("PDE") über die
    #acro("JSON")-Typbeschreibung zum Objektmodell in Desigo CC sowie die
    Instanziierung je physischem Gerät über den Unit Identifier],
)

#v(8mm)

#figure(
  abb_modbus_tcp,
  caption: [Aufbau eines Modbus-#acro("TCP")-Telegramms, oben die Kapselung im
    Ethernet-Rahmen, unten die Felder der Anwendungsdateneinheit aus
    #acro("MBAP")-Kopf und Protokolldateneinheit mit ihren Bytepositionen],
)

#v(8mm)

#figure(
  abb_ablauf_entwicklung,
  caption: [Arbeitsablauf des Entwicklungsteils, von der Registerkarte über
    Kriterien und Auswahl zur Typbeschreibung und ihrer Übernahme, mit dem
    Rücklauf aus der Prüfung am Testaufbau],
)

#v(8mm)

#figure(
  abb_testaufbau,
  caption: [Verschaltung des Laboraufbaus mit Einspeisung, Last, Funkstrecke,
    Powercenter, Ethernet-Anbindung an Desigo CC und dem unabhängigen
    Modbus-Werkzeug],
)

// Notwendig, damit die Sprungziele von `#acro` auch in der Einzelansicht
// vorhanden sind -- im Hauptdokument leistet das `insertAcronyms`.
#v(1fr)
#line(length: 100%, stroke: 0.5pt + sie_deep_blue_30)
#text(size: 9pt, fill: dg_grau)[Abkürzungsverzeichnis der Vorschau]
#v(2mm)
#text(size: 9pt)[#printAcronyms]
