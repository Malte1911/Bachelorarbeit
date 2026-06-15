#import "../../config/acronyms.typ": *
#include "../../config/config.typ"

== Technische Grundlagen
=== Funktionsweise schaltende Gleichspannungswandler
Gleichspannungswandler, auch Gleichstromsteller oder DCDC-Wandler finden sich in vielen elektrischen Systemen und sind ein zentraler Bestandteil vieler Anwendungen wie zum Beispiel in Kommunikationssystemen, Luftfahrt, Haushaltsanwendung und viele weitere Gebiete @zhang_power_2018, @schroeder2019leistungselektronische. Die Varianten der DCDC-Wandler lassen sich auf drei zugrundeliegende Architekturen reduzieren: Buck-, Boost- und Buck-Boost-Wandler. Bei dem Buck-Wandler handelt es sich um eine Schaltung, die eine hohe Eingangsspannung auf eine niedrigere Ausgangsspannung wandelt. Im Gegensatz dazu steht der Boost-Wandler, welcher eine niedrigere Eingangsspannung in eine höhere Ausgangsspannung wandelt. Die Kombination dieser beiden Schaltungen ergibt den Buck-Boost-Wandler, der in der Lage ist, eine Eingangsspannung sowohl hoch- als auch herunterzuwandeln @schroeder2019leistungselektronische, @mohan1995power.  

Da für die Anwendung im Rahmen dieser Arbeit $U_("in") >> U_("out")$ gilt, wird der Funktionsmechanismus eines Buck-Wandlers beschrieben. // Die grundlegenden Konzepte lassen sich jedoch auch auf Boost-Wandler anwenden. 

Der zentrale Funktionsmechanismus der DCDC-Wandler liegt in der Fähigkeit, Energie zu speichern und diese dann kontrolliert wieder abzugeben um die Spannung zu regulieren. Diese Energiespeicherung wird benötigt, da bei einem schaltenden DCDC-Wandler die Eingangsspannung nicht kontinuierlich anliegt und somit eine nicht gleichbleibende Ausgangsspannung geschaltet wird. In @r_converter kann eine Schaltung ohne diese energiespeichernde Komponenten gesehen werden, wobei $V_d$ die Eingangsspannung und $V_0$ die Ausgangsspannung ist. Eine Schaltperiode wird als $T_s = t_("on") + t_("off")$ definiert. Die Eingangsspannung wird in dem Zeitraum $t_("on")$ auf die Ausgangsspannung geschaltet, somit gilt für diesen Bereich $nu_0 = V_d$. Für den Zeitraum $t_("off")$ gilt $nu_0 = 0 space.thin V$. Die durchschnittliche Spannung von $V_0$ hängt somit von $t_("on")$ und $t_("off")$ ab @mohan1995power.

Aus diesen Zusammenhängen lässt sich @formulaaveragedcdc herleiten, die das Verhältnis der durchschnittlichen Ausgangsspannung und der Einschaltzeit des Schalters beschreibt.
$
    V_0 = "avg"(nu_0) = (t_("on")/T_s)*nu_0
$ <formulaaveragedcdc>

#figure(
    image("../../resources/img/r_dcdc.png", width: 60%, format: "png"),
    caption: [Schaltbild und Graph zur Ausgangsspannung bei einem DCDC-Wandler ohne Energiespeicher @mohan1995power] 
)<r_converter>

Obwohl diese Methode eine gewünschte durchschnittliche Spannung herunterwandeln kann, ist in Anwendungen wie zum Beispiel im Rahmen dieser Arbeit eine kontinuierliche Spannung und ein kontinuierlicher Strom vonnöten. Hierfür werden die bereits genannten Energiespeichermethoden benötigt.  

Bei einem Buck-Wandler, wie in @buck_converter zu sehen ist, wird eine Induktivität in Kombination mit einem Kondensator verwendet. Diese bilden in der gegebenen Konfiguration einen Tiefpassfilter. Durch die hohen Schaltfrequenzen kann mit solch einem Filter die Ausgangsspannung stabilisiert werden. Im geschalteten Zustand wird die Diode in Sperrrichtung betrieben, weswegen der Strom über die Spule in die Last fließt. Wird nun die Spannungsversorgung abgeschaltet, fließt der Spulenstrom weiterhin durch die Last und die Diode um die Last mit Energie zu versorgen @mohan1995power. 
#figure(
    image("../../resources/img/buck_dcdc.png", width: 60%, format: "png"),
    caption: [Schaltbild eines Buck-Wandlers @mohan1995power] 
)<buck_converter>

