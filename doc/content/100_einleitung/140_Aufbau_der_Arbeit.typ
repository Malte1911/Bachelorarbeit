#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Aufbau der Arbeit<sec:aufbau>

/* Anmerkung des Autors, erledigt: "Leserfuehrung ueber die Kapitel, eine knappe
   Seite. Nicht die Methodik beschreiben, die steht in @sec:vorgehensmodell,
   sondern nur, welches Kapitel welche Frage beantwortet." */

Die Arbeit ist entlang des in @sec:vorgehensmodell beschriebenen Vorgehens gegliedert. Sie führt vom Verständnis des Systems über die Anforderungen zur Umsetzung und von dort zurück zur Prüfung, wobei jedes Kapitel eine Frage beantwortet, die im vorangegangenen offengeblieben ist.

Die Grundlagen ordnen die Arbeit zunächst in den Stand der Technik ein und legen offen, auf welche Art von Quellen sich ihre Aussagen stützen (@sec:stand). Anschließend werden die Bestandteile des betrachteten Systems eingeführt, also die Schaltkreisschutzgeräte (@sec:ecpd), das Powercenter als Datenquelle (@sec:powercenter), das Protokoll der Übertragung (@sec:modbus), die Zielplattform (@sec:desigocc) und das Werkzeug, mit dem die Typbeschreibung entsteht (@sec:pde).

Das Kapitel zu Analyse und Anforderungen klärt, was zu leisten ist. Es bestimmt Systemgrenze und Interessengruppen, wählt aus den technisch bestehenden Integrationswegen einen aus und charakterisiert den Datenbestand, den dieser Weg eröffnet (@sec:analyse). Daraus entstehen der Anforderungskatalog (@sec:anforderungen) und die Testfälle, an denen die Lösung später zu messen ist (@sec:testfaelle).

Das folgende Kapitel beschreibt die Umgebung, in der die Entwicklung stattfindet und in der sämtliche Beobachtungen der Arbeit entstanden sind. Es umfasst den Testaufbau (@sec:testaufbau), die Konfiguration der Geräte (@sec:geraetekonfiguration), die Kommunikationsstrecke (@sec:kommunikationsstrecke) sowie die eingesetzten Werkzeuge und Softwarestände (@sec:werkzeuge). Ohne diese Angaben wäre nicht nachvollziehbar, worauf sich die Ergebnisse beziehen.

Den Kern bildet die Entwicklung des Datenmodells. Sie begründet zuerst die Kriterien der Datenauswahl (@sec:auswahlkriterien), wendet sie auf beide Gerätetypen an (@sec:datenpunkte) und überführt das Ergebnis in die Typbeschreibung (@sec:umsetzung). Deren Übernahme in die Zielplattform (@sec:uebernahme) und die begleitende Dokumentation (@sec:modelldoku) schließen das Kapitel ab.

Die Validierung führt die Testfälle am Testaufbau durch (@sec:testdurchfuehrung), hält die Befunde fest, die außerhalb des Datenmodells liegen und dennoch über seine Verwendbarkeit entscheiden (@sec:befunde), und stellt jeder Anforderung ihr Ergebnis gegenüber (@sec:anforderungsabgleich). Das Fazit gewichtet diese Ergebnisse für das Projektgeschäft (@sec:praxistauglichkeit), benennt die Grenzen der Lösung (@sec:wuerdigung) und zeigt Ansatzpunkte für eine Weiterentwicklung auf (@sec:weiterentwicklung).

Der Anhang trägt die Aufstellungen, die den Umfang eines Fließtextes überschreiten, darunter die aufgenommenen Datenpunkte beider Gerätetypen mit Register, Format und Begründung (#ref(<apx:datenpunkte_ecpd>, supplement: [Anhang])).

/* Claude: Abschnitt neu angelegt, sieben kurze Absaetze. Kapitelnummern sind
   nirgends hart eingetragen, die Kapitel sind ueber die Labels ihrer
   Unterabschnitte referenziert, damit eine Umsortierung nichts bricht. Das
   Vorgehensmodell selbst ist nicht beschrieben, sondern nur ueber
   @sec:vorgehensmodell angefuehrt, wie in der Anmerkung des Autors verlangt.

   Nicht erwaehnt sind @sec:nachhaltigkeit und @sec:zusammenfassung, damit die
   Aufzaehlung der Fazitkapitel nicht vollstaendig, sondern lesbar bleibt.
   Falls eine vollstaendige Aufzaehlung gewuenscht ist, sind sie im vorletzten
   Absatz zu ergaenzen. */
