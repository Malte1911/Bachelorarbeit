#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Ausgewählte Datenpunkte<sec:datenpunkte>

Die Kriterien aus @sec:auswahlkriterien werden im Folgenden auf beide Gerätetypen angewandt, zuerst auf das #acro("ECPD") und anschließend auf das Powercenter. Grundlage ist die Registerkarte der Gerätefamilie @src:sentronregistermap, deren Einträge nach @sec:quellenlage am Testaufbau gegengeprüft wurden. Das Ergebnis ist in der Arbeitsmappe des Anforderungskatalogs als eigene Aufstellung je Gerätetyp festgehalten, in der jede Zeile den Registerplatz, das Datenformat, den vorgeschlagenen Variablennamen und die Begründung der Aufnahme trägt. Der vorliegende Abschnitt gibt die Auswahl gruppenweise wieder und führt die Begründung. Die vollständigen Aufstellungen mit jedem einzelnen Register stehen in #ref(<apx:datenpunkte_ecpd>, supplement: [Anhang]) und #ref(<apx:datenpunkte_powercenter>, supplement: [Anhang]).



Die Darstellung folgt dabei einer Regel. Eine Reduktion um mehr als vier Fünftel des Registerraums ist nur dann ein Ergebnis und keine Behauptung, wenn die nicht aufgenommenen Register ebenso begründet sind wie die aufgenommenen. Beide Seiten werden deshalb gleichrangig behandelt, und jede Ausschlussgruppe wird auf das Kriterium zurückgeführt, das sie trägt.


==== Datenpunkte des ECPD

Die Gruppe des Live-Zustands umfasst fünf Register und beantwortet die Frage, in welchem Zustand sich ein Abgang befindet. Der Schalterstatus in Register 3110 unterscheidet planmäßiges Ausschalten von störungsbedingtem Auslösen und bildet zusätzlich die Standby-Zustände des elektronischen Schaltpfads ab, womit er UC-02 unmittelbar trägt. Register 3113 meldet zurück, ob ein Fernschaltbefehl ausgeführt wurde, und ist die Voraussetzung dafür, dass UC-05 nicht bei der Absendung des Befehls endet. Das Sammelregister 2560 trägt sämtliche Alarme des Geräts. Der Verbindungszustand aus Register $16484+n$ und die Empfangsfeldstärke aus Register 2622 tragen UC-04, wobei die Feldstärke die Verschlechterung einer Funkstrecke sichtbar macht, bevor die Verbindung abreißt. Von dem Feld über alle 24 Endgeräte wird nach K-04 nur der Index des jeweiligen Geräts abgebildet. // Cladue: 16484 geht nu rbei Powercenter, hat eigentlich bei EPCd nichts zu suchen


Aus dem Sammelregister 2560 werden 27 Alarmdatenpunkte gebildet, also alle für das #acro("ECPD") belegten Bits. Diese Gruppe zeigt die Wirkung von K-07 am deutlichsten. Sie hebt die Zahl der Datenpunkte je Gerät von 37 auf 64 und erhöht die Abfragelast um kein einziges Register, weil alle Bits aus demselben Register stammen. Die Bits 14 und 17 entfallen, da sie zur Fehlerlichtbogenerkennung einer anderen Gerätevariante gehören und auf dem #acro("ECPD") nicht gesetzt werden können, die Bits 21 bis 23 sind in der Bitfeldbeschreibung nicht vergeben. Beide Ausschlüsse folgen K-06. Die Alarme sind zugleich der Punkt, an dem das Modell allein nicht genügt, denn 13 der 27 Bits sind nach @sec:registerraum ab Werk abgeschaltet. Welche Bits betroffen sind, weist @tab:apx_ecpd_alarme aus.


Die Messwerte umfassen acht Register. Aufgenommen sind Strom, Spannung, Netzfrequenz, Wirkleistung, Leistungsfaktor, Temperatur und der Differenzstrom des #acro("RCM")-Tiefpasses als Momentanwerte sowie der vom Gerät gespeicherte Maximalwert des Stroms. Der Maximalwert ist der in @sec:auswahlkriterien beschriebene Grenzfall von K-05, denn eine Stromspitze zwischen zwei Abfragen ist im Archiv nicht mehr herstellbar. Der Differenzstrom trägt UC-07 in besonderer Weise, da er den Isolationszustand als Verlauf zeigt und damit eine Verschlechterung erkennbar macht, bevor das Gerät abschaltet.