=== Computational Fluid Dynamics <intro_cfd>

#acro("CFD"), auf Deutsch Numerische Strömungsmechanik, bezeichnet die computergestützte Simulation von Strömungsvorgängen und den damit verbundenen Wärme- und Stofftransportprozessen. #acro("CFD") hat sich als unverzichtbares Analysewerkzeug in zahlreichen Ingenieurdisziplinen etabliert, darunter Fahrzeugtechnik, Luft- und Raumfahrt sowie Verfahrenstechnik @schwarze_cfd_modellierung_2013, @laurien2018numerische.

Der grundlegende Ansatz der #acro("CFD") besteht darin, ein kontinuierliches strömungsmechanisches Problem in ein diskretes numerisches Problem zu überführen. Hierzu wird das zu untersuchende Strömungsgebiet in ein sogenanntes Rechengitter (engl. mesh) unterteilt, das aus einer endlichen Anzahl kleiner Kontrollvolumina besteht. Für jedes dieser Volumina werden die physikalischen Erhaltungsgleichungen, also primär die Erhaltung von Masse, Impuls und Energie, in algebraischer Form aufgestellt und iterativ gelöst @schwarze_cfd_modellierung_2013, @greenshieldsweller2022. Die mathematische Grundlage bilden dabei die Navier-Stokes-Gleichungen, welche die Bewegung viskoser Fluide vollständig beschreiben.

Für die praktische Anwendung im Rahmen dieser Arbeit ist vor allem die Wärmeübertragung durch erzwungene Konvektion in einem Flüssigkeitskühlkreislauf relevant. #acro("CFD") ermöglicht es, die Strömung des Kühlmediums, in diesem Fall Wasser, durch die internen Kanäle eines Kühlkörpers zu simulieren und dabei Größen wie Temperaturverteilung, Druckabfall und Wärmestrom quantitativ zu erfassen. Dabei wird sowohl die Wärmeaufnahme des Fluids als auch die Temperaturverteilung in der Kühlkörperstruktur selbst berechnet. Auf diese Weise können verschiedene Kanalgeometrien ohne aufwendige physische Prototypen bewertet und hinsichtlich ihrer Kühlleistung sowie ihres Druckverlusts optimiert werden.

Die Güte einer #acro("CFD")-Simulation hängt maßgeblich von der Qualität der Vernetzung, der Wahl geeigneter Randbedingungen sowie der Auswahl eines passenden Turbulenzmodells ab. Da reale Strömungen in technischen Anwendungen häufig turbulent sind, werden vereinfachende Modellierungsansätze wie das weit verbreitete 
k-ε- oder k-ω-Modell eingesetzt, die den erhöhten Impuls- und Wärmetransport durch Turbulenzen approximieren @laurien2018numerische, @greenshieldsweller2022.

// Im Rahmen dieser Arbeit wird #acro("CFD") als Bewertungswerkzeug für die entwickelten Kühlkörpergeometrien eingesetzt (siehe @cfd_cooler). Es wird ausdrücklich darauf hingewiesen, dass an dieser Stelle nur die für das Verständnis der Simulation notwendigen Grundlagen dargestellt werden. Für eine vertiefte Behandlung der numerischen Methoden und der zugrundeliegenden Strömungsmechanik ist auf die Fachliteratur zu verweisen @schwarze_cfd_modellierung_2013, @laurien2018numerische, @greenshieldsweller2022.

=== Selektives Laserstrahlschmelzen <slm_basics>
Selektives Laserschmelzen (SLM) ist ein additives Fertigungsverfahren, das einen hochintensiven Laser verwendet, um metallische Pulvermaterialien selektiv aufzuschmelzen und zu verschmelzen. Der Aufbauprozess erfolgt schichtweise anhand von CAD-Daten, wobei eine dünne Pulverschicht auf einer Bauplattform aufgetragen, der Laser die gewünschten Bereiche aufschmilzt und die Plattform anschließend abgesenkt wird, bevor die nächste Schicht aufgetragen wird @slmgoat.

Zu den zentralen Prozessparametern zählen Laserleistung, Scangeschwindigkeit, Spurabstand und Schichtdicke. Diese Parameter bestimmen gemeinsam die volumetrische Energiedichte, die dem Pulver zur Verfügung steht. Eine zu geringe Energiedichte führt zu unvollständigem Aufschmelzen und erhöhter Porosität, während eine zu hohe Energiedichte Materialverdampfung und den sogenannten Keyhole-Effekt verursachen kann @slmgoat.

