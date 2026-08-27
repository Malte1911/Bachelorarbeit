#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Umsetzung im Power Device Engineer<sec:umsetzung>

Die Auswahl aus @sec:datenpunkte ist eine Liste von Registern. Zur Typbeschreibung wird sie erst, wenn zu jedem Register festliegt, unter welchem Namen es in der Leitwarte erscheint, in welcher Gruppe es geführt wird, mit welchem Funktionscode und welcher Adresse es gelesen wird und wie der gelesene Registerinhalt zu deuten ist. Diese Festlegungen sind Gegenstand dieses Abschnitts. Das Werkzeug selbst, sein Arbeitsablauf und seine Datentypen sind in @sec:pde beschrieben und werden hier nicht wiederholt.

Der Abschnitt führt die Grenzen des Werkzeugs jeweils dort auf, wo sie eine Festlegung erzwingen, und behandelt sie nicht als Nebenprodukt. Bei einem Werkzeug, das Desigo CC nach @sec:pde_ziel nicht als Zielapplikation kennt, bestimmen sie die Gestalt des Modells in erheblichem Umfang mit. Eine dieser Grenzen wirkt so weit auf die vorangegangene Auswahl zurück, dass sie deren Ergebnis verändert; sie ist Gegenstand des Abschnitts zu den Alarmen.


==== Gruppenzuordnung und Benennung

Der #acro("PDE") gibt die Ablage der Datenpunkte vor. Die Wurzelgruppen für Messwerte, digitale Zustände, Geräteparameter und Kommandos lassen sich weder löschen noch umbenennen, eigene Untergruppen sind nur unterhalb der Messwerte und nur in einer Zahl von fünf zulässig @src:pdemanual. Die sieben Gruppen, in denen @sec:datenpunkte die Auswahl begründet hat, sind nach dem Nutzungszweck im Betrieb gebildet, die Gruppen des Werkzeugs dagegen nach der Art der Messgröße. Beide Gliederungen sind nicht deckungsgleich, weshalb die Zuordnung eine eigene Festlegung ist.

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

#kommentar[Hier ist einzutragen, wie beide Fälle tatsächlich abgelegt sind und ob überhaupt eine eigene Untergruppe angelegt wurde. Von der Antwort hängt der letzte Satz des Absatzes ab.]

Die Zuordnung ist dabei nicht allein eine Frage der Übersicht. Die konsumierende Applikation leitet aus Gruppe und Einheit ab, welche Datenpunkte sie für bestimmte Darstellungen überhaupt zur Auswahl stellt @src:pdemanual. Ein Leistungswert, der nicht in der Gruppe der Leistung mit passender Einheit liegt, steht dort nicht zur Verfügung, und zwar unabhängig davon, wie er benannt ist.

Für die Benennung gibt das Werkzeug den Zeichensatz vor. Zulässig sind Ziffern, Buchstaben, Umlaute und der Unterstrich; Leerzeichen und Sonderzeichen weist es zurück @src:pdemanual. Übernommen sind deshalb die in @tab:apx_ecpd_register vorgeschlagenen Bezeichner unverändert, also durchgehend kleingeschriebene englische Wortfolgen mit dem Unterstrich als Trennzeichen. Ein Präfix für den Gerätetyp ist bewusst nicht vergeben, da der Gerätebezug nach @sec:konzept an der Instanz hängt und nicht am Typ; ein Bezeichner `ecpd_current` trüge dieselbe Information ein zweites Mal. Ein funktionales Präfix ist dagegen erforderlich, weil mehrere Alarme denselben Sachverhalt betreffen wie ein Zähler und sich sonst nicht unterscheiden ließen. Der Auslösezähler heißt `trip_counter`, der zugehörige Alarm `alarm_trip_counter`.

