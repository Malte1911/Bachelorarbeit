#import "../../config/acronyms.typ": *
#include "../../config/config.typ"

== Entwicklung des Kühlkörpers
/* - geprägt von Zeitdruck wegen interner Deadline für Fertigungspartner, der SLM Druck macht
- von Anfang an wurde geplant, eine zweite Iteration der Kühlplatte zu machen um zu dem frühen Zeitpunkt die erste Version machen zu können --> feste, sichere Version der Platte um dann zu einem späteren Zeitpunkt (nach Beendigung dieser Arbeit) ein weiteres, riskanteres Design zu testen
 */
Die Entwicklung des Kühlkörpers stand unter dem Einfluss einer internen Deadline, die durch den externen Fertigungspartner für den #acro("SLM")-Druck vorgegeben war. Um diesen Termin einzuhalten, wurde von Beginn an das Vorgehen festgelegt, zunächst eine erste, konservative Iteration der Kühlplatte zu realisieren, die innerhalb des verfügbaren Zeitrahmens sicher gefertigt werden kann und im Fahrzeug sicher funktionieren wird. Eine zweite Iteration mit einem weiterentwickelten Design wird zu einem späteren Zeitpunkt, nach Abschluss dieser Arbeit, entwickelt, gefertigt und erprobt werden. In @zweiteiteration wird der Beginn des Entwicklungsprozesses für die zweite Iteration der Kühlplatte beschrieben.

Der Kühlkörper soll in Reihe mit dem Batteriekühlkreislauf verbunden werden. Dadurch werden keine weiteren Pumpen und Radiatoren benötigt. Thermisch wird bei der Auslegung des Kühlkreislaufs des Batterie-Teams auf eine zusätzliche Hitzequelle von den definierten X W geachtet. Außerdem besteht die Option, während des Trackdrives die gesamte Kühleinrichtung der Batterie aus dem Kreislauf zu entfernen und nur den DVPC damit zu kühlen. Da im Laufe des Trackdrives nur zehn Runden gefahren werden, reicht laut Flaig in @Marian26 die thermische Masse, also die Erhitzung der Batterie und anliegender Komponenten, aus, um einen Trackdrive ohne Einschränkung zu fahren.

=== Jetson Thor Thermal Design Guide 
Die thermischen Anforderungen des Jetson Thor wurden auf Basis des zugehörigen Thermal Design Guides unter @jetsondocumentation entwickelt.

Die Platine des Jetson Thors ist in der #acro("TTP") installiert. Gemeinsam bilden sie das Thor Modul. Laut dem Thermal Design Guide unter @jetsondocumentation ist dieses Modul als Grundlage für eigene Kühlungslösungen gedacht, die auf der Oberseite des #acro("TTP") angebracht werden sollen. Die #acro("TTP") darf nicht entfernt werden, da es die Garantie des Produkts erlöscht @jetsondocumentation, weswegen dieser Weg auch nicht weiter im Rahmen dieser Arbeit diskutiert wird. 

=== Konzeptentscheidung
/* - CNC-milled Kühlkörper wie zb https://www.instructables.com/DIY-CPU-Waterblock/ und https://www.youtube.com/watch?v=I1ZLeUKWJoI und viele weitere --> im Hobbybereich verbreitet
- technisch definitiv realisierbar und könnte sogar mit der CNC-Fräse des Vereins gefräst werden
- solider Aluminiumblock der heruntergefräst wird mit Plexiglass oder so obendrauf --> verschraubt mit Dichtung dazwischen
- Dichtigkeit nicht garantiert, vor allem mit Vibrationen
- Alternative SLM Druck
- hohe Flexibilität bei Konstruktion --> bis auf ein paar Einschränkungen quasi beliebige Geometrie möglich
- Dichtigkeit durch Dichte vom Druckverfahren gegeben --> Bezug auf technische Grundlagen
- geringerer Aufwand zur Fertigung --> Fertigungspartner übernimmt kompletten Prozess
 */
