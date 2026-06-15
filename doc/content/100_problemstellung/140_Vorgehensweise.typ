#import "../../config/acronyms.typ": *
#include "../../config/config.typ"

== Vorgehensweise
/* - irgendwie iterativer ansatz
- vereinskontext oft mit schnell wechselnden anforderungen
- claude: inhalt ausdenken und ansatz als methodisch in irgendeiner form beschreiben */

Die Entwicklung des #acro("DVPC") erfolgt im Rahmen eines studentischen Rennsportprojekts und unterliegt damit Rahmenbedingungen, die den methodischen Zugang maßgeblich prägen. Der Entwicklungshorizont ist durch die Saisonstruktur des Vereins fest umrissen, während sich die konkreten Anforderungen an das System im Projektverlauf weiterentwickeln können. Zentrale Festlegungen liegen zudem nicht ausschließlich im Verantwortungsbereich dieser Arbeit, sondern werden teilweise durch andere Subteams im Verein getroffen. Vor diesem Hintergrund wird ein iteratives Vorgehen gewählt, das auf eine schrittweise Konkretisierung und, wo erforderlich, auf parallele Konzeptpfade setzt, statt eine einmal festgelegte Lösung linear bis zur Fertigung zu behalten.

Die Vorgehensweise gliedert sich in aufeinander aufbauende Phasen. Den Ausgangspunkt bildet die Analyse des #acro("DVPC") der Vorjahressaison. Ziel dieser Phase ist es, die bestehende Lösung systematisch aufzuarbeiten und aus den im Rennbetrieb gesammelten Erfahrungen belastbare Entwicklungsziele abzuleiten. Dieser rückblickende Zugang ist zweckmäßig, da das Vorjahressystem unter realen Wettbewerbsbedingungen betrieben wurde und damit Informationen liefert, die sich aus Anforderungsdokumenten allein nicht erschließen lassen.

Aus der Analyse sowie aus übergeordneten Projektzielen werden anschließend die Anforderungen an das neue System abgeleitet. Die Formulierung erfolgt bewusst auf einer funktionalen Ebene und verzichtet dort auf absolute Grenzwerte, wo die zugrunde liegende Hardware noch nicht feststeht. Diese Offenheit ist notwendig, um die nachfolgende Konzeptentwicklung nicht durch verfrühte Festlegungen einzuschränken.

Auf die Anforderungsableitung folgt die prototypische Konzeptentwicklung. In dieser Phase werden die in Frage kommenden Lösungsansätze so weit ausgearbeitet, dass eine belastbare Gegenüberstellung möglich ist. Soweit zentrale Entscheidungen noch offen sind und einen wesentlichen Einfluss auf die weiteren Teilsysteme haben, werden parallele Konzeptpfade verfolgt. Die methodische Begründung liegt darin, dass bei einer verfrühten Festlegung auf einen einzelnen Pfad erhebliche Teile der Entwicklungsarbeit bei einer späteren Kurskorrektur verworfen werden müssten.

Im Anschluss an die Konzeptentscheidung wird in die Detailentwicklung übergegangen. Diese ist entlang der Teilsysteme des #acro("DVPC") strukturiert und erfolgt in Iterationsschleifen aus Konstruktion, Prototypenbau und Erprobung. Kurze Iterationszyklen sind im vorliegenden Kontext möglich, da die benötigten Fertigungskapazitäten überwiegend vereinsintern verfügbar sind. Die Entwicklung der Teilsysteme verläuft nicht streng sequentiell, sondern in wechselseitigem Austausch, da Entscheidungen in einem Bereich Auswirkungen auf die angrenzenden Teilsysteme haben können und Anforderungen sich im Saisonverlauf ändern können.

Die abschließende Phase bildet die Systemintegration, in der die zuvor einzeln entwickelten Baugruppen zu einer funktionsfähigen Einheit zusammengeführt werden. In diesem Schritt werden die in den vorhergehenden Phasen getroffenen Entscheidungen zusammengeführt und verbleibende Inkonsistenzen zwischen den Teilsystemen in einer letzten Iterationsschleife behoben.

Das beschriebene Vorgehen lässt sich methodisch als anforderungsgetriebene, iterative Entwicklung mit bedarfsweise parallelen Konzeptpfaden charakterisieren. Gegenüber einem streng sequentiellen Vorgehen bietet dieser Ansatz den Vorteil, auf sich ändernde Randbedingungen reagieren zu können, ohne bereits geleistete Entwicklungsarbeit vollständig verwerfen zu müssen. Eine abschließende Reflexion der gewählten Vorgehensweise sowie eine kritische Würdigung der getroffenen Entscheidungen erfolgt im Kapitel @kritischewuerdigung.