Diese Festlegung wiegt schwerer, als sie zunächst erscheint. Eine einheitliche und sprechende Benennung ist die Voraussetzung dafür, dass eine über Anlagengrenzen hinweg gültige Beschreibung entsteht und Anwendungen auf ihr aufsetzen können, statt für jede Anlage neu zugeschnitten zu werden @src:balaji2018. Hinzu kommt eine Bindung durch das Werkzeug selbst: Sind zu einem Gerätetyp bereits Instanzen angelegt, so ist von einer nachträglichen Änderung des Namens oder des Typs einer Eigenschaft ausdrücklich abzuraten, da sämtliche darauf aufsetzenden Funktionen der Zielapplikation dadurch unterbrochen werden @src:pdemanual. Die Benennung ist damit keine Frage des Geschmacks, sondern nach dem ersten produktiven Einsatz praktisch unveränderlich, was unmittelbar auf die von NFA-03 geforderte Fortschreibbarkeit wirkt.


==== Adressierung

Gelesen wird mit den Funktionscodes 3 und 4, geschrieben mit 6 und 16. Alle vier sind nach @tab:modbustreiber vom Treiber der Zielplattform abgedeckt, sodass an dieser Stelle keine Einschränkung besteht.

Der in @sec:geraetekonfiguration beschriebene Versatz von eins zwischen der Zählweise der Registerkarte und der Adressierung im Telegramm wird nicht in jeder einzelnen Eigenschaft nachgeführt, sondern einmalig über das Merkmal des Adressversatzes gesetzt, das das Werkzeug zur Basisadresse addiert @src:pdemanual. Das ist mehr als eine Bequemlichkeit. Jede Eigenschaft der Typbeschreibung trägt dadurch dieselbe Registernummer wie die Registerkarte @src:sentronregistermap und wie die Aufstellung in #ref(<apx:datenpunkte_ecpd>, supplement: [Anhang]), sodass sich jeder Datenpunkt ohne Umrechnung zurückverfolgen lässt. Für die nach NFA-01 geforderte Dokumentation ist das die Voraussetzung dafür, dass eine spätere Änderung an der richtigen Stelle ansetzt.

Die Byte-Reihenfolge ist auf Big Endian gesetzt, der zusätzliche Tausch der Bytes innerhalb der Wörter bleibt abgeschaltet. Maßgeblich ist, dass diese Festlegung auf beiden Seiten übereinstimmen muss, denn für Geräte mit Big-Endian-Anordnung ist nach @tab:modbustreiber auch der entsprechende Konfigurationseintrag des Modbus-Treibers zu setzen. Weichen die Annahmen voneinander ab, liefert ein richtig adressiertes Register einen unbrauchbaren Wert, ohne dass ein Fehler gemeldet würde @src:pdemanual. Betroffen ist jeder mehrwortige Wert, also sämtliche Gleitkommazahlen und Zeichenketten der Auswahl.

#kommentar[Anzugeben ist, woran die Byte-Reihenfolge am Testaufbau bestätigt wurde. Ein Messwert bekannter Größenordnung genügt dafür, etwa die Netzfrequenz, die bei falscher Anordnung keinen plausiblen Wert ergibt.]

Der Skalierungsfaktor lässt höchstens drei Dezimalstellen zu @src:pdemanual. Für die Messwerte ist das ohne Belang, da das Gerät sie als Gleitkommazahlen in der physikalischen Einheit führt und der Faktor eins bleibt. Zwei Datenpunkte berühren die Grenze gleichwohl. Der eingestellte Nennstrom in Register 5376 liegt in Milliampere vor und ist mit dem Faktor 0,001 umzurechnen, was die zulässige Genauigkeit gerade noch trifft. Die beiden Betriebsstundenzähler liefern Sekunden; ihre Umrechnung in Stunden erforderte den Faktor $1 slash 3600$, der sich mit drei Dezimalstellen nicht darstellen lässt. Sie werden deshalb in Sekunden übernommen, und die Umrechnung bleibt der Darstellung in Desigo CC überlassen.


==== Datentypen und Auflösung der Vorbehalte

