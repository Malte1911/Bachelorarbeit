#import "../../config/acronyms.typ": *
#include "../../config/config.typ"


= Nachhaltigkeitsbetrachtung
Die Entwicklung des #acro("DVPC") ist im Kontext eines studentischen Rennsportprojekts sowohl von ökonomischen als auch von ökologischen Randbedingungen geprägt. Das verfügbare Budget des Vereins ist begrenzt, und Bauteile, Werkzeuge sowie Fertigungskapazitäten müssen saisonübergreifend sinnvoll eingesetzt werden. Gleichzeitig gewinnen die mit Werkstoffwahl, Fertigung und Entsorgung verbundenen Umweltwirkungen auch im Hochschulumfeld zunehmend an Bedeutung. Im folgenden Abschnitt werden die im Rahmen dieser Arbeit getroffenen konstruktiven Entscheidungen unter diesen beiden Gesichtspunkten eingeordnet.

/* - Formula student generell mit elektrofahrzeugen nachhaltig da junge ingenieur und zukunftstechnologien und so weiter */
Über die projektspezifische Betrachtung hinaus ordnet sich die Entwicklung des #acro("DVPC") in den übergeordneten Kontext der Formula Student ein. Die Wettbewerbsreihe richtet einen deutlichen Fokus auf elektrisch angetriebene und fahrerlos operierende Fahrzeuge und adressiert damit gezielt Technologiefelder, denen in der zukünftigen Mobilität eine zentrale Rolle zugeschrieben wird. Studierende sammeln im Rahmen der Projektarbeit unmittelbare Erfahrung mit diversen zukunftsrelevanten Technologien, sodass das im Studium erworbene Wissen direkt an industrielle Zukunftstechnologien anknüpft. Der mit Entwicklung, Fertigung und Betrieb eines Rennfahrzeugs verbundene Ressourceneinsatz lässt sich in diesem Sinne zugleich als Investition in die Ausbildung junger Ingenieur:innen verstehen, deren Qualifikation langfristig zur Entwicklung nachhaltigerer Mobilitätslösungen beitragen kann.

== Materialwahl und Herstellung
/* - Aramid-Variante des Casings: hoher Energieaufwand in der Faserherstellung, aber sehr gute mechanische Eigenschaften pro Gewicht --> weniger Material für gleiche Steifigkeit, verwendung von restmaterial im verein welches für andere komponenten nicht mehr verwendet werden konnte die sicherheitskritisch sind
- Kühlkörper aus Aluminium: energieintensive Primärherstellung, aber hoher Recyclinganteil im Kreislauf und nahezu verlustfreies Einschmelzen möglich
- Blockmaterial auch Reste von Monotooling von vor Jahren --> Geld gespart und Ressourcen recycled
- Standardisierte Verbindungselemente (M3, Gewindeeinsätze) statt Sonderanfertigungen --> bessere Verfügbarkeit und Ersatzteilversorgung über mehrere Saisons
 */
Für das Casing wird eine Variante auf Basis von Aramidfasern eingesetzt. Die Faserherstellung ist energieintensiv und damit ökologisch zunächst ungünstig zu bewerten. Im Gegenzug weist der Werkstoff sehr gute mechanische Eigenschaften bezogen auf das Gewicht auf, sodass für eine geforderte Steifigkeit spürbar weniger Material benötigt wird als bei konventionellen Werkstoffen. Der über die Saison insgesamt benötigte Materialbedarf reduziert sich dadurch, was sich sowohl ökologisch in einem geringeren Rohstoffeinsatz als auch ökonomisch in einem niedrigeren Materialverbrauch niederschlägt. Ergänzend wird für die Fertigung des Casings Restmaterial aus anderen Vereinsprojekten verwendet, das für sicherheitskritische Komponenten am Fahrzeug nicht mehr freigegeben ist, für das vergleichsweise gering belastete Casing jedoch weiterhin genutzt werden kann. Dadurch entfällt eine zusätzliche Materialbeschaffung, und bereits vorhandene Ressourcen werden einer weiteren Nutzung zugeführt.

Der Kühlkörper wird aus Aluminium gefertigt. Die Primärherstellung des Werkstoffs ist mit einem hohen Energieaufwand verbunden, gleichzeitig zeichnet sich Aluminium durch einen etablierten Recyclingkreislauf und eine nahezu verlustfreie Wiederverwertung durch Einschmelzen aus. Für das Recycling wird dabei lediglich etwa fünf Prozent des für die Primärherstellung erforderlichen Energieeinsatzes benötigt @aluRecycling. Am Ende der Nutzungsdauer kann das Bauteil somit stofflich zurückgeführt werden, ohne dass wesentliche Anteile des Materials verloren gehen. Das für die Fräsbearbeitung verwendete Blockmaterial stammt überwiegend aus Resten eines vor mehreren Jahren durchgeführten Monotoolings und wäre andernfalls als Verschnitt im Lager des Vereins verblieben. Durch diese Nachnutzung entsteht kein zusätzlicher Einkauf von Rohmaterial, wodurch sowohl Kosten eingespart als auch bereits investierte Ressourcen weiterverwertet werden.

