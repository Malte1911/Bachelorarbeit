#import "../../config/acronyms.typ": *
#include "../../config/config.typ"

== Entwicklung des Gehäuses <casingdev>
=== Materialauswahl
/* - Aramid weil kein Kapton benötigt wird und es in der Fertigung flexibler ist als Alubiegeteil --> nicht abhängig von Fertigungspartner, kann alles auf der Fräse vom Verein gemacht werden
- Gewichtsanalyse hier einfügen --> Aramid am leichtesten da kein Kapton innen zur Abdeckung benötigt wird
- ich habe Erfahrung damit
- eigene Fräse ermöglicht schnelles Prototyping und Fertigung
 */
Für die Ausführung des Casings werden zwei grundsätzlich geeignete Bauweisen gegenübergestellt: ein Alubiegeteil analog zu etablierten Gehäuselösungen im Verein sowie ein Faserverbundlaminat aus Aramid. Das Alubiegeteil würde über einen externen Fertigungspartner beschafft werden müssen, wodurch sich eine Abhängigkeit von dessen Kapazitäten und Durchlaufzeiten ergibt. Das Aramidlaminat kann demgegenüber vollständig mit den Ressourcen des Vereins, insbesondere der vereinseigenen #acro("CNC")-Fräse und dem vorhandenen Laminierequipment, hergestellt werden, was sowohl die Fertigungsflexibilität erhöht als auch kurze Iterationszyklen für ein Prototyping ermöglicht.

Die Perspektive der Abschirmung spricht zusätzlich für Aramid, dass im Gegensatz zu einem metallischen oder einem aus Carbon gefertigten Gehäuse keine elektrisch isolierende Innenauskleidung, wie etwa eine Kaptonfolie @kapton, zur Vermeidung von Kurzschlüssen zwischen Platinen und Gehäuse benötigt. Dadurch entfällt nicht nur ein zusätzlicher Arbeitsschritt in der Fertigung, sondern auch eine entsprechende Masse, was das Aramidlaminat in einer vergleichenden Gewichtsbetrachtung als leichteste Variante ausweist.

Aus der Oberfläche des Casings lassen sich vorläufige Gewichtswerte für die verschiedenen zur Verfügung stehenden Materialien berechnen. Bei einer Oberfläche von $0.147 space.thin m^2$ beträgt das Gewicht bei einer Annahme von einem $0.3 space.thin"mm"$ dicken Alublech bei etwa $118 space.thin g$ unter der Annahme, dass das verwendete Aluminium $2.7 space.thin g/"cm"^3$ @aludichte wiegt. Bei Carbon wäre mit einem zweilagigen Lagenaufbau von insgesamt $400 space.thin g/m^2$ @carbongewicht mit etwa $200 space.thin g/m^2$ @compositeslab an Harz von einem Gesamtgewicht von  $88 space.thin g$ auszugehen. Eine zusätzliche Lage an Kaptontape @kapton wird zur Abdeckung benötigt um Kurzschlüsse zu verhindern. Bei einer Dicke von $50 space.thin mu m$ läge das zusätzliche Gewicht dieser beiden Optionen bei etwa $10 space.thin g$. Bei Aramid wird eine solche Extralage nicht benötigt, wodurch ein Gesamtgewicht bei $76 space.thin g$ möglich wäre, mit zwei Lagen Aramid von insgesamt $340 space.thin g/m^2$ @aramidgewicht und etwa $170 space.thin g/m^2$ @compositeslab an Harz. 

Ergänzend fließen Erfahrungswerte aus vorangegangener Arbeit im Verein und der im Composite Lab des Vereins @compositeslab erlangten Erkenntnisse in die Entscheidung ein. Die notwendigen Fertigungsschritte sind etabliert und durch den Autor mehrfach praktisch erprobt, wodurch das Risiko technischer Rückschläge im Fertigungsprozess gering eingeschätzt wird. In Summe wird daher Aramid als Werkstoff für das Casing festgelegt.