Vier Register der Registerkarte, die dort als Messwerte geführt werden, sind nicht aufgenommen, und dieser Ausschluss berührt FA-03. Die Anforderung verlangt die Sichtbarkeit sämtlicher Messwerte des #acro("ECPD"), und @sec:fa hält ausdrücklich fest, dass die Reduktion ihr nur so lange nicht entgegensteht, wie kein Messwert entfällt. Für Schein- und Blindleistung in den Registern 3088 und 3090 trägt K-05, da beide sich aus der abgebildeten Wirkleistung und dem Leistungsfaktor bilden lassen. Für die Mittelwerte von Temperatur und Strom in den Registern 3074 und 3078 trägt K-05 ebenfalls, allerdings mit einer Einschränkung. Der Gerätemittelwert wird über den in Register 3586 beziehungsweise 3597 parametrierten Zeitraum gebildet, während Desigo CC über die abgetasteten Werte mittelt. Beide Größen sind verwandt, aber nicht identisch, weshalb diese Abweichung im Anforderungsabgleich auszuweisen ist.


Die Netzfrequenz in Register 3084 ist dagegen aufgenommen, obwohl sie an jedem Endgerät denselben Wert zeigt und je Strang damit bis zu 24-fach erfasst wird. Eine andere Möglichkeit besteht nicht. Das Powercenter misst die Frequenz nicht, und aus den übrigen Datenpunkten lässt sie sich nicht bilden. Bliebe sie außen vor, fehlte dem Modell ein sehr relvanter Messwert vollständig. Die Doppelung wird deshalb bewusst in Kauf genommen.

Die Gruppe der Zähler und der Wartung umfasst sieben Register und trägt UC-07 nahezu allein. Betriebsstunden gesamt und unter Belastungsstrom, mechanische Schaltspiele sowie die nach Ursache getrennten Zähler für Auslösungen, Kurzschlussauslösungen und verzögerte Auslösungen erlauben es, einen Einsatz vorzubereiten, ohne zuvor vor Ort zu prüfen. Eine Häufung von Auslösungen an einem Abgang weist dabei auf ein Problem der Anlage hin und nicht auf einen Gerätefehler. Der Zähler der Änderungen an geschützten Parametern in Register 2726 gehört ebenfalls hierher und ist die Ergänzung zu K-03. Die geschützten Parameter selbst bleiben außerhalb des Modells, ihre Veränderung wird über diesen einen Zähler gleichwohl sichtbar, was für den Betreiber sicherheits- und haftungsrelevant ist.


Prüfung und Betriebsart umfassen drei Register. Der Status des Gerätetests und der Fehlercode des #acro("RCD")-Tests tragen gemeinsam UC-06 und sind die lesende Hälfte dessen, was FA-08 verlangt. Der Zustand des automatischen Wiedereinschaltens erklärt dem Betreiber, weshalb ein Abgang selbsttätig zurückgekehrt ist. Die in @sec:stakeholder benannte Grenze bleibt dabei bestehen, denn diese Datenpunkte unterstützen die wiederkehrende Prüfung und ersetzen sie nicht.


Als Kommandos sind sechs schreibende Register aufgenommen, die den in FA-06 gezogenen Rahmen ausfüllen. Das elektronische Schalten trägt UC-05, die Quittierung der Auslösemeldung UC-03, das Rücksetzen der #acro("RCM")-Alarme ebenfalls UC-03, der Anstoß des Gerätetests UC-06 und der Blinkmodus zur Lokalisierung UC-08. Der Blinkmodus ist relevant, da ein Servicetechniker im Verteiler bis zu 24 baugleiche Geräte vorfindet. Das sechste Kommando, das mechanische Trennen in Register 3694, ist der einzige Grenzfall der Auswahl. Es lässt sich als Befehl des laufenden Betriebs auffassen und fällt damit unter FA-06, es wirkt jedoch nicht rückstellbar, denn ein Register für das mechanische Einschalten existiert nicht. Ein aus der Ferne ausgelöstes Trennen erzwingt somit stets einen Einsatz vor Ort. Aufgenommen ist es unter dem Vorbehalt, dass die zugehörige Freigabe am Gerät gesetzt sein muss.


