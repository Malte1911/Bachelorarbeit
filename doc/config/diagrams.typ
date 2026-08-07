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
#let dg_schrift = 9pt
#let dg_klein = 8pt

#let dg_linie_betrieb = 0.7pt + dg_text
#let dg_linie_engineering = 0.7pt + dg_zurueck
#let dg_rahmen_geraet = 0.7pt + dg_text
#let dg_rahmen_werkzeug = (paint: dg_zurueck, thickness: 0.7pt, dash: "dashed")
#let dg_rahmen_grenze = (paint: dg_akzent, thickness: 1pt, dash: "dashed")

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
      "->",
      label: [Modbus #acro("TCP")\ über das Gebäudenetz],
      label-side: right,
    ),
    edge(
      <ecpd>,
      <pc>,
      "->",
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
      zusatz: [Inbetriebnahme und\ Parametrierung],
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
    edge(
      <pcfg>,
      <pc>,
      "->",
      dash: "dashed",
      stroke: dg_linie_engineering,
      label: text(fill: dg_grau)[REST-#acro("API")],
      label-side: left,
      label-pos: 25%,
    ),
    edge(
      <pcfg>,
      <ecpd>,
      "->",
      dash: "dashed",
      stroke: dg_linie_engineering,
      label: text(fill: dg_grau)[#acro("BLE")],
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


// ===========================================================================
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
  #acro("PDE").
]

#v(6mm)

#figure(
  abb_systemaufbau,
  caption: [Datenpfad vom #acro("ECPD") über die Funkstrecke zum Powercenter,
    von dort über Modbus #acro("TCP") im Gebäudenetz zu Desigo CC; seitlich
    angetragen die Werkzeuge SENTRON Powerconfig und #acro("PDE") mit ihren
    jeweiligen Zugriffspunkten],
)

// Notwendig, damit die Sprungziele von `#acro` auch in der Einzelansicht
// vorhanden sind -- im Hauptdokument leistet das `insertAcronyms`.
#v(1fr)
#line(length: 100%, stroke: 0.5pt + sie_deep_blue_30)
#text(size: 9pt, fill: dg_grau)[Abkürzungsverzeichnis der Vorschau]
#v(2mm)
#text(size: 9pt)[#printAcronyms]