Die Formate der Registerkarte lassen sich mit einer Ausnahme unmittelbar auf die Datentypen des Werkzeugs abbilden. Ganzzahlen mit und ohne Vorzeichen stehen mit zwei und vier Byte zur Verfügung, Gleitkommazahlen mit vier und acht Byte, Zeichenketten mit einer Länge bis 250 @src:pdemanual.

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

Das Register der Softwareversion dagegen bleibt wegen seiner gemischten Kodierung nicht dekodierbar und wird nach K-06 aus der Auswahl gestrichen. Der Verlust ist gering. Ein Firmware-Stand ändert sich allein durch ein Update, das Servicepersonal über SENTRON Powerconfig einspielt und das sich aus Desigo CC heraus weder auslösen noch veranlassen lässt. Der Datenpunkt beantwortete damit eine Frage, die im laufenden Betrieb nicht gestellt wird.

#kommentar[Die Streichung wirkt auf drei Stellen zurück, die nachzuziehen sind. In @tab:datenpunkte_ecpd sinken die Stammdaten von acht auf sieben Register und die Summe von 38 auf 37 Register beziehungsweise von 65 auf 64 Datenpunkte. In @tab:bilanz_datenpunkte werden aus 929 gelesenen Registern je Strang 905 und aus 1579 Datenpunkten 1555; die Reduktion beträgt dann rund 82,5 Prozent. In #ref(<apx:datenpunkte_ecpd>, supplement: [Anhang]) ist die Zeile zu Register 22 zu entfernen oder als gestrichen zu kennzeichnen.]

Der dritte Vorbehalt betrifft den Zeit- und Synchronisationsstatus des Powercenters. Er ist in der Auswahl dokumentiert, in der Typbeschreibung des Powercenters jedoch ausgespart geblieben, da diese bewusst schmal gehalten ist. Seine Aufnahme bleibt damit eine kleine Ergänzung, die @sec:weiterentwicklung aufgreift.

Bemerkenswert ist schließlich, was nicht gebraucht wird. Die Gerätefamilie führt ihre Werte binär und bereits skaliert, sodass weder die Umsetzung aus dem #acro("BCD")-Format noch das Modulo-10-Verfahren zum Einsatz kommt. Das ist für die Prüfung von Bedeutung, denn genau diese Kombinationen lassen sich im Online-Modus des Werkzeugs nach @sec:pde_online nicht abrufen.


==== Kommandos und schreibende Datenpunkte

Nach @tab:modbustreiber kennt ein Datenpunkt entweder die Lese- oder die Schreibrichtung. Ein Schaltbefehl und seine Rückmeldung belegen deshalb zwingend zwei Eigenschaften, selbst wenn sie auf dasselbe Register verwiesen. Beim #acro("ECPD") trifft diese Trennung ohnehin auf getrennte Register, da das Kommando in Register 3693 geschrieben, die Ausführung über Register 3113 und der erreichte Zustand über Register 3110 zurückgemeldet wird. Was die Plattform erzwingt, entspricht hier also dem Gerät und ist keine Doppelung im Sinne von K-04.

Für die Kommandogruppe unterscheidet das Werkzeug einen fest hinterlegten von einem erst in der Zielapplikation vergebenen Kommandowert @src:pdemanual. Diese Unterscheidung bildet die beiden Arten von Kommandos des #acro("ECPD") genau ab. Vier der sechs Kommandos werden durch das Schreiben eines festen Musters ausgelöst, dessen Inhalt keine Bedeutung trägt, sondern das unbeabsichtigte Schreiben verhindern soll; sie sind mit fest hinterlegtem Wert ausgeführt, sodass der Bediener eine Handlung auslöst und keinen Wert eingibt. Das betrifft die Quittierung der Auslösemeldung, das Rücksetzen der #acro("RCM")-Alarme, den Anstoß des Gerätetests und das mechanische Trennen. Beim elektronischen Schalten und beim Blinkmodus trägt der geschriebene Wert dagegen die Richtung der Handlung; beide sind deshalb mit dynamischem Kommandowert ausgeführt.

