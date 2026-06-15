#import "../../config/acronyms.typ": *
#include "../../config/config.typ"


== Entwicklung der Elektronik <electronics>
/* - komplette entwicklung in Horizon EDA mit LTSpice für Simulation
- capability rules von JLCPCB (quelle raussuchen) werden verwendet und in Horizon eingefügt, fertigung der Platinen auch bei JLCPCB
- Proof of Concept mit Thor bei allen Platinen, für reguläre Tests wird immer eine Last verwendet, die im Verein verfügbar ist. Die kann Strom limitieren und auch Spannung usw messen
- generell: DCDC muss 1 Stunde auf entsprechender Last funktionieren --> mit Puffer wird der ungefähr so lange anbleiben im Rennen, da natürlich nicht auf Volllast die ganze Zeit aber der muss das halt aushalten so
 */
Die Entwicklung der elektronischen Baugruppen des #acro("DVPC") erfolgt vollständig in Horizon EDA @horizoneda, begleitet von Simulationen einer Teilschaltung in LTSpice @ltspice. Als Fertiger der #acro("PCB") wird JLCPCB eingesetzt @jlcpcb, dessen Capability Rules direkt in Horizon EDA eingebunden werden, um eine fertigungsgerechte Auslegung der Leiterplatten sicherzustellen /* Claude: Quelle für JLCPCB Capability Rules: https://jlcpcb.com/capabilities/pcb-capabilities — [TODO Quelle JLCPCB Capabilities] */ @jlccapabilities.

Alle Platinen werden funktional zunächst als Proof of Concept am Jetson Thor verifiziert. Für die regulären Lasttests wird eine im Verein verfügbare elektronische Last verwendet, über die sowohl der Ausgangsstrom begrenzt als auch Spannung, Strom und Leistung zeitaufgelöst erfasst werden können. Als grundlegende Anforderung wird festgelegt, dass die DCDC-Platine mindestens eine Stunde bei der vorgesehenen Last stabil betrieben werden kann. Diese Anforderung ergibt sich aus der typischen Betriebsdauer des Fahrzeugs während eines Rennens. Obwohl im Rennbetrieb nicht durchgehend die maximale Last abgerufen wird, muss die Baugruppe diesen Lastpunkt als konservative Auslegungsgröße dauerhaft ertragen können.

=== Auswahl des DCDC-Boards
/* - wechsel des konzepts zu jetson thor --> geringere Leistungsaufnahme, Auslegung vom DCDC auf ca 150 W, etwas mehr wäre gut
- auslegung auf 12 V out
- begrenzte Optionen in diesem segment, es wird I6A4W020A033V-005-R gewählt wegen gewicht, andere optionen haben mehr gewicht --> insgesamt auch kleinerer DCDC mit nur 250 W
- andere optionen zum verschalten mit anderen sachen, grundsätzlich aber wie i7A48020A033V-003-R, trim widerstände unterscheiden sich zwischen den beiden und so weiter aber nichts großes --> schematic war sowieso noch nicht angefangen das heißt kein problem
 */
Mit der Umstellung des Gesamtkonzepts auf den Jetson Thor verändert sich die Leistungsanforderung an den DCDC-Wandler deutlich. Aufgrund der im Vergleich zum Zotac signifikant geringeren Leistungsaufnahme des Thor wird die Auslegung des DCDC-Boards auf eine Ausgangsleistung von etwa $150 space.thin W$ reduziert. Ein moderater Zuschlag über diesen Wert hinaus ist wünschenswert, um Lastspitzen sicher abfangen zu können. Die Ausgangsspannung wird zunächst auf $12 space.thin V$ festgelegt, da dies zu diesem Zeitpunkt sowohl die Versorgungsspannung des Jetson Thor als auch der LidarPCB abdeckt.

In der betrachteten Leistungsklasse steht nur eine begrenzte Zahl geeigneter Module zur Verfügung. Die Auswahl fällt auf den TDK-Lambda I6A4W020A033V-005-R, da dieser im Vergleich zu den übrigen Alternativen das geringste Gewicht aufweist und in einer kompakteren Bauform als der größere I7A48020A033V-003-R erhältlich ist @i6adcdc/* Claude: Quelle Datasheet I6A: https://product.tdk.com/en/search/power/switching-power/dc-dc-converter/info?part_no=I6A4W020A033V-005-R — [TODO Quelle Datasheet I6A] */. Die maximale Ausgangsleistung des gewählten Moduls liegt bei etwa $250 space.thin W$ und damit deutlich über dem im Betrieb erwarteten Arbeitspunkt /* PLACEHOLDER: exakter Wert laut Datenblatt bestätigen */.

// Zusätzlich zu dieser Variante werden mit dem I7A48020A033V-003-R kompatible Alternativen geprüft, die sich im Wesentlichen nur durch die Dimensionierung der Trim-Widerstände und geringfügig abweichende Pinbelegungen unterscheiden @tdkdcdc. Zum Zeitpunkt der Entscheidung ist das Schematic noch nicht erstellt worden, sodass ein späterer Wechsel zwischen den beiden Modulen ohne nennenswerten Mehraufwand möglich ist.

=== Testplatine
/* - erst wird Testplatine entworfen um funktion von allem zu testen und von da aus soll dann wirklich funktionierende platine entwickelt werden
 */
Um die prinzipielle Funktion der Beschaltung unter realen Bedingungen zu validieren, wird zunächst eine Testplatine entworfen und aufgebaut. Auf Basis der Ergebnisse dieser Testplatine werden anschließend iterativ die finalen Platinenvarianten entwickelt, die im Fahrzeug zum Einsatz kommen.

==== Entwurf des Schematas
/* - DCDC zentrales Bauteil
- sowohl DCDC als auch Thor sollen ein und ausschaltbar sein
- Automation Header auf Thor kann verwendet werden (doku quelle einfügen) --> wird in schematic doppelt mit unterschiedlichen steckern hinzugefügt um sicherzustellen, dass man mit der platine an den header kommt aber selbst auch noch dinge verändern kann wie zum beispiel jumper ein und ausstecken (auf dem anderen header dann)
- pin wird mit mosfet getoggelt von RCU aus (palceholder für schematic) und auf gnd gezogen
- schutz vor overvoltage mit Zenerdiode --> spätere Designs haben noch mehr sicherheitseinrichtungen um mosfet zu schützen
- pin header wird hinzugefügt um manuell brücken zu können
- schaltlogik des on off pins vom DCDC laut datenblatt mit mosfet (2n7002) --> normaler schaltmosfet für Logiksignale
- DCDC soll an sein wenn DCDC eingesteckt wird und dann von RCU nur ausgeschaltet werden --> RCU schaltet zwischen high impedance (HZ akronym hinzufügen) und ground (open drain)
- Spannungsteiler wird verwendet um mosfet standardmäßig einzuschalten um den pin auf ground zu ziehen --> spannung soll bei ca 3 V am mosfet laut datenblatt (quelle palceholder) damit er sicher toggled, deswegen von 48 V mit Spannungsteiler zwischen 180kohm und 12kohm (claude: bitte rechnung einfügen)
- geht RCU auf ground wird mosfet ausgeschaltet und wird hochohmig --> dcdc sollte ausgehen
- wird in LTSpice simuliert um Funktionsfähigkeit sicherzustellen
- dieses setup ermöglicht, dass wenn RCU nicht eingesteckt ist (zum Beispiel in Setup auf dem Tisch wenn DVPC nicht im Auto) der DCDC trotzdem funktioniert und der DVPC verwendet werden kann (auch hier wieder ne zener diode mit 3,9V --> durchbricht wenn Spannung an Gate deutlich höher als soll ist uind limitiert spannung)
- Alle eingänge bekommen ESD-Dioden
- Rup (trim widerstand) kann Datenblatt entnommen werden
- mischung aus elektrolyt und keramik kondensatoren für ein und ausgangsimpedanzen (claude: bitte nach quelle suchen um das zu belegen) wegen esr und so
- schlussendlich werden zwei elektrolyt und zwei keramik vor und hinter dem DCDC verbaut, 100 uF jeweils auf elektrolyt und 10 uf jeweils auf keramik --> was drauf verlötet wird dann immer noch andere sache
- als stecker werden sonst nur nanofit verwendet --> strom etwas knapp bei thor v out aber mit den richtigen kabeln sollte das klappen, nanofit standard im verein und flexibel
- zwei pin nanofit zur spannungsmessung auf platine, vier pin für thor --> thor seitig ist auch vier pin (microfit) verbaut, braucht dann kein sketchy crimpen von einem auf zwei crimps oder so und strom pro kabel ist geringer
- 2 pin megafit damit er anders ist als andere zwei pin stecker --> sicherstellen dass alles richtig eingesteckt wird
- anderer vierpin wird mit natural key (einsteckschutz) gelayoutet um verpolung zu vermeiden, das ist der stecker auf dem die RCU dann angeschlossen wird
- sync und power good option sind beides optionale features, werden nicht verwendet am DCDC, rest wird datenblatt entsprechend verschaltet
 */
