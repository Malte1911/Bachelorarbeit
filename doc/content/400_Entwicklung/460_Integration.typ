#import "../../config/acronyms.typ": *
#include "../../config/config.typ"


== Systemintegration <integration>
Nachdem die einzelnen Baugruppen des #acro("DVPC") in den vorangegangenen Abschnitten konstruktiv festgelegt wurden, werden diese im Folgenden zu einer funktionsfähigen Einheit zusammengeführt. Im Mittelpunkt steht dabei sowohl die mechanische Fixierung der Komponenten innerhalb des Casings als auch die elektrische Anbindung der Recheneinheit an die Peripherie des Fahrzeugs.

Der Aufbau gliedert sich in die Montage der Lidarplatine und der DCDC-Platine auf dem Boden des Casings, die Anbindung des Jetson Thor über Winkelmountings sowie die Konfektionierung der benötigten Signalverbindungen für Ethernet und #acro("CAN"). Abschließend wird das Tisch-Setup beschrieben, welches eine Inbetriebnahme und Funktionsprüfung des #acro("DVPC") außerhalb des Fahrzeugs ermöglicht. Die in diesem Kapitel dokumentierten Arbeitsschritte ergeben sich maßgeblich aus den Erfahrungen der Prototypenphase und berücksichtigen die im Verlauf der Saison zusätzlich aufgekommenen Anforderungen.

=== Platinen <pcbmounting>
/* - Lidarplatine und DCDC Board müssen angebracht werden
- PCBs werden an entsprechende Stelle auf den Boden des Casings gelegt, Mountingpunkte werden markiert
- dann wird an diesen Punkten durch den Boden des Casings miut 3mm Bohrer gebohrt
- Plastik-Standoffs werden installiert
- Schraube von unten in die Standoffs, dann auf die Standoffs die Platinen und auf die Platinen nochmal ein Standoff zur Befestigung
 */
Neben dem Jetson Thor werden im Inneren des Casings sowohl die Lidarplatine als auch die DCDC-Platine befestigt. Die Anbindung beider Baugruppen erfolgt über identische Arbeitsschritte. Zunächst werden die Platinen an ihrer vorgesehenen Einbauposition auf dem Boden des Casings aufgelegt und die Position der Befestigungsbohrungen auf dem Laminat angezeichnet. An den markierten Punkten wird anschließend mit einem $3 space.thin"mm"$-Standardbohrer durch den Boden des Casings gebohrt.

In die entstandenen Bohrungen werden Kunststoffstandoffs eingesetzt. Die Verschraubung erfolgt von der Außenseite des Casings, wobei die Schraube von unten durch das Laminat in den Standoff eingedreht wird. Auf diesen Standoff wird die jeweilige Platine aufgelegt und mit einem weiteren, von oben aufgeschraubten Standoff gesichert. Die zweistufige Ausführung mit Standoff unterhalb und oberhalb der Platine stellt sicher, dass die #acro("PCB") elektrisch vom Laminat beabstandet ist und gleichzeitig eine definierte mechanische Anbindung erzielt wird. In @pcbsmounted können die im Casing angebrachten #acro("PCB")s gesehen werden.

#figure(
  image("../../resources/img/pcbsmounted.jpeg", width: 60%, format: "jpg"),
  caption: [Im Casing über Kunststoffstandoffs montierte Lidarplatine und DCDC-Platine]
)<pcbsmounted>

