#import "../../config/acronyms.typ": *
#include "../../config/config.typ"
= Entwicklung
== Prototypische Konzeptentwicklung
Die Entscheidung, welche Recheneinheit im Fahrzeug verbaut wird, liegt bei dem #acro("AS")-Subteam, welches die Software für die #acro("DV")-Disziplinen entwickelt und Expertise im Bereich der Hardwareanforderungen besitzt. Bevor die Entscheidung gefällt wird, welche Recheneinheit die Anforderungen erfüllt und eine Reihe an Tests durchgeführt wurde, findet die prototypische Konzeptentwicklung statt. Hier werden Konzepte mit Hilfe von #acro("CAD")-Software getestet für einen möglichen Aufbau des #acro("DVPC") mit verschiedenen Recheneinheiten. Außerdem werden in dieser Phase aufgrund der Neuauslegung des Monocoques verschiedene Packaging-Konzepte im Fahrzeug evaluiert. 

Im Verlauf dieser Konzeptentwicklungsphase wird sich aufgrund von Unsicherheiten mit Jetson Thor zunächst für den Zotac als zentrale Recheneinheit entschieden. Nach weiterer Evaluation und direkten Tests mit dem Jetson Thor wird diese Entscheidung jedoch geändert und der Jetson Thor als Recheneinheit gewählt.

Im Prozess wurden verschiedene als relevant erachtete Aspekte der verschiedenen Ansätze evaluiert, die in diesem Abschnitt näher beschrieben werden. Diese Ansätze sollen bei der Konzeptentscheidung der Recheneinheit unterstützen und gelten als Orientierung und Hilfe bei der Festlegung der späteren Entwicklung des gesamten #acro("DVPC").

/* Entwicklung vor der Konzeptentscheidung für Jetson aufzeigen --> hier noch mit Konstruktion auf Jetson Orin da Jetson Thor noch nicht released
- Placeholder Bild einfügen */

=== Zotac
/* Option mit 3D-Laser Scanning um für Kühlung zu vermessen aufzeigen
Bild einfügen von Casing auseinandergebaut
Da anmalen wo was hinsoll und wie man mounten könnte auf abbildung (Placeholder Bild einfügen für den Moment) */


/* - komplexeres Kühlungskonzept notwendig, da die Platine nicht optimiert ist für solche Anwendungsfälle --> Wasserkühlung mit SLM-Druckteilen ziemlich sicher möglich, ist aber deutlich größerer Aufwand als vorhandene Lösung zu verwenden, wäre aber deutlich leichter vom Gewicht her
- deutlich größer als Jetson, was die Integration erschwert
- höherer Energieverbrauch, mehr Leistung auf DCDC-Platine notwendig */
Die Verwendung des Zotac Mini-PCs wird untersucht, da dieser im Vorjahr als Recheneinheit eingesetzt wurde. 

==== Kühlungskonzepte Zotac

Da die Platine des Zotac nicht für den Betrieb in eingebetteten Fahrzeugsystemen ausgelegt ist, gestaltet sich das Kühlungskonzept deutlich aufwändiger. Eine Wasserkühlung mittels #acro("SLM")-gefertigter Bauteile wäre grundsätzlich realisierbar und böte Vorteile hinsichtlich des Gewichts, erfordert jedoch einen erheblich höheren Entwicklungsaufwand im Vergleich zu vorhandenen Lösungen, da mehrere Komponenten gekühlt werden müssen. In @zotacnocasing ist der auseinandergebaute Zotac dargestellt. Hier sind zusätzlich die zu kühlenden Komponenten markiert, die durch die vom Hersteller entworfenen Kühlkörper abgedeckt werden. 

#figure(
  image("../../resources/img/zotacnocasing.jpeg", width: 60%, format: "jpg"),
  caption: [Auseinandergebauter Zotac Mini-PC mit freigelegter Platine und Markierung der zu kühlenden Komponenten. Blau: #acro("CPU"), Gelb: #acro("RAM"), Grün: #acro("GPU"), Orange: V-#acro("RAM"), Rot: Motherboard-Chipset]
)<zotacnocasing>