Für die Realisierung eines Flüssigkeitskühlkörpers wurden zwei grundlegende Fertigungsansätze bewertet. Der erste Ansatz ist das CNC-Fräsen aus einem massiven Aluminiumblock, eine im Hobby- und Entwicklungsbereich weit verbreitete Methode @diycooler @diycooler2. Hierbei werden Kühlkanäle in einen Metallblock (Aluminium oder Kupfer) gefräst und dieser anschließend mit einer Abdeckung aus Acrylglas oder ähnlichem Material verschraubt, wobei eine Dichtung den Verbund abdichtet @diycooler. Ein wesentlicher Vorteil ist die potenzielle Fertigung mit der vereinseigenen CNC-Fräse. Als kritischer Nachteil erweist sich jedoch die schwierig sicherzustellende Dichtigkeit der verschraubten Verbindung, insbesondere unter den dauerhaften Vibrationsbelastungen im Motorsporteinsatz. Eine solche Kühllösung kann beispielhaft in @hobbycooler gesehen werden. 

#figure(
    image("../../resources/img/hobbycooler.png", width: 60%, format: "png"),
    caption: [Beispielhafter gefräster Flüssigkeitskühlkörper aus dem Hobbybereich mit verschraubter Abdeckung @diycooler]
)<hobbycooler>

Als Alternative wurde das #acro("SLM")-Verfahren evaluiert. Gegenüber dem Fräsen bietet es mehrere entscheidende Vorteile: Die weitreichende Gestaltungsfreiheit bei der Kanalgeometrie ermöglicht strömungstechnisch optimierte Innenstrukturen, die mit konventionellen Zerspanungsverfahren nicht herstellbar wären. Darüber hinaus ist die Dichtigkeit des Bauteils durch die sehr hohe Relativdichte des Verfahrens von bis zu 99,9 % inhärent gegeben, wie in den technischen Grundlagen in @slm_basics beschrieben. Da der gesamte Fertigungsprozess vom Fertigungspartner übernommen wird, entfällt zudem der interne Fertigungsaufwand. Aufgrund dieser Vorteile wurde das #acro("SLM")-Verfahren als Fertigungsansatz gewählt.

=== Konzeptentwicklung
/* - einzelne Schlange über Platte vs. Inverterplatte mit größerem Raum und Tropfen innendrin

- Analyse von resources/bib/Jetson_Thor_Thermal_DG_TDG12271001_v1.2.pdf --> Version 1.2, damals noch 1.1 welche aber nicht mehr verfügbar ist. Änderungen an dem Dokument hervorstellen und klarmachen, dass jetzt nicht mehr so richtig klar ist was sich in Kapitel 3.1.1 geändert hat
- bezug auf technische grundlage nehmen
 */

Da Kühlkörper aus #acro("SLM")-Druckverfahren an mehreren Stellen in den vergangenen Saisons verwendet wurden, gibt es verschiedene Vorgehensweisen und grundlegende Konzepte. Für die zugrundeliegenden Konzepte wird sich an zwei im Verein bereits bewährten Kühlungslösungen orientiert. 

Das erste Konzept entstammt aus der Batteriekühlplatte und kann in @batterycooler gesehen werden. Hierbei wäre eine Adaption in einen mäanderförmigen Kanal über den Bereich des Jetsons anzustreben, was die Kontaktfläche zwischen Kühlkörper und Wasser vergrößert.

#figure(
    image("../../resources/img/batterycooler.jpeg", width: 60%, format: "jpg"),
    caption: [Mäanderförmige Batteriekühlplatte des Vereins als Referenzkonzept für die Kanalgeometrie]
)<batterycooler>

Das zweite Konzept entstammt aus den im Inverter und kann @inverterplate entnommen werden. Hierbei werden innere tropfenförmige Strukturen in einem Hohlraum in der Platte verwendet, um Turbulenzen zu erhöhen und somit die Kühlleistung zu steigern, was @inverterinside entnommen werden kann. 

#figure(
    image("../../resources/img/inverterplate.jpeg", width: 60%, format: "jpg"),
    caption: [Außenansicht der Inverterkühlplatte des Vereins als Referenzkonzept für die Verteilerplattengeometrie]
)<inverterplate>

#figure(
    image("../../resources/img/inverterinside.png", width: 80%, format: "png"),
    caption: [Innenansicht der Inverterkühlplatte mit tropfenförmigen Strömungsleitelementen zur Turbulenzerhöhung]
)<inverterinside>


