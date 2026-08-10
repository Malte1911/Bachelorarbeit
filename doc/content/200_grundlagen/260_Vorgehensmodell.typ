#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#import "../../config/diagrams.typ": abb_vmodell
#include "../../config/config.typ"

== Vorgehensmodell<sec:vorgehensmodell>

Die Entwicklung eines Datenmodells umfasst mehrere aufeinander aufbauende Tätigkeiten, von der Analyse des Systemkontexts und der Stakeholder über die Festlegung der Anforderungen und die Auswahl der abzubildenden Daten bis hin zur Umsetzung und deren Prüfung. Um diesen Ablauf nachvollziehbar zu strukturieren, wird ein Vorgehensmodell zugrunde gelegt. Ein solches Modell unterteilt den Entwicklungsprozess in definierte Phasen und legt deren Reihenfolge sowie die zwischen ihnen bestehenden Abhängigkeiten fest @src:sommerville2016. Im Folgenden werden mit dem Wasserfallmodell und dem darauf aufbauenden V-Modell zwei etablierte Vorgehensmodelle vorgestellt und anschließend begründet, welches der beiden sich für die vorliegende Arbeit eignet.

Das Wasserfallmodell zählt zu den ältesten Vorgehensmodellen der Softwaretechnik und geht in seiner ursprünglichen Beschreibung auf Royce zurück @src:royce1970. Es gliedert die Entwicklung in aufeinanderfolgende Phasen, die typischerweise die Anforderungsanalyse, den Entwurf, die Implementierung, den Test und den Betrieb umfassen. Diese Phasen werden sequenziell durchlaufen, wobei eine Phase erst begonnen wird, wenn die vorhergehende abgeschlossen ist @src:sommerville2016. Jede Phase schließt dabei mit einem Ergebnisdokument ab, das der folgenden Phase als Eingang dient, weshalb das Modell auch als dokumentgetrieben bezeichnet wird @src:sommerville2016. Sein wesentlicher Vorteil liegt in der Einfachheit und der klaren Struktur, weshalb es sich vor allem bei stabilen und von Beginn an weitgehend bekannten Anforderungen eignet @src:sommerville2016. Als nachteilig erweist sich, dass eine Überprüfung der Ergebnisse erst spät im Prozess erfolgt und Fehler aus frühen Phasen häufig erst im abschließenden Test sichtbar werden. Bereits Royce sieht deshalb Rücksprünge in die jeweils vorhergehende Phase vor, weist aber zugleich darauf hin, dass diese mit erheblichem Aufwand verbunden sind @src:royce1970.

Das V-Modell erweitert das Wasserfallmodell, indem es jeder konstruktiven Phase eine korrespondierende prüfende Phase gegenüberstellt @src:ludewig2023. Grafisch werden die Phasen in Form eines „V" angeordnet. Der absteigende, linke Ast beschreibt die zunehmende Detaillierung von den Anforderungen über den System- bis zum Feinentwurf, während der aufsteigende, rechte Ast die schrittweise Integration und Prüfung abbildet. Jeder Prüfebene ist dabei genau eine Spezifikationsebene des linken Astes zugeordnet, gegen die verifiziert und validiert wird @src:ludewig2023. Ein charakteristisches Merkmal besteht darin, dass die zugehörigen Testfälle bereits parallel zur jeweiligen Spezifikationsphase entworfen werden und nicht erst nach der Implementierung. Für die Entwicklung mechatronischer und eingebetteter Systeme, in denen Hardware- und Softwareanteile zusammenwirken, ist das V-Modell als Entwicklungsmethodik etabliert und in der VDI-Richtlinie 2206 beschrieben, die es in ihrer aktuellen Fassung ausdrücklich auf cyber-physische Systeme erweitert @src:vdi2206.


=== Auswahl für diese Arbeit<sec:vorgehensmodell_auswahl>

Für die vorliegende Arbeit wird das V-Modell als Vorgehensmodell gewählt. Ausschlaggebend sind drei Überlegungen.