Nicht schreibend geführt wird dagegen ein Teil dessen, was die Registerkarte als beschreibbar ausweist. Anlagenkennzeichen und Einbauort sind Zeichenketten, für die das Modell keine Eingabe vorsieht; sie werden gelesen und in SENTRON Powerconfig gesetzt. Für die Phaseninformation, den eingestellten Nennstrom und den Freigabestatus des elektronischen Schaltens gilt dasselbe, hier jedoch aus den Kriterien K-02 und K-03 heraus, da es sich um Inbetriebnahmewerte handelt. Von den Stammdaten ist damit kein Register schreibend abgebildet.

Für UC-10 bedeutet das eine Einschränkung, die zu benennen ist: Die Beschriftung eines Abgangs ist in der Leitwarte sichtbar, aber nicht änderbar. Zugleich stützt der Befund die in @sec:konzept getroffene Arbeitsteilung, denn die Stammdaten bleiben dort, wo sie bei der Inbetriebnahme ohnehin vergeben werden.

#kommentar[In #ref(<apx:datenpunkte_ecpd>, supplement: [Anhang]) ist die Spalte zur Zugriffsart entsprechend zu lesen. Sie gibt bislang die Zugriffsart des Registers wieder und nicht die im Modell umgesetzte Richtung. Ein Hinweis in der Vorbemerkung der Aufstellung genügt.]


==== Die Alarme aus dem Sammelregister

Die 27 Alarmdatenpunkte aus Register 2560 sind das Ergebnis, an dem @sec:datenpunkte die Wirkung von K-07 am deutlichsten zeigt: Sie heben die Zahl der Datenpunkte je Gerät um 27 an, ohne ein einziges zusätzliches Register zu lesen. Voraussetzung dafür ist, dass sich die einzelnen Bits des Registers als eigene Datenpunkte herauslösen lassen. Der #acro("PDE") sieht dafür zwei Wege vor. Ein Wahrheitswert lässt sich über einen Subindex an eine Bitstelle binden, und ein #acro("BLOB") erlaubt es, aus einem zusammenhängenden Registerbereich einzelne Messpunkte über Position und Länge herauszuschneiden, wobei der Subindex innerhalb der #acro("BLOB")-Parameter ebenfalls zur Verfügung steht @src:pdemanual.

Beide Wege sind am Testaufbau erprobt worden, und beide führen zu demselben Ergebnis. Der #acro("PDE") beschreibt die Zerlegung in beiden Fällen anstandslos und erzeugt eine gültige Typbeschreibung; erst deren Übernahme scheitert. Ein Eingriff von Hand in die erzeugte #acro("JSON")-Datei führt nicht weiter, da die Importregeln den veränderten Typ zurückweisen. Desigo CC kennt zwar einen Bitfeldtyp, der für genau diesen Zweck vorgesehen ist, doch lässt er sich über ein aus dem #acro("PDE") erzeugtes Objektmodell nicht erreichen, da die zugehörige Umsetzung dort nicht beschrieben werden kann.

Dass beide Wege gleich enden, ist dabei der aussagekräftigere Teil der Beobachtung. Sie unterscheiden sich im Werkzeug erheblich, denn der eine bindet einen Wahrheitswert über einen Subindex an eine Bitstelle, der andere schneidet Messpunkte aus einem Registerbereich heraus. Auf der Leitung sind sie kaum zu unterscheiden, weil in beiden Fällen derselbe Registerbereich mit demselben Funktionscode gelesen wird. Ein gleiches Ergebnis bei verschiedener Beschreibung und gleichem Telegramm spricht dafür, dass die Ursache auf der auswertenden Seite liegt und nicht am Gerät.

