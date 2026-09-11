#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Umsetzung im Power Device Engineer<sec:umsetzung>

Die Auswahl aus @sec:datenpunkte ist eine Liste von Registern. Zur Typbeschreibung wird sie erst, wenn zu jedem Register festliegt, unter welchem Namen es in der Leitwarte erscheint, in welcher Gruppe es geführt wird, mit welchem Funktionscode und welcher Adresse es gelesen wird und wie der gelesene Registerinhalt zu deuten ist. Diese Festlegungen sind Gegenstand dieses Abschnitts. Das Werkzeug selbst, sein Arbeitsablauf und seine Datentypen sind in @sec:pde beschrieben und werden hier nicht wiederholt.

Der Abschnitt führt die Grenzen des Werkzeugs jeweils dort auf, wo sie eine Festlegung erzwingen, und behandelt sie nicht als Nebenprodukt. Bei einem Werkzeug, das Desigo CC nach @sec:pde_ziel nicht als Zielapplikation kennt, bestimmen sie die Gestalt des Modells in erheblichem Umfang mit. Eine dieser Grenzen wirkt so weit auf die vorangegangene Auswahl zurück, dass sie deren Ergebnis verändert; sie ist Gegenstand des Abschnitts zu den Alarmen.


==== Gruppenzuordnung und Benennung

Der #acro("PDE") gibt die Ablage der Datenpunkte vor. Die Wurzelgruppen für Messwerte, digitale Zustände, Geräteparameter und Kommandos lassen sich weder löschen noch umbenennen, eigene Untergruppen sind nur unterhalb der Messwerte und nur in einer Zahl von fünf zulässig @src:pdemanual. Die sieben Gruppen, in denen @sec:datenpunkte die Auswahl begründet hat, sind nach dem Nutzungszweck im Betrieb gebildet, die Gruppen des Werkzeugs dagegen nach der Art der Messgröße. Beide Gliederungen sind nicht deckungsgleich, weshalb die Zuordnung eine eigene Festlegung ist. @tab:gruppenzuordnung hält sie fest.

#figure(
  table(
    columns: (12em, 1fr),
    inset: 6pt,
    align: (left + horizon, left),
    table.header(
      [*Gruppe nach @sec:datenpunkte*], [*Ablage in der Typbeschreibung*],
    ),
    [Messwerte], [Untergruppen `Current`, `Voltage`, `Power`, `Power Factor`, `Frequency` und `Temperature` unterhalb der Messwerte, entsprechend der jeweiligen Messgröße],
    [Zähler und Wartung], [Untergruppe `Counter`],
    [Live-Zustand], [Wurzelgruppe der digitalen Zustände, in der das Werkzeug den Verbindungsstatus ohnehin selbsttätig anlegt],
    [Alarme aus Register 2560], [Wurzelgruppe der digitalen Zustände (siehe den Abschnitt zu den Alarmen)],
    [Prüfung und Betriebsart], [Wurzelgruppe der Geräteparameter],
    [Stammdaten], [Wurzelgruppe der Geräteparameter],
    [Kommandos], [Wurzelgruppe `Command`],
    [Ereignis-Trigger], [Wurzelgruppe der digitalen Zustände],
  ),
  caption: [Zuordnung der Datenpunktgruppen aus @tab:datenpunkte_ecpd zur vorgegebenen Gruppenstruktur des #acro("PDE")]
)<tab:gruppenzuordnung>

Zwei Stellen fügen sich nicht bruchlos. Für den Differenzstrom des #acro("RCM")-Tiefpasses hält das Werkzeug keine passende Untergruppe bereit; er ist keine gewöhnliche Strommessung, und eine eigene Untergruppe verbrauchte eine der fünf verfügbaren. Ebenso sind der Status des Gerätetests und der Zustand des automatischen Wiedereinschaltens ihrer Natur nach Zustände und keine Parameter, sie sind jedoch nicht als digitale Eingänge des Geräts ausgeführt.