Das zentrale Bauteil des Schematas bildet der DCDC-Wandler. Sowohl der Wandler selbst als auch der Jetson Thor sollen unabhängig voneinander ein- und ausgeschaltet werden können, um im Betrieb und bei der Fehlersuche gezielt einzelne Teilbaugruppen deaktivieren zu können. Zur Ansteuerung des Thor wird der Automation Header auf dessen Carrierboard verwendet @jetsondocumentation. Der Header wird im Schematic doppelt mit zwei unterschiedlichen Steckervarianten angelegt. Auf diese Weise ist sowohl eine direkte Verbindung von der DCDC-Platine zum Automation Header gewährleistet als auch die Möglichkeit gegeben, parallel manuell Jumper zu setzen oder zu entfernen.

Das Toggeln des Enable-Pins des Thor erfolgt von der #acro("RCU") aus über einen MOSFET, der den Pin nach Masse zieht. In @schematicthortoggle ist der entsprechende Ausschnitt des Schematas dargestellt.

#figure(
  image("../../resources/img/schematicthortoggle.png", width: 80%, format: "png"),
  caption: [Schematic-Ausschnitt der Toggle-Schaltung des Enable-Pins des Jetson Thor mit MOSFET und Ansteuerung durch die #acro("RCU")]
)<schematicthortoggle>

Zum Schutz des MOSFET gegen Überspannungsspitzen am Gate wird eine Zenerdiode vorgesehen. Spätere Designs erhalten zusätzliche Schutzmaßnahmen, insbesondere weitere Dioden zur Gate-Source-Beschaltung. Zur manuellen Überbrückung der Toggle-Logik wird zusätzlich ein Pin-Header eingefügt, mit dem sich der Enable-Pin im Bedarfsfall ohne MOSFET-Ansteuerung auf das gewünschte Potential setzen lässt.

Die Schaltlogik des On/Off-Pins des DCDC-Wandlers wird nach Herstellerangaben umgesetzt /* Claude: Datasheet Control Logic: [TODO Quelle Datasheet I6A Control Pin] */. Als Schaltelement wird ein 2N7002 eingesetzt, ein verbreiteter Schalt-MOSFET für Logiksignale /* Claude: Quelle 2N7002 Datasheet: https://www.onsemi.com/pdf/datasheet/2n7002-d.pdf — [TODO Quelle 2N7002] */. Das Modul soll grundsätzlich eingeschaltet sein, sobald der DCDC-Wandler mit Spannung versorgt wird, und ausschließlich von der #acro("RCU") abgeschaltet werden können. Die #acro("RCU") schaltet das Steuersignal im Open-Drain-Betrieb zwischen #acro("HZ") und Masse.

Damit der MOSFET im Standardzustand eingeschaltet ist und den Enable-Pin gegen Masse zieht, wird dem Gate über einen Spannungsteiler eine definierte Vorspannung bereitgestellt. Laut Datenblatt wird für ein sicheres Durchschalten eine Gate-Source-Spannung von etwa $3 space.thin V$ benötigt /* Claude: Datasheet 2N7002, Threshold Voltage: [TODO Quelle 2N7002] */@2n7002docs. Ausgehend von der #acro("LV")-Versorgungsspannung von $48 space.thin V$ wird der Spannungsteiler mit $180 space.thin k Omega$ und $12 space.thin k Omega$ dimensioniert. Daraus ergibt sich

$ U_"Gate" = U_"LV" dot R_2 / (R_1 + R_2) = 48 space.thin V dot (12 space.thin k Omega) / (180 space.thin k Omega + 12 space.thin k Omega) = 3 space.thin V. $

Sobald die #acro("RCU") das Steuersignal auf Masse zieht, wird das Gate des MOSFET entladen und der Transistor sperrt. Der Enable-Pin geht dadurch in den #acro("HZ")-Zustand, sodass der DCDC-Wandler abschaltet. Zur Verifikation dieses Schaltverhaltens wird die Schaltung in LTSpice simuliert.

Dieses Setup bietet den wesentlichen Vorteil, dass der DCDC-Wandler auch ohne angeschlossene #acro("RCU") betriebsbereit ist. Damit bleibt der #acro("DVPC") insbesondere im Tisch-Setup außerhalb des Fahrzeugs vollständig nutzbar. Zur zusätzlichen Begrenzung der Gate-Source-Spannung wird parallel zum unteren Zweig des Spannungsteilers eine Zenerdiode mit einer Durchbruchspannung von $3 comma 9 space.thin V$ platziert. Steigt die Gate-Spannung über den Sollwert, bricht die Zenerdiode durch und begrenzt die Spannung am MOSFET auf einen unkritischen Wert.

Zum Schutz gegen elektrostatische Entladungen werden an allen signalführenden Eingängen #acro("ESD")-Dioden vorgesehen. Der Trim-Widerstand $R_"up"$ zur Einstellung der Ausgangsspannung auf $12 space.thin V$ wird dem Datenblatt entnommen /* Claude: Datasheet I6A Trim-Widerstand, [TODO Quelle Datasheet I6A] */@i6adcdc.

Für die Ein- und Ausgangsfilterung wird eine Kombination aus Elektrolyt- und Keramikkondensatoren eingesetzt. Diese Mischbestückung nutzt die hohe Kapazität der Elektrolytkondensatoren bei gleichzeitig niedrigem #acro("ESR") der Keramikkondensatoren im hochfrequenten Bereich, wodurch sowohl niederfrequente Lastwechsel als auch hochfrequente Schaltstörungen des Wandlers wirksam gedämpft werden @mohan1995power @schroeder2019leistungselektronische. Konkret werden vor und hinter dem DCDC jeweils zwei Elektrolytkondensatoren mit $100 space.thin mu F$ sowie zwei Keramikkondensatoren mit $10 space.thin mu F$ vorgesehen. Die endgültige Bestückung wird nach den Messergebnissen der Testplatine festgelegt.