/* Für die Gestaltung der Strömungskanäle wurden zwei geometrische Konzepte entwickelt und untersucht. Das erste Konzept sieht einen mäanderförmigen Kanal vor, bei dem das Kühlwasser in einer Schlange die gesamte Kühlfläche überstreicht. Das zweite Konzept orientiert sich an einer Verteilerplatte mit einem größeren innenliegenden Hohlraum, in dem tropfenförmige Strömungsleitelemente die Strömungsführung und Verwirbelung übernehmen.
 */

=== Konstruktion in CAD
/* - Aufbau der Strömungskanäle
- Konstruktion der Outlets bzw. Inlets
- Anpassung für 3D-Druck-Verfahren
 */
Die Konstruktion des Kühlkörpers erfolgte in der #acro("CAD")-Software NX @nxsiemens. 

In den frühen Phasen der Entwicklung des Kühlkörpers werden vereinfachte Versionen der Kühlkörpergeometrien konstruiert, die nur das Strömungsverhalten modellieren mit den entsprechenden Randbedinungen wie die untere Platte, die auf dem #acro("TTP") aufliegen wird. Die exakte Geometrie der Ein- und Auslassstutzen und diverse Verrundungen der Kanten sind ein konstruktiver Aufwand, der im simulativen Entwicklungsprozess keinen signifikanten Einfluss auf die Aussagekräftigkeit der Simulation hat.

Die zentralen Konstruktionselemente sind die mäanderförmigen Strömungskanäle oder die tropfenförmigen Muster in der Platte, die Einlass- und Auslassstutzen sowie die Befestigungspunkte zur Anbindung an das Thor Modul. Die Anbringungspunkte sind so gewählt, dass sie exakt auf den vier Löchern, die durch das Thor Modul gehen, liegen. Das ermöglicht eine Anbringung auf den bereits eingebauten Anbringungspunkten, die auch im Carrier Board an diesen Stellen sind und für die Installation eines Kühlkörpers gedacht sind.

Für das Konzept mit den tropfenförmigen Strukturen werden, wie auch bereits in den Inverterplatten, "Verteilungsstreben" einkonstruiert, die das Wasser über die gesamte Breite des Kühlkörpers verteilen sollen. Diese sind notwendig, um die Kontaktfläche des fließenden Wassers auf die gesamte Fläche zu maximieren. Am Ein- und Ausgang wird ein Zulauf einkonstruiert, der dem Wasser ermöglichen soll, ebendiese Breite bis zum Ausgang zu erreichen. 

Das mäanderförmige Kanallayout wurde so gestaltet, dass das Kühlwasser die gesamte Grundfläche des Wärmeüberträgers möglichst gleichmäßig überstreicht und so wenig Kurven wie möglich eingebaut sind, weswegen die Stutzen schräg übereinander angeordnet sind. Die Stutzen wurden für einen Schlauchanschluss von $4 space.thin"mm"$ dimensioniert und sind denen des Batteriekühlkörpers nachempfunden. Sämtliche Wandstärken und Übergänge wurden auf die verfahrensspezifischen Anforderungen des #acro("SLM")-Prozesses in Kooperation mit dem Fertigungspartner abgestimmt, insbesondere hinsichtlich Mindestmaterialstärken und der Entpulverbarkeit der innenliegenden Kanäle nach dem Druckprozess. Die Entpulverbarkeit stellte keine Herausforderung dar, jedoch mussten alle Wandstärken auf mindestens $1 space.thin"mm"$ dimensioniert werden. Zusätzlich wurden alle Kanten mit einem Radius von $1 space.thin"mm"$ verrundet. Hierbei handelt es sich um Anforderungen des Fertigungspartners.

=== Auswertung durch CFD Simulation <cfd_cooler>
/* - mit dem Inverterplattenkonzept kein simulativ relevantes Ergebnis --> wird nicht weiter verfolgt, da Dimensionen zu eng um das Konzept gut implementieren zu können, Aufwand dieses Konzept weiter zu verfolgen zu groß  im Vergleich zu anderem Konzept
- kann auf jeden Fall die Wärme abführen, Strömung kann verbessert werden um Druckabfall zu minimieren
- strömungs und druck und temperaturwerte richten sich nach den Erkenntnissen von Batterie, was ja der Kreislauf ist in den der Bums reinsoll
- versuchen es nicht wie bro science aussehen zu lassen
- aufzeigen, dass eine spätere Version möglich ist aber im Moment nicht implementiert werden kann
- simulation in StarCCM+ mit 100 C auf gesamter Unterseite der Platte --> hier Argumentationskette einfügen warum das eine gute Idee ist, glaube die Idee war quasi zu schauen, wenn der Thor der drunter sitzt seine Maximaltemperatur erreicht wie viel Hitze dann abgeführt werden kann
- Wasser erhitzt sich um x grad und es wird y W Energie aufgenommen
 */