Für eine Entwicklung einer eigenen Kühlungslösung müssten die verschiedenen Komponenten einzelne Kühlkörper erhalten, was ein erheblicher Aufwand im Hinblick auf die Konstruktion und Simulation bedeutet. Zusätzlich ist nicht bekannt, welche Abwärme durch die verschiedenen Komponenten produziert wird, was eine exakte Auslegung deutlich erschwert.

Darüber hinaus ist der Zotac deutlich größer als die Jetson-Plattform, was die räumliche Integration im Fahrzeug erschwert. Zudem ist der Energieverbrauch höher, sodass auf der DCDC-Platine eine größere Ausgangsleistung bereitgestellt werden müsste. Außerdem bietet der Hersteller des Zotac keine CAD-Dateien, was eine exakte Auslegung signifikant erschwert. Eine Möglichkeit wäre das Einscannen des Zotac mit einem 3D-Laserscanner welcher sehr präzise die räumliche Anordnung der verschiedenen Komponenten auf der Platine erfassen könnte. Ein solches Modell muss jedoch in ein verwendbares Modell per Hand überführt werden, was einen hohen Mehraufwand darstellt. 

==== DCDC Optionen mit Zotac
/* Hier Konzeptverteidigung vergleich einfügen mit den DCDCs --> siehe Konzeptverteidigung Vergleich
Hier beschreiben warum kein custom DCDC und warum kein linearer DCDC verwendet wurde
- linearer DCDC Argumente
- linear halt einfach kacke so
- vielschichtiges Projekt, eigener DCDC mit viel Entwicklungsaufwand verbunden
- bei höherer Leistung teilweise sehr schwierig zu entwickeln
- Aufwand nicht den Benefits wert einfach
- inhaltlich klarstellen dass die DCDC-Entwicklung nicht im Vordergrund der prototypischen Konzeptentwicklung stand, da die Entscheidung zwischen Zotac und Jetson sehr relevant ist für die Auslgung eines DCDCs wegen unterschiedlicher Leistung
- Nachforschung bei größeren Herstellern um Optionen zu finden. Ziel: Ausgangsspannung 19,5 V für Zotac, kleinen DCDC auf 12 V für LidarPCB wie 25 auch, Zotac braucht max 300 W, mit Puffer sollte DCDC wegen Leistungssprüngen mindestens 350 W haben
- Effizienz jeweils bei 48 V in und 19,5 V out
-  option 1: I7A48020A033V-003-R 500 W, 25 g, verfügbar mit insgesamt 50 g baseplate oder mit insgesamt 70 g mit Kühlkörper Fins, als quelle hinzufügen hat ocp und effizienz in unserem Arbeitspunkt von 97 % und kostet 62 €
- option 2: RPMGH12-40 insgesamt 49 g mit 480 W --> constrainter Bauraum möglicherweise problematisch ohne Kühlkörper, da Lüftung noch nicht sichergestellt, custom wasser kühlung für DCDC mit extra Gewicht verbunden und Entwicklungsaufwand, 95 % Effizienz 68 €, wurde letzte Saison verwendet, heißt Erfahrung besteht damit und im Zweifel auch eine Platine
- option 3: DS H48SC28025 700 W, 93 g mit 94 % Effizienz kostet aber auch nur 55 €, ist aber programmierbar --> Frage ist ob das realistisch verwendet wird und benefit bringt
- Entscheidung fällt auf TDK DCDC, vor allem wegen hoher Effizienz und eben Gewicht, Preisunterschiede zwischen DCDCs nicht wirklich relevant, Kühlungslösung OEM zu bekommen auch gutes Argument, da noch unklar wie das wird --> Backup ist immer gut
*/
Die Auslegung des DCDC-Wandlers bildet nicht den Schwerpunkt der prototypischen Konzeptentwicklung, da die zu wählende Topologie und Leistungsklasse unmittelbar von der Entscheidung über die Recheneinheit abhängen und sich die Leistungsaufnahme zwischen Zotac und Jetson-Plattform signifikant unterscheidet. Die folgenden Betrachtungen beziehen sich auf den Zotac, da die Konzeptentscheidung aufgrund der Unsicherheiten mit dem Jetson Thor zunächst zugunsten dieser Variante ausfällt; eine spätere Neubewertung revidiert diese Entscheidung zugunsten des Jetson Thor.

