#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Stand der Technik und Quellenlage<sec:stand>

Bevor die einzelnen Bestandteile des betrachteten Systems beschrieben werden, ist zu klären, an welchen Stand der Technik die Arbeit anschließt und auf welcher Art von Quellen ihre Aussagen beruhen. Beides gehört zusammen, denn die Beschaffenheit der verfügbaren Quellen bestimmt unmittelbar, welche Aussagen belegbar sind und welche am Gerät zu prüfen bleiben.


=== Einordnung in den Stand der Technik<sec:standdertechnik>

Die Aufgabe, Geräte unterschiedlicher Herkunft in einer übergeordneten Plattform zusammenzuführen, ist in der Gebäudeautomation seit langem beschrieben. Frühe Arbeiten begegnen der Vielfalt an Protokollen und Datenformaten mit einer vermittelnden Zwischenschicht, die die Teilsysteme entkoppelt und der Leitebene eine einheitliche Sicht anbietet @src:perumal2010. Der Ansatz löst die Frage der Übertragung, verschiebt die eigentliche Schwierigkeit jedoch nur, denn ob zwei Systeme zusammenarbeiten, entscheidet sich weniger am Transport als an der Bedeutung der übertragenen Größen.

Genau an dieser Stelle setzt die neuere Forschung an. Mit Brick liegt ein Schema vor, das Anlagenteile, Messpunkte und deren Beziehungen maschinenlesbar beschreibt, mit dem ausdrücklichen Ziel, Anwendungen von einem Gebäude auf ein anderes übertragbar zu machen @src:balaji2018. Die zugrunde liegende Beobachtung deckt sich mit der Ausgangslage dieser Arbeit. Ein Datenpunkt ist erst dann verwertbar, wenn feststeht, welche Größe er trägt, in welcher Einheit, in welchem Zustandsraum und zu welchem Gerät er gehört. Die Typbeschreibung, die im Rahmen dieser Arbeit entsteht, leistet für die betrachtete Gerätefamilie dasselbe, wenn auch mit den Mitteln und in der Ausdruckskraft der Zielplattform und nicht als allgemeines Schema.

Wie aufwendig diese Zuordnung in der Praxis ist, zeigt der Forschungszweig, der sich mit ihrer Automatisierung befasst. Eine Übersichtsarbeit zum sogenannten Point Mapping stellt fest, dass die Zuordnung von Datenpunkten eines Gebäudeleitsystems zu einer einheitlichen Beschreibung überwiegend von Hand erfolgt, herstellerabhängigen Benennungen folgt und einen erheblichen Anteil des Projektierungsaufwands ausmacht @src:wang2018. Spätere Arbeiten versuchen, die Zuordnung aus Bezeichnern und Messverläufen selbsttätig herzuleiten, erreichen dabei aber keine Güte, die eine Prüfung durch den Menschen entbehrlich machte @src:zhan2020. Für die vorliegende Arbeit folgt daraus zweierlei. Zum einen ist der wiederkehrende Zuordnungsaufwand ein anerkanntes Problem und keine Eigenheit des hier betrachteten Falls. Zum anderen greift eine wiederverwendbare Typbeschreibung das Problem an seiner Wurzel, da eine einmal geleistete Zuordnung für alle Geräte desselben Typs gilt und in Folgeprojekten nicht erneut zu erbringen ist.

Zur konkreten Verbindung von Schaltkreisschutzgeräten dieser Bauart, dem SENTRON Powercenter und einer Gebäudemanagementplattform ließ sich dagegen keine wissenschaftliche Veröffentlichung auffinden. Dieser Befund ist nicht nur eine Feststellung über die Literatur, sondern deckt sich mit dem Zustand der Werkzeuge selbst, da die Gerätereihe auch in der mitgelieferten Objektmodellbibliothek der Zielplattform fehlt (siehe @sec:systemanalyse). Die Arbeit bewegt sich damit in einem Feld, dessen allgemeine Problemstellung gut beschrieben ist, dessen konkreter Anwendungsfall jedoch bislang nicht bearbeitet wurde.


=== Quellenlage und Umgang mit den Quellen<sec:quellenlage>

Aus dieser Lage folgt eine Quellenbasis, die sich aus vier Arten zusammensetzt und deren Belastbarkeit sich deutlich unterscheidet.

Den größten Anteil trägt die Primärdokumentation der Hersteller, also Systemhandbuch, Registerkarte, Engineering-Dokumentation und Werkzeughilfe. Sie ist für Registeradressen, Datenformate und Systemgrenzen die einzige verfügbare und zugleich die maßgebliche Quelle, denn sie beschreibt das Verhalten, auf das sich der Hersteller festlegt. Sie ist jedoch weder neutral noch versionsstabil. Sie verfolgt den Zweck, das eigene Produkt einsetzbar zu machen, sie benennt Einschränkungen nicht immer dort, wo sie auftreten, und sie liegt nicht zu jedem Stand vor, der im Testaufbau tatsächlich installiert ist. Aussagen aus dieser Quellenart werden deshalb, wo immer möglich, am Gerät gegengeprüft.

Die zweite Art bilden Normen und offene Spezifikationen. Sie sind für den Rahmen der Arbeit gesetzt und werden nicht diskutiert, sondern angewandt, etwa bei der Zuordnung der Geräte zu ihren Produktnormen oder beim Aufbau der Modbus-Telegramme. Die dritte Art umfasst Fachbücher, die ausschließlich für das methodische Vorgehen herangezogen werden. Die vierte Art schließlich sind begutachtete Veröffentlichungen, die nicht der technischen Herleitung dienen, sondern der Einordnung des Problems, wie sie im vorangegangenen Abschnitt vorgenommen wurde.

Für den Umgang mit den Quellen ergibt sich daraus eine durchgehende Regel. Wo eine Angabe des Herstellers am Testaufbau bestätigt wurde, wird sie ohne weiteren Vorbehalt verwendet. Wo Dokumentation und Beobachtung auseinandergehen oder wo eine Angabe nicht zu dem installierten Stand vorliegt, wird dies an der betreffenden Stelle vermerkt und die Beobachtung als das Maßgebliche behandelt. Diese Prüfung ist nicht nur eine Vorsichtsmaßnahme, sondern selbst Teil des Ergebnisses, da sich mehrere für das Datenmodell wesentliche Eigenschaften der Geräte erst aus ihr ergeben haben (siehe @sec:registerraum).

/* Claude: Abschnitt neu angelegt. Die vier wissenschaftlichen Quellen sind
   recherchiert, die bibliographischen Angaben ueber die Crossref-API gegen die
   Verlagsmetadaten geprueft; die Volltexte lagen nicht vor. Zitiert wird jeweils
   nur die Kernaussage. Der Vermerk dazu steht auch in resources/quellen.bib.

   Der Absatz zur fehlenden Veroeffentlichung ueber genau diese Geraete-Plattform-
   Paarung ist bewusst als Befund und nicht als Beleg formuliert, weil sich das
   Fehlen von Literatur nicht positiv belegen laesst. */