Für die mechanische Fügung wird durchgängig auf standardisierte Verbindungselemente zurückgegriffen. Eingesetzt werden M3-Schrauben und handelsübliche Gewindeeinsätze anstelle von Sonderanfertigungen. Standardkomponenten sind dauerhaft verfügbar, kurzfristig nachbestellbar und deutlich günstiger als projektspezifische Lösungen. Über mehrere Saisons hinweg wird dadurch die Ersatzteilversorgung sichergestellt und der administrative Aufwand für Beschaffungen reduziert.


== Lebensdauer und Wiederverwendbarkeit
/* - Modularer Aufbau: Casing, Mounting, Kühlkörper und Elektronik sind entkoppelt --> einzelne Komponenten austauschbar, ohne das Gesamtsystem neu entwickeln zu müssen
- Mounting ist fahrzeugspezifisch, Casing und interne Elektronik sind bei Chassiswechsel weiterverwendbar
- Schraubverbindungen statt Klebeverbindungen --> zerstörungsfreies Öffnen für Wartung und Reparatur
- Gewindeeinsätze im gedruckten Casing erlauben mehrfaches Lösen ohne Materialermüdung
- Dokumentation dieser Arbeit dient dem Folgeteam als Übergabegrundlage --> keine Neuentwicklung aus dem Nichts
- Auslegung des Kühlsystems mit Reserve --> Weiterverwendung bei moderat höherer Rechenlast ohne Redesign möglich
- Nutzung von Consumer-/Embedded-Hardware (Jetson Thor) mit langer Herstellerverfügbarkeit reduziert das Risiko der Abkündigung innerhalb der Projektlaufzeit
 */
Der #acro("DVPC") ist konstruktiv in Casing, Mounting, Kühlkörper und Elektronik gegliedert und in diesen Baugruppen weitgehend entkoppelt aufgebaut. Einzelne Komponenten können dadurch unabhängig voneinander überarbeitet, ersetzt oder weiterentwickelt werden, ohne dass das Gesamtsystem neu entworfen werden muss. Während das Mounting fahrzeugspezifisch an das aktuelle Chassis angepasst ist, lassen sich Casing, Kühlkörper und interne Elektronik bei einem Chassiswechsel mit überschaubarem Anpassungsaufwand weiterverwenden. Der Entwicklungs- und Fertigungsaufwand für die Recheneinheit verteilt sich damit über mehrere Saisons, was sowohl die jährlichen Projektkosten senkt als auch den mit einer vollständigen Neuentwicklung verbundenen Ressourceneinsatz vermeidet.

Die mechanische Verbindung der Einzelbaugruppen erfolgt durchgängig über Schraubverbindungen anstelle von Klebeverbindungen. Das Gesamtsystem lässt sich dadurch zerstörungsfrei öffnen, warten und reparieren, sodass einzelne Bauteile im Defektfall gezielt getauscht werden können, ohne die umgebenden Komponenten zu verwerfen. Die im gedruckten Casing eingesetzten Gewindeeinsätze erlauben zudem ein mehrfaches Lösen und Anziehen der Verbindungen, ohne dass das umgebende Kunststoffmaterial ermüdet oder ausbricht. Die Lebensdauer der Einzelkomponenten wird dadurch erhöht und der Austauschbedarf über die Projektlaufzeit hinweg reduziert.

Die vorliegende Arbeit dient dem nachfolgenden Team zugleich als Übergabegrundlage und dokumentiert die im Entwicklungsprozess getroffenen Entscheidungen sowie deren Begründung. Dadurch kann an der bestehenden Konstruktion weitergearbeitet werden, anstatt vergleichbare Lösungen in einer Folgesaison erneut aus dem Nichts zu entwickeln. Ergänzend ist das Kühlsystem so ausgelegt, dass es eine moderat höhere Rechenlast ohne ein Redesign tragen kann. Diese thermische Reserve erweitert den Einsatzbereich des #acro("DVPC") auf zukünftige Softwarestände, ohne dass Kühlkörper oder thermische Anbindung überarbeitet werden müssen.

Als Recheneinheit wird mit dem Jetson Thor eine Embedded-Hardware eingesetzt, die der Hersteller mit einer langen Produktverfügbarkeit anbietet. Das Risiko, dass eine Abkündigung der zentralen Komponente innerhalb der Projektlaufzeit eine aufwendige Anpassung des übrigen Systems erzwingt, wird dadurch reduziert. Aus ökonomischer Sicht sichert dies die Investition in die Peripheriekonstruktion über mehrere Saisons hinweg ab, während aus ökologischer Sicht der Bedarf an einer vorzeitigen Neuentwicklung und dem damit verbundenen Ressourceneinsatz vermieden wird.