=== Winkelmountings für Jetson Thor
/* - Zu Beginn mit vereinfachten Modell in CAD gearbeitet --> offizielles Modell sehr groß mit sehr vielen Einzelkomponenten, die sehr lange zum Laden brauchen und Computer lagged --> deswegen nicht alle Komponenten
- nach der ersten Iteration mit Prototypen offensichtlich, dass Einpressgewinde in 3D Druck aus PLA ausreichend sind
- Konfiguration in Prototyp nicht so gut, Gewinde sind nebeneinander
- mit Schraube und Mutter auf der Außenseite ausreichend, horizontale Anordnung nicht optimal da Sicherung in Z Richtung nicht gut genug
- Erweiterung der Schraubpunkte in Z Richtung und generell weiter auseinander
- werden auch seitlich noch auseinandergebaut
- Schraubpunkte passen für jedes Mounting einzeln, Mountings sind jedoch rotiert orthogonal zum Casingwand --> Kommt von Positionierung von Bohrungen mit 3D-Druck Lehre die nicht gut genug ausgerichtet war
- iterativer Ansatz aka so lange die Punkte an den Mountings anpassen bis sie gerade genug sind --> Casing ist mehr Aufwand neu zu machen, deswegen werden die Mountings angepasst weil 3D Druck geht bei so kleinen Teilen schnell und billig
- nach einer weiteren Iteration sind sie alle gerade und es kann ein Testfit gemacht werden
- Problem bei Testfit: ein Mounting geht nicht ganz an die Platine dran --> Audio Header von Carrierboard im Weg --> Mounting wird entfernt, dann passt es --> so funktioniert es, drei sind ausreichend, es ist in Planung ein Mounting zu machen, welches von dem Carrierboard aus auf dem Boden des Casings aufsetzt und somit es befestigt, kann bei Bedarf noch gemacht werden
- M3 Einpressgewinde werden in die 3D Druck Teile eingesetzt und dann werden nach oben hin noch Gewindestangen in M3 eingesetzt
- Gewindestangen sind besser als Schrauben, da man den Thor quasi "einfädeln" können soll, also die Gewindestangen oben einführt und dann nur noch nach unten muss --> mit Schrauben ist Toleranz zu groß und das funktioniert nicht, da man sonst nicht die Gewinde in den Mountings trifft
- Muttern mit Unterlegscheiben auf dem Kühlkörper
 */
Die Konstruktion der Winkelmountings für den Jetson Thor erfolgt in Siemens NX @nxsiemens zunächst auf Basis eines vereinfachten #acro("CAD")-Modells des Thor. Das vom Hersteller bereitgestellte offizielle Modell umfasst eine Vielzahl an Einzelkomponenten und führt im Verlauf der Konstruktion zu deutlichen Performanceeinbußen im #acro("CAD")-System, weshalb für die Auslegung der Mountings eine reduzierte Geometrie verwendet wird.

Aus der ersten Iteration des Prototyps geht hervor, dass Einpressgewinde in 3D-gedruckten PLA-Teilen als Anbindungspunkte für die Winkel hinreichend tragfähig sind. Die im Prototyp gewählte Anordnung der Gewinde erweist sich jedoch als nicht optimal. Während die Ausführung mit Schraube und Mutter auf der Außenseite des Casings grundsätzlich funktioniert, ist die zunächst horizontal nebeneinanderliegende Anordnung der Verschraubungspunkte nicht ausreichend, um die Mountings zuverlässig gegen Verlagerung in Z-Richtung zu sichern.

Für die überarbeitete Variante werden die Verschraubungspunkte daher sowohl in Z-Richtung als auch seitlich weiter auseinandergezogen, um ein größeres Hebelverhältnis gegen Verkippen der Mountings zu erzielen. Die Schraubpunkte passen nach der Überarbeitung für jedes Mounting individuell, die Mountings liegen jedoch gegenüber der Casingwand leicht orthogonal rotiert vor. Diese Abweichung ist auf die Positionierung der Bohrungen mit einer 3D-gedruckten Lehre zurückzuführen, deren Ausrichtung im Fertigungsprozess nicht ausreichend reproduzierbar war.

Um die Mountings dennoch in eine geradlinige Ausrichtung zu bringen, wird iterativ an der Geometrie der Mountings selbst gearbeitet, bis diese mit den tatsächlich vorhandenen Bohrungen fluchten. Eine Neufertigung des Casings wäre mit deutlich höherem Aufwand verbunden, während sich die vergleichsweise kleinen Mountings im 3D-Druck schnell und kostengünstig in mehreren Iterationen anfertigen lassen. Nach einer weiteren Iteration liegen alle Mountings gerade ausgerichtet vor, sodass ein Testfit des Thor durchgeführt werden kann.