Zur vergleichenden Bewertung der beiden Kanalkonzepte wurde eine numerische Strömungssimulation mit der Software Simcenter STAR-CCM+ @starccm durchgeführt. Die methodischen Grundlagen der #acro("CFD")-Simulation sind in @intro_cfd beschrieben.

Die strömungsmechanischen Randbedingungen für die Simulation, insbesondere Volumenstrom und Systemdruck, orientieren sich an den Betriebsparametern des Batteriekühlkreislaufs, in den der Kühlkörper des #acro("DVPC") integriert ist.

Das Verteilerplattenkonzept erwies sich in der Simulation als nicht geeignet, um ein physikalisch belastbares Ergebnis zu liefern. Die innenliegenden Geometrien sind aufgrund der verfügbaren Bauhöhe zu eng dimensioniert, als dass das Konzept mit vertretbarem Konstruktionsaufwand so angepasst werden könnte, dass eine qualitativ hochwertige Simulation möglich wäre. In @shitplate kann der Schnitt aus der Simulation gesehen werden, welche kein realistisches Bild zeichnet. 

Das Konzept wurde daher nicht weiter verfolgt.
#figure(
    image("../../resources/img/shitplate.png", width: 60%, format: "png"),
    caption: [Strömungsschnitt aus der #acro("CFD")-Simulation des Verteilerplattenkonzepts ohne physikalisch belastbares Ergebnis]
)<shitplate>

Für das mäanderförmige Konzept wurde wie als bei dem Verteilerplattenkonzept als thermische Randbedingung eine Temperatur von $100 space.thin degree C$ auf der gesamten Unterseite der Kühlplatte definiert. Diese Randbedingung bildet den Worst-Case-Betrieb ab: Wenn der Jetson Thor seine maximale Gehäusetemperatur erreicht, ist zu prüfen, ob der Kühlkörper ausreichend Wärme abführen kann, um die Junction-Temperatur unterhalb des spezifizierten Grenzwertes zu halten. /* Der Zusammenhang zwischen Gehäusetemperatur und Junction-Temperatur wird dabei über die in den technischen Grundlagen eingeführte thermische Widerstandskette hergestellt. */

Die Simulation zeigt, dass der Kühlkörper in der Lage ist, die an der Unterseite anliegende Wärmeleistung zuverlässig an das Kühlwasser abzuführen. Das Kühlwasser nimmt dabei eine Leistung von rund $3000 space.thin W$ auf und erwärmt sich zwischen Einlass und Auslass um $5 space.thin K$. Nach der ersten Iteration ist offensichtlich anhand der simulativen Ergebnisse, dass der Kühlkörper in der Lage sein wird, die Hitze ausreichend abzuführen. Daraufhin wird die Kanalgeometrie weiter verbessert um den Druckabfall zu verringern. Der Bereich mit lokalem Druckabfall, wo das Wasser verwirbelt (in @stroemungsbildFinal dunkelblau), werden durch eine weitere Iteration entfernt und so angepasst, dass sie weniger präsent sind, was den Druckabfall über die Geometrie zu $0.63 space.thin"bar"$ verbessert. Die Hitzeaufnahme des Wassers nimmt zwar ab, ist aber trotzdem noch mehr als ausreichend um die Abwärme des Thor Moduls aunehmen zu können. Für die kommende Iteration sind weitere Verbesserungen des Strömungsverhaltens vorgesehen. In @stroemungsbildFinal kann beispielhaft die Kanalgeometrie der ersten Iteration gesehen werden.

#figure(
    image("../../resources/img/stroemungsbildFinal.png", width: 60%, format: "png"),
    caption: [Strömungsbild der ersten mäanderförmigen Kanalgeometrie aus der #acro("CFD")-Simulation in Simcenter STAR-CCM+]
)<stroemungsbildFinal>

