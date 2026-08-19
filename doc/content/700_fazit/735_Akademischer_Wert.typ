#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

=== Methodischer Beitrag und Übertragbarkeit<sec:methodischerbeitrag>

#kommentar[Frueher ein eigenes Unterkapitel "Akademischer Wert der Arbeit". Der Bewertungsbogen kennt dieses Kriterium nicht, wohl aber Systematik und Verwendung der Literatur, weshalb der Abschnitt jetzt unter der kritischen Wuerdigung steht. Der erste Satz ist an die neue Ueberschrift anzupassen.]

Über den unmittelbaren Anwendungsnutzen hinaus leistet die Arbeit einen Beitrag zur systematischen Auseinandersetzung mit der Integration von #acro("ECPD") in herstellerübergreifende Gebäudemanagementplattformen. Der wissenschaftliche Wert ergibt sich weniger aus der einzelnen Integrationslösung als aus dem methodischen Vorgehen, das zu ihr geführt hat, sowie aus der Übertragbarkeit der gewonnenen Erkenntnisse auf verwandte Problemstellungen.

Ein zentraler Beitrag liegt in der strukturierten Herleitung des Datenmodells. Ausgehend von einer Analyse der System- und Stakeholderanforderungen wurde nachvollziehbar aufgezeigt, welche Datenpunkte der #acro("ECPD") und des SENTRON Powercenters für eine sinnvolle Integration in Desigo CC relevant sind und wie diese über das entwickelte #acro("JSON")-Template auf die Zielplattform abgebildet werden. Damit dokumentiert die Arbeit nicht nur ein Ergebnis, sondern macht den Entscheidungsweg von der Anforderung bis zur konkreten Abbildung transparent und für Dritte reproduzierbar.

Methodisch verbindet die Arbeit anforderungsgetriebene Entwicklung mit einer experimentellen Validierung an einem realen Hardware-Testaufbau. Die Kopplung von konzeptioneller Modellbildung und praktischer Überprüfung erlaubt es, die formulierten Annahmen nicht nur theoretisch zu begründen, sondern empirisch zu belegen oder zu widerlegen. Dieses Vorgehen ist auf die Integration weiterer Geräteklassen über Modbus oder vergleichbare Protokolle übertragbar und liefert damit eine methodische Vorlage, die über den betrachteten Anwendungsfall hinaus Bestand hat.

Darüber hinaus schließt die Arbeit eine dokumentarische Lücke: Die Verknüpfung von Geräteseite (#acro("ECPD"), SENTRON Powercenter), Kommunikationsprotokoll (Modbus) und Managementplattform (Desigo CC) ist in der zugänglichen Literatur bislang nicht in dieser Geschlossenheit beschrieben. Indem die Arbeit diese Aspekte in einem durchgängigen Integrationsvorgehen zusammenführt, stellt sie eine Grundlage bereit, auf der weiterführende Untersuchungen und Entwicklungsarbeiten aufsetzen können.

Schließlich benennt die Arbeit die Grenzen ihres Geltungsbereichs. Die Validierung erfolgte an einem begrenzten Testaufbau unter kontrollierten Bedingungen, sodass sich Aussagen zur Skalierbarkeit und zum Verhalten unter produktiven Lastbedingungen nur eingeschränkt verallgemeinern lassen. Gerade diese explizite Abgrenzung besitzt akademischen Wert, da sie den Rahmen künftiger Forschung absteckt und Anknüpfungspunkte für weiterführende Arbeiten aufzeigt (vgl. @sec:weiterentwicklung).

#kommentar[Hier fehlt noch ein Absatz dazu, was die Quellenlage nach @sec:quellenlage für die Reichweite der Aussagen bedeutet. Kernpunkte: Die technischen Aussagen stützen sich überwiegend auf Herstellerdokumentation und auf eigene Messungen am Testaufbau, nicht auf unabhängig begutachtete Literatur. Die Einordnung des Problems in @sec:standdertechnik ist belegt, die Übertragbarkeit auf andere Gerätefamilien dagegen argumentativ und nicht empirisch gestützt.]