Im Testfit zeigt sich, dass eines der vier Mountings nicht vollständig an die Platine des Thor herangeführt werden kann, da ein Audio-Header auf dem Carrierboard im Weg liegt. Das betroffene Mounting wird daraufhin entfernt. Mit den verbleibenden drei Mountings lässt sich der Thor mechanisch sicher fixieren, sodass diese Konfiguration als ausreichend bewertet wird. Ergänzend ist geplant, ein weiteres Mounting zu entwerfen, welches von der Unterseite des Carrierboards auf den Boden des Casings aufsetzt und den Thor zusätzlich abstützt. Diese Ergänzung kann bei Bedarf zu einem späteren Zeitpunkt nachgereicht werden.

In die 3D-gedruckten Mountings werden M3-Einpressgewinde eingebracht, in die nach oben hin M3-Gewindestangen eingeschraubt werden. Die Verwendung von Gewindestangen anstelle von Schrauben ist notwendig, um den Thor beim Einbau über die Gewindestangen "einfädeln" zu können. Beim Aufsetzen des Thor von oben werden die Gewindestangen durch die Bohrungen in der Platine geführt und der Thor anschließend senkrecht nach unten auf die Mountings abgelassen. Ein äquivalenter Einbau mit Schrauben ist nicht zuverlässig möglich, da die Positionstoleranzen zwischen Platine und Mountings zu groß sind, um die Gewinde beim gleichzeitigen Einsetzen aller Schrauben reproduzierbar zu treffen. Die Sicherung des Thor gegen Abheben erfolgt mit Muttern und Unterlegscheiben, die von oben auf den Kühlkörper aufgeschraubt werden.

=== Ethernet-Kabel
/* - Verbindung zwischen Lidarplatine und Ethernetport des Carrierboards
- Platz zu eng für gekauftes Ethernet-Kabel zwischen Ethernetport auf Lidarplatine und Kühlkörper des DCDC Boards --> custom Variante herstellen lassen sehr sehr teuer, deswegen wird eigenes Kabel gecrimped --> ohne Schirmung und nur mit sehr basic Stecker, ist aber sehr kurz und passt da rein
- vorverdrillte Kabel werden genommen und entprechend der Vorgabe auf Stecker gecrimped
Kabel kann durch Öffnung, durch die auch die Ports gehen geführt werden und dann eingesteckt werden
- Funktionsprüfung findet mit Lidar in HiL statt, soweit funktionstüchtig
 */
Die Datenverbindung zwischen der Lidarplatine und dem Ethernetport des Carrierboards wird über ein dediziertes Ethernet-Kabel realisiert. Der zur Verfügung stehende Bauraum zwischen dem Ethernetport auf der Lidarplatine und dem Kühlkörper der DCDC-Platine ist für ein handelsübliches Ethernet-Kabel mit Standardsteckergeometrie zu gering. Eine Fertigung eines kundenspezifischen Kabels über externe Konfektionierer wurde aufgrund der unverhältnismäßig hohen Kosten verworfen.

Stattdessen wird ein eigenes Kabel konfektioniert. Dieses wird aus vorverdrillten, ungeschirmten Kabeln aufgebaut und gemäß der Belegungsvorgabe für Ethernet auf einen einfachen Standardstecker gecrimpt. Auf eine Schirmung wird verzichtet, da das Kabel aufgrund des engen Bauraums nur eine sehr geringe Länge aufweist und die zu erwartende Störeinkopplung entsprechend begrenzt ist. Das konfektionierte Kabel wird durch dieselbe Aussparung im Casing geführt, über die auch die übrigen Ports zugänglich gemacht werden, und auf beiden Seiten in die jeweiligen Buchsen eingesteckt.

Die Funktionsprüfung der Verbindung erfolgt im #acro("HiL")-Aufbau gemeinsam mit dem angeschlossenen Lidar. Die Kommunikation ist im getesteten Umfang funktionstüchtig.