=== Erste Konstruktion in CAD
/* - erste Iteration in CAD zeigen (Bild)
- Höhe muss etwas angepasst werden aufgrund von Höhe der Kondensatoren und des Kühlkörpers auf DCDC Board angepasst werden
- Top Plate wird entfernt für bessere Kühlung und geringeres Gewicht --> Schutz vor Spritzwasser zwar nicht mehr sichergestellt aber juckt eigentlich nicht weil das ultra hoch im Auto ist und da nicht wirklich irgendwo Wasser reinkommen kann
- seitlich müssen dann Cutouts reingemacht werden für die verschiedenen Konnektoren
--> das kann nach dem laminieren passieren und muss dann noch gemacht werden
 */
Die Konstruktion des Casings erfolgt in der #acro("CAD")-Software Siemens NX @nxsiemens. Eine erste Iteration der Geometrie ist in @casingcadfirst dargestellt. Hier wird bereits ein Flansch seitlich an das Gehäuse ankonstruiert, um den Fall nach dem Laminieren abzubilden. Der Flansch auf der anderen Seite fehlt noch, wird aber in kommenden Iterationen hinzugefügt.

#figure(
    image("../../resources/img/casingcadfirst.png", width: 60%, format: "png"),
    caption: [Erste Iteration der Casing-Geometrie in Siemens NX]
)<casingcadfirst>

Im Laufe der Konstruktion wird die Bauhöhe des Casings gegenüber der ersten Iteration angepasst, um die Höhe der Kondensatoren nach ihrer Vergrößerung (siehe @electronics) sowie des auf der DCDC-Platine aufgebrachten Kühlkörpers bauraumseitig zu berücksichtigen. Auf eine obenliegende Deckplatte wird bewusst verzichtet. Einerseits verbessert der entstehende Luftraum die konvektive Abfuhr der Abwärme der innenliegenden Komponenten, andererseits reduziert sich durch den Entfall der Deckplatte das Gesamtgewicht des Bauteils. Der damit verbundene Wegfall eines direkten Schutzes gegen Spritzwasser ist für die angestrebte Einbauposition im Fahrzeug vertretbar, da das Casing vergleichsweise hoch im Fahrzeug montiert wird und an dieser Position kein relevanter Wassereintrag zu erwarten ist. 

Aussparungen für die Konnektoren und Ports am #acro("DVPC") werden in der #acro("CAD")-Konstruktion lediglich in ihrer Position vorgehalten, jedoch nicht als fertigungsfertige Cutouts ausgeführt. Diese werden in einem späteren Arbeitsschritt nach dem Laminieren manuell in das Laminat eingebracht, da eine Integration in die Toolinggeometrie nur mit unverhältnismäßig hohem Aufwand umsetzbar wäre.

=== Entwicklung der Toolings
/* - alles an hier verwendeten Skills und Wissen kommen zu großen Teilen aus dem Composite Lab und vielen Erfahrungswerten
 */
Die im Folgenden beschriebenen Arbeitsschritte zur Entwicklung und Fertigung des Toolings basieren zu großen Teilen auf den Inhalten des Composite Labs @compositeslab, auf Erfahrungswerten aus vorangegangenen Projekten im Verein und der entsprechenden Literatur, siehe Mennig und Stoeckhert @moldmaking für das Formdesign generell und Lengsfeld et. al. @prepregverarbeitung für den restlichen Fertigungsprozess.

==== Auswahl des Toolingmaterials
/* - alter Toolingblock wird verwendet --> kein frisches Material weil das wäre Verschwendung, außerdem wurde kein blaues Ureol gekauft weil man die PU-Schaum Blöcke verwendet hat
- PU-Schaum Blöcke wären zwar vorhanden sind aber nicht gut fräsbar bei uns da sehr hart --> schlechte Erfahrungen gemacht mit Monotooling deswegen wird auf Restbestände an Ureol gesetzt
- Ureol ist mehr als genug vorhanden und auch temperaturbeständig genug um mit Prepreg gefertigt zu werden
 */
Für die Toolingfertigung wird auf vorhandene Restbestände an Epoxidharzblöcke zurückgegriffen. Die Verwendung eines bereits in früheren Projekten eingesetzten Toolingblocks ist zum einen ressourcenschonend und vermeidet unnötige Materialbeschaffung. Zum anderen wurden in der aktuellen Saison keine frischen Epoxidharzblöcke mit der entsprechenden Temperaturbeständigkeit beschafft, da der Verein für andere Toolingaufgaben auf Polyurethanblöcke umgestellt hat.

