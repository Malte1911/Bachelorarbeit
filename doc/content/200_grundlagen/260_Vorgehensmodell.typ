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
  caption: [V-Modell als Vorgehensmodell dieser Arbeit, mit dem Artefakt jeder Phase, der Zuordnung der Spezifikations- zu den Prüfebenen und der Rückkopplung aus der Erprobung am Testaufbau in die Auswahl der Daten],
)<img:vmodell>

Jede Phase schließt mit einem benennbaren Ergebnis ab, das @img:vmodell im jeweiligen Kasten ausweist und das der folgenden Phase als Eingang dient. Auf dem aufsteigenden Ast tritt an die Stelle des Artefakts der Nachweis, der nach @sec:nachweisarten am Testaufbau, am Artefakt selbst oder durch Begutachtung geführt wird.

Zur angewandten Methode gehört dabei eine Rückkopplung, die das Modell in seiner reinen Form nicht vorsieht. Welche Datenpunkte sich abbilden lassen, ergibt sich nicht allein aus der Dokumentation, sondern zeigt sich erst bei der Erprobung am realen Gerät, die deshalb bereits während der Umsetzung stattfindet und auf die zuvor getroffene Auswahl zurückwirkt. @sec:umsetzung weist diesen Rückfluss an den betroffenen Datenpunkten und Zahlen einzeln aus. Die Richtlinie VDI/VDE 2206 sieht ein solches Vorgehen vor, indem sie die Verschachtelung des V-Modells behandelt und keine Vorgaben zu Methoden macht, sondern erwartet, dass daraus ein auf die Aufgabe zugeschnittenes Vorgehen abgeleitet wird @src:vdi2206. Das V-Modell legt in dieser Arbeit somit die Phasen und ihre Bezugspunkte fest, während die Entwicklung innerhalb dieses Rahmens in Schleifen verläuft.

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

/* Claude: Nach der Anmerkung des Betreuers ueberarbeitet. Die Phasenkaesten
   nennen jetzt das Artefakt statt der Taetigkeit, auf dem aufsteigenden Ast
   die drei Nachweisarten aus @sec:nachweisarten.

   KORREKTUR nach Rueckfrage: Der Dateiname Requirements.xlsx ist wieder aus
   dem Anforderungskasten entfernt, weil er im gesamten Fliesstext nicht
   vorkommt, sondern nur in auskommentierten Arbeitsnotizen.

   Die Rueckkopplungskante lief zunaechst von der Durchfuehrung zurueck auf die
   Umsetzung. Das war nicht gedeckt: Kapitel 6 stellt Befunde fest, aendert das
   Modell aber nicht daraufhin, T-06 bleibt nicht erfuellt und die Grenzen
   stehen in @sec:anforderungsabgleich. Belegt ist stattdessen der Rueckfluss
   aus der Erprobung am Aufbau in die Auswahl, siehe @sec:umsetzung: Register 22
   nach K-06 gestrichen, Folgen durch drei Tabellen nachgezogen (54 statt 55
   Register je Strang), dazu vier weitere Stellen beim Sammelregister 2560.
   So ist die Kante jetzt gezeichnet.

   Die Rueckkopplung hing zuvor als Pfeilspitze an der Zuordnungskante
   "verifiziert gegen", eine Kante mit zwei Bedeutungen. Sie ist jetzt eine
   eigene Kante in Petrol von der Durchfuehrung zurueck auf die Umsetzung,
   mit eigenem Legendeneintrag.

   Der Schlussabsatz begann zuvor mit "Einschraenkend ist anzumerken" und las
   sich als Entschuldigung. Er steht jetzt als Aussage ueber die angewandte
   Methode. Beleg ist VDI/VDE 2206:2021, Abschnitt 6.5 "Verschachtelung des
   V-Modells zur Ableitung einer zeitlichen Abfolge", sowie die Aussage der
   Richtlinie, keine Methoden vorzugeben.

   VORBEHALT: Geprueft sind nur Inhaltsverzeichnis und Vorwort der Richtlinie,
   nicht der Text von 6.5. Die Formulierung bleibt deshalb bei "behandelt die
   Verschachtelung" und behauptet nichts ueber deren Inhalt. Vor Abgabe im
   Richtlinientext gegenlesen und bei Bedarf praeziser fassen. */