Erstens ist die Aufgabenstellung ihrem Wesen nach prüfungsorientiert. Aus der Analyse des Systemkontexts und der Stakeholder werden die Anforderungen an das Datenmodell abgeleitet, aus denen wiederum die Testfälle entstehen. Diese entstehen damit gemeinsam mit den Anforderungen und nicht erst nach der Umsetzung, was genau dem kennzeichnenden Merkmal des V-Modells entspricht.

Zweitens besteht der aufsteigende Ast nicht aus einer einzigen Prüfung, sondern aus mehreren Ebenen mit jeweils eigenem Bezugspunkt. Die Umsetzung des Mappings wird gegen die zuvor getroffene Auswahl der Daten verifiziert, das Prüfergebnis anschließend gegen den Anforderungskatalog validiert, und die Lösung insgesamt wird abschließend an den Erwartungen gemessen, die in der Analyse erhoben wurden. Damit liegt die für das V-Modell charakteristische Zuordnung von Spezifikations- und Prüfebenen tatsächlich vor.

Drittens umfasst die Arbeit sowohl Hardwarekomponenten wie die Schutzschaltgeräte und den Datentransceiver als auch die softwareseitige Modellierung in der Managementplattform, die über Kommunikationsschnittstellen miteinander vernetzt sind. Das Vorhaben ordnet sich damit in den Bereich der cyber-physischen Systeme ein, für den die aktuelle Fassung der VDI-Richtlinie 2206 das V-Modell ausdrücklich vorsieht @src:vdi2206.

#figure(
  abb_vmodell,
  caption: [V-Modell als Vorgehensmodell dieser Arbeit, mit der Zuordnung der Spezifikations- zu den Prüfebenen und der beidseitigen Kopplung zwischen der Auswahl der Daten und deren Prüfung am Testaufbau],
)<img:vmodell>

Einschränkend ist anzumerken, dass die Umsetzung nicht rein sequenziell verläuft. Insbesondere sind die Entwicklungs- und die Prüfphase über die Auswahl der Daten eng miteinander verzahnt, sodass die Übergänge zwischen dem absteigenden und dem aufsteigenden Ast an dieser Stelle fließend sind. Welche Datenpunkte sich sinnvoll abbilden lassen, ergibt sich nicht allein aus der Dokumentation, sondern zeigt sich erst in der Prüfung am realen Gerät. Die Prüfung liefert damit Eingangsinformationen für eine Auswahl, die ihr im Modell vorgelagert ist, während die Auswahl umgekehrt bestimmt, was überhaupt zu prüfen ist. In @img:vmodell ist diese unterste Zuordnung deshalb als beidseitige Kopplung dargestellt, während die darüberliegenden Ebenen der gerichteten Ordnung des Modells folgen. Das V-Modell dient in dieser Arbeit somit als übergeordneter Rahmen, der die Phasen und ihre Bezugspunkte festlegt, innerhalb dessen die Entwicklung jedoch mit Rückkopplungsschleifen zwischen Umsetzung und Prüfung erfolgt.

/* Claude: Der Abschnitt bleibt nach Ruecksprache beim V-Modell. Ergaenzt wurde
   der Schlussabsatz zur engen Verzahnung von Entwicklungs- und Pruefphase ueber
   die Auswahl der Daten; die Abbildung zeichnet diese unterste Zuordnung
   deshalb als beidseitige Kante, alle uebrigen bleiben gerichtet.

   Die Abbildung liegt als `abb_vmodell` in config/diagrams.typ. Sie verwendet
   eine abweichende Kantenkodierung (durchgezogen = Abfolge der Phasen,
   gestrichelt = Zuordnung von Spezifikation und Pruefung), was dort im
   Quelltext vermerkt und in der Legende der Abbildung ausgewiesen ist.

   Der zuvor hier stehende Ausblick auf die Kapitel zu Anforderungen und
   Validierung ist entfallen, da er den folgenden Kapiteln vorgriff; die
   Zuordnung der Phasen zu den Arbeitsschritten steht jetzt in der Abbildung. */