Diese Polyurethanblöcke liegen zwar in ausreichender Menge vor, haben sich im Rahmen der Fertigung des Monocoque-Toolings jedoch als nur eingeschränkt fräsbar erwiesen, da das Material auf der vereinseigenen Fräse ein ungünstiges Zerspanungsverhalten zeigt. Aufgrund dieser Erfahrungswerte wird für das Casing-Tooling auf die verbleibenden Epoxidharzblöcke zurückgegriffen. Das Material ist in ausreichender Menge vorhanden und besitzt eine für die Verarbeitung mit Prepreg hinreichende Temperaturbeständigkeit.

==== Design in CAD
/* - alles in Siemens NX
- Außenseite des Casings wird extrahiert als Fläche
- Seiten werden verlängert
- Blockgröße wird gemessen und eingepflegt, trim auf die Fläche
- negativ der Form da kein Kern geplant im Laminat, außerdem müssen keine Anwinklungen gemacht werden da das Laminat nach innen flext um entformt werden zu können
 */
Die Konstruktion des Toolings erfolgt ebenfalls in Siemens NX @nxsiemens. Ausgehend von der finalen Casing-Geometrie wird die Außenseite des Bauteils als Fläche extrahiert und an den Seiten nach oben verlängert, um eine ausreichende Überhöhung des Toolings für den späteren Laminierprozess sicherzustellen. Die tatsächlichen Abmessungen des verfügbaren Epxidharzblocks werden vermessen und in das Modell überführt. Anschließend wird der Block auf die extrahierte Fläche getrimmt, wodurch sich die finale Toolinggeometrie ergibt. In @erstestooling kann der Block in Siemens NX gesehen werden.

#figure(
    image("../../resources/img/erstestooling.png", width: 60%, format: "png"),
    caption: [Auf den Epoxidharzblock getrimmte Negativtooling-Geometrie des Prototyp-Casings in Siemens NX]
)<erstestooling>

Da für den Prototyp keine Sandwichbauweise mit Kern im Laminataufbau vorgesehen ist, wird das Tooling als Negativform ausgeführt. Auf eine Entformungsschräge wird dabei bewusst verzichtet: Das vergleichsweise dünne Aramidlaminat besitzt ausreichend Eigenflexibilität, um beim Entformen nach innen elastisch zu verformen und sich auf diese Weise zerstörungsfrei aus der Form lösen zu lassen.

=== Fertigung eines Prototyps

==== Planung des Fräsprogrammes
/* - Autodesk Fusion 360 wird verwendet --> Standardprogramm zum Programmieren im Verein, ich habe außerdem bereits eine gute Menge an Erfahrung
- spezieller Fräser für Blockmaterial wird verwendet (name placeholder bitte)
- Anpassung der Innenradien um Fräsprozess zu Beschleunigen und zu vereinfachen --> Gegencheck im CAD, keine Kollisionen konnten erkannt werden
- Schruppprogramm mit Blockbuster (spezialfräser)
- Schlichtprogramm nicht wirklich notwendig, Untere Innenradien werden auch mit Blockbuster gefräst
- konische Helix um Tiefe in Bauteil zu gewinnen
- placeholder für Bilder von Programm in Fusion
 */
Die Erstellung des Fräsprogramms erfolgt in Autodesk Fusion 360 @fusion, welches im Verein als Standardwerkzeug für die CAM-Programmierung eingesetzt wird und auf welches der Autor bereits auf umfangreiche Vorerfahrung zurückgreifen kann. Als Werkzeug kommt ein für die Zerspanung von Blockmaterialien ausgelegter Spezialfräser zum Einsatz.

Im Rahmen der Programmierung werden die Innenradien des Toolings in Abstimmung mit dem Fräser geringfügig angepasst, um den Zerspanungsprozess zu beschleunigen und die benötigte Werkzeugvielfalt zu reduzieren. Die Anpassung wurde im #acro("CAD")-Modell gegengeprüft; Kollisionen mit anderen konstruktiven Merkmalen des Casings konnten nicht identifiziert werden. Das Schruppprogramm (die grobe Entfernung des Großteils des Materials) wird vollständig mit dem genannten Spezialfräser durchgeführt. Auf ein dediziertes Schlichtprogramm wird verzichtet, da die erzielbare Oberflächenqualität des Schruppvorgangs für den Prototyp ausreichend ist und die unteren Innenradien ebenfalls mit dem Spezialfräser gefertigt werden können. Um die benötigte Bauteiltiefe zu erreichen, wird das Werkzeug über eine konische Helixbahn eingefahren. Eine Darstellung der finalen Werkzeugbahn in Fusion 360 @fusion ist in @fraesprogramm zu sehen.

