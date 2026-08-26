#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Umsetzbarkeit im Projektgeschäft<sec:praxistauglichkeit>

Ob eine Integrationsvorlage verwendbar ist, entscheidet sich daran, was sich mit ihr in einem Projekt tatsächlich ausliefern lässt. Der folgende Abschnitt gewichtet die Ergebnisse aus @sec:anforderungsabgleich und @sec:befunde unter diesem Gesichtspunkt.

Die Anbindung selbst ist mit der Vorlage ohne besonderen Aufwand zu leisten. Die Typbeschreibung wird eingelesen, je physischem Gerät entsteht eine Instanz, und die Adressierung beschränkt sich auf die Kommunikationsparameter des Strangs. Messwerte, Zählerstände, Stammdaten und der Schalterzustand erscheinen vollständig und richtig beschriftet, Schaltbefehle werden ausgeführt und quittiert. Damit tragen die Anwendungsfälle der Überwachung, der Auswertung, der Wartungsvorbereitung und der Bedienung, also UC-01, UC-02, UC-05, UC-06, UC-08, UC-09 und UC-10. Eine grundlegende Beobachtung eines Verteilers aus der Leitwarte ist erreichbar, und zwar in einem Umfang, der ohne Vorlage in jedem Projekt neu zu erarbeiten wäre.

Der Anwendungsfall, der eine Leitwartenanbindung im Betrieb rechtfertigt, bleibt gleichwohl offen. Ohne einzeln auswertbare Meldungen ist eine Störung weder nach Dringlichkeit einzuordnen noch zu quittieren, womit UC-03 und mit ihm FA-04 und FA-05 unerfüllt bleiben. Was in Desigo CC ankommt, ist eine Zahl, deren Bedeutung sich erst über @tab:apx_ecpd_alarme erschließt. Ein solcher Datenpunkt wird im Betrieb nicht beobachtet. Der Nutzen der Anbindung beschränkt sich damit auf Beobachtung und Auswertung und erreicht die Störungsbearbeitung nicht, also gerade jene Aufgabe, für die ein Schutzgerät steht.

Diese Grenze ist keine Eigenheit der hier entwickelten Lösung. Die Geräte, welche die Erweiterung des SENTRON Powermanagers bereits führt, bilden irhe Zustände innerhalb des Objektmodells ab. Sie lassen sich in Desigo CC über einen Managementstationsalarm auslösen, weil ihre Zustände als einzeln prüfbare Eigenschaften vorliegen. Genau dieser Weg steht dem #acro("ECPD") nicht offen, da sämtliche Meldungen in einem Sammelregister liegen und sich ohne Maskierung nicht zuverlässig gegen einen Wert prüfen lassen (siehe @sec:umsetzung). Der Unterschied liegt somit in der Form, in der das Gerät seine Zustände bereitstellt.

Der fehlenden Zähler der elektrischen Arbeit stellt zusätzlich eine Lücke dar. Für die Anbindung eines Endstromkreises an ein Energiemanagement ist er die spürbarste Lücke, sie ist jedoch dem Gerät zuzurechnen und nicht dem Modell. Eine Integration der Wirkleistung über die Zeit in Desigo CC bleibt eine Näherung, die bei schaltenden Lasten und einem Abtastintervall von einer Sekunde keine Genauigkeit erreicht, auf die sich eine Verbrauchsabrechnung stützen ließe. Eine Nachbesserung ist auf der Geräteseite zu leisten und liegt außerhalb des Rahmens dieser Arbeit.

Für das Projektgeschäft ergibt sich damit eine geteilte Bewertung. Als Vorlage für die Anbindung ist das Modell einsetzbar und nimmt dem Errichter die wiederkehrende Zuordnungsarbeit ab, die nach @src:wang2018 einen erheblichen Anteil des Projektierungsaufwands ausmacht. Als vollständige Leitwartenanbindung eines Schutzgeräts trägt es derzeit nicht, solange die Alarmierung nicht einfach möglich ist und dafür die Voraussetzung im Objektmodell nicht gegeben ist. Welcher wirtschaftliche Nutzen unter dieser Einschränkung verbleibt, behandelt @sec:nachhaltigkeit.

/* Claude: Abschnitt aus den vier Stichpunkten des Autors ausformuliert. Der
   Hinweis auf den wirtschaftlichen Nutzen im folgenden Kapitel ist als Verweis
   auf @sec:nachhaltigkeit umgesetzt. Die Aussage zu den bereits in der
   Powermanager-Erweiterung gefuehrten Geraeten stuetzt sich auf die Angabe des
   Autors und ist ohne Beleg gefuehrt; falls dafuer eine Quelle vorliegt, ist
   sie im dritten Absatz zu ergaenzen.

   Die uebergeordnete Ueberschrift "Bewertung der Praxistauglichkeit" ist
   entfallen, da sie nur dieses eine Unterkapitel trug. Das Label
   sec:praxistauglichkeit ist auf die verbliebene Ueberschrift uebernommen, da
   @sec:nachhaltigkeit zweimal darauf verweist; sec:umsetzbarkeit war nirgends
   referenziert und ist weggefallen. */
