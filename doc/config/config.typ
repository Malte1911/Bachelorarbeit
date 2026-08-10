#include "constants.typ"

// ACHTUNG: Hier steht bewusst kein `#set page(...)` mehr.
// Diese Datei wird von jeder Unterkapiteldatei per `#include` eingebunden.
// Eine Seiten-Regel im Dokumentfluss erzwingt in Typst einen Seitenumbruch,
// weshalb zuvor jedes Unterkapitel auf einer neuen Seite begann und die
// Kapitelueberschrift allein auf einer sonst leeren Seite stand.
// Die Seitenraender setzt `main.typ` einmalig fuer das gesamte Dokument.

// Bibliography settings
#set cite(style: "ieee")