=== #acro("CAN")-Verbindung
/* - VDC Port wird für Thor geschrieben --> benötigt Zugriff auf alle #acro("CAN")-Busse (insgesamt 6) am Fahrzeug, außerdem soll Telemetrie und Driver Audio auch darauf laufen, neue Anforderungen im Laufe der Saison die aber eigentlich alle auf #acro("CAN") zurückführen
- 2 Can Busse bereits auf Header drauf an Carrierboard --> könne so verwendet werden
- PEAK System #acro("CAN") Modul 4 Channel @pcanmodule wird verwendet um die restlichen 4 #acro("CAN") Busse zu erreichen auf dem Thor
- Problem: in M.2 Slot ist kein Einschraubpunkt für eine so lange M.2 Karte, deswegen muss andere Lösung gefunden werden, original war an dieser Stelle ein Wifi M2 Modul dran
- Option: 3-D Druck Teil zur Fixierung: schwierig, da entweder wo anders am Casing oder so angebracht werden muss oder geklebt werden muss auf dem Board: auch sehr suboptimal
- andere Option ist M.2 Extender Board mit mehreren Einschraubpunkten und Ribbon Cable --> deutlich robuster, kann wie gewollt angebracht werden und SSD wird an Casing gemountet --> extra Gewicht, aber für missionskritische Komponente absolut wichtig, dass es einwandfrei funktioniert
- placeholder für das genaue modell an extender, placeholder für bild vom extender
- Stecker (placeholder für genaues Modell) für das Can modul wird vorkonfektioniert gekauft und dann mit Schrumpfschlauch und Lötzinn an ein anderes Kabel gelötet und lang genug gemacht da längere Kabel deutlich teurer gewesen wären
- Stecker (placeholder Name) mit Case Mount wird an Casing angebracht und da werden die Kabel angelötet --> Stecker, der auch am Auto an anderer Stelle angebracht ist und von dem wir noch rumliegen hatten, viel in Verwendung und deswegen proven concept und, ist günstig und super
- placeholder bild für Kabel mit angelötetem Kabel und noch eins für stecker und noch eins für stecker am casing
 */
Im Laufe der Saison wird der Fahrreglers des Fahrzeugs auf den Jetson Thor portiert. Damit ergibt sich die Anforderung, dass der Thor Zugriff auf sämtliche im Fahrzeug verbauten #acro("CAN")-Busse erhält. Ergänzend werden weitere Funktionen wie die Telemetrie und das Driver-Audio-System über #acro("CAN") angebunden, sodass am Thor insgesamt sechs #acro("CAN")-Busse bereitstehen müssen. Diese Anforderung ergibt sich schrittweise aus verschiedenen Anpassungen im Laufe der Saison, die alle auf eine gemeinsame #acro("CAN")-Kommunikation zurückzuführen sind.

Auf dem Carrierboard des Thor sind zwei #acro("CAN")-Busse bereits über Pin-Header herausgeführt und lassen sich mit einem kleinen Pin-Header einbinden. Für die verbleibenden vier #acro("CAN")-Busse wird ein 4-Channel-#acro("CAN")-Modul des Herstellers PEAK-System @pcanmodule eingesetzt, welches über die M.2-Schnittstelle des Carrierboards an den Thor angebunden wird.

Bei der mechanischen Integration des #acro("CAN")-Moduls zeigt sich, dass der vorgesehene M.2-Slot keinen Einschraubpunkt für eine Karte der Länge des #acro("CAN")-Moduls besitzt. Ursprünglich war an dieser Stelle ein kürzeres WLAN-M.2-Modul vorgesehen, dessen Einschraubpunkt nicht für die längere Bauform des PEAK-Moduls ausgelegt ist. Für die Fixierung der Karte werden daher zwei Optionen gegenübergestellt. Ein 3D-gedrucktes Fixierungsteil erweist sich als nicht praktikabel, da es entweder an einer ungünstigen Stelle am Casing verankert oder unmittelbar auf das Carrierboard geklebt werden müsste, was beide Male zu einer mechanisch wenig robusten Lösung führen würde.

Als Alternative wird ein M.2-Extender-Board mit mehreren Einschraubpunkten und Ribbon-Cable-Anbindung (siehe @m2extender) verwendet. Diese Lösung ermöglicht eine deutlich robustere Befestigung des #acro("CAN")-Moduls, da sowohl die Positionierung als auch die Einschraubpunkte frei am Casing festgelegt werden können. Die Kombination aus Carrierboard-seitigem M.2-Stecker, Ribbon Cable und extender-seitiger Karte wird am Casing verschraubt. Das zusätzliche Gewicht des Extenders und der erforderlichen Verschraubung wird bewusst in Kauf genommen, da es sich bei der #acro("CAN")-Kommunikation um eine missionskritische Funktion handelt, deren zuverlässiger Betrieb priorisiert wird.