Auf der Steckerseite kommen Molex Nanofit-Steckverbinder @molexnanofit zum Einsatz, da diese im Verein als Standard etabliert sind und eine hohe Flexibilität in der Verkabelung ermöglichen. Für den Ausgang zum Thor ist der maximale Strom pro Kontakt des Nanofit bei $12 space.thin V$ grenzwertig @molexnanofit, lässt sich jedoch mit entsprechend dimensionierten Leitungen realisieren. Zur Spannungsmessung auf der Platine wird ein zweipoliger Nanofit eingesetzt. Für die Versorgung des Thor wird ein vierpoliger Nanofit verwendet, der auf der Thor-Seite mit einem ebenfalls vierpoligen Microfit korrespondiert. Dadurch entfällt ein Crimpen mehrerer Adern auf einen einzelnen Crimp-Kontakt und der Strom pro Leitung wird halbiert.

Für den Eingang wird ein zweipoliger Megafit eingesetzt, der sich durch seine Bauform eindeutig von den übrigen zweipoligen Nanofit-Steckern unterscheidet. Dadurch wird sichergestellt, dass die Versorgungsleitungen nicht versehentlich an einen falschen Port angeschlossen werden können. Der vierpolige Stecker zur #acro("RCU") wird mit einem Natural Key als Einsteckschutz versehen, um eine Verpolung auszuschließen. Die optionalen Features Sync und Power Good des DCDC-Wandlers werden nicht genutzt, die übrige Beschaltung erfolgt entsprechend der Empfehlung im Datenblatt @i6adcdc.

==== Layout der Platine
/* - für testplatine keine platzconstraints deswegen kein fokus auf kompaktes layout --> layout eher groß gebaut und einfach gehalten damit komponenten übersichtlich und einfach getauscht werden können
- DCDC mittig platziert, eingang auf der einen und ausgang auf der anderen Seite
- versehentlich rcu stecker falschherum gelayoutet weil package nicht richtig eingefügt im programm
- ESD Dioden werden nicht gelayoutet, nicht so kritisch für testsetup
- 2 layer platine --> mehr wird nicht gebraucht, keine komplexe logik oder so
- wird geschaut, dass flächen für ground und power sehr groß sind und gut verbunden mit vias zwischen den layers --> niedrige impedanzen für hohe ströme, weniger verlustleistung auf platine --> ströme von etwa 10 A (12V bei ca 130 W) (rechnung inline einfügen) zu erwarten, deswegen sind viele vias um Pads wichtig um niederohmige verbindung zwischen planes herzustellen
- bild placeholder für layout
 */
Für die Testplatine bestehen keine geometrischen Randbedingungen durch den späteren Einbauraum, sodass auf ein kompaktes Layout bewusst verzichtet wird. Stattdessen wird die Platine mit großzügigem Platz zwischen den Bauteilen ausgelegt, um eine gute Zugänglichkeit zu gewährleisten und bei Bedarf einen einfachen Austausch einzelner Komponenten im Rahmen der späteren Tests zu ermöglichen.

Der DCDC-Wandler wird mittig auf der Platine platziert, wobei Ein- und Ausgangsseite auf gegenüberliegenden Seiten der Platine angeordnet werden. Bei der Platzierung des RCU-Steckers fällt im späteren Test auf, dass das in Horizon EDA verwendete Package nicht korrekt eingebunden war und der Stecker infolgedessen spiegelverkehrt gelayoutet wurde. Auf eine Nachbesserung im Layout der Testplatine wird bewusst verzichtet, da die Funktion der übrigen Baugruppe davon nicht beeinträchtigt ist und der Fehler in der Folgeversion ohnehin korrigiert wird. Die #acro("ESD")-Dioden werden im Layout der Testplatine nicht berücksichtigt, da sie für den Laboraufbau unter kontrollierten Bedingungen nicht sicherheitskritisch sind.

Die Testplatine wird als zweilagige #acro("PCB") ausgeführt. Eine höhere Lagenzahl ist nicht erforderlich, da die Schaltung keine komplexe Logik oder dichte Signalführung enthält. Für die Ground- und Power-Flächen wird auf möglichst große Kupferflächen geachtet, die über eine hohe Dichte an Vias zwischen den Lagen verbunden werden. Diese Maßnahme reduziert die Impedanz der Leistungspfade und damit die Verluste auf der Platine. Der im Ausgangspfad zu erwartende Strom ergibt sich zu

$ I_"out" = P / U = (130 space.thin W) / (12 space.thin V) approx 10.8 space.thin A, $

sodass insbesondere um die Leistungspads herum eine ausreichende Anzahl an Vias zur Sicherstellung einer niederohmigen Kopplung zwischen den Flächen notwendig ist @pcbhandbook @ipc2221b. In @layouttestplatine kann das Layout der Testplatine gesehen werden.

#figure(
  image("../../resources/img/layouttestplatine.png", width: 80%, format: "png"),
  caption: [Layout der Testplatine mit mittig platziertem DCDC-Wandler, Ein- und Ausgang auf gegenüberliegenden Seiten sowie großflächigen Ground- und Power-Planes]
)<layouttestplatine>

==== Fertigung und Bestückung
/* - 2 oz kupfer wird gewählt wegen hohen strömen --> mehr Strom über das Kupfer verbessert Widerstand
- Konflikt in Datenblatt bezüglich Eingangsimpendanzen Auslegung, Support kontaktiert --> empfehlen nur Mischung aus Elektrolyt und Keramik, keine direkten Werte vorgegeben
 */
Aufgrund der erwarteten Ströme im Ausgangspfad wird die Platine mit einer Kupferauflage von $2 space.thin"oz"$ gefertigt. Die verdoppelte Kupferdicke gegenüber dem Standardwert von $1 space.thin"oz"$ reduziert den Leitungswiderstand der Power-Planes und damit die ohmschen Verluste auf der Platine @ipc2221b.

Bei der Auslegung der Eingangsimpedanz wird herstellerseitig kein Idealwert im Datenblatt angegeben, nur eine grobe Richtlinie @i6adcdc. Eine Rückfrage beim Hersteller-Support ergibt, dass ausschließlich eine Mischung aus Elektrolyt- und Keramikkondensatoren empfohlen wird, ohne dass konkrete Werte vorgegeben werden /* Claude: Korrespondenz mit TDK-Support — [TODO Referenz Kommunikation] */@tdkbenz. Die konkrete Dimensionierung wird daher anhand der Erkenntnisse mit der Testplatine ermittelt.