Als grundsätzliche Umsetzungsansätze werden die Entwicklung eines eigenen DCDC-Wandlers, der Einsatz eines linearen Spannungsreglers sowie die Verwendung eines kommerziell verfügbaren Schaltwandlermoduls gegenübergestellt. Die Entwicklung eines eigenen Wandlers ist im Rahmen dieses vielschichtigen Projekts nicht zielführend, da der Entwurf einer leistungselektronischen Baugruppe in der hier benötigten Leistungsklasse mit einem erheblichen Entwicklungs- und Validierungsaufwand verbunden ist, der in keinem angemessenen Verhältnis zum erzielbaren Nutzen steht. Ein linearer Spannungsregler scheidet aufgrund des prinzipbedingt geringen Wirkungsgrades bei großen Spannungsdifferenzen zwischen Ein- und Ausgang aus, da die dabei entstehende Verlustleistung in der betrachteten Leistungsklasse thermisch nicht beherrschbar ist.

Für die Verwendung eines DCDC-Moduls werden Produkte mehrerer etablierter Hersteller untersucht mit Fokus auf Through-Hole-Montage zur Anbringung auf einer eigenen Steuerungsplatine. Es werden keine isolierten DCDC-Wandler betrachtet, da eine galvanische Trennung hier nicht notwendig oder vom Regelwerk gefordert ist. Als Ausgangsspannung für die Versorgung des Zotac wird $19,5 space.thin V$ festgelegt, ergänzt durch einen kleineren DCDC-Wandler mit $12 space.thin V$ Ausgangsspannung für die LidarPCB analog zur 25er Auslegung. Die maximale Leistungsaufnahme des Zotac liegt bei etwa $300 space.thin W$, sodass der Wandler mit einem Puffer für Lastsprünge auf mindestens $350 space.thin W$ auszulegen ist. Der Wirkungsgradvergleich wird einheitlich im Arbeitspunkt $48 space.thin V$ Eingangsspannung und $19,5 space.thin V$ Ausgangsspannung geführt.

Als erste Option wird der TDK-Lambda i7A48020A033V-003-R in @tdkdcdc betrachtet. Das Modul stellt eine maximale Ausgangsleistung von $500 space.thin W$ @tdkdcdc bereit /* Datasheet i7A_spec.pdf, Product Offering Table S. 2: i7A48020A033V, 500 W, Efficiency 97 % */ und verfügt über eine Überstromabschaltung @tdkdcdc. Der Wirkungsgrad liegt nach Herstellerangabe im betrachteten Arbeitspunkt bei etwa $97 space.thin %$ @tdkdcdc/* Datasheet i7A_spec.pdf, Product Offering Table S. 2: Efficiency 97 % typ. */. Das Modul ist in drei Ausführungen verfügbar: mit offener Bauform bei einem Gewicht von $25 space.thin g$, mit Baseplate bei $50 space.thin g$ sowie mit zusätzlichen Kühlkörper-Fins bei $70 space.thin g$ @tdkdcdc/* Datasheet i7A_spec.pdf, Pin Assignment S. 7: Maximum Module Weight Open Frame 25g, Baseplate 50g, Heatsink 70g */. Der Beschaffungspreis beträgt etwa $62 space.thin €$ @tdkmouser.