In beiden Fällen ist der bestehenden Gliederung der Vorzug gegeben worden. Der Differenzstrom des #acro("RCM")-Tiefpasses ist unter den Messwerten geführt, der Status des Gerätetests bei den Datenpunkten zur Prüfung. Eine eigene Untergruppe ist für keinen der beiden Fälle angelegt worden, sodass alle fünf zulässigen Untergruppen für eine spätere Erweiterung verfügbar bleiben. Der Preis dafür ist gering: Beide Datenpunkte sind an der Stelle auffindbar, an der ein Bediener sie zuerst sucht, und die Ungenauigkeit der Zuordnung bleibt eine Frage der Ordnung und nicht der Erreichbarkeit.

Die Zuordnung ist dabei nicht allein eine Frage der Übersicht. Die konsumierende Applikation leitet aus Gruppe und Einheit ab, welche Datenpunkte sie für bestimmte Darstellungen überhaupt zur Auswahl stellt @src:pdemanual. Ein Leistungswert, der nicht in der Gruppe der Leistung mit passender Einheit liegt, steht dort nicht zur Verfügung, und zwar unabhängig davon, wie er benannt ist.

Für die Benennung gibt das Werkzeug den Zeichensatz vor. Zulässig sind Ziffern, Buchstaben, Umlaute und der Unterstrich, während Leerzeichen und Sonderzeichen zurückgewiesen werden @src:pdemanual. Die Sprache der Bezeichner gibt es faktisch ebenfalls vor, denn seine Oberfläche, seine Gruppen und die von ihm bereits mitgelieferten Eigenschaften sind durchgehend englisch benannt @src:pdemanual. Wo eine passende Eigenschaft vorbelegt war, ist ihr Name deshalb unverändert übernommen, und die selbst angelegten Eigenschaften folgen derselben Sprache, damit die Typbeschreibung nicht zwei Benennungen nebeneinander führt. Übernommen sind darüber hinaus die in @tab:apx_ecpd_register vorgeschlagenen Bezeichner unverändert, durchgehend kleingeschriebene englische Wortfolgen mit dem Unterstrich als Trennzeichen. Ein Präfix für den Gerätetyp ist bewusst nicht vergeben, da der Gerätebezug nach @sec:konzept an der Instanz hängt und nicht am Typ. Ein Bezeichner `ecpd_current` trüge dieselbe Information ein zweites Mal. Ein funktionales Präfix ist dagegen erforderlich, weil mehrere Alarme denselben Sachverhalt betreffen wie ein Zähler und sich sonst nicht unterscheiden ließen. Der Auslösezähler heißt `trip_counter`, der zugehörige Alarm `alarm_trip_counter`.

Diese Festlegung wiegt schwerer, als sie zunächst erscheint. @src:balaji2018 führt die Schwierigkeit, Anwendungen von einem Gebäude auf ein anderes zu übertragen, wesentlich auf die uneinheitliche und herstellerspezifische Benennung der Datenpunkte zurück. Weil derselbe Messwert je nach Anlage anders und teils nur über undurchsichtige Kürzel bezeichnet ist, muss jede Anlage von Hand und mit Kenntnis des Einzelfalls erschlossen werden. Brick begegnet dem mit einem Schema oberhalb der Namen, was eine Typbeschreibung nicht leisten kann; sie kann die Ursache jedoch für die betrachtete Gerätefamilie von vornherein vermeiden, indem sie die Benennung einheitlich und sprechend festschreibt. Hinzu kommt eine Bindung durch das Werkzeug selbst: Sind zu einem Gerätetyp bereits Instanzen angelegt, so ist von einer nachträglichen Änderung des Namens oder des Typs einer Eigenschaft ausdrücklich abzuraten, da sämtliche darauf aufsetzenden Funktionen der Zielapplikation dadurch unterbrochen werden @src:pdemanual. Die Benennung ist damit keine Frage des Geschmacks, sondern nach dem ersten produktiven Einsatz praktisch unveränderlich, was unmittelbar auf die von NFA-03 geforderte Fortschreibbarkeit wirkt.


==== Adressierung

Gelesen wird mit den Funktionscodes 3 und 4, geschrieben mit 6 und 16. Alle vier sind nach @tab:modbustreiber vom Treiber der Zielplattform abgedeckt, sodass an dieser Stelle keine Einschränkung besteht. Dass der Treiber darüber hinaus für einzelne Datenpunkte Coils liest, zeigt erst die Messung in @sec:testdurchfuehrung.

