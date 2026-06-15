#import "../../config/acronyms.typ": *
#include "../../config/config.typ"


= Kritische Würdigung <kritischewuerdigung>
== Betrachtung der Anforderungen
/* - kann noch nicht alles fertig getestet werden da noch nicht im auto integrierten
- Gewichtsoptimierung im Vergleich zum Vorjahr definitiv erreicht (Placeholder Gewichte für vorher nachher) */
Die in @anforderungen definierten Anforderungen lassen sich zum jetzigen Entwicklungsstand nur teilweise abschließend bewerten, da der #acro("DVPC") zwar als funktionsfähiges Gesamtsystem vorliegt, die finale Integration im Fahrzeug jedoch noch aussteht und somit ein Teil der Validierung erst im Fahrbetrieb möglich sein wird. Das übergeordnete Entwicklungsziel einer Gewichtsoptimierung gegenüber dem Vorjahressystem wird erreicht: Das Gesamtgewicht mit Mountings des neuen #acro("DVPC") liegt bei $730 space.thin g$ gegenüber etwa $2600 space.thin g$ der Vorjahresvariante.

=== Mechanische Anforderungen
/* - vibrationen und erschütterungen noch nicht testbar
- in handhabung bisher einwandfrei funktionstütchtig in dem Aspekt
- CoG so gut wie möglich eben, recht nah am fahrer und im bauraum drin */
Das Verhalten unter Vibrations- und Schockbelastung im Fahrbetrieb kann ohne Fahrzeugintegration nicht belastbar beurteilt werden. In der bisherigen Handhabung beim Auf- und Abbau sowie im Tisch-Setup zeigt das System keine mechanischen Auffälligkeiten. Eventuelle Probleme in Hinblick auf Vibrationen können über Gummidichtungen oder O-Ringen angegangen werden. Die Positionierung des #acro("CoG") entspricht im Rahmen des verfügbaren Bauraums der Zielvorgabe und liegt nahe am Unterkörper des Fahrers. 

=== Thermische Anforderungen
/* - läuft alles ohne einschränkungen durch thermik, siehe langzeittests */
Die thermische Auslegung erfüllt die Anforderung im getesteten Umfang: Im Langzeitbetrieb über mehr als eine Stunde unter Last treten keine thermisch bedingten Einschränkungen auf (siehe @integration). Eine Reserve für höhere Rechenlasten ist durch die konservative Auslegung der ersten Kühlkörperiteration gegeben.

=== Elektronische Anforderungen
/* - tut alles, ein und ausschalten geht, unter last funktionstüchtig
- #acro("CAN")-Verbindung angebracht, zusätzlich stehen alle Ports des Carrier Boards zur Verfügung für weitere Sachen */
Die elektronischen Funktionen sind vollständig nachgewiesen. Die Spannungsversorgung arbeitet im Ein- und Ausschaltverhalten sowie unter Last fehlerfrei. Die sechs geforderten #acro("CAN")-Busse sind angebunden, und darüber hinaus stehen sämtliche Ports des Carrierboards für zukünftige Erweiterungen unverändert zur Verfügung.

=== Nutzbarkeit und Wartbarkeit
/* - einziges Package
- soweit es ohne einbau im auto getestet werden kann ist der ein und ausbau soweit recht einfach und kann von alle übernommen werden
- system kann recht einfach zerlegt und wieder zusammengebaut werden */
Der #acro("DVPC") ist als einzelnes, geschlossenes Package ausgeführt, wodurch Transport und Handhabung außerhalb des Fahrzeugs eindeutig geregelt sind. Der Ein- und Ausbau ist soweit ohne Fahrzeugintegration beurteilbar werkzeugarm und ohne Spezialkenntnisse durchführbar. Das System lässt sich über die durchgängig verschraubten Baugruppen ohne Zerstörung in seine Einzelkomponenten zerlegen und in gleicher Qualität wieder zusammensetzen.