#figure(
  image("../../resources/img/m2extender.jpeg", width: 60%, format: "jpg"),
  caption: [M.2-Extender-Board mit Ribbon-Cable-Anbindung zur Fixierung des PEAK-#acro("CAN")-Moduls am Casing]
)<m2extender>

Die elektrische Anbindung des PEAK-#acro("CAN")-Moduls an die #acro("CAN")-Busse des Fahrzeugs erfolgt über vorkonfektionierte Stecker, die auf der modulseitig direkt am Modul aufgesteckt werden. Da die vorkonfektionierten Kabel nur eine begrenzte Länge besitzen und längere Varianten deutlich teurer gewesen wären, werden die Kabel an den vorkonfektionierten Steckern abgelängt und mit Lötzinn und Schrumpfschlauch an zusätzliche Leitungen angesetzt, um die benötigte Länge zu erreichen.

Auf der Casingseite wird ein Stecker mit Case-Mount des Herstellers Weipu vom Typ SP2113/S12-1C @weipustecker in das Casing eingebracht, an dem die verlängerten Leitungen angelötet werden. Bei diesem Stecker handelt es sich um einen Typ, der an anderer Stelle im Fahrzeug bereits zum Einsatz kommt und im Verein in ausreichender Stückzahl als Restbestand vorliegt. Die breite Verwendung des Steckertyps im Fahrzeug und die damit verbundene praktische Erprobung in anderen Baugruppen sprechen zusätzlich für dessen Einsatz. Ergänzend ist die Variante gegenüber alternativen Steckern kostengünstig. Die konfektionierten Kabel mit Verlängerung sowie der am Casing zu montierende Stecker sind in @canverkabelung und @cansteckerohnecasing dargestellt.

#figure(
  image("../../resources/img/canverkabelung.jpeg", width: 60%, format: "jpg"),
  caption: [Auf die benötigte Länge gekürzte, vorkonfektionierte #acro("CAN")-Stecker mit verlöteten Verlängerungsleitungen ohne Schrumpfschlauch]
)<canverkabelung>

#figure(
  image("../../resources/img/cansteckerohnecasing.jpeg", width: 60%, format: "jpg"),
  caption: [Case-Mount-Stecker für die #acro("CAN")-Anbindung mit innenseitig angelöteten Leitungen im Entwicklungskit. Auf der rechten unteren Seite kann der auf dem #acro("CAN")-Header angebrachte SMD Stecker mit den verlöteten Kabeln gesehen werden. Mittig im Bild ist das PEAK-#acro("CAN")-Modul mit den vorkonfektionierten modifizierten Kaebln mit Verlängerungen zum Case-Mount-Stecker auf der linken Bildseite gesehen werden.]
)<cansteckerohnecasing>

=== Tisch-Setup
/* - Tisch-Setup wird benötigt für die Benutzung des DVPCs außerhalb des Fahrzeugs
- benötigt separates Setup und so weiter für alles
- Plexiglasplatte wird als Basis verwendet --> ist noch rumgeflogen, Restteil von irgendwas anderem
- alte Pumpe wird verwendet
- nicht mehr benötigtes Laptop-Netzteil als 19.5 V Spannungsversorgung für die Pumpe
- normale Kühlungsschläuche wie auch im Auto
- Custom Reservoir von eDrive
- wird alles auf der Plaxiglasplatte aufgeklebt oder mit Pilzkopfband befestigt
- Funktionstüchtig insgesamt
- placeholder Bild
 */
Für die Inbetriebnahme und Funktionsprüfung des #acro("DVPC") außerhalb des Fahrzeugs wird ein dediziertes Tisch-Setup aufgebaut. Da der #acro("DVPC") für seinen Betrieb auf eine aktive Flüssigkühlung angewiesen ist, ist eine eigenständige Versorgungs- und Kühlperipherie erforderlich, die unabhängig vom Fahrzeug betrieben werden kann.

