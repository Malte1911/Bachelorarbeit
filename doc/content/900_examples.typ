#import "../config/acronyms.typ": *
#include "../config/config.typ"
// Examples (can be removed)
= Beispiele

Beispiele, können problemlos entfernt werden!

== Literatur
Beispiel Text @testBuch1[S. 10]
Beispiel Homepage @urlId

== Bilder



#figure(
  image("../resources/logo-dhbw.png", width: 30%),
  caption: "DHBW Logo"
) <abbildung>


Siehe #ref(<abbildung>) für das DHBW‑Logo.
#figure(
  image("../resources/logo-dhbw.png", width: 30%),
  caption: "DHBW Logo"
)
#figure(
  image("../resources/logo-dhbw.png", width: 30%),
  caption: "DHBW Logo"
) <abbildung2>
Siehe #ref(<abbildung2>) für das DHBW‑Logo.
#figure(
  image("../resources/logo-dhbw.png", width: 30%),
  caption: "DHBW Logo"
)
== Fußnote
Fußnote#footnote[Fußnote]

== Abkürzung
Die #acro("DHBW") wird bei der ersten Erwähnung ausgeschrieben und danach immer als #acro("DHBW") verwendet.

== Tabelle
#figure(
  table(
    columns: 3,
    [Spalte 1], [Spalte 2], [Spalte 3],
    [Zeile], [], [],
    [], [Zeile], [],
    [], [], [Zeile],
    align(right)[Verbunden], align(right)[Verbunden], [nicht Verbunden]
  ),
  caption: "Tabellenbeispiel"
)

== Code
```c
printf("Inline Code");
```

```python
def example_function():
    """Example Python function"""
    print("Hello, world!")
    return 42
```

== TODOs
// TODO: Liste aller TODOs