==== Test
/* - ein Stecker falschherum gelayoutet
- MegaFit ist Arsch weil es blöd zu crimpen ist und wir nicht so viele davon haben --> Strom wird am Eingang eigentlich gar nicht gebraucht für was der stecker ausgelegt ist
- grundlegende Funktion mit ein und ausschalten geht
- Spannung soweit korrekt
- alle getesteten Lastfälle haben mit den gewählten Impendanzen (placeholder für werte) funktioniert
- DCDC wird zu heiß und schaltet sich nach x Minuten ab bzw. die Spannung bricht ein, weswegen der große DCDC (i7A48020A033V-003-R) dann verwendet wird für zukünftige Designs --> Angabe im Datenblatt so halb wahr, da sind Plots die zeigen, dass der DCDC zwar diese Leistung abgeben kann ohne Konvektion an Luft obendrüber, aber halt nicht langfristig --> kein Vertrauen ab hier mehr in das Datenblatt was Kühlung angeht, deswegen auch großer DCDC: mehr Leistung und dadurch auf einem niedrigeren Lastpunkt, laut Datenblatt dann aber geringere Verlustleistung
- keine Indikatoren ob etwas an ist oder nicht auf Platine --> Indikator LEDs für nächste Iteration
- Prüfprotokoll mit verschiedenen Impedanzen in verschiedenen Konfigurationen wird ausgefüllt, alles soweit erfolgreich (Placeholder für verschiedene eingangs und ausgangsimpedanzen)
 */
Beim Test der aufgebauten Platine werden zunächst zwei Auffälligkeiten bezüglich der Steckerauswahl und -platzierung festgestellt. Zum einen ist der RCU-Stecker spiegelverkehrt platziert. Zum anderen zeigt sich in der Praxis, dass der Megafit am Eingang aufgrund der Crimpgeometrie nur schwer zu konfektionieren ist und im Verein nur in begrenzter Stückzahl verfügbar ist. Da die Stromtragfähigkeit eines Megafit für den Eingangsstrom des DCDC-Wandlers bei $48 space.thin V$ nicht erforderlich ist, wird dieser Stecker in späteren Versionen durch einen Nanofit ersetzt.

Die grundlegende Funktion der Schaltung wird als gegeben bestätigt. Die Toggle-Logik schaltet den DCDC-Wandler wie vorgesehen ein und aus, die Ausgangsspannung liegt im Toleranzband um den Sollwert von $12 space.thin V$. Alle im Prüfprotokoll dokumentierten Lastfälle mit den gewählten Ein- und Ausgangsimpedanzen funktionieren im Rahmen des geprüften Arbeitspunkts /* PLACEHOLDER: konkrete Werte der Ein- und Ausgangsimpedanzen sowie der getesteten Lastpunkte */.

Im Dauerlasttest zeigt sich jedoch eine thermische Begrenzung des gewählten Moduls. Der DCDC-Wandler erwärmt sich so stark, dass er nach wenigen Minuten die Ausgangsspannung absenkt beziehungsweise vollständig abschaltet /* PLACEHOLDER: genaue Zeit bis zum Abschalten und gemessene Gehäusetemperatur */. Eine Prüfung des Datenblatts zeigt, dass die angegebene maximale Ausgangsleistung zwar prinzipiell ohne aktive Konvektion erreicht werden kann, die zugehörigen Plots jedoch dem Schein nach nur Kurzzeitbetrachtungen darstellen /* Claude: Datasheet I6A Thermal Derating Plots: [TODO Quelle Datasheet I6A] */@i6adcdc. Für einen dauerhaften Betrieb bei der geforderten Leistung sind die Angaben im Datenblatt folglich nur eingeschränkt belastbar, was das Vertrauen in die thermischen Spezifikationen des Moduls mindert. Als Konsequenz wird für die nachfolgenden Designs der leistungsstärkere I7A48020A033V-003-R eingesetzt. Dieser ermöglicht es, die gleiche Ausgangsleistung auf einem deutlich niedrigeren relativen Lastpunkt bereitzustellen, wodurch nach Datenblatt eine geringere Verlustleistung im Modul anfällt @tdkdcdc.

Ergänzend zeigt sich, dass auf der Testplatine keine Indikatoren vorhanden sind, um den Betriebszustand des Wandlers visuell zu prüfen. Für die Folgeiterationen ist daher der Einsatz von Indikator-#acro("LED")s vorgesehen.

Die im Rahmen der Tests systematisch durchgeführten Messungen mit verschiedenen Kombinationen aus Ein- und Ausgangsimpedanzen werden in einem Prüfprotokoll dokumentiert. Alle getesteten Konfigurationen werden innerhalb ihres jeweiligen thermischen Rahmens als funktionsfähig bewertet /* PLACEHOLDER: Ergebnisse des Prüfprotokolls mit verschiedenen Ein- und Ausgangsimpedanzen */.

==== Kühlung des DCDC
/* - Kühlkörper aus Alu gefräst
- Wärmeleitpad verwendet
- hält zwar länger, reicht aber bei weitem nicht
 */
Zur Untersuchung der thermischen Grenze wird zusätzlich ein testweise aus Aluminium gefräster Kühlblock auf den DCDC-Wandler gelegt. Als thermisches Interface zwischen Modul und Kühlkörper wird ein Wärmeleitpad eingesetzt. Mit dieser Maßnahme kann die Betriebszeit bis zum thermischen Abschalten zwar verlängert werden, die resultierende Laufzeit liegt jedoch weiterhin deutlich unter der geforderten Stunde Dauerbetrieb /* PLACEHOLDER: gemessene Betriebszeit mit Aluminium-Kühlkörper und Wärmeleitpad */. Dieses Ergebnis bestätigt die Entscheidung, für die späteren Varianten auf den leistungsstärkeren I7A48020A033V-003-R zu wechseln.

#figure(
  image("../../resources/img/kuehltestplatine.png", width: 60%, format: "png"),
  caption: [Aufgebaute Testplatine mit aufgelegten Aluminium-Kühlkörper am DCDC-Wandler mit einem Stück Fasertape zur besseren Messung der Temperatur via Infrarot-Thermometer]
)<kuehltestplatine>

=== Anpassung des Layouts für die V2 Platine
/* - V2 wird auch gefertigt
- grundsätzlich nur ein kompakteres Layout als die Testplatine mit dem kleinen DCDC
- dieser kleine DCDC wird nicht mit Kühlkörper verkauft, weswegen er im Moment nicht in Frage kommt
- Layout wird trotzdem gemacht, da die Platine für andere Komponenten im Auto theoretisch genutzt werden kann
- außerdem besteht die Möglichkeit, dass man noch einen eigenen Kühlkörper für den kleinen DCDC fertigt, dann kann man den theoretisch auch verwenden
- stecker werden gefixt und layout halt angepasst und kompakter gemacht --> Kondensatoren so wie auf Testplatine, sonst gleiches vorgehen wie bei testplatine mit großen Power rails
- wurde verwendet als spannungsquelle für tests am Kabelbaum
- LEDs werden hinzugefügt (Claude: Rechnung einfügen für Spannung die anliegt, Spannung die über die Diode abfällt und Strom um dann auf einen Widerstand zu kommen)
- im Rahmen dieser Arbeit wird diese Platine nicht weiter bearbeitet
- bild placeholder mit fertigem Layout
- QR-Code wird auf die Platine getan damit man auf das Prüfprotokoll und weitere Informationen zu der Platine zugreifen kann
 */
Parallel zur Umstellung auf den größeren DCDC-Wandler wird aus der Testplatine eine kompaktere V2-Variante abgeleitet und ebenfalls gefertigt. Diese Version basiert weiterhin auf dem kleineren I6A4W020A033V-005-R und stellt im Wesentlichen ein auf den tatsächlichen Bauraum reduziertes Layout der Testplatine dar. Da der kleine DCDC-Wandler ab Werk nicht mit Kühlkörper angeboten wird, kommt er zum jetzigen Zeitpunkt nicht als Zielbauteil im Fahrzeug in Frage. Das Layout wird dennoch angefertigt, da die Platine zum einen als Versorgungsquelle für andere Komponenten im Fahrzeug eingesetzt werden kann und zum anderen die Möglichkeit besteht, zu einem späteren Zeitpunkt einen eigens gefertigten Kühlkörper für das Modul zu entwerfen und damit den kleineren Wandler verwendbar zu machen.