Der in @sec:geraetekonfiguration beschriebene Versatz von eins zwischen der Zählweise der Registerkarte und der Adressierung im Telegramm wird nicht in jeder einzelnen Eigenschaft nachgeführt, sondern einmalig über das Merkmal des Adressversatzes gesetzt, das das Werkzeug zur Basisadresse addiert @src:pdemanual. Jede Eigenschaft der Typbeschreibung hat dadurch dieselbe Registernummer wie die Registerkarte @src:sentronregistermap und wie die Aufstellung in #ref(<apx:datenpunkte_ecpd>, supplement: [Anhang]), sodass sich jeder Datenpunkt ohne Umrechnung zurückverfolgen lässt. Für die nach NFA-01 geforderte Dokumentation ist das die Voraussetzung dafür, dass eine spätere Änderung an der richtigen Stelle ansetzt.

Die Byte-Reihenfolge ist auf Big Endian gesetzt, der zusätzliche Tausch der Bytes innerhalb der Wörter bleibt abgeschaltet. Maßgeblich ist, dass diese Festlegung auf beiden Seiten übereinstimmen muss, denn für Geräte mit Big-Endian-Anordnung ist nach @tab:modbustreiber auch der entsprechende Konfigurationseintrag des Modbus-Treibers zu setzen. Weichen die Annahmen voneinander ab, liefert ein richtig adressiertes Register einen unbrauchbaren Wert, ohne dass ein Fehler gemeldet würde @src:pdemanual. Betroffen sind sämtliche mehrwortigen Werte der Auswahl, die Gleitkommazahlen und die Zeichenketten.

Bestätigt wurde die Festlegung am Testaufbau an der Netzfrequenz in Register 3084. Sie ist eine Gleitkommazahl über zwei Register und damit von der Anordnung betroffen, ihre Größenordnung steht mit rund $50space.thin"Hz"$ jedoch von vornherein fest. Der angezeigte Wert lag in dieser Größenordnung, womit die Anordnung auf beiden Seiten übereinstimmt. Eine vertauschte Reihenfolge hätte einen um Größenordnungen abweichenden Wert ergeben, sodass die Prüfung ohne ein Referenzmessgerät auskommt. Dasselbe Vorgehen ist in #ref(<apx:anwenderdoku>, supplement: [Anhang]) als Prüfschritt für die Inbetriebnahme aufgenommen.

Der Skalierungsfaktor lässt höchstens drei Dezimalstellen zu @src:pdemanual. Für die Messwerte ist das ohne Belang, da das Gerät sie als Gleitkommazahlen in der physikalischen Einheit führt und der Faktor eins bleibt. Zwei Datenpunkte berühren die Grenze gleichwohl. Der eingestellte Nennstrom in Register 5376 liegt in Milliampere vor und ist mit dem Faktor 0,001 umzurechnen, was die zulässige Genauigkeit gerade noch trifft. Die beiden Betriebsstundenzähler liefern Sekunden; ihre Umrechnung in Stunden erforderte den Faktor $1 slash 3600$, der sich mit drei Dezimalstellen nicht darstellen lässt. Sie werden deshalb in Sekunden übernommen, und die Umrechnung bleibt der Darstellung in Desigo CC überlassen.


==== Datentypen und Auflösung der Vorbehalte

Die Formate der Registerkarte lassen sich mit einer Ausnahme unmittelbar auf die Datentypen des Werkzeugs abbilden. Ganzzahlen mit und ohne Vorzeichen stehen mit zwei und vier Byte zur Verfügung, Gleitkommazahlen mit vier und acht Byte, Zeichenketten mit einer Länge bis 250 @src:pdemanual. Die Formate FP32 und FP64 der Registerkarte entsprechen dabei den Austauschformaten binary32 und binary64 nach IEEE 754 @src:ieee754, weshalb die Zuordnung ohne Umrechnung auskommt. @tab:datentypen führt sie im Einzelnen auf.

