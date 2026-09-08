#import "../config/acronyms.typ": *
#import "../config/functions.typ": *
#include "../config/config.typ"


= Kurzfassung

Elektronische Schaltkreisschutzgeräte (#acro("ECPD")) der Reihe SENTRON messen Strom, Spannung und Wirkleistung je Endstromkreis und lassen sich über das SENTRON Powercenter fernschalten. In der Objektmodellbibliothek der Gebäudemanagementplattform Desigo CC fehlt sie, weshalb jede Anbindung bisher eine Einzelanfertigung war und die Zuordnung der Modbus-Register in jedem Projekt erneut anfiel.

Die Arbeit entstand bei der Siemens AG, die beide Produktlinien führt. Sie entwickelt dafür eine wiederverwendbare Integrationsvorlage und weist sie an einem Hardwareaufbau nach. Das Vorgehen folgt dem V-Modell. Aus System- und Stakeholderanalyse gehen zehn Anwendungsfälle hervor, daraus 15 Anforderungen und 14 Testfälle, womit jede Festlegung auf eine benannte Nutzergruppe zurückführbar bleibt.

Den Kern bildet die Auswahl der Datenpunkte. Ein voll bestückter Strang aus einem Powercenter und 24 Endgeräten umfasst 3859 Einträge der Registerkarte. Sieben Auswahlkriterien senken diesen Umfang auf 904 gelesene Register, den abgebildeten Registerraum also um rund 77 Prozent. Das Ergebnis umfasst maschinenlesbare Typbeschreibungen beider Gerätetypen, eine Aufstellung mit Register, Format und Begründung sowie eine Unterlage für Errichter und Betreiber.

Die Validierung weist zehn der 15 Anforderungen als erfüllt aus, drei als teilweise und zwei als nicht. Messwerte, Zählerstände, Stammdaten und Schalterzustand erscheinen vollständig und richtig beschriftet, Schaltbefehle werden ausgeführt und quittiert. Offen bleibt die Alarmierung, da sämtliche Meldungen in einem Sammelregister liegen, das die Werkzeugkette nicht in einzelne Zustände zerlegt.

Die Bewertung fällt geteilt aus. Als Vorlage nimmt das Modell die wiederkehrende Zuordnungsarbeit ab und trägt die Auswertung eines Verteilers aus der Leitwarte. Als vollständige Leitwartenanbindung trägt es nicht, solange die Meldungen nicht als einzelne Zustände vorliegen.

/* Claude: Kurzfassung aus @sec:zusammenfassung, @sec:anforderungsabgleich,
   @sec:praxistauglichkeit und @sec:standdertechnik verdichtet, fuenf Absaetze
   nach dem Muster Ausgangslage, Ziel und Vorgehen, Kern der Entwicklung,
   Ergebnis der Validierung, Bewertung. Das berufliche Umfeld steht als ein
   Satz zu Beginn des zweiten Absatzes und nennt nur, was die Arbeit selbst
   belegt, naemlich die Siemens AG als dualen Partner und den Umstand, dass
   Geraetereihe und Zielplattform aus demselben Haus stammen (siehe
   @sec:ausgangslage und @sec:desigocc). Der Geschaeftsbereich ist bewusst
   nicht genannt, da ihn keine Stelle der Arbeit auffuehrt. Alle Zahlen stammen
   aus
   @tab:bilanz_datenpunkte und @tab:anforderungsabgleich und sind bei einer
   Aenderung dort mitzufuehren.

   Der Text ist auf hoechstens 250 Woerter begrenzt. Der englische Abstract in
   001_abstract.typ ist die Uebersetzung dieses Textes, unterliegt derselben
   Grenze und ist bei jeder Aenderung mit anzupassen.

   ECPD steht hier als "Elektronische Schaltkreisschutzgeraete (ECPD)", weil
   #acro die Langform nur bei der ersten Verwendung im Dokument setzt und diese
   nach der Reihenfolge in main.typ auf den Abstract faellt. Wird die
   Reihenfolge von Abstract und Kurzfassung getauscht, ist die Klammer hier zu
   entfernen und der erste Satz des Abstracts entsprechend umzustellen. */