Als zweite Option wird der Recom RPMGH12-40 geprüft @RecomDCDC. Der Wandler weist ein Gewicht von $49 space.thin g$ @RecomDCDC/* Datasheet RPMGH-40.pdf S. 1: Weight 49g typ. */ sowie eine typische Effizienz von $95 space.thin %$ @RecomDCDC/* Datasheet RPMGH-40.pdf S. 1, Selection Guide: RPMGH12-40, Efficiency typ. 95 % */ bei einer maximalen Ausgangsleistung von $480 space.thin W$ (entsprechend $40 space.thin A$ bei nominal $12 space.thin V$) auf @RecomDCDC/* Datasheet RPMGH-40.pdf S. 1: Output Current max. 40 A; 40 A × 12 V = 480 W */. Der Ausgangsspannungsbereich ist über einen Trim-Widerstand auf Werte zwischen $8 space.thin V$ und $24 space.thin V$ einstellbar und damit für die geforderten $19,5 space.thin V$ geeignet /* Datasheet RPMGH-40.pdf S. 1: Vout Adjust Range 8-24 VDC */@RecomDCDC. Der Beschaffungspreis liegt bei etwa $68 space.thin €$ @recommouser. Für diese Variante spricht, dass das Modul bereits in der 25er Saison eingesetzt wurde, sodass Erfahrungswerte und im Zweifelsfall bestehende Platinenentwürfe zur Verfügung stehen. Nachteilig ist, dass der Wandler ohne integrierten Kühlkörper vertrieben wird. Im begrenzten Bauraum des Casings ist eine ausreichende Konvektion nicht gesichert, sodass gegebenenfalls eine eigens entwickelte Wasser- oder Luftkühlung für den Wandler erforderlich wäre, was sowohl zusätzliches Gewicht als auch Entwicklungsaufwand mit sich bringen würde.

Als dritte Option wird der Delta Electronics H48SC28025 untersucht @dsdcdc. Das Modul bietet eine maximale Ausgangsleistung von $700 space.thin W$ @dsdcdc/* Datasheet DS_H48SC28025-3.pdf S. 1: 700W 1/2th Brick DC/DC Power Module */ bei einem Wirkungsgrad von etwa $94 space.thin %$ @dsdcdc sowie einem Gewicht von $93 space.thin g$ @dsdcdc und einem Preis von rund $55 space.thin €$ @dsmouser. Eine Besonderheit stellt die Möglichkeit der digitalen Konfiguration über eine PMBus-Schnittstelle dar /* Datasheet DS_H48SC28025-3.pdf S. 1, Features: Digital pins, PMBus */@dsdcdc. Ob die damit verbundenen Konfigurationsmöglichkeiten im vorliegenden Anwendungsfall einen spürbaren Mehrwert gegenüber einer fest parametrierten Lösung bieten, ist jedoch fraglich @dsdcdc.

Die Entscheidung fällt auf den TDK-Lambda i7A48020A033V-003-R @tdkdcdc wie in @dcdczotac gesehen werden kann. Ausschlaggebend sind der höchste Wirkungsgrad im betrachteten Arbeitspunkt sowie das geringste Gewicht der drei Optionen, insbesondere in Kombination mit der ab Werk verfügbaren Kühlkörpervariante. Letztere stellt einen wichtigen Rückfallansatz dar, da die thermischen Randbedingungen im späteren Casing zum Entscheidungszeitpunkt noch nicht abschließend geklärt sind. Die Preisunterschiede zwischen den drei Modulen fallen vor dem Hintergrund der jeweiligen Leistungsklasse und des Entwicklungsumfangs des Gesamtsystems nicht signifikant ins Gewicht.

#figure(
  image("../../resources/img/dcdczotac.png", width: 60%, format: "png"),
  caption: [i7A48020A033V DCDC-Wandler @tdkdcdc]
)<dcdczotac>