Gegenüber der Testplatine werden die Stecker angepasst. Insbesondere der spiegelverkehrt gelayoutete RCU-Stecker wird korrigiert und der Megafit am Eingang durch einen passenden Nanofit ersetzt. Die Kondensatorbestückung entspricht der Testplatine. Auch im Layoutprozess wird analog zur Testplatine auf große Power-Planes mit dichter Via-Vernetzung geachtet. In der Praxis wird die V2 als Spannungsquelle für Tests am Kabelbaum eingesetzt.

Erstmals werden auf der V2 Indikator-#acro("LED")s verbaut, die den Betriebszustand am Ein- und Ausgang anzeigen. Zur Dimensionierung des Vorwiderstands werden eine typische Flussspannung roter #acro("LED")s von etwa $U_"F" = 2 space.thin V$ @weredled/* Claude: typische LED-Flussspannung, [TODO Quelle LED-Datenblatt] */ sowie ein Ziel-Durchlassstrom von $I_"LED" = 10 space.thin m A$ zugrunde gelegt. Mit der Versorgungsspannung der #acro("LED") von $U_"DC" = 12 space.thin V$ am Ausgang des Wandlers ergibt sich der Vorwiderstand zu

$ 
R_"V" = (U_"DC" - U_"F") / I_"LED" = (12 space.thin V - 2 space.thin V) / (10 space.thin m A) = 1 space.thin k Omega. 
$<ledcalc>

Die zugehörige Verlustleistung am Vorwiderstand liegt mit $P_"V" = (U_"DC" - U_"F") dot I_"LED" = 100 space.thin m W$ unkritisch niedrig. Diese Rechnung gilt exemplarisch für alle verwendeten #acro("LED")s, bei denen die Werte entsprechend angepasst werden. 

Ergänzend wird auf der Platine ein QR-Code aufgebracht, der auf das zugehörige Prüfprotokoll und weitere Dokumentationsunterlagen zur Platine verweist.

Im Rahmen dieser Arbeit wird die V2 nicht weiter bearbeitet. In @layoutv2 ist das fertige Layout dargestellt.

#figure(
  image("../../resources/img/layoutv2.png", width: 80%, format: "png"),
  caption: [Fertiges Layout der V2-Platine mit kompakter Anordnung der Bauteile, korrigierten Steckern und Indikator-#acro("LED")s]
)<layoutv2>

=== Umstellung auf den leistungsstärkeren DCDC-Wandler

==== Anpassung des Layouts für die V3 Platine
/* - Aufgrund von Hitze wird der andere (große) DCDC auch gelayoutet
- Andere Kondis werden da gewählt für die große Platine mit größerer Kapazität damit die Platine kompakter wird --> Tests auf der Testplatine mit kleinem DCDC vom gleichen Hersteller haben keinen messbaren Unterschied in Performance gehabt
- wird ins Mockup eingepflegt um Dimensionen zu checken und Accessibility der Stecker zu prüfen
- Casing muss dann nochmal minimal in Z angepasst werden
- aufgrund zeitlicher Constraints ist es hier nicht möglich eine weitere Testplatine für den großen DCDC zu fertigen weswegen direkt die V3 der Platine gefertigt wird
- OCP bei 200 k Ohm für ca 20 A Limit --> Datenblatt nicht gut, für verwendeten DCDC ist der entsprechende Plot nicht drauf sondern nur für einen ähnlichen DCDC, Rückfrage beim Support nicht wirklich hilfreich (placeholder für schlechten und lowkey falschen Plot aus dem Datenblatt)
- LEDs am Eingang und am Ausgang parallel geschaltet --> Dimensionierung auf 10 mA
- Schaltung von toggle LED zwischen 48V mit Widerstand und dem on off signal, Idee: wenn RCU in HZ dann fließt da kein Strom und LED geht nicht an (Placeholder bild für schaltung)
- 1 nF Kondensator wird noch zwischen Gater und Source am Mosfet eingefügt
- MegaFit wird hier auch entfernt und es wird natural und black key nanofit verbaut --> verpolungsschutz von ein und ausgang
- QR-Code wird auf die Platine getan damit man auf das Prüfprotokoll und weitere Informationen zu der Platine zugreifen kann
 */
Aufgrund der festgestellten thermischen Grenzen des kleineren Wandlers wird für die V3 der Platine der I7A48020A033V-003-R gelayoutet @tdkdcdc. Für die Eingangs- und Ausgangsimpedanz werden bei der V3 größere Kondensatoren mit höherer Kapazität ausgewählt. Diese Wahl ermöglicht bei gleicher Filterwirkung eine kompaktere Anordnung auf der Platine, da statt mehrerer kleinerer Kondensatoren einzelne, dichter platzierbare Bauteile verwendet werden können. Vergleichstests auf der Testplatine mit dem kleinen DCDC desselben Herstellers zeigen zwischen beiden Kondensatorkonfigurationen keinen messbaren Performanceunterschied /* PLACEHOLDER: Messwerte des Vergleichstests Klein- vs. Großkondensator */.

Das angepasste Layout wird in das Gesamt-Mockup des #acro("DVPC") eingepflegt, um die Außenabmessungen und die Zugänglichkeit der Stecker bereits in der Konstruktionsphase zu prüfen. Im Zuge dieser Integration wird das Casing minimal in Z-Richtung angepasst, um die größere Bauhöhe des Wandlers samt Kühlkörper aufzunehmen. Aufgrund der zeitlichen Randbedingungen ist es nicht möglich, eine separate Testplatine für den größeren DCDC-Wandler zu fertigen. Stattdessen wird die V3 direkt als produktive Variante umgesetzt.

Als zusätzliche Schutzmaßnahme wird die #acro("OCP") des Wandlers über einen Widerstand von $200 space.thin k Omega$ auf ein Strom-Limit von etwa $20 space.thin A$ konfiguriert /* PLACEHOLDER: genauer Wert laut Datenblatt-Plot */. Das Datenblatt liefert für diesen Einsatzfall jedoch keinen belastbaren Plot des verwendeten Moduls, sondern lediglich einen Plot eines ähnlich aufgebauten Moduls derselben Produktfamilie. Eine Rückfrage beim Support des Herstellers liefert keine zusätzliche Klarheit /* Claude: Korrespondenz mit TDK-Support zur OCP-Kennlinie — [TODO Referenz Kommunikation] */@tdkbenz. Der dem Datenblatt entnommene Plot ist in @ocpplot dargestellt.

#figure(
  image("../../resources/img/ocpplot.png", width: 60%, format: "png"),
  caption: [Aus dem Datenblatt des I7A48020A033V-003-R entnommener Plot zur Dimensionierung der #acro("OCP"), der nur für ein ähnliches, nicht aber das verwendete Modul gültig ist @tdkdcdc]
)<ocpplot>