Die Stammdaten umfassen sieben Register und tragen UC-09 sowie die von FA-03 geforderte Beschriftung. Anlagenkennzeichen und Einbauort machen aus einer Störungsmeldung eine verwertbare Information, Seriennummer und Artikelnummer tragen die Anlagendokumentation, die Phasenzuordnung erlaubt die Betrachtung der Schieflast über alle Abgänge eines Verteilers. Zwei Register dieser Gruppe haben eine besondere Aufgabe. Der eingestellte Nennstrom in Register 5376 ist zwingend erforderlich, weil die Stromgrenzwerte des Geräts in Prozent des Nennstroms angegeben sind und ein Messwert ohne diese Bezugsgröße nicht einzuordnen ist. Der Freigabestatus des elektronischen Schaltens in Register 5425 wird ausschließlich lesend genutzt und ist ein reines Diagnosemerkmal, das erklärt, weshalb ein Schaltbefehl wirkungslos bleibt. Der Nutzen dieses Datenpunkts hat sich im Verlauf der Arbeit bestätigt, wie @sec:befunde zeigt.


Die letzte Gruppe besteht aus einem einzigen Register. Das #acro("ECPD") führt intern ein Auslöseprotokoll und legt darin zu jeder Auslösung einen Eintrag mit Zeitpunkt und Messwerten ab. Das Protokoll selbst wird über ein eigenes, mehrstufiges Leseverfahren abgerufen, das nach K-01 nicht in das Modell aufgenommen ist. Register 3671 trägt die Kennung des jüngsten Eintrags und ändert sich deshalb bei jeder neuen Auslösung. Der Datenpunkt kostet ein einziges Register und zeigt an, dass eine weitere Auslösung hinzugekommen ist, auch wenn der zugehörige Alarm noch ansteht oder bereits quittiert wurde. Aus dem Alarmbit allein ließe sich das nicht erkennen.



#figure(
  table(
    columns: (12em, 5em, 7em, 1fr),
    inset: 6pt,
    align: (left + horizon, center + horizon, center + horizon, left + horizon),
    table.header(
      [*Gruppe*], [*Register*], [*Datenpunkte*], [*Tragende Anwendungsfälle*],
    ),
    [Live-Zustand], [5], [5], [UC-02, UC-04, UC-05],
    [Alarme aus Register 2560], [keines], [27], [UC-03],
    [Messwerte], [8], [8], [UC-02, UC-07],
    [Zähler und Wartung], [7], [7], [UC-07],
    [Prüfung und Betriebsart], [3], [3], [UC-06],
    [Kommandos], [6], [6], [UC-03, UC-05, UC-06, UC-08],
    [Stammdaten], [7], [7], [UC-09],
    [Ereignis-Trigger], [1], [1], [UC-03, UC-07],
    [*Summe*], [*37*], [*64*], [],
  ),
  caption: [Aufgenommene Datenpunkte des #acro("ECPD") nach Gruppen, gegliedert nach gelesenen Registern und daraus gebildeten Datenpunkten]
)<tab:datenpunkte_ecpd>

==== Nicht aufgenommene Register des ECPD

Von den 152 Einträgen, welche die Registerkarte für das #acro("ECPD") ausweist, bleiben 116 unberücksichtigt. Sie verteilen sich auf sieben Gruppen, die sich jeweils einem Kriterium zuordnen lassen. Zwei dieser Gruppen tragen zusammen drei Viertel des Ausschlusses und verdienen deshalb eine eigene Begründung.

Die größte Gruppe bilden mit 61 Registern die Alarm- und Grenzwertkonfiguration sowie die zugehörigen Mittelungszeiträume. Zu nahezu jedem Alarm gehören ein Ein- und Ausschalter, ein Grenzwert und eine Hysterese. Diese Register werden bei der Inbetriebnahme gesetzt und verbleiben nach FA-09 bei SENTRON Powerconfig, während für den Betrieb allein das Ergebnis zählt, das über das Sammelregister 2560 vollständig vorliegt. Die zweite große Gruppe umfasst 23 geschützte Schutzeinstellungen, die nach K-03 nicht über die Leitwarte veränderbar sein sollen. Die Felder der Funk- und Pairing-Diagnose erscheinen dagegen nicht in dieser Aufstellung, da sie nach der Registerkarte dem Powercenter gehören und dort geführt werden.