#figure(
  table(
    columns: (10em, 9em, 1fr),
    inset: 6pt,
    align: (left + horizon, left + horizon, left),
    table.header(
      [*Format der Registerkarte*], [*Datentyp im Modell*], [*Betroffene Datenpunkte*],
    ),
    [U16], [`UINT`, 2 Byte], [Zustands-, Status- und Kommandoregister],
    [S16], [`INT`, 2 Byte], [Empfangsfeldstärke],
    [U32], [`UINT`, 4 Byte], [Sammelregister der Alarme],
    [FP32], [`FLOAT`, 4 Byte], [sämtliche Messwerte sowie die Zähler außer den Betriebsstunden],
    [FP64], [`FLOAT`, 8 Byte], [beide Betriebsstundenzähler],
    [UCHAR\[n\]], [`STRING`], [Stammdaten mit Ausnahme der Softwareversion],
  ),
  caption: [Abbildung der Datenformate der Registerkarte auf die Datentypen der Typbeschreibung]
)<tab:datentypen>

Von den drei Vorbehalten, die @sec:datenpunkte offengelassen hat, klären sich zwei an dieser Stelle. Die beiden Betriebsstundenzähler in doppelter Genauigkeit lassen sich abbilden, da das Werkzeug den Gleitkommatyp auch mit acht Byte führt; die Annahme, es biete dafür keinen Datentyp an, hat sich am Testaufbau nicht bestätigt. Der Vorbehalt entfällt damit ersatzlos.

Das Register der Softwareversion dagegen bleibt wegen seiner gemischten Kodierung nicht dekodierbar und wird nach K-06 aus der Auswahl gestrichen, und zwar an beiden Gerätetypen, da es dort dieselbe Kodierung verwendet. Der Verlust ist gering. Ein Firmware-Stand ändert sich allein durch ein Update, das Servicepersonal über SENTRON Powerconfig einspielt und das sich aus Desigo CC heraus weder auslösen noch veranlassen lässt. Der Datenpunkt beantwortete damit eine Frage, die im laufenden Betrieb nicht gestellt wird.


Der dritte Vorbehalt betrifft den Zeit- und Synchronisationsstatus des Powercenters. Er ist in der Auswahl dokumentiert, in der Typbeschreibung des Powercenters jedoch ausgespart geblieben, da diese bewusst schmal gehalten ist. Seine Aufnahme bleibt damit eine kleine Ergänzung, die @sec:weiterentwicklung aufgreift.

Bemerkenswert ist schließlich, was nicht gebraucht wird. Die Gerätefamilie führt ihre Werte binär und bereits skaliert, sodass weder die Umsetzung aus dem #acro("BCD")-Format noch das Modulo-10-Verfahren zum Einsatz kommt.


==== Kommandos und schreibende Datenpunkte

Nach @tab:modbustreiber kennt ein Datenpunkt entweder die Lese- oder die Schreibrichtung. Ein Schaltbefehl und seine Rückmeldung belegen deshalb zwingend zwei Eigenschaften, selbst wenn sie auf dasselbe Register verwiesen. Beim #acro("ECPD") trifft diese Trennung ohnehin auf getrennte Register, da der Befehl zum elektronischen Schalten in Register 3693 geschrieben, seine Ausführung über Register 3113 und der erreichte Schalterzustand über Register 3110 zurückgemeldet wird @src:sentronregistermap. Was die Plattform erzwingt, entspricht hier dem Gerät und ist keine Doppelung im Sinne von K-04.

Für die Kommandogruppe unterscheidet das Werkzeug einen fest hinterlegten von einem erst in der Zielapplikation vergebenen Kommandowert @src:pdemanual. Diese Unterscheidung bildet die beiden Arten von Kommandos des #acro("ECPD") genau ab. Vier der sechs Kommandos werden durch das Schreiben eines festen Musters ausgelöst, das die Registerkarte je Kommando vorgibt @src:sentronregistermap. Der geschriebene Wert enthält dabei keine Information über die gewünschte Handlung, sondern löst sie allein aus. Diese vier sind deshalb mit fest hinterlegtem Wert ausgeführt, sodass der Bediener eine Handlung anstößt und keinen Wert eingibt.

 Das betrifft die Quittierung der Auslösemeldung, das Rücksetzen der #acro("RCM")-Alarme, den Anstoß des Gerätetests und das mechanische Trennen. Beim elektronischen Schalten und beim Blinkmodus gibt der geschriebene Wert dagegen die Richtung der Handlung an; beide sind deshalb mit dynamischem Kommandowert ausgeführt.