Ein wesentlicher Vorteil des SLM-Verfahrens gegenüber dem verwandten Selektiven Lasersintern (SLS) liegt darin, dass keine Bindermaterialien benötigt werden und eine nahezu vollständige Aufschmelzung des Pulvers erreicht werden kann, was zu Bauteilen mit sehr hoher Relativdichte, teilweise bis zu 99,9 %, führt. Dadurch entfallen aufwendige Nachbearbeitungsschritte wie Wärmebehandlung oder Materialinfiltration, die beim SLS typischerweise erforderlich sind @slmgoat.

//Bei Bedarf hier kürzen

=== Einführung in Thermofluiddynamik

Die Thermofluiddynamik verbindet die Strömungsmechanik mit der Wärmeübertragung und bildet damit die theoretische Grundlage für die Auslegung flüssigkeitsgekühlter Kühlkörper. Da in dieser Arbeit ein Kühlkörper entwickelt wird, der die Verlustwärme einer Recheneinheit an einen Wasserkreislauf überträgt, sind sowohl die Wärmetransportvorgänge im Festkörper und zwischen Festkörper und Fluid als auch die strömungsmechanischen Eigenschaften des Kühlkreislaufs relevant @waermeuebertragung1, @waermeuebertragung2. 
//Die folgenden Abschnitte führen kompakt die für die Auslegung benötigten Grundbegriffe ein. Eine vertiefte Darstellung findet sich in den Standardwerken von Baehr und Stephan [19] sowie Polifke und Kopitz [20].

==== Thermoelektrische Analogie 
Für die stationäre Wärmeleitung existiert eine formale Analogie zum Ohmschen Gesetz der Elektrotechnik. Der Wärmestrom $dot(Q)$ übernimmt dabei die Rolle des elektrischen Stroms, die Temperaturdifferenz $Delta T$ die Rolle der Spannung und der thermische Widerstand $R_("th")$ die Rolle des Ohmschen Widerstands @waermeuebertragung1, @waermeuebertragung3. Analog zum Ohmschen Gesetz gilt:
$
dot(Q) = frac(Delta T, R_(t h))
$
Diese Betrachtungsweise erlaubt es, komplexe Wärmepfade in ein thermisches Ersatzschaltbild zu überführen, in dem sich in Serie geschaltete Widerstände, beispielsweise zwischen Halbleiterchip (Junction), Bauteilgehäuse (Case), Wärmeleitmittel und Kühlkörper, addieren lassen @waermeuebertragung2, @waermeuebertragung3. Für die Auslegung der Kühlung einer Recheneinheit ist diese Analogie von zentraler Bedeutung, da die kritische Kenngröße, die maximal zulässige Junction-Temperatur, über eine Kette thermischer Widerstände mit der Fluidtemperatur im Kühlkreislauf verknüpft ist.

==== Thermofluiddynamik in Kühlkreisläufen
Ein geschlossener Flüssigkeitskühlkreislauf besteht im Wesentlichen aus einem Kühlkörper an der Wärmequelle, einem Wärmeübertrager (Radiator) zur Abgabe der Wärme an die Umgebung sowie einer Pumpe, die das Wärmeträgermedium, im vorliegenden Fall Wasser, umwälzt. Die am Kühlkörper aufgenommene Wärmeleistung folgt aus der Energiebilanz des Fluids
$
dot(Q) = dot(m) · c_p · Delta T_"Fluid"
$
mit dem Massenstrom $dot(m)$, der spezifischen Wärmekapazität $c_p$ und der Temperaturdifferenz zwischen Ein- und Austritt des Fluids @waermeuebertragung1, @waermeuebertragung2. Neben der thermischen Leistung stellt der Druckverlust $Delta P$ über den Kühlkörper eine zentrale Auslegungsgröße dar, da die im Kreislauf verbaute Pumpe diesen überwinden muss, um den für die angestrebte Kühlleistung erforderlichen Volumenstrom aufrechtzuerhalten @waermeuebertragung2. Zwischen Wärmeübergang und Druckverlust besteht ein inhärenter Zielkonflikt: Eine erhöhte Strömungsgeschwindigkeit oder turbulenzfördernde Geometrien verbessern den konvektiven Wärmeübergang, führen jedoch zu einem überproportional steigenden Druckverlust @waermeuebertragung1, @waermeuebertragung2. Die in @intro_cfd beschriebene CFD-Simulation ist daher das geeignete Werkzeug, um beide Größen gleichzeitig zu bewerten und ein Optimum zu finden.