#figure(
  table(
    columns: (1fr, 4em, 5em),
    inset: 6pt,
    align: (left, center + horizon, center + horizon),
    table.header(
      [*Nicht aufgenommene Gruppe*], [*Anzahl*], [*Kriterium*],
    ),
    [Alarm- und Grenzwertkonfiguration einschließlich Mittelungszeiträumen], [61], [K-02],
    [Werksrückstellung und Schreibschutz], [2], [K-03],
    [Geschützte Schutzeinstellungen], [23], [K-03],
    [Geräteweit konstante oder nicht lesbare Identifikationsregister], [17], [K-06],
    [Abgeleitete Messwerte und nicht beschaltete Ein- und Ausgänge], [9], [K-05],
    [Zeitschaltuhr-Funktionsblöcke], [3], [K-05],
    [Im Auswahlblatt nicht erfasst (Funk-Sendeleistung 1050)], [1], [K-02],
    [*Summe*], [*116*], [],
  ),
  caption: [Nicht aufgenommene Register des #acro("ECPD") und das jeweils tragende Kriterium aus @tab:auswahlkriterien]
)<tab:ausschluss_ecpd>

Drei der kleineren Gruppen verdienen eine Erläuterung, weil ihr Ausschluss auf einer Eigenschaft der Zielplattform oder des Geräts beruht. Die Zeitschaltuhr-Funktionsblöcke liegen als Felder mit gepackten Zeitstempeln vor, die sich in Desigo CC nicht sinnvoll beschreiben lassen, während dieselbe Aufgabe über den Zeitplaner der Plattform und das bereits abgebildete Schaltkommando erfüllt werden kann. Die Protokollregister der verzögerten Quittierung gehören zum Schreibverfahren über die Funkstrecke und sind vom Modbus-Treiber auszuwerten, für den Betreiber tragen sie keine Tätigkeit und fallen damit unter K-01. Die digitalen Ein- und Ausgänge schließlich sind nur dann von Belang, wenn die zugehörige Zusatzfunktion des Geräts tatsächlich beschaltet ist, was am Testaufbau nicht der Fall ist.


==== Datenpunkte des Powercenters

Für das Powercenter fällt die Reduktion deutlicher aus, und zwar aus einem einzigen Grund. Von den 211 Einträgen der Registerkarte entfallen 126 auf Funkparameter, also überwiegend auf Felder je Endgeräteplatz, dazu auf Schalterzustände, Zähler von Parameteränderungen sowie Pairing-, Verbindungs- und Identifikationszustände. Sie sämtlich am Powercenter abzubilden hieße, jeden dieser Werte doppelt zu führen und bis zu 24 fremde Geräte in ein Objekt zu mischen. K-04 löst diese Doppelung zugunsten des Endgeräts auf und trägt damit den größten Teil des Ausschlusses.


Aufgenommen sind 16 Register, die ausschließlich das Powercenter selbst betreffen. Das Sammelregister 2560 trägt auch hier die Alarme, von denen beim Powercenter nur die Übertemperatur und die Betriebsstunden belegt sind, da das Gerät weder misst noch schaltet. Die Temperatur des Powercenters ist der beste verfügbare Anhaltspunkt für das Klima im Verteiler, weil das Gerät dort zentral sitzt. Der Zeit- und Synchronisationsstatus entscheidet über die Güte sämtlicher Zeitstempel des Strangs, denn eine abweichende Uhr des Datentransceivers entwertet jedes Auslöseprotokoll der angeschlossenen Endgeräte. Der aktive Funkkanal erklärt gehäufte Verbindungsabbrüche eines ganzen Strangs und ergänzt damit die Empfangsfeldstärke der einzelnen Endgeräte.


Fünf Register beschreiben die Netzanbindung mit Adresse, Subnetzmaske, Gateway und Hardwareadresse sowie dem Zustand der Bluetooth-Schnittstelle. Sie tragen UC-04 aus der Sicht des IT-Betriebs, und der Zustand der Bluetooth-Schnittstelle ist darüber hinaus sicherheitsrelevant, weil er zeigt, ob der lokale Zugang für die Inbetriebnahme im Regelbetrieb offen steht. Die zugehörigen Konfigurationsregister sind demgegenüber nach K-02 und K-03 ausgeschlossen, da sie einmalig eingerichtet werden und einem geschützten Zugriff unterliegen. Abgebildet werden folglich die Ist-Werte, nicht deren Einstellung. Als einziger schreibender Datenpunkt ist die Uhrzeit aufgenommen, was den Fall abdeckt, dass am Standort kein Zeitserver vorgesehen ist. Die Stammdaten entsprechen denen des #acro("ECPD").