==== Mountingkonzepte Zotac
/* - Mountingkonzept noch auf Zotac, erstes Konzept --> Entscheidung wegen Unsicherheiten mit Jetson Thor, später wurde diese Entscheidung auf Jetson Thor geändert
- CoG soll so nah wie möglich an Unterkörper des Fahrers robertkaufhold quelle
- Bei Zotac mit Luftkühlung: Integration in Hinteres Aerocover (Abdeckung des hinteren Fahrwerks), genug Luft um gescheit zu kühlen, also definitiv möglich
- alternativ Mountingmethode mit Struts verwenden
- externe Mountingmethode als Experiment ungetestet von 25er Saison --> wird angebracht und getestet, theoretisch funktionstüchtig, in dieser Ausführung aber nicht stabil genug
- Trennung von DCDC und Lidarplatine und Haupt PC möglich --> können in den oberen Hinterwagen während PC hinten ist
- trennung von Package verbessert CoG, verschlechtert usability da zwei packages benötigt werden
- andere Packagingoption über Syselbox (RCU und VDC) im oberen Hinterwagen
- unklar ob bei neuem Mono mit Zotac möglich wegen Platz
- Luftkühlung deutlich schwieriger, da höhere Außentemperatur und es würde zusätzliche Kühlungshardware benötigen, mehr Gewicht
- Wasserkühlung von Zotac wäre hier ziemlich sicher vonnöten
- integration in Batteriekühlkreislauf nötig, eDrive Kühlkreislauf ist zu heiß --> Wassertemperatur kurz vor kochen teilweise
- Wasserkühlung höherer Entwicklungsaufwand, wegen Einscannen etc.
- bei Zotac Konzeptentscheidung wäre aufgrund von Gewicht und CoG Installation im Hinterwagen mit eigener Wasserkühlungslösung beste Option */
Die Betrachtung der Mountingkonzepte für den Zotac stellt das erste Konzept im Rahmen der prototypischen Entwicklung dar, da die Entscheidung der Recheneinheit aufgrund der Unsicherheiten bezüglich des Jetson Thor zunächst zugunsten des Zotac fällt. Fahrdynamisch maßgeblich für die Positionierung am Fahrzeug ist, dass das #acro("CoG") möglichst niedrig und nahe am Unterkörper des Fahrers liegt, um den Einfluss des Systems auf das Fahrverhalten zu minimieren @CoGRobertKaufhold.

Als erster Ansatz wird die Integration des Zotac in das hintere Aerocover betrachtet, welches die Abdeckung des hinteren Fahrwerks darstellt. Aus @mountinggetrennt kann eine schematische Darstellung des Konzepts entnommen werden. Der Bogen in blau wäre eine beispielhafte Darstellung des Aercovers, welches den Zotac in rot enthalten und integrieren würde. Lidarplatine und DCDC-Wandler wären an der Position des blauen Rechtecks im oberen Hinterwagen.

#figure(
  image("../../resources/img/mountinggetrennt.png", width: 60%, format: "png"),
  caption: [Schematische Darstellung des Mountingkonzepts mit Integration des Zotac in das hintere Aerocover]
)<mountinggetrennt>

An dieser Position steht ausreichend Luftvolumen zur Verfügung, sodass eine Luftkühlung des Zotac grundsätzlich realisierbar ist. Als Alternative hierzu wird eine Mountingmethode über Struts in Betracht gezogen. Zusätzlich wird ein bereits in der 25er Saison experimentell vorbereitetes, jedoch nicht erprobtes externes Mountingkonzept am Fahrzeug angebracht und getestet. Dieses erweist sich in der vorliegenden Ausführung zwar als theoretisch funktionsfähig, mechanisch jedoch als nicht ausreichend stabil.

Ein weiterer betrachteter Ansatz ist die räumliche Trennung des DCDC-Wandlers sowie der LidarPCB von der Recheneinheit. Hierbei werden DCDC-Wandler und LidarPCB im oberen Hinterwagen untergebracht, während der Zotac im hinteren Bereich des Fahrzeugs verbleibt. Diese Aufteilung verbessert das #acro("CoG") durch die gleichmäßigere Massenverteilung, verschlechtert jedoch die Nutzerfreundlichkeit, da zwei separate Packages gehandhabt werden müssen. Alternativ wird die Unterbringung über der Syselbox geprüft, welche die #acro("RCU") sowie den zentralen Fahrregler beherbergt und im oberen Hinterwagen installiert ist. Aufgrund der Neuauslegung des Monocoques ist jedoch nicht abschließend geklärt, ob der Bauraum an dieser Position für den vergleichsweise großen Zotac ausreicht.

Bei einer Integration im Hinterwagen so wie in @mountinghinterwagenoben dargestellt gestaltet sich die Luftkühlung des Zotac deutlich schwieriger, da die dort herrschenden Umgebungstemperaturen höher sind und zusätzliche Kühlhardware erforderlich wäre, was das Systemgewicht weiter erhöht. Der Zotac wäre in der Abbildung die oberste hellgrüne Box.