Die Indikator-#acro("LED")s werden am Ein- und Ausgang parallel zu den jeweiligen Spannungen geschaltet und analog zur V2 auf einen Durchlassstrom von $10 space.thin m A$ dimensioniert. Für die Darstellung des Toggle-Zustands des DCDC wird eine weitere #acro("LED") zwischen der LV-Versorgung und dem On/Off-Signal mit einem zusätzlichen Vorwiderstand eingefügt. Die Überlegung dahinter ist, dass im #acro("HZ")-Zustand der #acro("RCU") der Stromfluss durch die #acro("LED") unterbrochen wird, sodass sie nicht leuchtet, während sie bei aktiv durch die #acro("RCU") auf Masse gezogenem Signal mit Strom durchflossen wird und damit den aktiven Toggle-Zustand anzeigt. Die entsprechende Schaltung ist in @toggleledv3 gezeigt.

#figure(
  image("../../resources/img/toggleledv3.png", width: 80%, format: "png"),
  caption: [Schaltung der Toggle-#acro("LED") der V3-Platine zwischen $48 space.thin V$-Versorgung und On/Off-Signal der #acro("RCU") mit Vorwiderstand]
)<toggleledv3>

Zum verbesserten Schutz des MOSFET wird zusätzlich ein Kondensator mit $1 space.thin n F$ zwischen Gate und Source eingefügt, der hochfrequente Transienten auf das Gate-Potential dämpft. Der Megafit am Eingang wird entfernt und durch einen Nanofit ersetzt. Sowohl der Eingangs- als auch der Ausgangsstecker werden mit unterschiedlichen Keys ausgeführt – Natural Key am Ausgang und Black Key am Eingang – um eine Verwechslung von Ein- und Ausgangssteckern beim Anschluss auszuschließen. Wie bei der V2 wird auch auf der V3 ein QR-Code zur Verknüpfung mit dem Prüfprotokoll und der begleitenden Dokumentation aufgebracht.

==== Fertigung und Bestückung der V3 Platine
/* - Fertigung mit 1 oz Kupfer
- Rücksprache mit Hersteller von Lidar --> stellt sich heraus, dass der Lidar und die LidarPCB auch mit 24 V betrieben werden kann, trim widerstand wird auf x ohm angepasst und die Widerstände vor den LEDs auch --> großer Vorteil weil insgesamt weniger Strom am Ausgang --> weniger Verluste (Claude: bitte einmal hier richtige Formeln noch mit Quellen einfügen)
- mit Stencil gelötet, größerer DCDC wird zuerst gelötet und getestet
- alles SMD Bauteile werden direkt mit Stencil aufgelötet, große Kondensatoren werden danach zusammen mit DCDC gelötet
- Erhöhung der Spannung auf 24V --> hat sich jetzt herausgestellt, dass das funktioniert das war vorher nicht ganz sicher weswegen auf 12 V ausgelegt wurde, Widerstände werden dem Datenblatt entsprechend angepasst auf finale 270 Ohm
- natural key nicht verfügbar, deswegen wird mit black key bestückt alles
 */

Parallel zur Fertigung der V3 erfolgt eine Rücksprache mit dem Hersteller des Lidar, aus der hervorgeht, dass sowohl der Lidar als auch die LidarPCB alternativ mit $24 space.thin V$ anstelle der ursprünglich angenommenen $12 space.thin V$ betrieben werden können /* PLACEHOLDER: Referenz Lidar-Hersteller-Dokumentation bzw. Kommunikation */. Die Anhebung der Ausgangsspannung bringt einen signifikanten Vorteil im Gesamtsystem: Bei gleichbleibender übertragener Leistung halbiert sich bei Verdopplung der Spannung der Ausgangsstrom gemäß


$ I = P / U. $

Da die ohmschen Verluste auf den Leitungen sowie den Power-Planes der Platine quadratisch vom Strom abhängen,

$ P_"Verl" = I^2 dot R, $

ergibt sich bei halbiertem Strom eine Reduktion der Verluste auf ein Viertel des ursprünglichen Wertes @mohan1995power @schroeder2019leistungselektronische. Daraus resultiert sowohl eine geringere thermische Belastung der Leiterbahnen als auch ein höherer Gesamtwirkungsgrad der Versorgungsstrecke. Entsprechend wird der Trim-Widerstand an die neue Ausgangsspannung angepasst. Nach Abgleich mit dem Datenblatt des Wandlers wird der finale Wert auf $270 space.thin Omega$ festgelegt @tdkdcdc. Ebenso werden die Vorwiderstände der #acro("LED")s auf die neue Ausgangsspannung angepasst.

Die Bestückung erfolgt mittels Schablone. Alle #acro("SMD")-Bauteile werden in einem ersten Schritt über die Schablone pastiert und gemeinsam aufgelötet. Der DCDC-Wandler selbst sowie die großen Elektrolytkondensatoren werden aufgrund ihrer Bauform in einem zweiten Schritt nachträglich eingesetzt. Der größere DCDC-Wandler wird zuerst aufgelötet und auf grundlegende Funktion geprüft, bevor die übrigen Bauteile bestückt werden, um Fehler frühzeitig zu erkennen. Da der ursprünglich vorgesehene Natural Key für den Ausgangsstecker zum Bestückungszeitpunkt nicht verfügbar ist, werden stattdessen alle Stecker mit Black Key bestückt. Diese Abweichung wird im Prüfprotokoll vermerkt.

==== Test der V3 Platine
/* - großer DCDC mit Kühlplatte ausreichend, funktioniert länger als eine Stunde, ohne Kühlkörper nur x minuten --< Dokumentation in Prüfprotokoll mit Zeiten wie lange es hält, Eingangs unnd Ausgangsspannungen und Strömen
- 24 V hat die grüne LED noch gefetzt, die wurde mit einem größeren Widerstand ersetzt und dann neu beschaltet, war dann immer noch sehr hell --> Auslegung auf 15 mA, ist aber anscheinend immer noch zu viel deswegen muss das noch runter dann
- LEDs insgesamt sehr hell, werden erneut eingesetzt mit Dimensionierung auf 1 mA (Claude: Referenz auf vorherige Rechnung die oben eingefügt ist)
- LED für den Toggle funktioniert nicht ist konstant eingeschaltet, toggle an sich funktioniert --> Widerstand über Spannungsteiler an Mosfet anscheinend klein genug dass der strom da abfließen kann und die LED konstant leuchtet, egal ob HZ oder Ground
- Pins für Thor sind zwar dran aber nicht wirklich dienlich für irgendwas, deswegen ist die Überlegung das noch zu entfernen
- Kondis können verkleinert werden
- Test mit großem DCDC mit 1mF Kondis in Klimakammer: beim Einschalten für mehrere Sekunden springt Spannung hin und her unm Strom liefern zu können --> kann in späteren Tests nicht reproduziert werden, weswegen nicht ganz klar ist wo das Problem herkommt --> Hoffnung auf einmaliges Vorkommen, wäre im Zweifel auch nicht so schlimm, da so ein extremer Lastsprung im Auto eigentlich nicht vorkommen kann
- Idee: Kondis verkleinern um merkwürdige Lade- und Entladekurve bei Lastsprüngen zu verhindern
- Problem in Klimakammer wenn es so ist: enorme Konvektion, d.h. keine gute Simulation der Umgebungsbedingungen da Abwärme abgeleitet wird trotz höherer Temperatur
- erneute Tests mit übergestülptem Casing mit Raumtemperatur außen ohne Konvektion mit DCDC innen --> close enough um an das ranzukommen, wie es auch im auto sein wird (placheolder bild)
- Test mit übergestülptem Casing: Casing wird über DCDC ungefähr 60 Grad heiß, das ist zwar nicht ideal aber es funktioniert, Rest vom Casing bei 30 Grad was im Rahmen ist
- nach Tests wird Temperatur gemessen an DCDC, ähnliche Werte wie in offenem Setup
- Funktionstests soweit erfolgreich bis eben auf LED, sonst funktioniert alles
 */