Nicht schreibend geführt wird dagegen ein Teil dessen, was die Registerkarte als beschreibbar ausweist. Anlagenkennzeichen und Einbauort sind Zeichenketten, für die das Modell keine Eingabe vorsieht; sie werden gelesen und in SENTRON Powerconfig gesetzt. Für die Phaseninformation, den eingestellten Nennstrom und den Freigabestatus des elektronischen Schaltens gilt dasselbe, hier jedoch aus den Kriterien K-02 und K-03 heraus, da es sich um Inbetriebnahmewerte handelt. Von den Stammdaten ist damit kein Register schreibend abgebildet.

Für UC-09 bedeutet das eine Einschränkung, die zu benennen ist: Die Beschriftung eines Abgangs ist in der Leitwarte sichtbar, aber nicht änderbar. Zugleich stützt der Befund die in @sec:konzept getroffene Arbeitsteilung, denn die Stammdaten bleiben dort, wo sie bei der Inbetriebnahme ohnehin vergeben werden.

/* Offen beim Autor, Stand 09.09.2026: Die Spalte zur Zugriffsart in
   @tab:apx_ecpd_register gibt die Zugriffsart des Registers wieder und nicht
   die im Modell umgesetzte Richtung. Der Autor sieht sich die Spalte selbst
   noch einmal an; im Fliesstext ist dazu auf seinen Wunsch nichts weiter
   ergaenzt. */


==== Die Alarme aus dem Sammelregister

Die 27 Alarmdatenpunkte aus Register 2560 sind das Ergebnis, an dem @sec:datenpunkte die Wirkung von K-07 am deutlichsten zeigt: Sie heben die Zahl der Datenpunkte je Gerät um 27 an, ohne ein einziges zusätzliches Register zu lesen. Voraussetzung dafür ist, dass sich die einzelnen Bits des Registers als eigene Datenpunkte herauslösen lassen. Der #acro("PDE") sieht dafür zwei Wege vor. Ein Wahrheitswert lässt sich über einen Subindex an eine Bitstelle binden, und ein #acro("BLOB") erlaubt es, aus einem zusammenhängenden Registerbereich einzelne Messpunkte über Position und Länge herauszuschneiden, wobei der Subindex innerhalb der #acro("BLOB")-Parameter ebenfalls zur Verfügung steht @src:pdemanual.

Beide Wege sind am Testaufbau erprobt worden, und beide führen zu demselben Ergebnis. Der #acro("PDE") beschreibt die Zerlegung in beiden Fällen anstandslos und erzeugt eine gültige Typbeschreibung. Der Import dieser Typbeschreibung in Desigo CC gelingt ebenfalls, der Objekttyp erscheint mit der zerlegten Eigenschaft in der Applikationssicht; erst der zugehörige Datenpunkt bleibt ohne gültigen Wert. Ein Eingriff von Hand in die erzeugte #acro("JSON")-Datei führt nicht weiter, da die Importregeln den veränderten Typ zurückweisen. Desigo CC kennt zwar einen Bitfeldtyp, der für genau diesen Zweck vorgesehen ist, doch lässt er sich über ein aus dem #acro("PDE") erzeugtes Objektmodell nicht erreichen, da die zugehörige Umsetzung dort nicht beschrieben werden kann.

Dass beide Wege gleich enden, ist dabei der aussagekräftigere Teil der Beobachtung. Sie unterscheiden sich im Werkzeug erheblich, denn der eine bindet einen Wahrheitswert über einen Subindex an eine Bitstelle, der andere schneidet Messpunkte aus einem Registerbereich heraus. Auf der Leitung sind sie kaum zu unterscheiden, weil in beiden Fällen derselbe Registerbereich mit demselben Funktionscode gelesen wird. Ein gleiches Ergebnis bei verschiedener Beschreibung und gleichem Telegramm spricht dafür, dass die Ursache auf der auswertenden Seite liegt und nicht am Gerät.