#figure(
  image("../../resources/img/mountinghinterwagenoben.png", width: 60%, format: "png"),
  caption: [Schematische Darstellung des Mountingkonzepts mit Integration des Zotac im oberen Hinterwagen über der Syselbox]
)<mountinghinterwagenoben>

Eine Wasserkühlung des Zotac wäre in diesem Fall nahezu zwingend notwendig. Die thermische Anbindung müsste dabei an den Batteriekühlkreislauf erfolgen, da der eDrive-Kühlkreislauf Wassertemperaturen erreicht, die teilweise nahe dem Siedepunkt liegen und damit für die Kühlung der Recheneinheit ungeeignet sind. Eine solche Wasserkühlungslösung bringt jedoch einen erheblichen Entwicklungsaufwand mit sich, unter anderem durch das bereits beschriebene Einscannen des Zotac zur Erfassung der Komponentengeometrie.

Unter Berücksichtigung der fahrdynamischen Anforderungen an das #acro("CoG") in Form der Gewichtsverteilung und des Gewichts insgesamt ergibt sich bei einer Konzeptentscheidung zugunsten des Zotac die Installation im Hinterwagen in Kombination mit einer eigens entwickelten Wasserkühlungslösung als bevorzugte Variante.


//=== Nvidia Jetson generell (claude: nicht bearbeiten!!!)
/* - größere Energieeffizienz bei hoher Performance
- einfacheres Kühlungskonzept möglich, da TTP optimiert ist für solche Anwendungsfälle
- insgesamt deutlich kompakter als Alternative --> einfacheres Packaging */
/*Die Nvidia-Jetson-Plattform zeichnet sich gegenüber konventionellen Einplatinencomputern durch eine deutlich höhere Energieeffizienz bei gleichzeitig hoher Rechenleistung aus. Da die Module über eine integrierte #acro("TTP") verfügen, ist das Kühlungskonzept auf solche eingebetteten Anwendungsfälle ausgelegt, was den Entwicklungsaufwand für die thermische Anbindung reduziert. Zusätzlich sind die Jetson-Module insgesamt deutlich kompakter als vergleichbare Alternativlösungen, was die räumliche Integration in das Fahrzeug vereinfacht.*/

=== Testaufbau Jetson Orin
/* - Hier dann halt beschreiben mit diesem hässlichem Adapter Kabel und wie das befestigt wurde
- grundsätzlich möglich die Software des DV-Systems auszuführen, jedoch nicht genug Leistung für gleichen Funktionsumfang wie im Zotac-Konzept */
Parallel zur Konzeptentwicklung wird ein Testaufbau mit dem Nvidia Jetson Orin durchgeführt, um die grundsätzliche Lauffähigkeit der #acro("DV")-Software zu evaluieren. Die Anbindung des Moduls erfolgt über ein Adapterkabel. Das eigens gebaute Adapterkabel wird im DCDC-Wandler des 25er #acro("DVPC") angeschlossen, welches die Energieversorgung übernimmt.

Bei dem Kabel handelt es sich um ein Kabel eines alten Netzteils, welches den passenden Hohlstecker für den Jetson Orin besitzt. Dieses Kabel wird aufgeschnitten und die verschiedenen enthaltenen Litzen werden auf einen Molex MegaFit 2-Pin Stecker gecrimped, welcher in den 25er DCDC-Wandler gesteckt werden kann. Der Jetson Orin wird auf der Unterseite mit Pilzkopfband am Fahrzeug fixiert und das Kabel wird aus dem alten Casing an den Jetson Orin herangeführt. Da kein Wasserschutz besteht und die Anbringung nur provisorisch ist, wird in trockenen Bedingungen mit niedriger Geschwindigkeit getestet. 

Im Rahmen dieses Aufbaus kann die Software des #acro("AS")-Systems grundsätzlich ausgeführt werden. Allerdings zeigt sich, dass die Rechenleistung des Jetson Orin nicht ausreicht, um denselben Funktionsumfang wie im Zotac-Konzept zu unterstützen @Sinan26concept.