Der Produktsupport führt das Verhalten demgegenüber darauf zurück, dass der #acro("BLOB")-Typ mit dem Powercenter nicht zusammenarbeite. Diese Auskunft ist aus zwei Gründen nicht ohne weiteres auf den hier gegangenen Weg übertragbar. Modbus kennt den #acro("BLOB") nicht als eigene Betriebsart; er ist nach @sec:pde_datentypen eine Beschreibung auf der Seite des Lesenden, während das Gerät in beiden Fällen denselben zusammenhängenden Registerbereich ausliefert. Hinzu kommt, dass die Bezeichnung Powercenter zwei verschiedene Erzeugnisse benennt. Am Testaufbau steht nach @sec:testaufbau ein Powercenter 1100 als Datentransceiver, während der #acro("PDE") nach @sec:pde_ziel das Powercenter 3000 als Zielapplikation führt, also eine Software und kein Gerät der Verteilerebene. Für dieses wäre die Auskunft ohne weiteres schlüssig, da #acro("BLOB") und Zeitstempel neu hinzugekommene Datentypen sind und das Werkzeug ausdrücklich nur zu bestimmten Versionsständen der Zielapplikationen kompatibel ist @src:pdemanual. Auf den Weg über Desigo CC wirkte sie dann nicht.

#kommentar[Die Zuschreibung der Ursache ist noch offen und in dieser Fassung bewusst als offen dargestellt. Entscheidbar ist sie an der Frage, an welcher Stelle der Vorgang abbricht. Verweigert Desigo CC bereits den Import der Typbeschreibung, so hat das Powercenter zu keinem Zeitpunkt eine Anfrage erhalten und scheidet als Ursache aus. Kommt der Import dagegen zustande und bleibt erst der Datenpunkt ohne gültigen Wert, so ist der Modbus-Verkehr zu betrachten, und ein Ausnahmecode des Geräts wäre der Beleg für die Auskunft des Supports. Der Online-Modus des #acro("PDE") hilft dabei nicht, da er nach @sec:pde_online weder #acro("BLOB") noch Wahrheitswerte abrufen kann. Sobald das geklärt ist, sind die drei Absätze oben zu einer Aussage zusammenzuziehen und @src:siemenssupport2026 mit Datum und Form der Auskunft zu belegen.]

Für die Gestalt des Modells ist diese Frage allerdings nicht entscheidend. Gangbar ist der Weg in dieser Werkzeugkette nach beiden Erklärungen nicht, und die daraus folgende Festlegung fiele in beiden Fällen gleich aus. Bedeutsam ist die Unterscheidung erst für die Bewertung der Werkzeugkette, denn im einen Fall handelt es sich um eine Grenze des Geräts, im anderen um eine Bruchstelle zwischen zwei Werkzeugen, die nicht füreinander gebaut sind. Letzteres wäre die unmittelbare Folge dessen, was @sec:pde_ziel festhält: Desigo CC ist keine dokumentierte Zielapplikation des #acro("PDE"), und die Entsprechung der beiden #acro("JSON")-Formate, auf der die Lösung nach @sec:desigoccmechanik aufsetzt, reichte dann nur so weit wie die Menge der beiderseits unterstützten Datentypen. Für die einfachen Typen trüge sie, für die zusammengesetzten nicht.

Der naheliegende Ausweg bestünde darin, das Sammelregister als Zahl zu übertragen und die Auswertung nach Desigo CC zu verlagern, wo ein diskreter Managementstationsalarm nach @sec:desigocc_alarme den Wert einer Eigenschaft gegen einzelne Werte, Wertelisten oder Wertebereiche prüft. Die Bedingungsliste eines solchen Alarms wäre dabei nicht der begrenzende Umstand. Vorgesehen ist je Bit ein eigener Alarm mit genau zwei Zuständen, dem anstehenden und dem nicht anstehenden, sodass die zulässige Zahl von zwanzig Alarmzuständen je Liste bei weitem nicht ausgeschöpft ist.