Die simulierte Wärmeaufnahme entspricht einem Worst-Case-Szenario mit einer Bauteiloberfläche auf $100 space.thin degree C$ und liegt mit rund $3000 space.thin W$ deutlich oberhalb der im realen Betrieb zu erwartenden Verlustleistung des Thor Moduls von etwa $150 space.thin W$. Eine Übertragung dieses Lastfalls auf die in den technischen Grundlagen eingeführte Energiebilanz $dot(Q) = dot(m) · c_p · Delta T$ ergibt bei identischem Massenstrom von $0,1333 space.thin "kg/s"$ und einer spezifischen Wärmekapazität von $c_p approx 4182 space.thin "J/(kg" dot "K)"$ für Wasser einen Temperaturhub von lediglich $Delta T approx 0,27 space.thin K$ zwischen Ein- und Auslass @waermeuebertragung1. Dies entspricht etwa $5 space.thin %$ der im Worst-Case simulierten Wärmeaufnahme und bestätigt, dass der Kühlkörper im nominalen Betrieb deutliche thermische Reserven aufweist. 
=== Fertigung und Nachbearbeitung
/* - Aluminium 3D-Druck
- Nachbearbeitung durch Fräsen --> Platte zu dünn
 */
Die Fertigung des Kühlkörpers erfolgte im #acro("SLM")-Verfahren aus Aluminium durch den externen Fertigungspartner. Im Anschluss an den Druckprozess wurde die Dichtfläche auf der Oberseite des Bauteils zur Sicherstellung der Maßhaltigkeit nachgefräst. Dabei stellte sich heraus, dass die Wandstärke in diesem Bereich zu gering ausgelegt war: Die Fräsbearbeitung führte zu einer ungleichmäßigen Oberfläche, die für den ersten Test nicht weiter nachgearbeitet wurde. Zusätzlich stellt sich bei dem Fräsen der Platte heraus, dass die Geometrie so nicht gut in die Fräsmaschine eingespannt werden kann, was vor allem der vertikalen Geometrie der Stutzen geschuldet ist.
#figure(
    image("../../resources/img/bottomofplate.jpeg", width: 60%, format: "jpg"),
    caption: [Unterseite des #acro("SLM")-gedruckten Kühlkörpers nach der spanenden Nachbearbeitung der Kontaktfläche mit sichtbar ungleichmäßiger Oberfläche]
)<bottomofplate>

=== Test des Kühlkörpers
/* - Dichtigkeitstest
- Kühlleistungstest
- Platte zu dünn, Wird vorsichtig agefräst --> ungleiche Oberfläche, wird für den ersten Test nicht mehr geschliffen
- Zipties für Dichtung und Anbindung des Schlauchs --> Erfahrungswerte zeigen, dass es sich um eine sehr leichte und dichte Lösung handelt
- Kühlschläuche sind 6 mm dick, Eingänge am Kühlkörper sind aber für 4 mm designed --> müssen noch Adapter für den ersten Test verwendet werden
- für den Test wird Thermalpaste verwendet um sauberen Übergang sicherzustellen --> festes Anschrauben um Abstand zwischen Kühlkörper und Heatspreader zu gewährleisten
- thermische Leistung ist optimal in Prüfstand --> nicht perfekte Repräsentation aber definitiv gut genug um sagen zu können, dass es funktionieren wird im Auto
- Junction Temperatur im Thor bei 52 C was mehr als akzeptabel ist (ca 110 W Leistung auf dem Thor)
- Temperaturunterschied Eingang/Ausgang ca 1 C bei 21 C Wassertemperatur

- irgendwie Kurve schlagen zu thermischen Widerstand und Kette etc
 */
Der gefertigte Kühlkörper wurde in zwei aufeinanderfolgenden Tests auf Dichtigkeit und Kühlleistung geprüft.

