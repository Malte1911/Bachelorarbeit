// Import configuration files
#import "config/functions.typ": *
#include "config/config.typ"
#import "config/acronyms.typ" : acro

// Blocksatz mit deutscher Silbentrennung. Die Regeln stehen bewusst VOR der
// folgenden show-Regel. Alles, was innerhalb von deren Funktionskoerper erzeugt
// wird, also Deckblatt, Vorspann, Verzeichnisse und Anhang, sieht set-Regeln
// nicht mehr, die weiter unten in dieser Datei stehen. Die Ueberschriften-
// numerierung bleibt deshalb unten, sonst traegt der Abstract eine Nummer.
// Ohne die Sprachangabe wendet Typst die englischen Trennmuster auf den
// deutschen Text an; content/001_abstract.typ setzt sie fuer sich auf "en".
#set text(lang: "de")
#set par(justify: true)

// Tabellenzellen, Bildunterschriften und Verzeichniseintraege bleiben im
// Flattersatz. In schmalen Spalten reisst der Blocksatz sonst grosse Luecken
// zwischen die Woerter.
#show table: set par(justify: false)
#show figure.caption: set par(justify: false)
#show outline: set par(justify: false)
// Define a function to create headers

// Front matter
#show: doc => {
  // Set up page numbering for front matter
  set page(numbering: "I", number-align: right)
  
  // Cover page (no header/footer on cover)
  include "config/cover.typ"
  
  // Inhaltsverzeichnis
  pagebreak()
  heading(level: 1, outlined: false)[Inhaltsverzeichnis]
  outline(title: none, depth: 2)
  
  // set page(numbering: "1", number-align: center)
  pagebreak()
  importChapter("../content/001_abstract.typ")
  importChapter("../content/002_Kurzfassung.typ")  
  importChapter("../content/003_ai.typ")

  insertAcronyms
  
  // Insert main content
  set page(
    margin: (top: 3.5cm, bottom: 3cm, left: 2.5cm, right: 2.5cm),
    // Ohne diese Vorgabe waere der Abstand zwischen Kopfzeile und Textkoerper
    // 30 Prozent des oberen Randes. Fest gesetzt bleibt der Abstand von der
    // Linie zum Text gleich, waehrend der groessere Rand Logos und Text
    // gemeinsam um 0,5 cm nach unten schiebt, damit der Drucker die Logos
    // nicht mehr anschneidet.
    header-ascent: 0.9cm,
    
    header: create_header(),
    footer: context create_footer(),
    numbering: "1"
  )

  // set page(numbering: "1", number-align: right)
  counter(page).update(1)
  
  doc
  
    set page(
    margin: (top: 3.5cm, bottom: 3cm, left: 2.5cm, right: 2.5cm),
    // Ohne diese Vorgabe waere der Abstand zwischen Kopfzeile und Textkoerper
    // 30 Prozent des oberen Randes. Fest gesetzt bleibt der Abstand von der
    // Linie zum Text gleich, waehrend der groessere Rand Logos und Text
    // gemeinsam um 0,5 cm nach unten schiebt, damit der Drucker die Logos
    // nicht mehr anschneidet.
    header-ascent: 0.9cm,
    
    header: create_header(),
    footer: context create_footer_(),
    numbering: "1"
  )
  set page(numbering: "i", number-align: right)
  counter(page).update(1)


  insertBibliography
  
  insertListOfFigures
  
  insertListOfTables
  
  // insertListOfScripts
  
  insertAppendix
}

// Main content


#set heading(numbering: "1.1.1", outlined: true, supplement: [Abschnitt])

// Überschriften der vierten Ebene dienen nur der Gliederung innerhalb eines
// Unterkapitels (z. B. die Integrationswege W1 bis W6). Eine Nummer der Form
// 3.1.3.2 vor einer bereits gekennzeichneten Überschrift wäre doppelt gemoppelt,
// deshalb bleiben sie unnummeriert. Im Inhaltsverzeichnis erscheinen sie wegen
// `outline(depth: 2)` ohnehin nicht.
#show heading.where(level: 4): set heading(numbering: none)

#set figure.caption(separator: [: ])
#show figure.where(kind: table): set figure(supplement: [Tabelle])
#show figure.where(kind: image): set figure(supplement: [Abbildung])
// Tabellen dürfen umbrechen, sonst passen die langen Anforderungs- und
// Registertabellen nicht auf eine Seite. Abbildungen dürfen es nicht, sonst
// landet die Bildunterschrift allein auf der Folgeseite.
#show figure: set block(breakable: true)
#show figure.where(kind: image): set block(breakable: false)
#set math.equation(numbering: "(1)", supplement: [Formel], )
#show math.equation: set text(10.5pt)


#include "content/999_chapters.typ"