Der Produktsupport @src:siemenssupport2026 führt das Verhalten demgegenüber darauf zurück, dass der #acro("BLOB")-Typ mit dem Powercenter nicht zusammenarbeite. Diese Auskunft ist aus zwei Gründen nicht ohne weiteres auf den hier gegangenen Weg übertragbar. Modbus kennt den #acro("BLOB") nicht als eigene Betriebsart; er ist nach @sec:pde_datentypen eine Beschreibung auf der Seite des Lesenden, während das Gerät in beiden Fällen denselben zusammenhängenden Registerbereich ausliefert. Hinzu kommt, dass die Bezeichnung Powercenter zwei verschiedene Erzeugnisse benennt. Am Testaufbau steht nach @sec:testaufbau ein Powercenter 1100 als Datentransceiver, während der #acro("PDE") nach @sec:pde_ziel das Powercenter 3000 als Zielapplikation führt, eine Software und kein Gerät der Verteilerebene. Für dieses wäre die Auskunft ohne weiteres schlüssig, da #acro("BLOB") und Zeitstempel neu hinzugekommene Datentypen sind und das Werkzeug ausdrücklich nur zu bestimmten Versionsständen der Zielapplikationen kompatibel ist @src:pdemanual. Auf den Weg über Desigo CC wirkte sie dann nicht.

#kommentar[Die Zuschreibung der Ursache bleibt offen und ist in dieser Fassung bewusst als offen dargestellt. Die Stelle des Scheiterns ist seit dem 09.09.2026 geklärt: Der Import kommt zustande, erst der Datenpunkt bleibt ohne gültigen Wert. Damit entfällt die einfachere der beiden Möglichkeiten, denn das Powercenter ist nicht schon deshalb als Ursache ausgeschlossen, weil es nie eine Anfrage erhalten hätte. Zu unterscheiden bleiben die beiden Erklärungen an einem einzigen Merkmal, und zwar ob das Gerät die Leseanfrage auf diesen Registerbereich mit einem Ausnahmecode beantwortet. Trifft das zu, so stützt es die Auskunft des Supports; antwortet es normal und wertet erst Desigo CC den gelieferten Bereich nicht aus, so liegt die Ursache auf der auswertenden Seite. Die Aufzeichnung in @sec:testdurchfuehrung leistet das nicht, da sie am fertigen Modell mit dem Sammelregister als einer Zahl entstanden ist und nicht an der zerlegten Fassung. Erst wenn das geklärt ist, sind die drei Absätze oben zu einer Aussage zusammenzuziehen. Der Online-Modus des #acro("PDE") hilft dabei nicht, da er nach @sec:pde_online weder #acro("BLOB") noch Wahrheitswerte abrufen kann.]

Für die Gestalt des Modells ist diese Frage allerdings nicht entscheidend. Gangbar ist der Weg in dieser Werkzeugkette nach beiden Erklärungen nicht, und die daraus folgende Festlegung fiele in beiden Fällen gleich aus. Bedeutsam ist die Unterscheidung erst für die Bewertung der Werkzeugkette, denn im einen Fall handelt es sich um eine Grenze des Geräts, im anderen um eine Bruchstelle zwischen zwei Werkzeugen, die nicht füreinander gebaut sind. Letzteres wäre die unmittelbare Folge dessen, was @sec:pde_ziel festhält: Desigo CC ist keine dokumentierte Zielapplikation des #acro("PDE"), und die Entsprechung der beiden #acro("JSON")-Formate, auf der die Lösung nach @sec:desigoccmechanik aufsetzt, reichte dann nur so weit wie die Menge der beiderseits unterstützten Datentypen. Für die einfachen Typen trüge sie, für die zusammengesetzten nicht.

Der naheliegende Ausweg bestünde darin, das Sammelregister als Zahl zu übertragen und die Auswertung nach Desigo CC zu verlagern, wo ein diskreter Managementstationsalarm nach @sec:desigocc_alarme den Wert einer Eigenschaft gegen einzelne Werte, Wertelisten oder Wertebereiche prüft. Die Bedingungsliste eines solchen Alarms wäre dabei nicht der begrenzende Umstand. Vorgesehen ist je Bit ein eigener Alarm mit genau zwei Zuständen, dem anstehenden und dem nicht anstehenden, sodass die zulässige Zahl von 20 Alarmzuständen je Liste bei weitem nicht ausgeschöpft ist.

