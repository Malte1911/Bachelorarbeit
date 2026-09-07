#import "functions.typ": *

// Das Deckblatt ist zentriert gesetzt; der Blocksatz aus main.typ wuerde den
// Titel auseinanderziehen und trennen. Deshalb hier ausdruecklich aus.
#set par(justify: false)
// Auf dem Deckblatt steht keine Seitenzahl. Die Nummerierung des Vorspanns
// setzt main.typ nach dem Seitenumbruch wieder auf "I"; der Seitenzaehler
// laeuft dabei weiter, der Sperrvermerk bleibt also Seite II.
#set page(
  margin: (top: 2cm, bottom: 4cm, left: 2.5cm, right: 2.5cm),
  numbering: none
)
// Header with logos
#insertCompanyImage

#v(1cm)

#insertCoverText

#v(1fr)

// Bottom table with additional information
#set par(leading: 1.2em)

// Bottom table
#if document_type == "T3_3100" {
  grid(
    columns: (2fr, 1fr),
    rows: 2,
    gutter: 8pt,
    align: (left, left),
    [*Bearbeitungszeitraum*], [#period],
    [*Matrikelnummer, Kurs*], [#matriculation_number, #course],
    [*Betreuer der DHBW #location_university*], [#evaluator],
  )
} else if document_type == "T3_3300" {
  grid(
    columns: (1fr, 1fr, 1fr),
    rows: 5,
    gutter: 6pt,
    align: (left, left),
    [*Bearbeitungszeitraum*], [], [#period],
    [*Matrikelnummer, Kurs*], [], [#matriculation_number, #course],
    [*Dualer Partner*], [], [#company_name, #company_location],
    [*Betreuer des Dualen Partners*], [], [#tutor],
    [*Betreuer der DHBW #location_university*], [], [#evaluator],
  )
} else {
  grid(
    columns: (1fr, 1fr, 1fr),
    rows: 4,
    gutter: 6pt,
    align: (left, left),
    [*Bearbeitungszeitraum*], [], [#period],
    [*Matrikelnummer, Kurs*], [], [#matriculation_number, #course],
    [*Dualer Partner*], [], [#company_name, #company_location],
    [*Betreuer des Dualen Partners*], [], [#tutor],
  )
}