#figure(
    image("../../resources/img/fraesprogramm1.png", width: 60%, format: "png"),
    caption: [Finale Werkzeugbahn des Schruppprogramms für die Toolingfertigung in Autodesk Fusion 360]
)<fraesprogramm>

==== Fräsen des Toolings
/* - Einspannung mit Spannzangen und Schrauben an Platte
- Löcher seitlich in den Block um Spannzangen anzubringen
- Block minimal zu klein an einer Kante, wird mit 2K Spachtelmasse (Placeholder Name) aufgefüllt und dann mit abgefräst
- Fräsen!
- Nut an der Seite wird nicht gefräst da Block nicht korrekt abgenullt wurde --> nicht zwingendermaßen notwendig, muss sowieso per Hand geschnitten werden dann macht es eigentlich keinen Unterschied ob es drinnen ist oder nicht
- Nut kann bei einer potenziellen zweiten Iteration noch hinzugefügt werden
 */
Die Einspannung des Epoxidharzblocks auf dem Maschinentisch erfolgt über Spannpratzen, die seitlich am Block mit Schrauben in eingebrachten Befestigungslöchern verschraubt werden. Diese Spannlöcher werden vor Beginn des eigentlichen Fräsprozesses manuell in die Seitenflächen des Blocks eingebracht.

An einer Kante weist der verwendete Block eine geringfügig zu kleine Abmessung gegenüber der Sollgeometrie des Toolings auf. Diese Materialfehlerstelle wird mit einer 2K-Spachtelmasse vom Typ Presto Füllspachtel @presto aufgefüllt, nach Aushärtung zusammen mit dem Epoxidharzblock abgefräst und geht somit homogen in die Toolingoberfläche über.

Eine ursprünglich am seitlichen Flansch vorgesehene Nut wird im Prototyp nicht gefräst, da der Block vor Beginn des Programms nicht exakt abgenullt wurde und eine Nachbesserung an dieser Stelle mit verhältnismäßig hohem Aufwand verbunden gewesen wäre. Da die Nut ohnehin nach dem Laminierprozess manuell nachgearbeitet wird, ergibt sich hieraus kein relevanter Nachteil für die Weiterverarbeitung des Prototyps. In einer potenziellen zweiten Iteration kann die Nut bei erneut erzeugtem Tooling unmittelbar mit eingebracht werden.

==== Vorbereiten des Toolings auf den Laminierprozess
/* - grobes Schleifpapier wird verwendet um Rillen aus den Kanten zu bekommen --> enstanden durch Vibrationen mit Fräser und Blockmaterial
- feineres Schleifpapier um die Seiten glatt zu bekommen
- Black Versiegler um Oberfläche zu versiegeln (genauer name auch placeholder), dreimal in Erfahrung ausreichend
- Eintrenner damit Laminat nicht am Tooling klebt (auch placeholder für exaktes produkt)
 */
Im Anschluss an das Fräsen weist das Tooling an einigen Kanten sichtbare Rillen auf, die aus Vibrationen zwischen Fräser und Blockmaterial resultieren. Diese werden zunächst mit grobem Schleifpapier entfernt, bevor die Seitenflächen mit feinerem Schleifpapier auf eine möglichst gleichmäßige Oberfläche gebracht werden.

Zur Versiegelung der porösen Epoxidharzoberfläche wird ein schwarzer Oberflächenversiegler vom Typ Marbocote HP3181 Black @hp3181 aufgetragen. Auf Grundlage interner Erfahrungswerte hat sich ein dreimaliger Auftrag als ausreichend erwiesen, um eine geschlossene, prepreg-taugliche Oberfläche zu erzielen. Abschließend wird das Tooling mit einem Trennmittel vom Typ Marbocote HP7 @hp7 behandelt, um ein Ankleben des Laminats am Tooling und damit ein beschädigungsfreies Entformen sicherzustellen.