== Reflexion des Vorgehens
/* - Methodik und Ansatz generell nicht optimal, zu großen Teilen den strukturen und arbeitsweisen des vereins geschuldet, eigene prozesse aber oft auch nicht gut koordiniert und geplant
- fokus prototypische konzeptentwicklung richtig, früh bei der beurteilung von konzepten zu unterstützen und den entscheidungsprozess von AS subteam zu verbessern
- kühlung von DCDC hätte früher auffallen müssen und hätte früher relevant sein sollen
- kühlkörper aus slm hätte besser simuliert und entwickelt werden können für die erste iteration --> suboptimaler prototyp, mehr kommunikation mit leuten die erfahrung haben wäre wichtig gewesen --> nächste iteration sollte besser werden
- sehr zufrieden mit casing, konnte auf sehr viel vorkenntnisse zurückgreifen
- gesamtes CAD hätte besser gepflegt werden können von anfang an, hätte an vielen Stellen für weniger Schmerzen gesorgt (zum Beispiel Verkabelung im Casing mit Biegeradien etc hätten besser sein können), thor generell detaillierter zu verwenden wäre gut gewesen (es wurde nur ein vereinfachets modell verwendet, probleme hätten durch höheren detailgrad schneller erkannt und behoben werden können)
- mounting zwar funktionstüchtig aber das mit der entformungsschräge dass das nicht sauber passt hätte besser mit mehr CAD besser geplant werden können
- Integration insgesamt ganz gut
- elektrisch vor allem mit dem Automation Header hätte man früher mehr testen sollen wie das wirklich auf dem Thor funktioniert, dann hätte man das einfach nicht machen können so weil das hat sich ja herausgestellt dass es unnötig ist, hätte man sich sparen können
- mehr LTspice zur simulation für die LEDs wäre auch sinnvoll gewesen --> funktionieren status quo noch immer nicht */
Die gewählte Methodik ist im Rückblick nur teilweise optimal. Ein Teil der Einschränkungen ergibt sich aus den Arbeitsweisen und Strukturen des Vereins, darüber hinaus waren auch die eigenen Prozesse in Planung und Koordination nicht durchgängig zielführend. Der in der prototypischen Konzeptentwicklung gesetzte Schwerpunkt erweist sich demgegenüber als richtig, da die frühzeitige Bewertung der Konzepte die Entscheidungsfindung im #acro("AS")-Subteam nachweisbar unterstützt hat.

Die thermische Problematik des DCDC-Wandlers hätte zu einem früheren Zeitpunkt erkannt und adressiert werden müssen. Ebenso wäre für die erste Iteration des #acro("SLM")-gefertigten Kühlkörpers eine fundiertere Simulation sowie ein engerer Austausch mit erfahrenen Fertigungspartnern sinnvoll gewesen, um den Prototyp qualitativ zielgerichteter auszulegen und weitere Ansätze zu verfolgen. Die Erkenntnisse fließen in die konzeptionell bereits vorbereitete zweite Iteration ein.

Die Entwicklung des Casings ist aus methodischer Sicht positiv zu bewerten, da auf umfangreiche Vorerfahrung aus dem Verein zurückgegriffen werden konnte. Demgegenüber hätte das übergreifende #acro("CAD")-Modell von Beginn an konsequenter gepflegt werden müssen. Im Verlauf der Konstruktion wurde für den Jetson Thor lediglich ein vereinfachtes Modell verwendet, wodurch Integrationsprobleme wie die Biegeradien der Verkabelung im Casing oder die Passung des Mountings erst spät aufgefallen sind. Ein detaillierteres Modell und eine sorgfältigere #acro("CAD")-Pflege hätten insbesondere beim Mounting die Problematik der Entformungsschräge und der daraus resultierenden ungenauen Passung frühzeitig sichtbar gemacht.

Die Systemintegration ist insgesamt zufriedenstellend gelöst. Auf elektronischer Seite wäre eine frühere praktische Erprobung des Automation Headers am Jetson Thor sinnvoll gewesen: Die spätere Erkenntnis, dass dessen Nutzung für den vorgesehenen Anwendungsfall nicht erforderlich ist, hätte den damit verbundenen Entwicklungsaufwand vollständig eingespart. Ergänzend hätte eine umfassendere Simulation der Status-#acro("LED")-Beschaltung in LTspice zu einer belastbareren Auslegung geführt; die Anzeige ist zum aktuellen Stand noch nicht vollständig funktionsfähig.

