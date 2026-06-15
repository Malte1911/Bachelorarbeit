// Import configuration files
#import "config/functions.typ": *
#include "config/config.typ"
#import "config/acronyms.typ" : acro
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
    margin: (top: 4cm, bottom: 4cm, left: 2.5cm, right: 2.5cm), 
    header: create_header(),
    footer: context create_footer(),
    numbering: "1"
  )

  // set page(numbering: "1", number-align: right)
  counter(page).update(1)
  
  doc
  
    set page(
    margin: (top: 4cm, bottom: 4cm, left: 2.5cm, right: 2.5cm), 
    header: create_header(),
    footer: context create_footer_(),
    numbering: "1"
  )
  set page(numbering: "i", number-align: right)
  counter(page).update(1)


  insertBibliography
  
  insertListOfFigures
  
  // insertListOfTables
  
  // insertListOfScripts
  
  // insertAppendix
}

// Main content


#set heading(numbering: "1.1.1", outlined: true, supplement: [Abschnitt])

#set figure.caption(separator: [: ])
#show figure.where(kind: table): set figure(supplement: [Tabelle])
#show figure.where(kind: image): set figure(supplement: [Abbildung])
#set math.equation(numbering: "(1)", supplement: [Formel], )
#show math.equation: set text(10.5pt)


#include "content/999_chapters.typ"