Der begrenzende Umstand ist ein anderer. Ohne die Möglichkeit, ein einzelnes Bit auszumaskieren, prüft jede Bedingung den Inhalt des gesamten Registers. Ein Bit lässt sich gegen eine Zahl folglich nur dann zuverlässig prüfen, wenn kein weiteres Bit gesetzt ist. Sobald zwei Meldungen gleichzeitig anstehen oder zu einer bestehenden Meldung eine zweite hinzutritt, trifft keine der hinterlegten Bedingungen mehr zu, und der Alarm bleibt aus. Vollständig abgedeckt wäre der Fall erst durch eine Liste über sämtliche Kombinationen gesetzter Bits, deren Zahl mit $2^27$ wächst. Erst an dieser Stelle wäre die Grenze von zwanzig Zuständen tatsächlich erreicht, und zwar um Größenordnungen.

Damit ist der Ausweg nicht bloß umständlich, sondern für den vorliegenden Zweck untauglich. Eine Lösung, die den Einzelfall abdeckt und im Mehrfachfall stillschweigend versagt, ist bei einer Meldung über den Zustand eines Schutzgeräts nicht zu vertreten. Ein ausbleibender Alarm ist schlechter als ein nicht vorhandener, weil er eine Überwachung suggeriert, die tatsächlich nicht besteht. Der Fall mehrerer gleichzeitig anstehender Meldungen ist zudem kein Sonderfall, sondern der Regelfall einer Störung, da eine Auslösung typischerweise mehrere Bits zugleich setzt. Der Weg wird deshalb nicht beschritten.

Umgesetzt ist stattdessen die Übertragung des Sammelregisters als ein Datenpunkt `alarm_state` vom Typ einer vorzeichenlosen Ganzzahl mit vier Byte. Die Zuordnung der Bits zu den einzelnen Meldungen ist in @tab:apx_ecpd_alarme vollständig dokumentiert, sodass sich die Zerlegung nachholen lässt, sobald ein tragfähiger Weg dafür besteht.

#kommentar[Hier ist einzutragen, was tatsächlich in der Typbeschreibung steht. Denkbar sind neben der Übertragung als eine Zahl auch eine Aufnahme der Alarme als einzelne Wahrheitswerte, sofern der Weg über den Subindex doch gangbar war, oder ein Verzicht auf das Register. Der weitere Text hängt an dieser Angabe.]

Die Folgen reichen über diesen Abschnitt hinaus und sind an vier Stellen nachzuziehen. Die Zahlen in @tab:datenpunkte_ecpd und @tab:bilanz_datenpunkte weisen 27 Alarmdatenpunkte je Gerät aus, die in dieser Form nicht entstehen. Die Begründung zu K-07 in @sec:auswahlkriterien stützt sich auf dasselbe Beispiel. FA-04 und FA-05 sind nach @sec:fa ohnehin nur im Zusammenwirken von Modell und Projektierung erfüllbar; diese Feststellung verschärft sich hier, da das Modell die Voraussetzung für die Auswertung nicht in der vorgesehenen Form schafft, und der Anforderungsabgleich in @sec:anforderungsabgleich hat das auszuweisen. Unberührt bleibt allein NFA-06, denn ob ein Alarm ab Werk eingeschaltet ist, entscheidet sich am Gerät und nicht im Modell.


==== Grenzen des Werkzeugs

Drei weitere Beobachtungen betreffen nicht einzelne Datenpunkte, sondern die Arbeit am Modell als solche.

Die Eigenschaften sind nicht einzeln von Hand angelegt, sondern über das Tabellenblatt eingelesen, das das Werkzeug zu diesem Zweck bereitstellt @src:pdemanual. Da die Auswahl ohnehin als Arbeitsmappe vorliegt, entfällt damit eine fehleranfällige Doppelerfassung. Von dieser Möglichkeit ausgenommen sind gerade die aufwendigen Typen, also #acro("BLOB"), #acro("BCD"), Modulo-10 und Zeitstempel @src:pdemanual. Für dieses Modell wirkt sich das kaum aus, weil es ausschließlich Standardtypen verwendet.