==== Laminieren des Casings
/* - eintrennen von tooling
- Eine Lage Aramid an den Seiten, eine Lage an der Unterseite, eine Lage an der Oberseite, zwei Lagen an den Kanten und in den Ecken
- Vakuumsack wird gelegt um das Laminat während des Aushärtens zu komprimieren und Lagen aneinanderzudrücken (Verweise auf technische Grundlagen)
- Temperofen mit Vakuum wird verwendet um das Laminat zu härten
- Kosten bei Autoklav zu hoch, nicht wirklich notwendig da der hohe Druck nicht zwingendermaßen gebraucht wird, da es sich nicht um ein Bauteil mit konkreten oder hohen Materialanforderungen handelt
- Zyklus des Herstellers wird verwendet, 2 Stunden bei 120 Grad
 */
Aufgrund von Materialverfügbarkeit und der mit Prepreg verbundenen erhöhten Fertigungsqualität wird ein Prepreg-Laminat aus Restbeständen verwendet. 

Nach der beschriebenen Vorbereitung des Toolings wird der Laminataufbau eingebracht. Für den Prototyp wird auf den Seitenflächen jeweils eine Lage Aramid-Prepreg aufgebracht, ergänzt durch jeweils eine Lage an der Unter- und Oberseite. In den Kanten- und Eckbereichen werden zwei Lagen überlappend gelegt, um dort die höchste mechanische Belastung zu kompensieren. Beim Laminierprozess wird darauf geachtet, mit einer Plastikkarte alle Lufteinsparungen zwischen Laminatlagen oder Laminat und Form herausgestrichen werden. Diese sorgen im Verlauf des Prozesses zu Inkonsistenzen im resultierenden Prototypen @prepregverarbeitung. Der Laminierprozess in dem Tooling stellt sich als herausfordernd dar aufgrund der Notwendigkeit, die Aramidlagen in die Form zu drücken. Die schlechte Drapierbarkeit des Materials macht diesen Prozess sehr umständlich. 

Zur Konsolidierung des Laminats wird ein Vakuumsack über das Bauteil gezogen und evakuiert. Der dabei aufgebrachte Unterdruck verdichtet die Einzellagen, treibt eingeschlossene Luft aus dem Laminat und verbessert die Anbindung zwischen den Lagen, wie in den technischen Grundlagen zu Faserverbundstoffen beschrieben.

Die Aushärtung erfolgt in einem Temperofen mit Vakuumanschluss, welcher im Verein verfügbar ist. Auf eine Verarbeitung im Autoklaven wird verzichtet, da der dort zusätzlich aufgebrachte Überdruck für das vorliegende Bauteil nicht zwingend notwendig ist: Das Casing unterliegt keinen konkreten faserverbundmechanischen Anforderungen, die eine maximale Faservolumenanteilsausschöpfung erforderlich machen würden. Zudem stehen die Kosten und die eingeschränkte Verfügbarkeit eines Autoklaven in keinem sinnvollen Verhältnis zum erwartbaren Qualitätsgewinn. Für die Aushärtung wird der vom Prepreg-Hersteller spezifizierte Zyklus von zwei Stunden bei $120 space.thin degree C$ mit dem maximalen Vakuumdruck mit der im Verein verfügbaren Vakuumpumpe gefahren. Dieser Druck liegt bei ca. $200 space.thin"mBar"$.

=== Evaluation des Prototyps
/* - Protoyp flext in Torsion um Z-Achse, durch Platine wird das gefixt (siehe Metallplatte als Ersatz für die Platine im Testaufbau) (Placeholder Bild)
- 3D-Inserts Winkelteile sind nicht wirklich optimal, biegen bei wirklichen Jetson zu stark um, weswegen eine Alternative gefunden werden muss --> Wände müssen stärker werden, Winkel müssen vertikaler eingeschraubt werden
 */