Aus dieser Auswahl entsteht in @sec:umsetzung eine eigene Typbeschreibung, die gegenüber der des #acro("ECPD") deutlich kleiner ausfällt. Der Schwerpunkt der Umsetzung liegt beim Endgerät, da dort die Messwerte, die Zählerstände und die Schaltfunktion liegen, während das Powercenter Zustands- und Diagnoseangaben des Strangs trägt.


==== Bilanz der Reduktion

Die Wirkung der Kriterien lässt sich beziffern. Ein Strang aus einem Powercenter und einem Endgerät umfasst nach @sec:registerraum 363 Einträge der Registerkarte. Nach Anwendung der Kriterien werden davon 53 Register gelesen, aus denen in Desigo CC 82 Datenpunkte entstehen. Die Abfragelast sinkt damit um rund 85 Prozent, während die in der Leitwarte verfügbare Information deutlich weniger stark abnimmt, weil die Alarme aus einem einzigen Register gewonnen werden. Jedes weitere Endgerät fügt 152 Einträge der Registerkarte, 37 gelesene Register und 64 Datenpunkte hinzu.


#figure(
  table(
    columns: (1fr, 7em, 7em, 8em),
    inset: 6pt,
    align: (left + horizon, center + horizon, center + horizon, center + horizon),
    table.header(
      [*Bezugsgröße*], [*Registerkarte*], [*Gelesene Register*], [*Datenpunkte in Desigo CC*],
    ),
    [Ein #acro("ECPD")], [152], [37], [64],
    [Ein Powercenter], [211], [16], [18],
    [Ein Strang mit einem Endgerät], [363], [53], [82],
  ),
  caption: [Bilanz der Datenauswahl je Gerät und für einen Strang aus einem Powercenter und einem Endgerät]
)<tab:bilanz_datenpunkte>

Die Zahl der gelesenen Register ist dabei die für den Betrieb maßgebliche Größe. Gezählt sind die Einträge der Registerkarte, von denen einzelne nach K-07 je nach Datenformat mehrere aufeinanderfolgende Register belegen. Das Systemhandbuch empfiehlt, jedes Gerät höchstens einmal je Sekunde abzufragen und die Endgeräte sequenziell abzuarbeiten @src:sentronsystemhandbuch. Da der Treiber der Zielplattform benachbarte Register selbsttätig zu Leseblöcken zusammenfasst @src:desigoccenghelp, fällt die verbleibende Last je Gerät deutlich geringer aus als die Zahl der Register vermuten lässt. Die Messung in @sec:testdurchfuehrung beziffert sie für das #acro("ECPD") auf zwölf Anfragen je Abfragezyklus, von denen neun die insgesamt 69 Register in Blöcken zwischen einem und 42 Wörtern abholen. Ein voll bestückter Strang mit 24 Endgeräten käme damit rechnerisch auf 288 Anfragen je Zyklus zuzüglich derjenigen des Powercenters. Von den 53 Registern entfallen 9 auf die Gruppe des Live-Zustands, deren Werte am schnellsten aktuell sein müssen.


Diese Unterscheidung nach Aktualität ist in der Arbeitsmappe zu jedem Datenpunkt vermerkt, lässt sich am eingesetzten Stand nach @sec:konzept jedoch nicht umsetzen. Die Angaben zum Zyklus sind deshalb als Vorgabe für die Projektierung und für eine spätere Weiterentwicklung zu verstehen und nicht als Bestandteil der Typbeschreibung. Sie erhöhen zugleich das Gewicht der Reduktion.



Drei Datenpunkte der Auswahl stehen unter einem Vorbehalt, der sich erst bei der Umsetzung klären lässt. Das Register der Softwareversion ist wegen einer gemischten Kodierung derzeit nicht dekodierbar und widerspricht damit K-06, es bleibt vorläufig in der Auswahl und ist zu streichen, falls sich daran nichts ändert. Die beiden Betriebsstundenzähler liegen als Gleitkommazahlen doppelter Genauigkeit vor. Ob das Werkzeug der Typbeschreibung dafür einen Datentyp anbietet, war zum Zeitpunkt der Auswahl offen. Der Zeit- und Synchronisationsstatus des Powercenters schließlich war zum Zeitpunkt der Auswahl noch nicht am Testaufbau erprobt. Alle drei Punkte werden in @sec:umsetzung wieder aufgegriffen, wo die Zuordnung zu Datentypen und Transformationen erfolgt.