Der vierte Arbeitsschritt des Werkzeugs, in dem Vorbelegungen, Favoriten und Trenddarstellungen festgelegt werden, richtet sich nach @tab:pde_schritte an den SENTRON Powermanager. Für Desigo CC bleibt er ohne Wirkung, da die Darstellung dort im Projekt angelegt wird. Er ist deshalb nur so weit ausgefüllt, wie das Werkzeug es zum Speichern verlangt. Das ist die unmittelbare Folge daraus, dass Desigo CC keine dokumentierte Zielapplikation des #acro("PDE") ist.

Zuletzt ein Verhalten, für das sich keine Erklärung finden ließ. Nach dem Entfernen des #acro("BLOB")-Datentyps aus der Typbeschreibung stieg die Größe der #acro("JSON")-Datei von 22 auf 150 Megabyte, obwohl der Vorgang Inhalt entfernt und die Datei somit hätte verkleinern müssen. Das Werkzeug ließ die Datei danach nicht mehr öffnen, und ihr Import in Desigo CC nahm entsprechend viel Zeit in Anspruch. Für die Bewertung ist das kein Randbefund, denn NFA-03 verlangt, dass sich das Modell fortschreiben lässt, und eine Typbeschreibung, die sich nicht mehr öffnen lässt, ist nicht fortschreibbar. Für die Arbeitsweise folgt daraus, Zwischenstände zu sichern und eine Änderung an einem Datentyp nicht durch Löschen und Neuanlegen vorzunehmen.

#kommentar[Zwei Punkte sind hier noch zu klären. Erstens ist bereits die Ausgangsgröße von 22 Megabyte für eine Typbeschreibung mit rund 40 Eigenschaften auffällig groß; falls sich dazu etwas sagen lässt, gehört es hierher. Zweitens ist zu entscheiden, ob dieser Absatz hier oder in @sec:befunde steht. Für diese Stelle spricht, dass er die Arbeit am Modell betrifft und keine Eigenschaft der Geräte ist; für @sec:befunde spricht, dass er wie die dortigen Beobachtungen erst bei der Erprobung zutage getreten ist.]


==== Ergebnis

Das Ergebnis dieses Arbeitsschritts sind zwei #acro("JSON")-Dateien. Die erste beschreibt den Gerätetyp des #acro("ECPD") und führt zu jeder Eigenschaft den Namen, die Gruppe, den Funktionscode, die Registeradresse, den Datentyp, die Einheit und den Skalierungsfaktor. Sie trägt damit zugleich die Adressbelegung, die bei dem in @sec:desigoccmechanik beschriebenen allgemeinen Importweg gesondert anzulegen wäre.

Die zweite beschreibt das Powercenter und folgt denselben Festlegungen zu Benennung, Gruppenzuordnung, Adressierung und Byte-Reihenfolge. Sie fällt deutlich kleiner aus, da das Gerät weder misst noch schaltet, und bildet einen Teil der in @sec:datenpunkte begründeten Auswahl ab. Aufgenommen sind die Stammdaten, die Temperatur, der aktive Funkkanal, die Netzanbindung samt dem Zustand der Bluetooth-Schnittstelle sowie das Sammelregister der Alarme, das hier allein die Übertemperatur und die Betriebsstunden belegt. Die Uhrzeit ist als einziger schreibender Datenpunkt geführt.

Ob sich die beiden Dateien in Desigo CC einlesen lassen und was dabei aus den einzelnen Eigenschaften wird, ist Gegenstand von @sec:uebernahme.