Zur Bewertung des Prototyps wird das gefertigte Casing mit den geplanten Anbauteilen bestückt und mechanisch beurteilt. Dabei zeigt sich, dass das Casing unter Torsionsbelastung um die Z-Achse eine wahrnehmbare Flexibilität aufweist. Im bestimmungsgemäßen Betrieb wird diese Verformung durch die zentral montierte Platine, die als zusätzlich versteifendes Element wirkt, deutlich reduziert. Im Rahmen des Testaufbaus wird die Platine durch eine Metallplatte ersetzt, um diesen Effekt reproduzierbar nachzubilden. Der entsprechende Aufbau ist in @casingtorsionstest dargestellt, wobei die Z-Achse in diesem Fall in die Bildfläche hineingeht.

#figure(
    image("../../resources/img/casingtorsionstest.png", width: 60%, format: "png"),
    caption: [Casing-Prototyp mit installierten Mountings und angebrachter Metallplatte als Ersatz für Carrierboard-Platine. ]
)<casingtorsionstest>

Ein weiterer identifizierter Schwachpunkt sind die aus dem Laminat herausgeführten 3D-Inserts in Winkelausführung, die im aktuellen Aufbau nicht optimal dimensioniert sind. Zum Einen sorgen Ungenauigkeiten im Fertigungsprozess zu einer Verformung des Casings mit der Metallplatte. Unter der Masse des Jetson Thor biegen die Winkel stärker nach unten als vorgesehen, wodurch die positionsgenaue und ausreißsichere Anbindung nicht zuverlässig sichergestellt werden kann. Hieraus ergibt sich die Notwendigkeit, die Wandstärken des Casings zu erhöhen und die Verschraubungsrichtung der Winkel stärker zu vertikalisieren, um das Biegemoment in den Inserts zu reduzieren und die Platine als lasttragendes Element bei der Torsion um die Z-Achse zu entlasten.

=== Anpassungen nach Evaluation
/* - Wände müssen stärker werden, weswegen in den Installationsseiten Kern und Hardpoints hinzugefügt werden müssen --> vor allem Kern wichtig
- durch den Kern muss das Tooling positiv werden muss, sonst kann auf der Innenseite keine saubere Oberfläche erreicht werden
- Winkel von zwei Grad wird reinkonstruiert um die Entformung einfacher zu machen (placeholder bild aus CAD)
 */
Auf Basis der Erkenntnisse aus der Prototypevaluation wird die Konstruktion des Casings überarbeitet. Um die Torsionssteifigkeit zu erhöhen und gleichzeitig die Anbindungspunkte der Winkel zu verbessern, werden an den Installationsseiten ein $1 space.thin"mm"$ Kern aus Aramidwabe sowie lokale Hardpoints in den Laminataufbau integriert. Der Kern wirkt dabei als Abstandshalter im Sinne der in den technischen Grundlagen beschriebenen Sandwichbauweise und steigert die Biegesteifigkeit der Seitenwände bei geringem Gewichtszuwachs. Die Hardpoints dienen als lokale Verstärkung im Bereich der Verschraubungspunkte.

Die Einbringung eines Kerns erfordert eine Änderung der Toolingtopologie: Während der Prototyp über ein Negativtooling gefertigt wurde, ist für die finale Variante ein Positivtooling notwendig, da nur auf diese Weise die Innenseite des Casings eine definierte und saubere Oberfläche erhält, an welcher der Kern reproduzierbar anliegen kann.

Zusätzlich wird in die #acro("CAD")-Geometrie eine Entformungsschräge von $2 degree$ eingearbeitet. Diese erleichtert das Entformen des Laminats vom Positivtooling, da das Bauteil bei ausreichender Steifigkeit durch Kern und Hardpoints nicht mehr nach innen flexen kann. Die überarbeitete Geometrie ist in @casingcadfinal dargestellt.

#figure(
    image("../../resources/img/casingcadfinal.png", width: 60%, format: "png"),
    caption: [Überarbeitete Casing-Geometrie mit integriertem Aramidwabenkern mit Hardpoints (nicht im CAD konstruiert) und einer Entformungsschräge von $2 degree$]
)<casingcadfinal>