Was diese Auswahl nicht festlegt, ist die Form, in der die Datenpunkte im Modell erscheinen. Benennung, Datentyp, Skalierung, Byte-Reihenfolge und der Versatz zwischen Registerkarte und Telegramm sind Gegenstand von @sec:umsetzung. Die Auswahl legt allein fest, welche Register gelesen werden und aus welchem Grund.

#kommentar[Offen und am Gerät zu prüfen: Im Anhang tragen die Register "Aktuelle IP-Adresse", "Aktuelle Subnetzmaske" und "Aktuelle Gateway Adresse" des Powercenters die Werte 528, 529 und 530. Das sind die Werte der Spalte "ID für https" der Registerkarte, nicht die Modbus-Adressen. Dezimal lauten diese 669, 671 und 673.]

/* Claude: Zahlenbasis am 31.08.2026 gegen die Registerkarte
   Modbus_Register_Map_DE_V7-3_2026-04(1).xlsx neu gerechnet.

   Zuvor stammten die Spalte "Registerkarte" und der Strangwert aus den
   Blaettern "Modbus Parameter ECPD" (208 Zeilen) und "Modbus Parameter
   Powercenter 11" (177 Zeilen) der Requirements.xlsx. Das ECPD-Blatt enthielt
   58 Zeilen, die die Registerkarte nicht dem ECPD zuordnet: 53 Funk Parameter,
   3 Delayed ACK, 2 Security. Es sind Register des Powercenters
   ("Pairing Status (n)", "Device Status (n)"). Da sie auch im
   Powercenter-Blatt stehen, zaehlte 24 x 208 + 177 = 5169 sie fuenfundzwanzig-
   mal, obwohl sie einmal existieren.

   Jetzt gilt die Gerätespalte der Registerkarte: ECPD 152 Eintraege,
   POC 1100 211 Eintraege. Gegengeprueft wurde jedes ausgewaehlte Register.
   Alle 36 numerischen ECPD-Register sind dort auch fuer das ECPD markiert.
   Das 37. ist 16484+n (Device Status), ein Powercenter-Register, das nach der
   Modellierungsentscheidung am ECPD-Objekt haengt; das ist im Text benannt.

   Bezugsfall ist jetzt ein Strang aus einem Powercenter und einem Endgeraet
   (363 / 53 / 82, Reduktion rund 85 Prozent). Der Zuwachs je weiterem
   Endgeraet steht im Text.

   Rechenweg @tab:ausschluss_ecpd: 152 Eintraege minus 36 ausgewaehlte = 116.
   Seit dem 01.09.2026 ist die Softwareversion nach @sec:umsetzung gestrichen,
   weshalb 37 statt 38 Register uebernommen sind und von diesen 36 in der
   Geraetespalte der Registerkarte dem ECPD zugeordnet sind.
   Die alte Summe 170 enthielt 57 Powercenter-Zeilen (52 Funk/Pairing,
   3 Delayed ACK, 2 Security), diese Zeilen sind entfallen. Es bleiben 114.
   Dazu Register 1050 "Funk Sendeleistung", das die Registerkarte fuer das ECPD
   markiert, das im Auswahlblatt aber fehlt, und ein Eintrag, den die Karte auf
   zwei Blaettern fuehrt. 114 + 2 = 116.

   VORBEHALT: Diese letzten beiden Eintraege sind aus dem Abgleich hergeleitet
   und nicht im Auswahlblatt begruendet. Register 1050 gehoert in das Blatt
   nachgetragen. Ebenfalls nicht belegt ist die Zahl der Straenge je
   Treiberinstanz in @sec:systemanalyse: die zugrunde liegende Obergrenze von
   Desigo CC steht nirgends in der Arbeit, die Angabe wurde nur proportional
   von sechs auf acht mitgezogen. Entweder Quelle ergaenzen oder Aussage
   qualitativ fassen. */

/* Claude: Am 02.09.2026 an drei Stellen gekuerzt. Die ab Werk abgeschalteten
   Alarmbits sind auf den Verweis nach @sec:registerraum reduziert, die
   DGUV-Grenze auf den bereits vorhandenen Verweis nach @sec:stakeholder, und
   die Herleitung des einheitlichen Abfrageintervalls am Ende der Bilanz
   entfaellt, da sie im selben Absatz ueber @sec:konzept schon angefuehrt ist. */