== Einschränkungen und offene Punkte
/* - noch nicht im auto verbaut
- neuer kühlkörper kommt noch
- wirkliche Integration im Fahrzeug fehlt noch
- usability wird sich noch herausstellen wie gut das wirklich funktionieren wird
- viele probleme werden sich noch zeigen über den verlauf der saison */
Die im Rahmen dieser Arbeit erreichte Freigabe des #acro("DVPC") bezieht sich auf den Betrieb im #acro("HiL")-Aufbau. Die tatsächliche Integration in das Fahrzeug der 26er Saison steht noch aus und ist für den Nachweis der Anforderungen unter realen Betriebsbedingungen unerlässlich. Parallel dazu ist die zweite Iteration des Kühlkörpers in Vorbereitung, sodass der aktuelle Aufbau in diesem Punkt als Zwischenstand zu verstehen ist. Eine belastbare Aussage zur Nutzerfreundlichkeit im Werkstatt- und Wettbewerbsbetrieb kann erst nach dem Einbau im Fahrzeug getroffen werden. Im Verlauf der Saison ist zudem mit dem Auftreten weiterer, derzeit nicht absehbarer Probleme zu rechnen, die iterativ adressiert werden müssen.

== Weiterentwicklungspotenzial
/* - integration in syselbox steht an, da VDC jetzt nicht mehr benötigt wird (die ja vorher auch in der Syselbox war), die berechnungen werden jetzt alle auf dem thor gemacht
- kühlkörper version zwei natürlich, möglicherweise mit anpassungen auf neues packaging konzept --> könnte gewicht sparen
- kühlkörper mit wasser für DCDC --> könnte leichter und performanter sein als die Kauflösung vom Hersteller
- mounting vom thor im casing selbst könnte auch besser sein als es ist, muss man dann bei der verwendung sehen ob es funktioniert oder nicht
- mounting vom DVPC insgesamt nicht so wie geplant, funktioniert ist aber nicht so elegant
- #acro("CAN") auf der DCDC Platine vielleicht nicht dumm, könnte ein bisschen das Debugging vereinfachen */
Ein naheliegender nächster Entwicklungsschritt ist die Integration des #acro("DVPC") in die Syselbox. Da die bisher dort untergebrachte Fahrregler entfällt und die entsprechenden Berechnungen künftig auf dem Jetson Thor ausgeführt werden, wird an dieser Position Bauraum frei, der für ein kompakteres Gesamtpackage genutzt werden kann. In diesem Zusammenhang bietet sich die bereits konzeptionell vorbereitete zweite Iteration des Kühlkörpers an, die bei einer Anpassung an ein neues Packaging-Konzept zusätzliches Gewichtseinsparpotenzial erschließt.

Für die Kühlung des DCDC-Wandlers stellt eine eigenentwickelte Wasserkühlung eine technisch attraktive Weiterentwicklung gegenüber der derzeit eingesetzten Herstellerlösung dar und verspricht sowohl ein geringeres Gewicht als auch eine höhere thermische Leistungsfähigkeit. Das Mounting des Jetson Thor innerhalb des Casings ist funktionsfähig, lässt jedoch konstruktiv noch Spielraum für eine sauberere Lösung; die Beurteilung der endgültigen Qualität ist erst im Fahrbetrieb möglich. Ebenso ist das Mounting des #acro("DVPC") am Fahrzeug zwar funktionstüchtig, entspricht in seiner Ausführung jedoch nicht dem ursprünglich angestrebten Konzept und bietet Ansatzpunkte für eine elegantere Umsetzung in einer Folgeiteration.

Abschließend erscheint eine #acro("CAN")-Anbindung direkt auf der DCDC-Platine sinnvoll. Eine solche Schnittstelle würde die Diagnose elektrischer Parameter wie Strom, Spannung und Temperatur im laufenden Betrieb ermöglichen und das Debugging des Gesamtsystems spürbar vereinfachen.
