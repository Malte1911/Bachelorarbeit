#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Berücksichtigung von Nachhaltigkeitsaspekten<sec:nachhaltigkeit>

Die Lösung verbraucht selbst keine nennenswerten Ressourcen und erzeugt auch keine direkte Einsparung. Sie schafft Sichtbarkeit, und deren Wirkung entsteht erst dort, wo jemand die gewonnenen Daten auswertet und daraus eine Entscheidung ableitet. Unter dieser Einschränkung sind die folgenden Aspekte zu lesen.


=== Ökologische Aspekte

Der unmittelbare Beitrag liegt in der Energietransparenz auf der Ebene des einzelnen Abgangs. Erst wenn Strom, Spannung und Wirkleistung je Endstromkreis in der Leitwarte vorliegen, lassen sich Verbraucher einander gegenüberstellen, Dauerlasten außerhalb der Nutzungszeit erkennen und Maßnahmen zur Lastverschiebung überhaupt begründen. Die Auflösung, die eine Verteilerebene mit bis zu 24 einzeln erfassten Abgängen bietet, geht dabei deutlich über die eines zentralen Zählers hinaus. Der in @sec:praxistauglichkeit benannte fehlende Zähler der elektrischen Arbeit begrenzt diesen Beitrag jedoch, da eine belastbare Verbrauchsbilanz aus integrierten Momentanwerten nicht entsteht.

Der zweite Beitrag betrifft die Instandhaltung. Betriebsstunden, Schaltspiele und die nach Ursache getrennten Auslösezähler erlauben eine zustandsbasierte statt einer intervallbasierten Wartung, womit Geräte nach ihrer tatsächlichen Beanspruchung getauscht werden und nicht nach einem pauschalen Zeitraum. Dasselbe gilt für den Differenzstrom des #acro("RCM")-Tiefpasses, dessen Verlauf eine Verschlechterung der Isolation erkennbar macht, bevor das Gerät abschaltet. Beides verlängert die Nutzungsdauer der verbauten Geräte.


=== Ökonomische Aspekte

Der wirtschaftliche Nutzen der Vorlage liegt in der Verlagerung eines wiederkehrenden Aufwands. Die Zuordnung von Registern zu benannten Datenpunkten erfolgt in der Gebäudeautomation überwiegend von Hand und bleibt arbeitsintensiv und kostentreibend @src:wang2018. Diese Zuordnung ist mit der Typbeschreibung und der zugehörigen Aufstellung einmalig geleistet und gilt für jedes Gerät desselben Typs. In Folgeprojekten entfällt damit nicht nur die Arbeit selbst, sondern auch die Fehlerquelle, die in einer jedes Mal neu getroffenen Auslegung von Registerinhalten liegt.

Hinzu kommt die Skalierung innerhalb einer Anlage. Aus einer Typbeschreibung entstehen beliebig viele Instanzen, denen allein ihre Kommunikationsparameter mitzugeben sind, sodass der Aufwand mit der Zahl der Geräte nicht linear wächst. Die in @sec:datenpunkte begründete Reduktion des Umfangs wirkt in dieselbe Richtung, da sie die Abfragelast eines voll bestückten Strangs um rund vier Fünftel senkt und damit den Betrieb mehrerer Stränge an einem Server erst ermöglicht.

Beide Punkte stehen unter zwei Vorbehalten. Solange die Alarmierung nach @sec:praxistauglichkeit je Anlage von Hand einzurichten ist, bleibt ein Teil der Handarbeit bestehen, den die Vorlage gerade abnehmen sollte. Und die Wiederverwendbarkeit ist nach @sec:anforderungsabgleich an einem einzelnen #acro("ECPD") belegt, nicht an einem vollständigen Strang unter Betriebsbedingungen.

// #kommentar[Zu entscheiden ist, ob neben der ökologischen und der ökonomischen Dimension eine soziale Betrachtung aufgenommen wird. Anknüpfungspunkte bestünden mit der Unterstützung der wiederkehrenden Prüfung nach #acro("DGUV") Vorschrift 3 und mit der Entlastung des Servicepersonals von Einsätzen im Verteiler unter Spannung.]

/* Claude: Abschnitt aus den vier Stichpunkten des Autors ausformuliert und auf
   drei kurze Absaetze je Dimension gebracht. Die beiden Vorbehalte im letzten
   Absatz sind ergaenzt, damit der Nutzen nicht staerker behauptet wird, als
   @sec:anforderungsabgleich ihn traegt. */