Im Dichtigkeitstest wurde der Kühlkörper unter Betriebsdruck auf Leckagefreiheit geprüft. Die Schlauchanbindung erfolgte mit Kabelbindern, die sich in der Praxis als leichte und zuverlässige Dichtelemente für die verwendeten Gummi-Kühlschläuche bewährt haben. Da die im Kreislauf verbauten Kühlschläuche einen Durchmesser von $6 space.thin"mm"$ aufweisen, die Stutzen des Kühlkörpers jedoch für $4 space.thin"mm"$ ausgelegt sind, wurden für diesen Test Adapter eingesetzt. In der kommenden Iteration wird die Größe der Stutzen entsprechend angepasst, damit diese Adapterstücke nicht mehr nötig sind.

Für den Kühlleistungstest wurde der Kühlkörper mit Wärmeleitpaste auf dem Heatspreader des Jetson Thor montiert und fest verschraubt, um einen definierten thermischen Kontakt sicherzustellen. Es wird der Hydraulikprüfstand des eDrive-Teams verwendet, welcher Durchflusssensoren, eine Pumpe, ein Reservoir und Auswerteelektronik bereits besitzt. Es werden für den Prüfstand entworfene Skripte verwendet, um die Daten aufzuzeichnen. Außerdem werden Temperatursensoren verwendet. Hierbei handelt es sich um #acro("NTC")-Widerstände, die in Adapterstücken eingeklebt sind und somit vollständig im Wasser eingetaucht sind. Der Prüfstand wurde im Rahmen einer vergangenen Studienarbeit von Makus und Maisch in @edrivecooling entwickelt und die Dokumentation des Prüfstandes ist unter @hydraulicpruefstand zu finden.

Obwohl der Prüfstand nicht die vollständige Einbausituation im Fahrzeug abbildet, ist er hinreichend repräsentativ, um die Funktionsfähigkeit des Kühlkonzepts zu validieren.

Die Messung ergab eine Junction-Temperatur von $52 space.thin degree C$ bei einer Verlustleistung von ca. $110 space.thin"W"$. Dieser Wert liegt deutlich unterhalb der spezifizierten Maximaltemperatur des Jetson Thor und belegt, dass der Kühlkörper für den geplanten Betrieb ausreichend dimensioniert ist. Die Temperaturdifferenz zwischen Kühlwassereintritt und -austritt betrug ca. $1 space.thin K$ bei einer Einlauftemperatur von $23 space.thin degree C$. Somit ist die Funktionstüchtigkeit des Kühlkörpers bestätigt.

Das Gewicht des Kühlkörpers beträgt $90 space.thin g$

=== Verbesserungsmaßnahmen für die Folgeiteration <zweiteiteration>
/* - Platte untendrunter dicker machen um fräsen zu vereinfachen
- Inletgröße anpassen --> zu klein
- drop an der einen Stelle verbessern ist glaube ich noch zu dünn
- Einschraubpunkte nach oben ziehen damit Schraubenkopf/Unterlegscheibe sauber aufsitzen kann
- CFD Bilder hier einfügen und dann ein bisschen beschreiben was für die nächste Iteration geändert wurde
 */
Aus den Erkenntnissen der Fertigung, des Tests sowie der #acro("CFD")-Simulation wurden Verbesserungsmaßnahmen für die nächste Iteration des Kühlkörpers abgeleitet. Die Wandstärke im Bereich der zu fräsenden Dichtfläche wird erhöht, um eine reproduzierbare, plane Oberfläche nach der spanenden Nachbearbeitung zu gewährleisten. Die Einlass- und Auslassstutzen werden auf einen Nenndurchmesser von $6 space.thin"mm"$ angepasst, um die Verwendung von Adaptern zu vermeiden und den Strömungswiderstand an den Übergängen zu reduzieren. Darüber hinaus ist eine konstruktiv eng ausgelegte Stelle im Kanalverlauf zu überarbeiten, da der dortige lokale Druckabfall die Gesamtperformance beeinträchtigt. Schließlich sind die Befestigungspunkte für die Montageschrauben konstruktiv weiter aus der Plattenebene herauszuführen, sodass Schraubenkopf und Unterlegscheibe sauber und reproduzierbar aufliegen. Zusätzlich wird die gesamte Kanalgeometrie auf eine Ebene gebracht, was die Handhabung insgesamt und das Einspannen im Nachbearbeitungsprozess auf der Fräsmaschine verbessern soll. 

Zum Zeitpunkt des Verfassens wurden erste #acro("CFD")-Simulationen mit begrenztem Erfolg durchgeführt.