Im Dauerlasttest zeigt sich, dass der größere DCDC-Wandler in Kombination mit der integrierten Kühlplatte die geforderte Laufzeit von mehr als einer Stunde stabil erreicht. Ohne Kühlkörper lässt sich der Wandler dagegen nur für wenige Minuten betreiben /* PLACEHOLDER: konkrete Zeiten, Ein- und Ausgangsspannungen sowie Ströme im Prüfprotokoll */. Die Messwerte werden im zugehörigen Prüfprotokoll hinsichtlich Standzeit sowie Ein- und Ausgangsspannungen und -strömen dokumentiert.

Bei der Spannungserhöhung auf $24 space.thin V$ zeigt sich, dass die grüne Indikator-#acro("LED") am Ausgang deutlich zu hell leuchtet und nach kurzer Betriebsdauer ausfällt. In einem ersten Schritt wird der Vorwiderstand angehoben, sodass der Durchlassstrom rechnerisch auf $15 space.thin m A$ reduziert wird /* PLACEHOLDER: konkreter Widerstandswert für 15 mA bei 24 V */. Auch mit dieser Anpassung ist die Leuchtkraft jedoch weiterhin zu hoch. Da die Blickrichtung auf die Platine im eingebauten Zustand ohnehin eng begrenzt ist und bereits sehr kleine Ströme zur optischen Signalisierung ausreichen, werden die #acro("LED")s analog zur Rechnung in @ledcalc auf einen Durchlassstrom von $1 space.thin m A$ dimensioniert /* PLACEHOLDER: konkreter Widerstandswert für 1 mA bei 24 V */.

Die Toggle-#acro("LED") funktioniert in der umgesetzten Schaltung nicht wie vorgesehen. Sie leuchtet konstant, unabhängig vom Schaltzustand der #acro("RCU"), obwohl das Toggeln des DCDC-Wandlers selbst funktioniert. Die Analyse ergibt, dass der im Spannungsteiler am Gate des MOSFET eingesetzte obere Widerstand niederohmig genug ist, um auch im #acro("HZ")-Zustand der #acro("RCU") einen ausreichenden Strom zum Leuchten der #acro("LED") durchzulassen. Eine saubere Trennung des Toggle-Signals von der Indikator-Schaltung ist mit der vorliegenden Topologie nicht möglich. Eine Lösung wäre ein separater, ausschließlich zur Ansteuerung der #acro("LED") vorgesehener MOSFET.

Die auf der Platine vorgesehenen Pin-Header zur Abgriffsmöglichkeit am Automation Header des Thor erweisen sich im praktischen Einsatz als wenig zweckmäßig, da die eigentliche Verbindung bereits über einen direkten Stecker hergestellt wird. Sie sollen daher in der nächsten Iteration entfernt werden. Darüber hinaus zeigt sich, dass die Kapazität der Ein- und Ausgangskondensatoren reduziert werden kann, ohne die Filterwirkung relevant zu verschlechtern.

Bei einem Test der V3 mit $1 space.thin m F$ Kondensatoren in der Klimakammer mit der elektronischen Last tritt beim Einschalten ein mehrere Sekunden andauerndes Oszillieren der Ausgangsspannung auf, während der Wandler den geforderten Strom bereitstellt. In allen nachfolgenden Tests kann dieses Verhalten nicht reproduziert werden, sodass die Ursache nicht eindeutig bestimmt werden kann. Das Phänomen wird als Einzelfall bewertet. Ein vergleichbar abrupter Lastsprung ist im Fahrzeugbetrieb nicht zu erwarten, da die angeschlossenen Verbraucher über definierte Einschaltsequenzen hochgefahren werden. Als zusätzliche Gegenmaßnahme wird überlegt, die Kondensatoren zu verkleinern, um das Lade- und Entladeverhalten bei Lastsprüngen zu dämpfen.

Ein weiterer Einflussfaktor bei den Tests in der Klimakammer ist die dort vorherrschende erzwungene Konvektion durch die Luftumwälzung. Diese verfälscht die thermische Randbedingung erheblich, da trotz erhöhter Umgebungstemperatur die Abwärme vom Modul deutlich besser abgeführt wird als im Casing des Fahrzeugs. Um eine realitätsnähere thermische Umgebung zu erzeugen, werden ergänzende Tests bei Raumtemperatur mit übergestülptem Casing durchgeführt. Im so geschaffenen Luftvolumen ohne erzwungene Konvektion nähert sich die thermische Randbedingung dem im Fahrzeug vorliegenden Fall an. Der Versuchsaufbau ist in @casingtest dargestellt.

#figure(
  image("../../resources/img/casingtest.jpeg", width: 60%, format: "jpg"),
  caption: [Testaufbau mit über die V3-Platine und den DCDC-Wandler gestülptem Casing zur Simulation der thermischen Randbedingungen ohne erzwungene Konvektion und einer Rolle Lötzinn als Beschwerung, damit das Casing sauber aufliegt]
)<casingtest>

Im Test mit übergestülptem Casing erreicht die Oberseite des Casings über dem DCDC-Wandler eine Temperatur von etwa $60 space.thin degree C$, während die übrigen Bereiche des Casings bei rund $30 space.thin degree C$ liegen /* PLACEHOLDER: exakte Temperaturmesswerte */. Dieses Ergebnis wird als im Rahmen der Spezifikationen der verbauten Komponenten liegend bewertet. Eine nachträgliche Messung direkt am DCDC-Wandler ergibt vergleichbare Werte wie im offenen Aufbau mit Kühlplatte, sodass die Kühlleistung auch unter den eingeschränkten Konvektionsverhältnissen ausreichend ist. Insgesamt sind die Funktionstests der V3 mit Ausnahme der nicht wie vorgesehen funktionierenden Toggle-#acro("LED") erfolgreich.

==== Entwurf der V3.1 Platine
/* - Layout minimal überarbeitet
- LED wird anders gelayoutet, diesmal zwischen DCDC Toggle von RCU und Masse mit invertierter Logik
- Pin Header für den Thor werden entfernt, da sie keinen wirklichen Nutzen haben, wenn man nicht den Mosfet an den Steckern hat dann braucht man die Stecker insgesamt eigentlich nicht
- zusätzlicher Stecker wird hinzugefügt um möglicherweise einen 24 V Lüfter noch anzuschließen
- der Stecker an die RCU bekommt auf den freien Pin 24 V, vorher war da GND drauf --> können zur Spannungsplausibilisierung genutzt werden um festzustellen, ob der DCDC an ist
- es werden Sicherungshalterungen für Fuses eingebaut für den Lidar und den potenziellen zusätzlichen Lüfter, damit im Kurzschlussfall nichts kaputt geht
- Thor wird nicht extra gefused, wenn der Probleme macht schaltet die RCU das gesamte Board aus, da sind auch Sicherungen drauf --> dann fährt das auto sowieso nicht mehr
- Stecker werden weiter auseinander positioniert um sicherzustellen, dass die Stecker sauber reinpassen nach Außen hin
- vertikale Nanofit werden hinten noch hinzugefügt, einmal für den Lidar und dann nochmal einen extra falls man doch noch einen Lüfter brauchen sollte
- generell wird beschriftung angepasst damit auf der Platine offensichtlicher ist, wo Vin, Vout und ground sind
- QR-Code wird auf die Platine getan damit man auf das Prüfprotokoll und weitere Informationen zu der Platine zugreifen kann
 */
