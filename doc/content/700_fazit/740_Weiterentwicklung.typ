#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Möglichkeiten der Weiterentwicklung <sec:weiterentwicklung>


Aus den Befunden in @sec:befunde und den Grenzen in @sec:wuerdigung ergeben sich mehrere Anknüpfungspunkte für zukünftige Entwicklungen.

Mit dem geringsten Aufwand ließe sich Abfragelast beseitigen, die derzeit ohne jeden Nutzen anfällt. Nach @sec:testdurchfuehrung entfallen drei der zwölf Anfragen je Abfragezyklus auf Coils, die das Powercenter nicht bedient. Ließe sich klären, woher sie stammen, sänke die Zahl der Telegramme je Gerät um ein Viertel, ohne dass ein Wert verloren geht. Der Weg dorthin ist kurz, denn eine erneute Aufzeichnung nach dem Entfernen eines der drei Datenpunkte zeigt, ob die Anfrage an einem Datenpunkt hängt oder vom Treiber selbst stammt.

Am nächsten liegt die nach Verwendungszweck abgestufte Abfrage. Sie scheitert nach @sec:befunde nicht an der Zielplattform, die benannte Abfragegruppen mit eigenem Intervall führt, sondern an der Stelle, an der diese zugewiesen werden. Ließe sich die Zuordnung mit der Vorlage ausliefern statt sie je Projekt über den tabellarischen Geräteimport nachzuziehen, wäre die Abfragelast eines vollen Strangs über die Auswahl der Datenpunkte hinaus zu senken. Die dafür nötige Einstufung liegt bereits vor: Jeder Datenpunkt ist nach @sec:datenpunkte in der Arbeitsmappe des Anforderungskatalogs mit einem Vermerk zur erforderlichen Aktualität versehen, der dort ausdrücklich als Vorgabe für die Projektierung und eine spätere Weiterentwicklung ausgewiesen ist.

Die Typbeschreibung des Powercenters lässt sich abrunden. Sie ist nach @sec:umsetzung bewusst schmal gehalten und liefert die abgebildeten Werte nach @sec:uebernahme in der vorgesehenen Form, ist über Import und Instanzbildung hinaus jedoch nicht mit derselben Tiefe geprüft worden wie die des #acro("ECPD"). Der Zeit- und Synchronisationsstatus ist darin zudem ausgespart geblieben. Seine Aufnahme wäre eine kleine Ergänzung, deren Nutzen allerdings an derselben Alarmierung hängt, denn eine abweichende Uhr des Datentransceivers entwertet die Zeitstempel des Strangs und fällt erst auf, wenn sie gemeldet wird.

Der fehlende Zähler der elektrischen Arbeit ist auf der Geräteseite zu schließen. Ein Zählregister im #acro("ECPD") wäre die einzige Lösung, die eine belastbare Verbrauchsbilanz je Endstromkreis ermöglicht, da eine Integration der Wirkleistung in Desigo CC bei schaltenden Lasten eine Näherung bleibt.

Die naheliegende Frage nach einer Automatisierung von Auswahl und Zuordnung ist gesondert zu betrachten, da der Stand der Forschung sie für den hier vorliegenden Fall bereits weitgehend beantwortet. Verfahren, die Datenpunkte selbsttätig zuordnen, arbeiten auf uneinheitlich benannten Beständen und erreichen dort eine mittlere Trefferquote von 91,4 Prozent, wobei eine Prüfung durch den Menschen erforderlich bleibt @src:zhan2020. Für den hier betrachteten Fall entfällt ihre Voraussetzung ohnehin, da die Registerkarte die Benennung vorgibt. Die verbleibende Arbeit besteht in der Entscheidung, welche Register die Anwendungsfälle benötigen, und diese Entscheidung folgt aus den Anwendungsfällen.

Weiter reicht ein Vorschlag, den der Produktsupport in @src:siemenssupport2026 zu mehreren der aufgetretenen Schwierigkeiten gab. Eine vorgelagerte Steuerung übernimmt dabei die Modbus-Kommunikation mit dem Powercenter und stellt Desigo CC die aufbereiteten Daten bereit. Das Sammelregister ließe sich dort in einzelne Meldungen zerlegen und die Abfrage je Gruppe abstufen, womit gerade die beiden Grenzen entfielen, an denen diese Arbeit notgedrungen endete. Dieser Weg greift allerdings tief in den Aufbau der Anbindung ein, denn die entwickelte Typbeschreibung verliert damit ihren Adressaten, und die Zuordnungsarbeit verlagert sich aus dem Objektmodell in die Steuerung, wo sie erneut zu leisten und zu pflegen ist. Für eine große Liegenschaft mit mehreren Strängen könnte dieser Weg eine realistische Option darstellen, vor allem wenn mehrere Stränge gebündelt auf einer Steuerung bearbeitet werden können. Zu untersuchen wäre, ob sich beide Wege verbinden lassen, indem die Steuerung allein die Meldungen zerlegt und die übrigen Datenpunkte weiterhin unmittelbar aus der Typbeschreibung stammen.

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

/* Claude: Am 07.09.2026 nach dem Feedback des Betreuers ueberarbeitet.
   Der Einstieg des zweiten Absatzes benennt jetzt den Aufwand statt der Wendung
   von der "Last, die keinen Ertrag bringt". Der Verweis auf die Arbeitsmappe
   nennt, was dort steht und wo es im Text belegt ist (@sec:datenpunkte); der
   Dateiname bleibt nach der Ruecksprache zu @sec:vorgehensmodell aus dem
   Fliesstext heraus. Der Absatz zum Powercenter haelt nach der Auskunft des
   Autors fest, dass die Typbeschreibung die Werte grundsaetzlich traegt und
   allein nicht in derselben Tiefe geprueft ist wie die des ECPD; Beleg ist
   @sec:uebernahme. Das Wort "nuechtern" ist ersetzt, ebenso "Der Preis ist
   hoch", das offenliess, ob ein finanzieller Aufwand gemeint war. */