//==== Mechanismen der Wärmeübertragung

// https://gemini.google.com/app/73e93d511421d04e


// === Rechenarchitekturen
// - ganz kurz Unterschied zwischen x86 und ARM beschreiben und klarmachen dass die Entscheidung nicht in diesem Arbeitspaket liegt (maybe auch schon bei DVPC?) es aber trotzdem interessant zur Einordnung ist der verschiedenen Konzepte
=== Grundlagen Faserverbundstoffe
Faserverbundwerkstoffe bestehen aus zwei Hauptkomponenten: einer Faserstruktur, die als Verstärkung dient, und einer Matrix, die die Fasern einbettet und Lasten zwischen ihnen überträgt. Die mechanischen Eigenschaften des Verbundes werden dabei maßgeblich durch die Faserorientierung, den Faservolumenanteil sowie die Wahl des Fasermaterials bestimmt @konstruierenFaserverbundwerkstoffe. Im Rahmen dieser Arbeit sind vor allem zwei Fasertypen relevant: Kohlenstofffasern (Carbon) und Aramidfasern (bekannt unter dem Handelsnamen Kevlar)

Kohlenstofffasern weisen eine sehr hohe spezifische Steifigkeit und Festigkeit bei geringer Dichte auf, was sie zu einem bevorzugten Material im strukturellen Leichtbau macht @konstruierenFaserverbundwerkstoffe. Aramidfasern erreichen im Vergleich eine geringere Druckfestigkeit, übertreffen Kohlenstofffasern jedoch deutlich in ihrer Schlagzähigkeit und Energieabsorption unter Stoßbelastung @engineeringcompositesharris.

Um bei minimalem Gewicht eine hohe Biegesteifigkeit zu erzielen, werden in Faserverbundstrukturen häufig Sandwichbauweisen mit Kernmaterialien eingesetzt. Das Wirkprinzip entspricht dabei dem eines Doppel-T-Trägers: Die beiden Decklagen aus Faserverbundwerkstoff nehmen die Biegezug- und Biegedruckspannungen auf, während ein leichter Kern den Abstand zwischen den Decklagen sicherstellt und auftretende Schubkräfte überträgt. Da die Biegesteifigkeit quadratisch mit dem Abstand der Decklagen vom Neutralpunkt ansteigt, lässt sich bereits durch einen vergleichsweise dünnen Kern eine erhebliche Steifigkeitssteigerung bei nur geringem Gewichtszuwachs erzielen @konstruierenFaserverbundwerkstoffe, @compositeslab. Als Kernmaterial werden unter anderem Wabenstrukturen aus Aramidpapier, Hartschaumstoffe sowie Balsaholz eingesetzt. Aramid-Waben bieten dabei ein besonders vorteilhaftes Verhältnis aus Steifigkeit und Gewicht und lassen sich gut zuschneiden und an bauteilspezifische Geometrien anpassen @faserverbundbauweisen, @compositeslab.

Für die Fertigung der in dieser Arbeit verwendeten Bauteile sind zwei Verfahren relevant. Beim Handlaminieren wird trockenes Faserhalbzeug in ein Werkzeug eingelegt und manuell mit einem flüssigen Harzsystem getränkt. Das Verfahren zeichnet sich durch niedrige Werkzeugkosten und eine hohe Flexibilität aus, birgt jedoch das Risiko eines inhomogenen Harzgehalts und einer eingeschränkten Reproduzierbarkeit @compositeslab. Zur Verbesserung der Laminatqualität wird ergänzend ein Vakuumsack eingesetzt, der durch Unterdruck überschüssiges Harz entfernt, eingeschlossene Luft aus dem Laminat treibt und die Fasern stärker komprimiert. Beim Prepreg-Verfahren sind die Faserhalbzeuge bereits werksseitig mit einem definierten Harzgehalt imprägniert. Zur vollständigen Aushärtung wird in der Regel sowohl Temperatur als auch Druck benötigt, weshalb Prepregs typischerweise im Autoklaven verarbeitet werden. Dieses Verfahren ermöglicht sehr hohe Faservolumenanteile und eine exzellente Reproduzierbarkeit der mechanischen Eigenschaften, ist jedoch mit deutlich höherem Aufwand und höheren Kosten verbunden @compositeslab.