Als Basis des Aufbaus dient eine Plexiglasplatte, die als Restteil aus einem anderen Projekt zur Verfügung steht und auf der die einzelnen Komponenten aufgesetzt werden. Für die Kühlmittelförderung wird eine bereits aus einer früheren Saison vorhandene Pumpe weiterverwendet. Die Spannungsversorgung der Pumpe erfolgt über ein nicht mehr benötigtes Laptop-Netzteil mit einer Ausgangsspannung von $19.5 space.thin "V"$, welches die Anforderungen der Pumpe abdeckt. Als Verbindungselemente kommen die im Fahrzeug eingesetzten Kühlungsschläuche zum Einsatz, sodass die Strömungsverhältnisse im Tischaufbau weitgehend denen des Fahrzeugs entsprechen. Als Ausgleichsbehälter wird ein vom eDrive-Subteam in Eigenfertigung hergestelltes Reservoir verwendet.

Die einzelnen Komponenten werden auf der Plexiglasplatte fixiert, wobei je nach Bauteilgeometrie und voraussichtlicher Wiederverwendbarkeit eine Klebeverbindung oder eine lösbare Befestigung über Pilzkopfband gewählt wird. Der Aufbau ist im Gesamtbetrieb funktionstüchtig und ermöglicht eine vollständige Versorgung des #acro("DVPC") mit ausreichend Kühlwasser. Das Tisch-Setup ist in @tischsetup dargestellt.

#figure(
  image("../../resources/img/tischsetup.png", width: 60%, format: "png"),
  caption: [Tisch-Setup mit Plexiglasplatte, Pumpe (rechts), Reservoir (weiß, mittig), angeschlossener Kühlplatte und modifiziertem Laptop-Netzteil (links), Radiator mit Lüfter und Hasendraht als Berührungsschutz (unten) und Verschlauchung zur Versorgung des #acro("DVPC") außerhalb des Fahrzeugs]
)<tischsetup>


=== finaler Integrationstest
/* - Auto noch nicht fertig --> alles andere kann aber simuliert werden
- Tischsetup wird verwendet für Kühlung
- Netzteil als Energieversorgung in DCDC
- alles so eingesteckt wie es soll
- placeholder bild
- Lasttests und #acro("CAN") tests werden durchgeführt --> langer Zeitraum (>1h) funktionstüchtig
- somit funktionierendes Gesamtsystem
 */
Da das Fahrzeug zum Zeitpunkt der Fertigstellung des #acro("DVPC") noch nicht vollständig aufgebaut ist, kann ein Integrationstest im Fahrzeug selbst nicht durchgeführt werden. Sämtliche für den Betrieb des #acro("DVPC") relevanten Randbedingungen lassen sich jedoch außerhalb des Fahrzeugs simulieren, sodass ein abschließender Integrationstest auf dem Tisch realisiert werden kann.

Die Kühlung des #acro("DVPC") wird im Rahmen des Integrationstests über das in @tischsetup beschriebene Tisch-Setup bereitgestellt. Die Energieversorgung der DCDC-Platine erfolgt über ein Labornetzteil, welches die im Fahrzeug anliegende #acro("LV")-Spannung nachbildet. Die übrigen Verbindungen, insbesondere die #acro("CAN")-Anbindung sowie die Datenverbindung zum Lidar, werden entsprechend der vorgesehenen Konfiguration im Fahrzeug aufgesteckt. Der vollständige Versuchsaufbau ist in @integrationstest dargestellt.

#figure(
  image("../../resources/img/integrationstest.png", width: 60%, format: "png"),
  caption: [Aufbau des finalen Integrationstests mit Tisch-Setup zur Kühlung, Labornetzteil zur #acro("LV")-Versorgung und vollständig konfektioniertem #acro("DVPC")]
)<integrationstest>

Im Rahmen des Integrationstests werden sowohl Lasttests auf dem Jetson Thor als auch Funktionstests der #acro("CAN")-Kommunikation über alle sechs angebundenen Busse durchgeführt. Über einen zusammenhängenden Zeitraum von mehr als einer Stunde arbeitet das System ohne thermische Abregelung oder Kommunikationsausfälle. Das Zusammenspiel der einzelnen Baugruppen entspricht damit der vorgesehenen Funktion und der #acro("DVPC") liegt als funktionierendes Gesamtsystem für den anschließenden Einbau in das Fahrzeug vor.