Auf Basis der Erkenntnisse aus den Tests der V3 wird das Layout zur V3.1 überarbeitet. Die Änderungen sind bewusst punktuell gehalten, da die wesentliche Verschaltung der V3 als funktionstüchtig verifiziert ist.

Die Toggle-#acro("LED") wird grundlegend neu platziert. Statt zwischen der $48 space.thin V$-Versorgung und dem On/Off-Signal wird sie nun zwischen dem Toggle-Ausgang der #acro("RCU") und Masse mit invertierter Schaltlogik betrieben. Die Pin-Header zum Abgriff des Automation Headers des Thor werden entfernt, da sie sich im praktischen Betrieb als nicht dienlich erwiesen haben. Es stellt sich heraus, dass der Reset-Pin auf dem Automation Header den Jetson Thor lediglich die gesamte Stormversorgung unterbricht, was grundsätzlich dem Verhalten von einem Aus- und wieder Einschalten des DCDC-Wandlers entspricht, weswegen dieses Feature nicht mehr benötigt wird. Ergänzend wird ein weiterer Stecker vorgesehen, über den bei Bedarf ein $24 space.thin V$-Lüfter angeschlossen werden kann, um eine zusätzliche aktive Kühlung im Casing nachträglich zu ermöglichen.

Auf dem Stecker zur #acro("RCU") wird der bisher freie Pin von Masse auf $24 space.thin V$ umgelegt. Damit steht der #acro("RCU") ein Messpunkt zur Plausibilisierung der Ausgangsspannung des DCDC-Wandlers zur Verfügung, über den festgestellt werden kann, ob der Wandler aktiv ist. Zum Schutz der angeschlossenen Verbraucher werden Sicherungshalter für Schmelzsicherungen für den Lidar sowie den optionalen Lüfter vorgesehen, damit im Fall eines Kurzschlusses die entsprechenden Abgänge gezielt abgeschaltet werden. Der Thor wird bewusst nicht zusätzlich abgesichert, da die #acro("RCU") im Fehlerfall das gesamte Board abschaltet und auf der #acro("RCU") selbst bereits entsprechende Sicherungen verbaut sind. In einem Szenario, in dem diese Sicherungskette zum Tragen kommt, ist der Fahrbetrieb des Fahrzeugs ohnehin nicht mehr gegeben.

Die Stecker werden im Layout weiter auseinander positioniert, um auch mit den verbauten Gegensteckern und Knickschutzhüllen ausreichend Abstand zueinander zu gewährleisten. Zusätzlich werden zwei vertikale Nanofit-Stecker auf der Rückseite der Platine ergänzt, einer für den Lidar und ein weiterer als Reserve für einen späteren Lüfter. Die Beschriftung auf der Platine wird überarbeitet, sodass Eingangsspannung, Ausgangsspannung und Masse eindeutig zuordenbar sind. Wie bei den Vorgängerversionen wird auf der V3.1 ein QR-Code aufgebracht, der auf das Prüfprotokoll und die begleitende Dokumentation verweist.

==== Fertigung und Bestückung der V3.1 Platine
/* - Limitierung der Eingangsimpedanzen wegen HV DCDC des Akkus zu dem LV Netz: kann nur begrenzte Kapazität im System, deswegen werden Kondensatoren mit x Kapazität verbaut obwohl das Pad größer ist
- Bestückung von nur einem Stecker hinten, noch wird Lüfter nicht gebraucht
 */
Bei der Bestückung der Eingangsimpedanz ist eine systemische Einschränkung zu berücksichtigen. Der #acro("HV")-zu-#acro("LV")-DCDC-Wandler der Traktionsbatterie kann nur eine begrenzte kapazitive Last von $470 space.thin"uF"$ @hvdcdc am #acro("LV")-Netz versorgen, ohne dass Schutzmechanismen auslösen. Die Gesamtkapazität aller an das #acro("LV")-Netz angeschlossenen Eingangsfilter ist daher begrenzt. Aus diesem Grund werden die Eingangskondensatoren der V3.1 mit einer kleineren Kapazität als die verbauten Pads zulassen würden bestückt mit insgesamt $70 space.thin"uF"$, wovon $50 space.thin"uF"$ mit einem Elektrolyt-Kondensator und $20 space.thin"uF"$ mit Keramik-Kondensatoren gedeckt werden.

Von den beiden vertikal angeordneten Nanofit-Steckern wird nur einer der vorgesehenen Stecker bestückt. Der zusätzliche Steckplatz für einen möglichen Lüfter bleibt vorerst unbestückt, da die thermischen Tests bislang keine Notwendigkeit für eine aktive Kühlung ergeben haben.

In @v31pcb kann die fertig bestückte Platine gesehen werden.

#figure(
  image("../../resources/img/v31pcb.png", width: 60%, format: "png"),
  caption: [Fertig bestückt und gelötetete V3.1 DCDC Platine]
)<v31pcb>

==== Test der V3.1 Platine
/* - alle Tests die vorher auch schon gemacht wurden, hat sich nicht wirklich was an der Verschaltung verändert also alles gut
- LED funktioniert leider immer noch nicht, ist jetzt immer aus --> Widerstand oben am Spannungsteiler zu groß deswegen kann nicht ausreichend Strom fließen damit LED leuchten kann --> Lösung wäre ein separater Mosfet der einfach die LED schaltet
- Widerstände werden so angepasst, dass die LEDs ungefähr gleich hell alle leuchten
 */
An der V3.1 werden dieselben Tests durchgeführt wie an der V3, da die wesentliche Verschaltung unverändert geblieben ist. Die Ergebnisse bestätigen die bereits auf der V3 dokumentierte Funktionsfähigkeit.

Abweichend zeigt sich erneut ein Problem mit der Toggle-#acro("LED"). Durch die veränderte Schaltung bleibt die #acro("LED") nun dauerhaft ausgeschaltet. Die Analyse ergibt, dass der obere Widerstand im Spannungsteiler in der jetzt verwendeten Schaltungstopologie zu hochohmig ist, sodass der durch die #acro("LED") fließende Strom nicht ausreicht, um ein sichtbares Leuchten zu erzeugen. Damit ist die über die Topologie des Spannungsteilers geführte Lösung in beiden Varianten nicht funktionstüchtig. Als praktikable Lösung wird der Einsatz eines separaten MOSFET vorgeschlagen, der die #acro("LED") unabhängig vom Spannungsteiler am Gate des Haupt-MOSFET schaltet und damit eine saubere Trennung zwischen Schaltlogik und Zustandsanzeige ermöglicht. Eine entsprechende Überarbeitung liegt außerhalb des Umfangs dieser Arbeit.

Die Vorwiderstände der verbleibenden Indikator-#acro("LED")s werden so angepasst, dass alle #acro("LED")s eine vergleichbare Helligkeit aufweisen. Damit ist die V3.1 innerhalb der dokumentierten Einschränkungen als funktionsfähig zu bewerten und wird im weiteren Verlauf als produktive DCDC-Platine des #acro("DVPC") eingesetzt.
