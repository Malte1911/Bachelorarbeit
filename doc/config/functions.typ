#import "constants.typ": *
#import "acronyms.typ": *
#import "colors.typ": *

// Sichtbarer Arbeitskommentar: wird fett und rot im Dokument dargestellt.
// Verwendung inline oder als eigener Absatz:
//   #kommentar[Hier fehlt noch die Quelle zum Delayed ACK.]
// Über `show_comments` in constants.typ lassen sich alle Kommentare
// für die Abgabe auf einmal ausblenden.
#let kommentar(body) = {
  if show_comments {
    text(fill: sie_red, weight: "bold")[#body]
  }
}

#let insertCoverText = {
  align(center)[
    #text(size: 18pt, weight: "bold")[
      #title
    ]
    #v(24mm)
    #text(size: 14pt, weight: "bold")[
      #document_type_phrase
    ]
  ]

  if document_type == "T3_3300" [
    #align(center)[
      #v(12mm)
      für die Prüfung zum
      #v(3mm)
      #degree
    ]
  ]

  align(center)[
    #v(12mm)
    #study_program
    #v(3mm)
    #university
    #v(12mm)
    von
    #v(3mm)
    #text(size: 14pt, weight: "bold")[
      #author
    ]
    #v(12mm)
    #date
  ]
}

// Der Siemens-Schriftzug ist deutlich breiter als hoch; er wird deshalb ueber
// die Breite auf das DHBW-Logo abgestimmt und senkrecht mittig gesetzt, damit
// beide Logos optisch auf einem Band liegen.
#let insertCompanyImage = [
  #grid(
    columns: (1fr, 1fr, 1fr),
    align: (left + horizon, center, right + horizon),
    if show_company {
      image("../resources/sie-logo-petrol-rgb.png", width: 4cm)
    } else {
      []
    },
    [],
    image("../resources/logo-dhbw.png", width: 4cm)
  )
]

#let create_header() = {
  insertCompanyImage
  line(length: 100%)
}

// Define a function to create footers
#let create_footer() = context {
  line(length: 100%)
  grid(
    columns: (1fr, 1fr, 1fr),
    align: (left, center, right),
    document_type_phrase,
    author,
    [Seite #counter(page).display("1")]
  )
}

// Define a function to create footers
#let create_footer_() = context {
  line(length: 100%)
  grid(
    columns: (1fr, 1fr, 1fr),
    align: (left, center, right),
    document_type_phrase,
    author,
    [Seite #counter(page).display("i")]
  )
}

// Styling settings
#set page(
  margin: (top: 4cm, bottom: 4cm, left: 2.5cm, right: 2.5cm), 
  header: create_header(),
  footer: context create_footer,
  numbering: "1"
)
#set text(font: "Arial", size: 12pt)
#set par(justify: true, leading: 1.5em)

#let importChapter(file) = {
  include file
  pagebreak()
}

#let insertBibliography = {
  // Bibliography
  bibliography("../resources/quellen.bib", title: "Literaturverzeichnis", style: "ieee")
  v(1fr)
}

#let insertListOfFigures = {
  // List of figures
  pagebreak()
  outline(title: "Abbildungsverzeichnis", target: figure.where(kind: image))
  v(1fr)
}

#let insertListOfTables = {
  // List of tables
  pagebreak()
  outline(title: "Tabellenverzeichnis", target: figure.where(kind: table, ))
  v(1fr)
}

#let insertListOfScripts = {
  // List of code listings
  pagebreak()
  outline(title: "Skriptverzeichnis", target: figure.where(kind: raw))
  v(1fr)
}

#let insertAppendix = {
// Appendix
  pagebreak()
  // Ohne Ruecksetzen zaehlt der Anhang die Kapitel weiter und erscheint als "H".
  counter(heading).update(0)
  heading(numbering: "A")[Anhang]
  include "../content/999_appendix.typ"
  v(1fr)
}

#let insertAcronyms = {
  // Abbreviations
  //pagebreak()
  heading(outlined: true)[Abkürzungsverzeichnis]
  v(0.9em)
  printAcronyms
  // v(1fr)
}

