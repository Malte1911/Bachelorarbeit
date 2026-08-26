#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Kritische Würdigung<sec:wuerdigung>

/* Anmerkung des Autors, erledigt: "Die folgenden Punkte sind in @sec:befunde
   erstmals zu belegen und hier nur noch zu gewichten, damit der Leser sie nicht
   erst im Fazit zum ersten Mal erfaehrt." */

Die Arbeit ist an ihrem eigenen Anspruch zu messen, eine Vorlage zu liefern, mit der sich die Gerätereihe ohne erneute Grundlagenarbeit an Desigo CC anbinden lässt. Der folgende Abschnitt benennt zuerst die Grenzen dieses Ergebnisses und ordnet anschließend ein, was von dem Vorgehen über den betrachteten Fall hinaus Bestand hat.


=== Grenzen der Lösung

Drei Grenzen wiegen schwer, und sie teilen eine Eigenschaft. Keine von ihnen liegt in der Auswahl der Datenpunkte oder in ihrer Abbildung, also in dem Teil, den diese Arbeit gestaltet hat. Sie liegen an den beiden Enden der Strecke, am Gerät und an der Zielplattform. Für denjenigen, der die Vorlage einsetzt, ändert diese Zuordnung nichts, denn er erhält das Ergebnis und nicht dessen Begründung.

Am schwersten wiegt, dass die Alarme nicht als einzelne Meldungen in der Leitwarte ankommen. Das Sammelregister wird vollständig übertragen, die Information ist also vorhanden und über @tab:apx_ecpd_alarme bitweise zu deuten. Was fehlt, ist ihre Umwandlung in eine Meldung, die sich einordnen und quittieren lässt, und diese bleibt eine von Hand zu leistende Projektierung je Anlage. Das trifft die Vorlage an ihrem Zweck, denn eine wiederverwendbare Beschreibung, die den aufwendigsten Teil der Einrichtung gerade nicht mitnimmt, verkürzt den Projektierungsaufwand nur zum Teil. Zu betonen bleibt, dass die Grenze bei der Auswertung liegt und nicht bei der Übertragung.

Die zweite Grenze betrifft das Abfrageintervall, das sich nach @sec:befunde allein am Modbus-Treiber und dort für sämtliche angebundenen Geräte einstellen lässt. Die Auswahl unterscheidet die Datenpunkte nach der erforderlichen Aktualität, das Modell kann diese Unterscheidung jedoch nicht ausdrücken, weshalb Stammdaten und Zählerstände im selben Takt gelesen werden wie der Schalterzustand. FA-02 bleibt damit teilweise erfüllt. Spürbar wird die Grenze erst mit der Größe der Anlage, da der am schnellsten benötigte Wert die Last aller übrigen bestimmt. Sie ist zugleich der Grund, weshalb die in @sec:datenpunkte begründete Reduktion nicht der Übersicht dient, sondern der Abfragelast.

Die dritte Grenze ist streng genommen keine der Arbeit. Dem #acro("ECPD") fehlt eine Zählfunktion für die elektrische Arbeit, weshalb sie auch in Desigo CC fehlt, denn ein Datenmodell kann nur abbilden, was das Gerät führt. Die Feststellung gehört gleichwohl hierher. Ein Schutzgerät, das Strom, Spannung und Wirkleistung je Abgang misst, weckt die Erwartung einer Verbrauchsauswertung, und an dieser Erwartung wird die Anbindung gemessen und nicht an der Frage, welche Komponente die Lücke zu verantworten hat. Adressat dieser Feststellung ist die Produktentwicklung.

Daneben stehen zwei kleinere Einschränkungen, die in der Anwendung dennoch auffallen. Zeichenketten sind nicht beschreibbar, weshalb Anlagenkennzeichen und Einbauort in der Leitwarte sichtbar, aber nur über SENTRON Powerconfig zu ändern sind, was UC-10 begrenzt. Und die beiden schaltenden Kommandos sind als schreibende Werte ausgeführt, da eine Schaltfläche den anstehenden Zustand nicht anzeigt und nur in eine Richtung wirkt (siehe @sec:uebernahme). Beides ist hinnehmbar, gehört aber in die Unterlage und sollte nicht erst im Betrieb auffallen.

In der Summe trägt das Modell dort, wo es Daten bereitstellt, und es endet dort, wo aus diesen Daten eine Handlung werden soll.

/* Claude: Abschnitt aus den drei Stichpunkten des Autors ausformuliert. Die
   Befunde selbst sind nicht wiederholt, sondern nur gewichtet und jeweils auf
   @sec:befunde zurueckgefuehrt, wie es die Anmerkung des Autors verlangt.

   Ergaenzt sind zwei kleinere Einschraenkungen aus @sec:umsetzung und
   @sec:uebernahme, die nicht in den Stichpunkten standen, dem Anwender aber
   begegnen. Falls sie hier zu weit fuehren, ist der vorletzte Absatz
   ersatzlos zu streichen.

   Die Bewertung des fehlenden Zaehlers ist sachlich gefuehrt und nicht als
   Abwertung des Produkts. Der Adressat ist ausdruecklich die
   Produktentwicklung, womit die Aussage in @sec:weiterentwicklung anschliesst. */