=== Jetson

Zu Beginn der Konzeptphase war eine vom 
#acro("AS")-Subteam betrachtete Option das Verwenden des Jetson Orin als Recheneinheit, weswegen hierfür ein möglicher Casing-Prototyp entwickelt wird.

Eine einfache Konstruktion in Siemens NX eines möglichen Gehäuses kann in @orinconcept gesehen werden. Hierbei ist zu beachten, dass das in der Konstruktion enthaltene Carrierboard des Jetson Orin, auf dem die Konstruktion basiert, den gleichen Fußabdruck wie das Orin Modul besitzt, wodurch andere Packaging-Optionen vefügbar wären. Das Casing ist in grau und blassgrün, während das Orin Modul in grün und das Carrierboard in blau dargestellt ist.

#figure(
  image("../../resources/img/orinconcept.png", width: 60%, format: "png"),
  caption: [Erste #acro("CAD")-Konstruktion eines möglichen Casing-Prototyps für den Jetson Orin in Siemens NX in Schnittansicht]
)<orinconcept>

Hier ist das Modul mit Carrierboard oben an der Öffnung des Casings positioniert. Dort kann eine Kühllösung angebracht werden. Unter dem Orin Modul können Komponenten wie die LidarPCB oder der DCDC-Wandler untergebracht werden. 

In späteren Iterationen in @casingdev ist das Carrierboard des Jetson Thor in Verwendung, was einen deutlich größeren Fußabdruck als das Thor Modul besitzt, wodurch das hier dargestellte Konzept nicht anwendbar wäre, in abgewandelter Version jedoch maßgeblich den kommenden Entwicklungsprozess beeinflusst. 

==== Kühlungskonzepte Jetson
/* - Wasserkühlung vs. Luftkühlung
- Luftkühlung entweder aktiv oder passiv
- passiv nicht realisierbar --> Temperatur im Hinterwagen bis zu 45 Grad, ziemlich unrealistisch passiv zu kühlen
- aktive Luftkühlung möglich --> benötigt Kühlkörper und Lüfter, Kühlkörper muss recht groß sein (vgl. Kühlkörper Jetson Thor) und Lüfter benötigt extra Energieversorgung --> mehr Integrationsaufwand
- Wasserkühlung einfacher und günstiger, da Materialien von Fertigungspartner kommen --> Luftkühlung müsste gekauft werden, eigene Entwicklung sehr komplex im Vergleich zu Wasser
--> hier halt zum Schluss kommen dass Wasserkühlung eigentlich die einzige Lösung ist */
Für die thermische Anbindung des Jetson-Moduls, sei es der Jetson Thor oder der Jetson Orin, werden zwei grundlegende Ansätze betrachtet: Luft- und Wasserkühlung. Die Luftkühlung lässt sich dabei in eine passive und eine aktive Variante unterteilen. Eine passive Kühlung ohne aktive Luftförderung scheidet aus, da die Umgebungstemperatur im Hinterwagen des Fahrzeugs Werte von bis zu 45 °C erreichen kann und eine ausreichende Wärmeabfuhr allein durch natürliche Konvektion unter diesen Bedingungen nicht realisierbar ist, vor allem bei Jetson Thor, da dieser mehr Abwärme produziert. 

Die aktive Luftkühlung mittels Kühlkörper und Lüfter wäre prinzipiell möglich, erfordert jedoch einen vergleichsweise großen Kühlkörper sowie eine zusätzliche Energieversorgung für den Lüfter, was den Integrationsaufwand erhöht. In den Entwicklungskits der beiden Jetsons sind aktive Luftkühlkörper verbaut. Diese geben Aufschluss darüber, wie groß ein Kühlkörper jeweils sein müsste. Der Kühlkörper mit Lüfter wie in @orinCADcooler gezeigt ist auf dem gleichen Fußabdruck wie das Orin Modul, was eine Integration dieser Lösung vereinfachen würde. 