=== Fertigung des finalen Gehäuses
/* - Fräsen ähnlich zum Prototyp nur mit anderem Programm
diesmal auch mit Schlichten damit 2 Grad Kanten sauber sind und Rundungen passen
- Tooling wird mit anderem Versiegler (name placeholder) behandelt, da die Oberfläche ein bisschen mehr konsistent ist, da der erste schwarze Versiegler nicht so wirklich geil war, der war teilweise sehr fleckig aufgetragen was nicht einfach zu fixen war
- Hardpoints werden aus Rest-MDF gemacht (wird abgeschliffen auf die Dicke vom Kern und dann wird der Kern ausgeschnitten)
- MDF wird runtergeschliffen bis es auf der Dicke des Kerns ist
- Kern wird aus Aramidwaben gemacht, da das Material sehr leicht ist und trotzdem eine hohe Steifigkeit bietet, außerdem ist es einfach zu verarbeiten
- Kern wird ausgeschnitten um die Hardpoints dazwischen einzufügen
- wieder eintrennen drei mal mit placeholder eintrenner
- Laminieren mit insgesamt 2 Lagen Aramid um das gesamte Casing drumherum
- um das Ganze ins Laminat zu bekommen wird Klebefolie auf beide Seiten getan, um den Kern und die Hardpoints zu fixieren, damit beim Ausbacken nichts verrutscht, außerdem sollte die Klebefolie helfen, dass nichts delaminiert
- Aramidlagen werden um den Kern reingedrückt, damit die Lagen sauber zusammengeführt werden können, Vermeidung von Luftblasen
- Ausbacken im Ofen wieder mit nur Vakuum
- Entformen ist easy
 */
Das Fräsen des finalen Toolings erfolgt grundsätzlich analog zum Prototyp, wird jedoch um ein Schlichtprogramm ergänzt. Dies ist notwendig, um die konstruktiv vorgesehenen Entformungsschrägen von $2 space.thin degree$ und die Rundungen an den Kanten in der geforderten Maß- und Oberflächengüte abzubilden.

Zur Oberflächenversiegelung wird ein anderes Produkt vom Typ Marbocote MTS12 @mts12 eingesetzt, das durch seine dickflüssigere Konsistenz eine gleichmäßigere Oberfläche erzeugt als der im Prototyp verwendete schwarze Versiegler. Dieser wies in der Anwendung eine nur eingeschränkt reproduzierbare Auftragsqualität mit lokaler Fleckenbildung auf, die nicht mit vertretbarem Aufwand auszugleichen war.

Die Hardpoints werden aus Restbeständen von mitteldichter Holzfaserplatte gefertigt. Das Ausgangsmaterial wird zunächst auf die Zieldicke des Kerns abgeschliffen, sodass Hardpoints und Kern in der gleichen Ebene liegen. Als Kernmaterial kommen Aramidwaben zum Einsatz, die in der beschriebenen Sandwichbauweise ein besonders vorteilhaftes Verhältnis aus Steifigkeit und Gewicht bieten und sich gut zuschneiden lassen @compositeslab, @faserverbundbauweisen. Der Kern wird im Bereich der Hardpoints passgenau ausgeschnitten, sodass die Holzfaserplatten-Hardpoints bündig in die Wabenstruktur eingesetzt werden können.

Das Tooling wird erneut dreimal mit dem Trennmittel vom Typ Marbocote HP7 @hp7 behandelt. Auf diesem Aufbau werden insgesamt zwei Lagen Aramid um das gesamte Casing gelegt. Um ein Verrutschen von Kern und Hardpoints während des Ofenzyklus zu verhindern, werden beide beidseitig mit einer dünnen Klebefolie fixiert (siehe @kernhardpoints). Diese übernimmt zusätzlich eine unterstützende Funktion gegen mögliche Delamination im Übergangsbereich zwischen Kern und Decklagen. Die Aramidlagen werden im Kantenbereich sorgfältig um den Kern herum eingedrückt, damit die Lagen ober- und unterhalb des Kerns sauber zusammengeführt werden und sich keine Lufteinschlüsse bilden.

#figure(
    image("../../resources/img/kernhardpoints.jpeg", width: 60%, format: "jpg"),
    caption: [Casing im Laminierprozess mit eingelegten Holz-Hardpoints in Aramidwabe und mit bereits aufgebrachter Klebefolie]
)<kernhardpoints>

Die Aushärtung erfolgt erneut im Temperofen unter Vakuum entsprechend dem vom Hersteller spezifizierten Zyklus. Das Entformen vom Positivtooling gestaltet sich aufgrund der einkonstruierten Entformungsschräge unkritisch.