Der begrenzende Umstand ist ein anderer. Ohne die Möglichkeit, ein einzelnes Bit auszumaskieren, prüft jede Bedingung den Inhalt des gesamten Registers. Ein Bit lässt sich gegen eine Zahl folglich nur dann zuverlässig prüfen, wenn kein weiteres Bit gesetzt ist. Sobald zwei Meldungen gleichzeitig anstehen oder zu einer bestehenden Meldung eine zweite hinzutritt, trifft keine der hinterlegten Bedingungen mehr zu, und der Alarm bleibt aus. Vollständig abgedeckt wäre der Fall erst durch eine Liste über sämtliche Kombinationen gesetzter Bits, deren Zahl mit $2^27$ wächst. Erst an dieser Stelle wäre die Grenze von 20 Zuständen tatsächlich erreicht, und zwar um Größenordnungen.

Damit ist der Ausweg nicht bloß umständlich, sondern für den vorliegenden Zweck untauglich. Eine Lösung, die den Einzelfall abdeckt und im Mehrfachfall stillschweigend versagt, ist bei einer Meldung über den Zustand eines Schutzgeräts nicht zu vertreten. Ein ausbleibender Alarm ist schlechter als ein nicht vorhandener, weil er eine Überwachung suggeriert, die tatsächlich nicht besteht. Der Fall mehrerer gleichzeitig anstehender Meldungen ist zudem kein Sonderfall, sondern der Regelfall einer Störung, da eine Auslösung typischerweise mehrere Bits zugleich setzt. Der Weg wird deshalb nicht beschritten.

Umgesetzt ist stattdessen die Übertragung des Sammelregisters als ein Datenpunkt `alarm_state` vom Typ einer vorzeichenlosen Ganzzahl mit vier Byte. Die Zuordnung der Bits zu den einzelnen Meldungen ist in @tab:apx_ecpd_alarme vollständig dokumentiert, sodass sich die Zerlegung nachholen lässt, sobald ein tragfähiger Weg dafür besteht.

Die Folgen reichen über diesen Abschnitt hinaus und sind an vier Stellen nachzuziehen. Die Zahlen in @tab:datenpunkte_ecpd und @tab:bilanz_datenpunkte weisen 27 Alarmdatenpunkte je Gerät aus, die in dieser Form nicht entstehen. Die Begründung zu K-07 in @sec:auswahlkriterien stützt sich auf dasselbe Beispiel. FA-04 und FA-05 sind nach @sec:fa ohnehin nur im Zusammenwirken von Modell und Projektierung erfüllbar; diese Feststellung verschärft sich hier, da das Modell die Voraussetzung für die Auswertung nicht in der vorgesehenen Form schafft, und der Anforderungsabgleich in @sec:anforderungsabgleich hat das auszuweisen. Unberührt bleibt allein NFA-06, denn ob ein Alarm ab Werk eingeschaltet ist, entscheidet sich am Gerät und nicht im Modell.


==== Grenzen des Werkzeugs

Zwei weitere Beobachtungen betreffen nicht einzelne Datenpunkte, sondern die Arbeit am Modell als solche.


Der vierte Arbeitsschritt des Werkzeugs, in dem Vorbelegungen, Favoriten und Trenddarstellungen festgelegt werden, richtet sich nach @tab:pde_schritte an den SENTRON Powermanager. Für Desigo CC bleibt er ohne Wirkung, da die Darstellung dort im Projekt angelegt wird. Er ist deshalb nur so weit ausgefüllt, wie das Werkzeug es zum Speichern verlangt.

Zuletzt zwei Beobachtungen zur Größe der erzeugten Datei, für die sich keine Erklärung finden ließ und die beide dem Werkzeug zuzurechnen sind. Schon die Ausgangsgröße ist auffällig: Eine Typbeschreibung mit rund 40 Eigenschaften belegt 22 Megabyte und damit ein Vielfaches dessen, was der beschriebene Inhalt erwarten ließe. Nach dem Entfernen des #acro("BLOB")-Datentyps stieg diese Größe auf 150 Megabyte, obwohl der Vorgang Inhalt entfernt und die Datei somit hätte verkleinern müssen. Der Import in Desigo CC gelang mit dieser Datei zwar noch, benötigte dafür aber rund fünf Minuten und ist damit für die Einrichtung einer Anlage nicht mehr zumutbar. Ausschlaggebend ist gleichwohl das andere Werkzeug: Der #acro("PDE") ließ die Datei danach nicht mehr öffnen. Damit ist die Typbeschreibung unbrauchbar, unabhängig davon, wie lange die Zielplattform für ihren Import benötigt, denn eine Beschreibung, die sich nicht mehr bearbeiten lässt, kann nicht mehr gepflegt werden. Für die Bewertung ist das kein Randbefund, denn NFA-03 verlangt, dass sich das Modell fortschreiben lässt. Für die Arbeitsweise folgt daraus, Zwischenstände zu sichern und eine Änderung an einem Datentyp nicht durch Löschen und Neuanlegen vorzunehmen.