=== Printed Circuit Boards
Eine Leiterplatte, englisch #acro("PCB"), ist ein mechanischer Träger und gleichzeitig das elektrische Verbindungsmedium für elektronische Bauelemente. Der grundlegende Aufbau eines PCBs besteht aus einem dielektrischen Substrat, auf das leitfähige Kupferschichten aufgebracht werden, welche die elektrischen Verbindungen zwischen den Bauelementen herstellen. Als Substratmaterial hat sich in der Industrie FR4, ein glasfaserverstärktes Epoxidharz, als Standard etabliert, da es eine hohe mechanische Festigkeit bei gleichzeitig guten dielektrischen Eigenschaften aufweist @pcbhandbook.
 
Mehrlagige #acro("PCB")s, sogenannte Multilayer-Boards, bestehen aus mehreren abwechselnden Lagen aus Kupfer und Substrat, die unter Druck und Wärme zu einem monolithischen Bauteil verpresst werden. Verbindungen zwischen den einzelnen Lagen werden durch metallisierte Bohrungen, sogenannte Vias, hergestellt @pcbhandbook. Für Anwendungen mit erhöhten Anforderungen an die #acro("EMV") empfiehlt sich die Verwendung dedizierter Masseflächen und Versorgungslagen im Lagenaufbau, da diese die Impedanz der Versorgungsleitungen reduzieren und als Rückleiterebene für Signalströme dienen @emcengineering, @emcBoard.

Für die Auslegung von Leistungspfaden auf PCBs ist die Stromtragfähigkeit der Kupferleiterbahnen eine zentrale Entwurfsgröße. Diese ist von der Leiterbahnbreite, der Kupferdicke, ausgedrückt in der Einheit Unze pro Quadratfuß (oz/ft²), sowie der zulässigen Temperaturerhöhung abhängig. Die entsprechenden Auslegungsregeln sind in der Norm IPC-2221 standardisiert @ipc2221b. Da im Rahmen dieser Arbeit eine Platine entwickelt wird, die einen DCDC-Wandler mit einer Ausgangsleistung im Bereich mehrerer hundert Watt trägt, ist die korrekte Dimensionierung der Leistungspfade für einen zuverlässigen Betrieb unerlässlich.

=== Nvidia Jetson Plattform

Die Nvidia Jetson Plattform ist eine Familie eingebetteter Rechenmodule, die für die energieeffiziente Verarbeitung von Aufgaben der künstlichen Intelligenz unter den Ressourcenbeschränkungen eingebetteter Systeme konzipiert sind. Die Plattform richtet sich primär an Anwendungen in der Robotik und im Bereich autonomer Fahrzeuge, die eine leistungsstarke KI-Inferenz unter strikten Energie- und Platzbeschränkungen erfordern @jetsondocumentation.

Das grundlegende Designkonzept der Jetson Plattform basiert auf der Trennung des Rechenmoduls von der anwendungsspezifischen Peripherie. Ein Jetson-Modul ist ein kompaktes System-on-Module, das #acro("CPU"), #acro("GPU"), Arbeitsspeicher sowie weitere Prozessorkerne auf einem einzelnen Träger vereint. Über einen standardisierten Steckverbinder wird das Modul auf einem sogenannten Carrierboard montiert, die die anwendungsspezifischen Schnittstellen wie Kameraverbindungen, Ethernet, USB sowie weitere Peripherie bereitstellt. Dieses Konzept ermöglicht es, dasselbe Rechenmodul in unterschiedlichen Trägersystemen einzusetzen und so den Entwicklungsaufwand für verschiedene Endprodukte zu reduzieren @jetsondocumentation.

Für die Wärmeabführung sind manche Jetson-Module mit einer integrierten #acro("TTP") ausgestattet. Diese Metallplatte auf der Oberseite des Moduls bildet die thermische Schnittstelle zwischen dem Prozessor und einer externen Kühlstruktur, ohne dass das Modul selbst einen Lüfter oder Kühlkörper erfordert. Die anfallende Verlustleistung wird somit an ein extern angebrachtes Kühlsystem übergeben, was die Integration des Moduls in maßgeschneiderte Gehäuse und Kühlkonzepte erheblich vereinfacht @jetsondocumentation.
