// Farbbibliothek der Siemens AG.
//
// Quelle: resources/sie-colors-overview-V1-4-4.pdf, Stand 2025-02-17.
// Fuer Abbildungen dieser Arbeit werden ausschliesslich Farbtoene aus dieser
// Datei verwendet; andere Werte sind nicht zulaessig. Die semantische
// Zuordnung (welcher Ton wofuer steht) erfolgt in config/diagrams.typ.
//
// Die Namen entsprechen denen der Bibliothek; Umbenennungen waeren nur eine
// Fehlerquelle beim Abgleich mit dem Original.

// --- Primaerfarben ---------------------------------------------------------
#let sie_siemens_petrol = rgb("#009999")
#let sie_light_petrol = rgb("#00c1b6")
#let sie_bold_green = rgb("#00ffb9")
#let sie_soft_green = rgb("#00d7a0")
#let sie_bold_blue = rgb("#00e6dc")
#let sie_soft_blue = rgb("#00bedc")
#let sie_deep_blue = rgb("#000028")
#let sie_light_sand = rgb("#f3f3f0")

// --- Sekundaerfarben -------------------------------------------------------
#let sie_dark_sand = rgb("#aaaa96")
#let sie_soft_sand = rgb("#c5c5b8")
#let sie_bright_sand = rgb("#dfdfd9")
#let sie_dark_yellow = rgb("#f7c600")
#let sie_yellow = rgb("#ffd732")
#let sie_soft_yellow = rgb("#ffe270")
#let sie_dark_green = rgb("#00646e") // dunkles Petrol, trotz des Namens
#let sie_green = rgb("#00af8e")
#let sie_dark_blue = rgb("#00557c")
#let sie_blue = rgb("#0087be")
#let sie_dark_purple = rgb("#553ba3")
#let sie_purple = rgb("#805cff")
#let sie_soft_purple = rgb("#b4a8ff")
#let sie_red = rgb("#ef0137")
#let sie_dark_orange = rgb("#ec6602")
#let sie_orange = rgb("#ff9000")

// --- Deep-Blue-Abstufungen (die Grauwerte der Bibliothek) ------------------
#let sie_deep_blue_95 = rgb("#0d0d33")
#let sie_deep_blue_90 = rgb("#19193d")
#let sie_deep_blue_85 = rgb("#262648")
#let sie_deep_blue_80 = rgb("#333353")
#let sie_deep_blue_70 = rgb("#4c4c68")
#let sie_deep_blue_60 = rgb("#66667e") // in der Bibliothek auch "Dark Gray"
#let sie_deep_blue_55 = rgb("#737389")
#let sie_deep_blue_50 = rgb("#808099")
#let sie_deep_blue_40 = rgb("#9999a9")
#let sie_deep_blue_30 = rgb("#b3b3be")
#let sie_deep_blue_20 = rgb("#ccccd4") // in der Bibliothek auch "Soft Gray"
#let sie_deep_blue_10 = rgb("#e5e5e9")
#let sie_deep_blue_8 = rgb("#ebebee")

// --- Kontrastwerte gegen Weiss (WCAG), als Entscheidungshilfe --------------
// Deep Blue        20,4 : 1     Deep Blue 60 %    5,6 : 1
// Dark Blue         8,1 : 1     Red               4,4 : 1
// Dark Green        6,9 : 1     Blue              4,0 : 1
// Deep Blue 50 %    3,8 : 1     Siemens Petrol    3,5 : 1
// Deep Blue 40 %    2,8 : 1
// Ab 4,5 : 1 ist ein Ton fuer Text geeignet, ab 3,0 : 1 fuer Linien und
// Flaechen. Siemens Petrol traegt deshalb Linien, aber keinen Text.