#figure(
  image("../../resources/img/orinCADcooler.png", width: 60%, format: "png"),
  caption: [#acro("CAD")-Modell des aktiven Luftkühlkörpers mit Lüfter aus dem Entwicklungskit des Jetson Orin]
)<orinCADcooler>

Im Gegensatz dazu steht der Kühlkörper des Entwicklungskits des Jetson Thor wie in @thorCADcooler dargestellt. 

#figure(
  image("../../resources/img/thorCADcooler.png", width: 80%, format: "png"),
  caption: [#acro("CAD")-Modell des seitlich angeordneten Luftkühlkörpers aus dem Entwicklungskit des Jetson Thor]
)<thorCADcooler>

Dieser ist seitlich von dem Carrierboard und dem Modul selbst installiert und ist deutlich größer als der des Jetson Orins, was eine direkte Integration erschweren würde, da deutlich mehr Platz benötigt werden würde. Zusätzlich lässt sich anhand der verfügbaren #acro("CAD")-Modellen schließen, dass das Gewicht des Kühlkörpers des Jetson Thor deutlich größer ist als das des Jetson Orins. 

Diese Konzepte für die aktive Luftkühlung werden evaluiert, jedoch ist nur der Jetson Orin als Kühlungssystem relevant. Aufgrund seiner Größe ist der Kühlkörper des Jetson Thor nicht integrierbar. Da schlussendlich die Entscheidung auf den Jetson Thor als Recheneinheit fällt, und der Kühlkörper des Jetson Orins deutlich kleiner und somit wahrscheinlich nicht in der Lage ist, den Jetson Thor zu kühlen, ist aktive Luftkühlung keine mögliche Option.

Die Wasserkühlung stellt demgegenüber die praktikablere Lösung dar: Die erforderlichen Materialien können über den bestehenden Fertigungspartner beschafft werden, während eine eigenständige Entwicklung oder der Kauf einer Luftkühlungslösung deutlich komplexer und kostenintensiver wäre. Damit ergibt sich die Wasserkühlung als einzig realisierbare Option für diesen Anwendungsfall.

=== Konzeptentscheidung des #acro("AS")-Subteams
/* - nicht im Umfang dieser Arbeit, da vor allem Software-Aspekte und Performancethemen die Entscheidung beeinflussen, was nicht Teil der Arbeit ist
- Konzeptentscheidung für Jetson Thor obwohl noch softwareseitig nicht getestet, da die Software des DV-Teams bereits auf Jetson Orin läuft und damit eine hohe Wahrscheinlichkeit besteht, dass sie auch auf Jetson Thor laufen wird, außerdem ist die Performance von Jetson Thor deutlich höher als die von Jetson Orin, was die Entscheidung zusätzlich begünstigt
- Entscheidung fällt auf Jetson Thor --> Risiko da neuer Release aber Performance soll sehr gut sein und Integration ist deutlich einfacher als bei Zotac --> Gewicht ist geringer, Kühlung ist deutlich einfacher realisierbar */
Die Konzeptentscheidung liegt im Verantwortungsbereich des #acro("AS")-Subteams und ist nicht Gegenstand dieser Arbeit, da primär Software-Aspekte sowie Performanceanforderungen die Entscheidung bestimmen. Das Subteam entscheidet sich für den Nvidia Jetson Thor als Recheneinheit, obwohl dieser zum Zeitpunkt der Entscheidung noch nicht softwareseitig validiert ist. Diese Entscheidung basiert darauf, dass die #acro("DV")-Software bereits erfolgreich auf dem Jetson Orin läuft und damit eine hohe Wahrscheinlichkeit besteht, dass sie auf der leistungsstärkeren Thor-Plattform ebenfalls lauffähig ist. Zusätzlich begünstigen die deutlich höhere Rechenleistung sowie das geringere Gewicht und die einfacher realisierbare Kühlung im Vergleich zum Zotac-Konzept diese Entscheidung, wenngleich das Risiko eines neuen, noch nicht vollständig erprobten Releases in Kauf genommen wird @Sinan26concept.

// === Fazit der prototypischen Konzeptentwicklung