=== Nachbearbeitung
/* - 3D Druck Lehre wird verwendet (Placeholder Bild) um Ports auszuschneiden
- 3D Druck Lehre wird außerdem für die Löcher seitlich durch den Kern verwendet --> Positionierung schwierig
- Dremel wird verwendet um alles auszuschneiden, standard 3 mm Bohrer wird verwendet für Löcher seitlich
- erst wird versucht bei den Cutouts für die Ports vorne und an der Seite noch Stege dazwischen zu behalten
- für Testfit wird Folie verwendet um die ausgefransten Kanten zu überdecken
- Folie klebt nicht gut genug, sehr suboptimal insgesamt (placeholder bild)
- bei einem Testfit wird klar dass die Cutouts so nicht funktionieren werden, in einem weiteren Nachbearbeitungsschritt werden die Stege entfernt und die Cutouts vergrößert
- mit größeren Cutouts passt alles rein (placeholder bild)
- Kanten werden mit Fasertape (Placeholder Name) abgedeckt --> klebt besser und sieht sauberer aus
- in @pcbmounting wird das interne mounting im casing von dem Thor und den weiteren Platinen im Casing drinnen beschrieben
 */
Nach dem Entformen werden die zuvor in der #acro("CAD")-Konstruktion ausgesparten Cutouts für die Konnektoren sowie die seitlichen Befestigungsbohrungen manuell in das Laminat eingebracht. Zur reproduzierbaren Positionierung dieser Bearbeitungen werden 3D-gedruckte Lehren verwendet, die sowohl die Kontur der Ports als auch die Positionen der seitlichen Bohrungen durch den Kern festlegt. Die Lehren sind in @cutoutlehre dargestellt.

#figure(
    image("../../resources/img/cutoutlehre.jpeg", width: 60%, format: "jpg"),
    caption: [3D-gedruckte Lehren zur Positionierung der Port-Cutouts]
)<cutoutlehre>

Die Positionierung der seitlichen Bohrungen erweist sich trotz Lehre als anspruchsvoll, da die Positionierung der Bohrung und das Durchdringen des Sandwichaufbaus eng toleriert sind. Die Cutouts werden mit einem Trennwerkzeug der Marke Dremel @dremel ausgeschnitten, die seitlichen Bohrungen mit einem $3 space.thin"mm"$-Standardbohrer eingebracht.

In einer ersten Ausführung werden zwischen den vorderen und seitlichen Port-Cutouts Stege im Laminat belassen, um das Casing weitestgehend geschlossen zu halten. Für einen ersten Testfit werden die ausgefransten Kanten der Cutouts mit einer dünnen Folie abgedeckt. Da diese Folie nicht zuverlässig am Laminat haftet, ergibt sich ein insgesamt suboptimales Ergebnis (vergleiche @cutoutsfolie).

#figure(
    image("../../resources/img/cutoutsfolie.jpeg", width: 60%, format: "jpg"),
    caption: [Testfit mit den ursprünglichen Cutouts inklusive verbleibender Stege, deren ausgefranste Kanten provisorisch mit Folie abgedeckt sind]
)<cutoutsfolie>

Im Testfit zeigt sich zudem, dass die Cutouts in der ursprünglichen Ausführung mit Stegen nicht für die geplante Konnektorbestückung geeignet sind. In einem weiteren Nachbearbeitungsschritt werden die Stege daher entfernt und die Cutouts entsprechend vergrößert. Mit der angepassten Geometrie lassen sich sämtliche Konnektoren bestimmungsgemäß montieren./*, wie in @cutoutsfinal dargestellt.
#figure(
    image("../../resources/img/placeholder.png", width: 60%, format: "png"),
    caption: [Finales Casing mit vergrößerten Cutouts und nach Entfernung der Stege]
)<cutoutsfinal>
*/
Abschließend werden die freigelegten Kanten mit einem Fasertape abgedeckt. Dieses haftet gegenüber der zuvor eingesetzten Folie deutlich zuverlässiger am Laminat und erzeugt zudem ein optisch konsistenteres Erscheinungsbild der Bauteilkanten. Das Gewicht liegt schlussendlich bei $71 space.thin g$.

Die interne Anbindung des Thor-Moduls sowie der weiteren Platinen innerhalb des Casings wird in @pcbmounting beschrieben.
