#import "../config/acronyms.typ": *
#import "../config/functions.typ": *
#include "../config/config.typ"


= Kurzfassung

Elektronische Schaltkreisschutzgeräte der Reihe SENTRON #acro("ECPD") messen Strom, Spannung und Wirkleistung je Endstromkreis und lassen sich über einen zugehörigen Datentransceiver, das SENTRON Powercenter, fernschalten. In der mitgelieferten Objektmodellbibliothek der Gebäudemanagementplattform Desigo CC fehlt diese Gerätereihe, weshalb jede Anbindung bisher eine Einzelanfertigung war. Der dabei wiederkehrende Aufwand, Modbus-Register benannten Datenpunkten zuzuordnen, ist arbeitsintensiv und fällt in jedem Projekt erneut an.

Die vorliegende Arbeit entwickelt dafür eine wiederverwendbare Integrationsvorlage und weist sie an einem Hardwareaufbau nach. Das Vorgehen folgt dem V-Modell. Aus einer System- und Stakeholderanalyse gehen zehn Anwendungsfälle hervor, daraus fünfzehn Anforderungen und vierzehn Testfälle, womit jede Festlegung des Modells auf eine Tätigkeit einer benannten Nutzergruppe zurückführbar bleibt.

Den Kern bildet die Auswahl der Datenpunkte. Ein Strang aus einem Powercenter und einem Endgerät umfasst 363 Einträge der Registerkarte, die weder sinnvoll darstellbar noch im geforderten Takt abfragbar sind, und jedes weitere Endgerät fügt 152 hinzu. Sieben Auswahlkriterien senken diesen Umfang auf 53 gelesene Register und damit die Abfragelast um rund 85 Prozent. Das Ergebnis besteht aus maschinenlesbaren Typbeschreibungen für beide Gerätetypen, einer Aufstellung, die zu jedem Datenpunkt Register, Format und Begründung festhält, sowie einer Unterlage für Errichter und Betreiber.

Die Validierung weist zehn der fünfzehn Anforderungen als erfüllt aus, drei als teilweise und zwei als nicht erfüllt. Messwerte, Zählerstände, Stammdaten und der Schalterzustand erscheinen vollständig und richtig beschriftet, Schaltbefehle werden ausgeführt und quittiert. Offen bleibt die Alarmierung, da sämtliche Meldungen in einem Sammelregister liegen und sich mit der eingesetzten Werkzeugkette nicht in einzeln auswertbare Zustände zerlegen lassen. Die Prüfung belegt darüber hinaus Eigenschaften der Geräte und der Plattform, die kein Datenmodell beheben kann, darunter die nur örtlich zu erteilende Freigabe des Fernschaltens, ab Werk abgeschaltete Alarmbits und ein nur geräteübergreifend einstellbares Abfrageintervall.

Für das Projektgeschäft ergibt sich eine geteilte Bewertung. Als Vorlage nimmt das Modell die wiederkehrende Zuordnungsarbeit ab und trägt die Beobachtung und Auswertung eines Verteilers aus der Leitwarte. Als vollständige Leitwartenanbindung eines Schutzgeräts trägt es nicht, solange die Meldungen nicht als einzelne Zustände vorliegen und sich die Alarmierung deshalb auch in der Projektierung nicht einrichten lässt.

/* Claude: Kurzfassung aus @sec:zusammenfassung, @sec:anforderungsabgleich,
   @sec:praxistauglichkeit und @sec:standdertechnik verdichtet, fuenf Absaetze
   nach dem Muster Ausgangslage, Ziel und Vorgehen, Kern der Entwicklung,
   Ergebnis der Validierung, Bewertung. Alle Zahlen stammen aus
   @tab:bilanz_datenpunkte und @tab:anforderungsabgleich und sind bei einer
   Aenderung dort mitzufuehren.

   Der englische Abstract in 001_abstract.typ ist die Uebersetzung dieses
   Textes und bei jeder Aenderung mit anzupassen. */