/* Claude: Rohentwurf nach der mit dem Autor abgestimmten Gliederung. Die
   Stichpunkte der bisherigen Fassung sind vollstaendig aufgegangen:
   - Namensvorschlaege aus der Tabelle -> Gruppenzuordnung und Benennung
   - BLOB nicht unterstuetzt, keine Maskierung, kein Bitfeldtyp erreichbar,
     Untauglichkeit des Zahlenvergleichs -> Abschnitt zu den Alarmen
   - kein Text als Eingabe -> Kommandos und schreibende Datenpunkte
   - float64 funktioniert, Softwareversion nicht -> Datentypen
   - Dateigroesse und Absturz -> Grenzen des Werkzeugs
   Der Managementstationsalarm ist ebenfalls im Alarmabschnitt aufgenommen,
   allerdings als verworfene Alternative.

   Zur Korrektur des Autors: Die Grenze von zwanzig Alarmzustaenden je
   Bedingungsliste ist nicht das Hindernis, da je Bit ein Alarm mit zwei
   Zustaenden vorgesehen ist. Der Text sagt das jetzt ausdruecklich und fuehrt das
   Hindernis stattdessen auf die fehlende Maskierung und die Zahl moeglicher
   Bitkombinationen zurueck. Die Zwanzig steht nur noch als nachgeordnete
   Bemerkung an der Stelle, an der sie tatsaechlich griffe.

   Belegt ist der Abschnitt aus @src:pdemanual (ueber doc/resources/pde_referenz.md,
   dort mit Topic-IDs), @src:desigoccenghelp ueber @tab:modbustreiber und
   @sec:desigocc_alarme sowie @src:balaji2018 und @src:sentronregistermap. Nicht
   belegbare Aussagen stehen ausnahmslos in #kommentar-Bloecken.

   Nachtrag des Autors, eingearbeitet: Der Weg ueber den Wahrheitswert mit
   Subindex ist ebenfalls erprobt und liefert in Desigo CC dasselbe Ergebnis wie
   der Weg ueber den BLOB. Damit ist die Ursache lokalisiert. Sie liegt nicht am
   PDE, der beide Varianten anstandslos beschreibt, sondern an den Importregeln
   der Zielplattform. Der Alarmabschnitt sagt das jetzt ausdruecklich und ordnet
   den Befund als Bruchstelle der Werkzeugkette ein, mit Rueckbezug auf
   @sec:pde_ziel und @sec:desigoccmechanik. Dieser Absatz ist zugleich der
   Anschluss an @sec:uebernahme, wo die Grenze des Importwegs nochmals auftritt.

   Offen und vom Autor einzutragen sind fuenf Punkte, jeweils als #kommentar
   markiert: die Ablage von Differenzstrom und Pruefstatus, der Nachweis der
   Byte-Reihenfolge, die Belegstelle zum Bitfeld nebst der Rolle des Powercenters,
   die tatsaechlich umgesetzte Form des Alarmregisters sowie die Ausgangsgroesse
   der JSON-Datei und die Verortung des Absatzes dazu.

   Zwei Rueckwirkungen auf bereits geschriebene Abschnitte sind im Text als
   #kommentar vermerkt und bewusst noch nicht ausgefuehrt:
   1. Streichung der Softwareversion: @tab:datenpunkte_ecpd 38 -> 37 Register und
      65 -> 64 Datenpunkte, @tab:bilanz_datenpunkte 929 -> 905 Register und
      1579 -> 1555 Datenpunkte je Strang, Reduktion rund 82,5 statt 82 Prozent,
      dazu die Zeile zu Register 22 im Anhang. Der Satz in @sec:datenpunkte, der
      den Vorbehalt formuliert, ist dann ebenfalls anzupassen.
   2. Die 27 Alarmdatenpunkte in @tab:datenpunkte_ecpd, @tab:bilanz_datenpunkte
      und in der Begruendung zu K-07 setzen die Zerlegung des Bitfelds voraus.
      Solange nicht feststeht, in welcher Form die Alarme im Modell erscheinen,
      bleiben die Zahlen unveraendert.
   Ausserdem behauptet @sec:datenpunkte derzeit, das Werkzeug biete fuer FP64
   keinen entsprechenden Datentyp an. Das ist nach der Beobachtung des Autors
   nicht zutreffend und dort zu streichen; hier steht die Aufloesung bereits.

   Der Befund zum abgewiesenen Schreibzugriff beim Fernschalten ist bewusst nicht
   aufgenommen, da er nach der Notiz in @sec:befunde dorthin gehoert. */