==== Ergebnis

Das Ergebnis dieses Arbeitsschritts sind zwei #acro("JSON")-Dateien. Die erste beschreibt den Gerätetyp des #acro("ECPD") und führt zu jeder Eigenschaft den Namen, die Gruppe, den Funktionscode, die Registeradresse, den Datentyp, die Einheit und den Skalierungsfaktor. Sie enthält damit zugleich die Adressbelegung, die bei dem in @sec:desigoccmechanik beschriebenen allgemeinen Importweg gesondert anzulegen wäre.

Die zweite beschreibt das Powercenter und folgt denselben Festlegungen zu Benennung, Gruppenzuordnung, Adressierung und Byte-Reihenfolge. Sie fällt deutlich kleiner aus, da das Gerät weder misst noch schaltet, und bildet einen Teil der in @sec:datenpunkte begründeten Auswahl ab. Aufgenommen sind die Stammdaten, die Temperatur, der aktive Funkkanal, die Netzanbindung samt dem Zustand der Bluetooth-Schnittstelle sowie das Sammelregister der Alarme, das hier allein die Übertemperatur und die Betriebsstunden belegt. Die Uhrzeit ist als einziger schreibender Datenpunkt geführt.

Damit ist die unterste Ebene des absteigenden Astes des in @sec:vorgehensmodell gewählten Vorgehens erreicht. Auf die Anforderungen aus @sec:anforderungen und die Auswahl aus @sec:datenpunkte folgt mit den beiden Typbeschreibungen das Artefakt, gegen das sich der aufsteigende Ast richtet. Zugleich zeigt dieser Arbeitsschritt die Rückkopplung, die @sec:vorgehensmodell für diese Arbeit ausdrücklich vorsieht. Die Erprobung am Gerät fand bereits während der Umsetzung statt und wirkte auf die vorangehende Phase zurück, sichtbar an der gestrichenen Softwareversion, an der geänderten Form des Alarmregisters und an den daraus folgenden Zahlen in @sec:datenpunkte. Die Prüfung dieses Artefakts beginnt mit der Übernahme in die Zielplattform.

Ob sich die beiden Dateien in Desigo CC einlesen lassen und was dabei aus den einzelnen Eigenschaften wird, ist Gegenstand von @sec:uebernahme.


/* Claude: Belegt ist der Abschnitt aus @src:pdemanual (ueber
   doc/resources/pde_referenz.md, dort mit Topic-IDs), @src:desigoccenghelp
   ueber @tab:modbustreiber und @sec:desigocc_alarme sowie @src:balaji2018 und
   @src:sentronregistermap. Nicht belegbare Aussagen stehen ausnahmslos in
   #kommentar-Bloecken.

   Offen ist an diesem Abschnitt nur noch die Zuschreibung der Ursache beim
   Alarmregister, siehe den #kommentar dort. Sie bleibt auf Entscheidung des
   Autors vom 09.09.2026 offen, weil die dafuer noetige Aufzeichnung der
   zerlegten Fassung nicht mehr vorliegt.

   Zu pruefen bleibt eine Rueckwirkung: @tab:datenpunkte_ecpd,
   @tab:bilanz_datenpunkte und die Begruendung zu K-07 fuehren die 27
   Alarmdatenpunkte weiterhin als eigene Datenpunkte, obwohl sie in dieser Form
   nicht entstehen. Der Absatz zu den Folgen benennt das ausdruecklich, sodass
   Text und Zahlen einander nicht widersprechen; ob die Zahlen dennoch
   angepasst werden, ist eine Entscheidung des Autors.

   Der Befund zum abgewiesenen Schreibzugriff beim Fernschalten ist bewusst
   nicht aufgenommen, da er nach der Notiz in @sec:befunde dorthin gehoert. */
