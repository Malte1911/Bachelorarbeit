#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Möglichkeiten der Weiterentwicklung <sec:weiterentwicklung>

/* Anmerkung des Autors, erledigt: "Anknuepfungspunkte aus den Befunden in
   @sec:befunde, unter anderem die nach Verwendungszweck abgestufte Abfrage, ein
   eigenes Objektmodell fuer das Powercenter und die Behandlung des fehlenden
   Energiezaehlers." */

/* Anmerkung des Autors, erledigt: "Die naheliegende Frage nach einer
   Automatisierung von Auswahl und Zuordnung gehoert hierher, mit der ehrlichen
   Antwort. Verfahren, die Datenpunkte aus Bezeichnern und Messverlaeufen
   selbsttaetig zuordnen, existieren, erreichen aber keine Guete, die eine
   Pruefung durch den Menschen ersetzt @src:zhan2020." */

Aus den Befunden in @sec:befunde und den Grenzen in @sec:wuerdigung ergeben sich mehrere Anknüpfungspunkte für zukünftige Entwicklungen.

Am nächsten liegt die nach Verwendungszweck abgestufte Abfrage. Die Auswahl vermerkt zu jedem Datenpunkt die erforderliche Aktualität, das Abfrageintervall gilt am eingesetzten Stand jedoch geräteübergreifend, weshalb Stammdaten und Zählerstände im Takt des Schalterzustands gelesen werden. Ließe es sich je Datenpunktgruppe einstellen, wäre FA-02 erfüllt und die Abfragelast eines vollen Strangs weiter zu senken. Die Angaben dafür liegen in der Arbeitsmappe bereits vor.

Die Typbeschreibung des Powercenters lässt sich abrunden. Sie ist nach @sec:umsetzung bewusst schmal gehalten und über Import und Instanzbildung hinaus ungeprüft, und der Zeit- und Synchronisationsstatus ist darin ausgespart geblieben. Seine Aufnahme wäre eine kleine Ergänzung, deren Nutzen allerdings an derselben Alarmierung hängt, denn eine abweichende Uhr des Datentransceivers entwertet die Zeitstempel des Strangs und fällt erst auf, wenn sie gemeldet wird.

Der fehlende Zähler der elektrischen Arbeit ist auf der Geräteseite zu schließen. Ein Zählregister im #acro("ECPD") wäre die einzige Lösung, die eine belastbare Verbrauchsbilanz je Endstromkreis trägt, da eine Integration der Wirkleistung in Desigo CC bei schaltenden Lasten eine Näherung bleibt.

Die naheliegende Frage nach einer Automatisierung von Auswahl und Zuordnung verdient eine nüchterne Antwort. Verfahren, die Datenpunkte selbsttätig zuordnen, arbeiten auf uneinheitlich benannten Beständen und erreichen dort eine mittlere Trefferquote von 91,4 Prozent, wobei eine Prüfung durch den Menschen erforderlich bleibt @src:zhan2020. Für den hier betrachteten Fall entfällt ihre Voraussetzung ohnehin, da die Registerkarte die Benennung vorgibt. Die verbleibende Arbeit besteht in der Entscheidung, welche Register die Anwendungsfälle tragen, und diese Entscheidung folgt aus den Anwendungsfällen.

Weiter reicht ein Vorschlag, den der Produktsupport in @src:siemenssupport2026 zu mehreren der aufgetretenen Schwierigkeiten gab. Eine vorgelagerte Steuerung übernimmt dabei die Modbus-Kommunikation mit dem Powercenter und stellt Desigo CC die aufbereiteten Daten bereit. Das Sammelregister ließe sich dort in einzelne Meldungen zerlegen und die Abfrage je Gruppe abstufen, womit gerade die beiden Grenzen entfielen, an denen diese Arbeit endet. Der Preis ist hoch, denn die entwickelte Typbeschreibung verliert damit ihren Adressaten und die Zuordnungsarbeit verlagert sich in die Steuerung. Für eine große Liegenschaft mit mehreren Strängen könnte dieser Weg eine realistische Option darstellen, vor allem wenn mehrere Stränge gebündelt auf einer Steuerung bearbeitet werden können. Zu untersuchen wäre, ob sich beide Wege verbinden lassen, indem die Steuerung allein die Meldungen zerlegt und die übrigen Datenpunkte weiterhin unmittelbar aus der Typbeschreibung stammen.

/* Notizen des Autors zu diesem Abschnitt, in den letzten Absatz überführt:
   - Produktsupport empfiehlt für quasi alle Probleme die ich hatte ein
     Davorschalten einer PLC --> irgendwie den ganzen punkt ein objektmodell zu
     bauen ist halt tot damit --> bei verwendung mehrerer Powercenters in großer
     Anwendung durchaus realistisch und denkbar, Objektmodell insgesamt halt dann
     nicht mehr verwendbar, mit einer ebene dazwischen ist halt das mit den
     Alarmen und so easy lösbar */

/* Claude: Sechs kurze Absaetze, bewusst knapp gehalten. Die Reihenfolge folgt
   dem Aufwand, von der Einstellung am Treiber bis zur Architekturaenderung. Der
   Vorschlag der vorgelagerten Steuerung steht am Schluss, weil er den Ansatz
   dieser Arbeit in Frage stellt; die Bewertung ist der Notiz des Autors gefolgt
   und weder beschoenigt noch verworfen. Die zhan-Formulierung entspricht der am
   27.08.2026 am Volltext geprueften Fassung aus @sec:auswahlkriterien. */
