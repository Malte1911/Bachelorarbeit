#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Ausgewählte Datenpunkte<sec:datenpunkte>

Die Kriterien aus @sec:auswahlkriterien werden im Folgenden auf beide Gerätetypen angewandt, zuerst auf das #acro("ECPD") und anschließend auf das Powercenter. Grundlage ist die Registerkarte der Gerätefamilie @src:sentronregistermap, deren Einträge nach @sec:quellenlage am Testaufbau gegengeprüft wurden. Das Ergebnis ist in der Arbeitsmappe des Anforderungskatalogs als eigene Aufstellung je Gerätetyp festgehalten, in der jede Zeile den Registerplatz, das Datenformat, den vorgeschlagenen Variablennamen und die Begründung der Aufnahme trägt. Der vorliegende Abschnitt gibt die Auswahl gruppenweise wieder und führt die Begründung. Die vollständigen Aufstellungen mit jedem einzelnen Register stehen in #ref(<apx:datenpunkte_ecpd>, supplement: [Anhang]) und #ref(<apx:datenpunkte_powercenter>, supplement: [Anhang]).



Die Darstellung folgt dabei einer Regel. Eine Reduktion um mehr als vier Fünftel des Registerraums ist nur dann ein Ergebnis und keine Behauptung, wenn die nicht aufgenommenen Register ebenso begründet sind wie die aufgenommenen. Beide Seiten werden deshalb gleichrangig behandelt, und jede Ausschlussgruppe wird auf das Kriterium zurückgeführt, das sie trägt.


==== Datenpunkte des ECPD

Die Gruppe des Live-Zustands umfasst fünf Register und beantwortet die Frage, in welchem Zustand sich ein Abgang befindet. Der Schalterstatus in Register 3110 unterscheidet planmäßiges Ausschalten von störungsbedingtem Auslösen und bildet zusätzlich die Standby-Zustände des elektronischen Schaltpfads ab, womit er UC-02 unmittelbar trägt. Register 3113 meldet zurück, ob ein Fernschaltbefehl ausgeführt wurde, und ist die Voraussetzung dafür, dass UC-06 nicht bei der Absendung des Befehls endet. Das Sammelregister 2560 trägt sämtliche Alarme des Geräts. Der Verbindungszustand aus Register $16484+n$ und die Empfangsfeldstärke aus Register 2622 tragen UC-04, wobei die Feldstärke die Verschlechterung einer Funkstrecke sichtbar macht, bevor die Verbindung abreißt. Von dem Feld über alle 24 Endgeräte wird nach K-04 nur der Index des jeweiligen Geräts abgebildet.


Aus dem Sammelregister 2560 werden 27 Alarmdatenpunkte gebildet, also alle für das #acro("ECPD") belegten Bits. Diese Gruppe zeigt die Wirkung von K-07 am deutlichsten. Sie hebt die Zahl der Datenpunkte je Gerät von 38 auf 65 und erhöht die Abfragelast um kein einziges Register, weil alle Bits aus demselben Register stammen. Die Bits 14 und 17 entfallen, da sie zur Fehlerlichtbogenerkennung einer anderen Gerätevariante gehören und auf dem #acro("ECPD") nicht gesetzt werden können, die Bits 21 bis 23 sind in der Bitfeldbeschreibung nicht vergeben. Beide Ausschlüsse folgen K-06. Die Alarme sind zugleich der Punkt, an dem das Modell allein nicht genügt. Von den 27 Bits sind 13 ab Werk abgeschaltet und liefern ohne Parametrierung dauerhaft den Wert null, darunter die beiden #acro("RCM")-Alarme. Welche Bits betroffen sind, weist @tab:apx_ecpd_alarme aus. Genau hierauf zielt NFA-06, und die zugehörige Einstellung des Testaufbaus ist in @sec:geraetekonfiguration beschrieben.


Die Messwerte umfassen acht Register. Aufgenommen sind Strom, Spannung, Netzfrequenz, Wirkleistung, Leistungsfaktor, Temperatur und der Differenzstrom des #acro("RCM")-Tiefpasses als Momentanwerte sowie der vom Gerät gespeicherte Maximalwert des Stroms. Der Maximalwert ist der in @sec:auswahlkriterien beschriebene Grenzfall von K-05, denn eine Stromspitze zwischen zwei Abfragen ist im Archiv nicht mehr herstellbar. Der Differenzstrom trägt UC-08 in besonderer Weise, da er den Isolationszustand als Verlauf zeigt und damit eine Verschlechterung erkennbar macht, bevor das Gerät abschaltet.



Vier Register der Registerkarte, die dort als Messwerte geführt werden, sind nicht aufgenommen, und dieser Ausschluss berührt FA-03. Die Anforderung verlangt die Sichtbarkeit sämtlicher Messwerte des #acro("ECPD"), und @sec:fa hält ausdrücklich fest, dass die Reduktion ihr nur so lange nicht entgegensteht, wie kein Messwert entfällt. Für Schein- und Blindleistung in den Registern 3088 und 3090 trägt K-05, da beide sich aus der abgebildeten Wirkleistung und dem Leistungsfaktor bilden lassen. Für die Mittelwerte von Temperatur und Strom in den Registern 3074 und 3078 trägt K-05 ebenfalls, allerdings mit einer Einschränkung. Der Gerätemittelwert wird über den in Register 3586 beziehungsweise 3597 parametrierten Zeitraum gebildet, während Desigo CC über die abgetasteten Werte mittelt. Beide Größen sind verwandt, aber nicht identisch, weshalb diese Abweichung im Anforderungsabgleich auszuweisen ist.


Die Netzfrequenz in Register 3084 ist dagegen aufgenommen, obwohl sie an jedem Endgerät denselben Wert zeigt und je Strang damit bis zu 24-fach erfasst wird. Eine andere Möglichkeit besteht nicht. Das Powercenter misst die Frequenz nicht, und aus den übrigen Datenpunkten lässt sie sich nicht bilden. Bliebe sie außen vor, fehlte dem Modell ein sehr relvanter Messwert vollständig. Die Doppelung wird deshalb bewusst in Kauf genommen.

Die Gruppe der Zähler und der Wartung umfasst sieben Register und trägt UC-08 nahezu allein. Betriebsstunden gesamt und unter Belastungsstrom, mechanische Schaltspiele sowie die nach Ursache getrennten Zähler für Auslösungen, Kurzschlussauslösungen und verzögerte Auslösungen erlauben es, einen Einsatz vorzubereiten, ohne zuvor vor Ort zu prüfen. Eine Häufung von Auslösungen an einem Abgang weist dabei auf ein Problem der Anlage hin und nicht auf einen Gerätefehler. Der Zähler der Änderungen an geschützten Parametern in Register 2726 gehört ebenfalls hierher und ist die Ergänzung zu K-03. Die geschützten Parameter selbst bleiben außerhalb des Modells, ihre Veränderung wird über diesen einen Zähler gleichwohl sichtbar, was für den Betreiber sicherheits- und haftungsrelevant ist.


Prüfung und Betriebsart umfassen drei Register. Der Status des Gerätetests und der Fehlercode des #acro("RCD")-Tests tragen gemeinsam UC-07 und sind die lesende Hälfte dessen, was FA-08 verlangt. Der Zustand des automatischen Wiedereinschaltens erklärt dem Betreiber, weshalb ein Abgang selbsttätig zurückgekehrt ist. Die in @sec:stakeholder benannte Grenze bleibt dabei bestehen, denn die wiederkehrende Prüfung nach #acro("DGUV") Vorschrift 3 setzt die Beurteilung durch eine befähigte Person voraus und wird durch diese Datenpunkte unterstützt, nicht ersetzt.


Als Kommandos sind sechs schreibende Register aufgenommen, die den in FA-06 gezogenen Rahmen ausfüllen. Das elektronische Schalten trägt UC-06, die Quittierung der Auslösemeldung UC-03, das Rücksetzen der #acro("RCM")-Alarme ebenfalls UC-03, der Anstoß des Gerätetests UC-07 und der Blinkmodus zur Lokalisierung UC-09. Der Blinkmodus ist relevant, da ein Servicetechniker im Verteiler bis zu 24 baugleiche Geräte vorfindet. Das sechste Kommando, das mechanische Trennen in Register 3694, ist der einzige Grenzfall der Auswahl. Es lässt sich als Befehl des laufenden Betriebs auffassen und fällt damit unter FA-06, es wirkt jedoch nicht rückstellbar, denn ein Register für das mechanische Einschalten existiert nicht. Ein aus der Ferne ausgelöstes Trennen erzwingt somit stets einen Einsatz vor Ort. Aufgenommen ist es unter dem Vorbehalt, dass die zugehörige Freigabe am Gerät gesetzt sein muss.


Die Stammdaten umfassen acht Register und tragen UC-10 sowie die von FA-03 geforderte Beschriftung. Anlagenkennzeichen und Einbauort machen aus einer Störungsmeldung eine verwertbare Information, Seriennummer und Artikelnummer tragen die Anlagendokumentation, die Phasenzuordnung erlaubt die Betrachtung der Schieflast über alle Abgänge eines Verteilers. Zwei Register dieser Gruppe haben eine besondere Aufgabe. Der eingestellte Nennstrom in Register 5376 ist zwingend erforderlich, weil die Stromgrenzwerte des Geräts in Prozent des Nennstroms angegeben sind und ein Messwert ohne diese Bezugsgröße nicht einzuordnen ist. Der Freigabestatus des elektronischen Schaltens in Register 5425 wird ausschließlich lesend genutzt und ist ein reines Diagnosemerkmal, das erklärt, weshalb ein Schaltbefehl wirkungslos bleibt. Der Nutzen dieses Datenpunkts hat sich im Verlauf der Arbeit bestätigt, wie @sec:befunde zeigt.


Die letzte Gruppe besteht aus einem einzigen Register. Das #acro("ECPD") führt intern ein Auslöseprotokoll und legt darin zu jeder Auslösung einen Eintrag mit Zeitpunkt und Messwerten ab. Das Protokoll selbst wird über ein eigenes, mehrstufiges Leseverfahren abgerufen, das nach K-01 nicht in das Modell aufgenommen ist. Register 3671 trägt die Kennung des jüngsten Eintrags und ändert sich deshalb bei jeder neuen Auslösung. Der Datenpunkt kostet ein einziges Register und zeigt an, dass eine weitere Auslösung hinzugekommen ist, auch wenn der zugehörige Alarm noch ansteht oder bereits quittiert wurde. Aus dem Alarmbit allein ließe sich das nicht erkennen.



#figure(
  table(
    columns: (12em, 5em, 7em, 1fr),
    inset: 6pt,
    align: (left + horizon, center + horizon, center + horizon, left + horizon),
    table.header(
      [*Gruppe*], [*Register*], [*Datenpunkte*], [*Tragende Anwendungsfälle*],
    ),
    [Live-Zustand], [5], [5], [UC-02, UC-04, UC-06],
    [Alarme aus Register 2560], [keines], [27], [UC-03],
    [Messwerte], [8], [8], [UC-02, UC-05, UC-08],
    [Zähler und Wartung], [7], [7], [UC-08],
    [Prüfung und Betriebsart], [3], [3], [UC-07],
    [Kommandos], [6], [6], [UC-03, UC-06, UC-07, UC-09],
    [Stammdaten], [8], [8], [UC-10],
    [Ereignis-Trigger], [1], [1], [UC-03, UC-08],
    [*Summe*], [*38*], [*65*], [],
  ),
  caption: [Aufgenommene Datenpunkte des #acro("ECPD") nach Gruppen, gegliedert nach gelesenen Registern und daraus gebildeten Datenpunkten]
)<tab:datenpunkte_ecpd>

==== Nicht aufgenommene Register des ECPD

Von den 208 Datenpunkten, welche die Registerkarte für das #acro("ECPD") ausweist, bleiben 170 unberücksichtigt. Sie verteilen sich auf acht Gruppen, die sich jeweils einem Kriterium zuordnen lassen. Zwei dieser Gruppen tragen zusammen zwei Drittel des Ausschlusses und verdienen deshalb eine eigene Begründung.


Die größte Gruppe bilden mit 61 Registern die Alarm- und Grenzwertkonfiguration sowie die zugehörigen Mittelungszeiträume. Zu nahezu jedem Alarm gehören ein Ein- und Ausschalter, ein Grenzwert und eine Hysterese. Diese Register werden bei der Inbetriebnahme gesetzt und verbleiben nach FA-09 bei SENTRON Powerconfig, während für den Betrieb allein das Ergebnis zählt, das über das Sammelregister 2560 vollständig vorliegt. Die zweite große Gruppe umfasst 52 Register der Funk- und Pairing-Diagnose, die am Endgerät als Felder über alle 24 Endgeräte des Strangs erscheinen. Sie gehören nach K-04 an das Powercenter, und von ihnen ist je Endgerät genau ein Index bedeutsam, der bereits in der Gruppe des Live-Zustands enthalten ist. Pairing- und Identifikationsstatus sind darüber hinaus reine Inbetriebnahmewerte.


#figure(
  table(
    columns: (1fr, 4em, 5em),
    inset: 6pt,
    align: (left, center + horizon, center + horizon),
    table.header(
      [*Nicht aufgenommene Gruppe*], [*Anzahl*], [*Kriterium*],
    ),
    [Alarm- und Grenzwertkonfiguration einschließlich Mittelungszeiträumen], [61], [K-02],
    [Funk- und Pairing-Diagnose als Felder über 24 Endgeräte], [52], [K-04],
    [Geschützte Schutzeinstellungen], [23], [K-03],
    [Geräteweit konstante oder nicht lesbare Identifikationsregister], [16], [K-06],
    [Abgeleitete Messwerte und nicht beschaltete Ein- und Ausgänge], [9], [K-05],
    [Zeitschaltuhr-Funktionsblöcke], [3], [K-05],
    [Werksrückstellung, Schreibschutz und Security-Register], [3], [K-03],
    [Protokollregister der verzögerten Quittierung], [3], [K-01],
    [*Summe*], [*170*], [],
  ),
  caption: [Nicht aufgenommene Register des #acro("ECPD") und das jeweils tragende Kriterium aus @tab:auswahlkriterien]
)<tab:ausschluss_ecpd>

Drei der kleineren Gruppen verdienen eine Erläuterung, weil ihr Ausschluss auf einer Eigenschaft der Zielplattform oder des Geräts beruht. Die Zeitschaltuhr-Funktionsblöcke liegen als Felder mit gepackten Zeitstempeln vor, die sich in Desigo CC nicht sinnvoll beschreiben lassen, während dieselbe Aufgabe über den Zeitplaner der Plattform und das bereits abgebildete Schaltkommando erfüllt werden kann. Die Protokollregister der verzögerten Quittierung gehören zum Schreibverfahren über die Funkstrecke und sind vom Modbus-Treiber auszuwerten, für den Betreiber tragen sie keine Tätigkeit und fallen damit unter K-01. Die digitalen Ein- und Ausgänge schließlich sind nur dann von Belang, wenn die zugehörige Zusatzfunktion des Geräts tatsächlich beschaltet ist, was am Testaufbau nicht der Fall ist.


==== Datenpunkte des Powercenters

Für das Powercenter fällt die Reduktion deutlicher aus, und zwar aus einem einzigen Grund. Von den 177 Datenpunkten der Registerkarte entfallen 121 auf Felder über alle 24 Endgeräte, also auf Schalterzustände, Zähler von Parameteränderungen, Pairing-, Verbindungs- und Identifikationszustände. Sie sämtlich am Powercenter abzubilden hieße, jeden dieser Werte doppelt zu führen und 24 fremde Geräte in ein Objekt zu mischen. K-04 löst diese Doppelung zugunsten des Endgeräts auf und trägt damit allein drei Viertel des Ausschlusses.


Aufgenommen sind 17 Register, die ausschließlich das Powercenter selbst betreffen. Das Sammelregister 2560 trägt auch hier die Alarme, von denen beim Powercenter nur die Übertemperatur und die Betriebsstunden belegt sind, da das Gerät weder misst noch schaltet. Die Temperatur des Powercenters ist der beste verfügbare Anhaltspunkt für das Klima im Verteiler, weil das Gerät dort zentral sitzt. Der Zeit- und Synchronisationsstatus entscheidet über die Güte sämtlicher Zeitstempel des Strangs, denn eine abweichende Uhr des Datentransceivers entwertet jedes Auslöseprotokoll der angeschlossenen Endgeräte. Der aktive Funkkanal erklärt gehäufte Verbindungsabbrüche eines ganzen Strangs und ergänzt damit die Empfangsfeldstärke der einzelnen Endgeräte.


Fünf Register beschreiben die Netzanbindung mit Adresse, Subnetzmaske, Gateway und Hardwareadresse sowie dem Zustand der Bluetooth-Schnittstelle. Sie tragen UC-04 aus der Sicht des IT-Betriebs, und der Zustand der Bluetooth-Schnittstelle ist darüber hinaus sicherheitsrelevant, weil er zeigt, ob der lokale Zugang für die Inbetriebnahme im Regelbetrieb offen steht. Die zugehörigen Konfigurationsregister sind demgegenüber nach K-02 und K-03 ausgeschlossen, da sie einmalig eingerichtet werden und einem geschützten Zugriff unterliegen. Abgebildet werden folglich die Ist-Werte, nicht deren Einstellung. Als einziger schreibender Datenpunkt ist die Uhrzeit aufgenommen, was den Fall abdeckt, dass am Standort kein Zeitserver vorgesehen ist. Die Stammdaten entsprechen denen des #acro("ECPD").


Aus dieser Auswahl entsteht in @sec:umsetzung eine eigene Typbeschreibung, die gegenüber der des #acro("ECPD") deutlich kleiner ausfällt. Der Schwerpunkt der Umsetzung liegt beim Endgerät, da dort die Messwerte, die Zählerstände und die Schaltfunktion liegen, während das Powercenter Zustands- und Diagnoseangaben des Strangs trägt.


==== Bilanz der Reduktion

Die Wirkung der Kriterien lässt sich beziffern. Ein vollständig bestückter Strang aus einem Powercenter und 24 Endgeräten umfasst nach @sec:registerraum 5169 Datenpunkte der Registerkarte. Nach Anwendung der Kriterien werden davon 929 Register gelesen, aus denen in Desigo CC 1579 Datenpunkte entstehen. Die Abfragelast sinkt damit um rund 82 Prozent, während die in der Leitwarte verfügbare Information deutlich weniger stark abnimmt, weil die Alarme aus einem einzigen Register gewonnen werden.


#figure(
  table(
    columns: (1fr, 7em, 7em, 8em),
    inset: 6pt,
    align: (left + horizon, center + horizon, center + horizon, center + horizon),
    table.header(
      [*Bezugsgröße*], [*Registerkarte*], [*Gelesene Register*], [*Datenpunkte in Desigo CC*],
    ),
    [Ein #acro("ECPD")], [208], [38], [65],
    [Ein Powercenter], [177], [17], [19],
    [Ein Strang mit 24 Endgeräten], [5.169], [929], [1.579],
  ),
  caption: [Bilanz der Datenauswahl je Gerät und je Strang]
)<tab:bilanz_datenpunkte>

Die Zahl der gelesenen Register ist dabei die für den Betrieb maßgebliche Größe. Gezählt sind die Einträge der Registerkarte, von denen einzelne nach K-07 je nach Datenformat mehrere aufeinanderfolgende Register belegen. Das Systemhandbuch empfiehlt, jedes Gerät höchstens einmal je Sekunde abzufragen und die Endgeräte sequenziell abzuarbeiten @src:sentronsystemhandbuch. Da der Treiber der Zielplattform benachbarte Register selbsttätig zu Leseblöcken zusammenfasst @src:desigoccenghelp, entspricht die verbleibende Last je Gerät einer geringen Zahl von Leseblöcken je Abfrage. Von den 929 Registern entfallen 124 auf die Gruppe des Live-Zustands, deren Werte am schnellsten aktuell sein müssen.


Diese Unterscheidung nach Aktualität ist in der Arbeitsmappe zu jedem Datenpunkt vermerkt, lässt sich am eingesetzten Stand jedoch nicht umsetzen. Das Abfrageintervall ist nach @tab:modbustreiber nur am Modbus-Treiber einstellbar und gilt dort für alle angebundenen Geräte, sodass Stammdaten und Zählerstände im selben Takt gelesen werden wie der Schalterzustand. Die Angaben zum Zyklus sind deshalb als Vorgabe für die Projektierung und für eine spätere Weiterentwicklung zu verstehen und nicht als Bestandteil der Typbeschreibung. Sie erhöhen zugleich das Gewicht der Reduktion, denn solange alle Datenpunkte denselben Takt teilen, bestimmt der schnellste benötigte Zyklus die Last sämtlicher übrigen Register.



Drei Datenpunkte der Auswahl stehen unter einem Vorbehalt, der sich erst bei der Umsetzung klären lässt. Das Register der Softwareversion ist wegen einer gemischten Kodierung derzeit nicht dekodierbar und widerspricht damit K-06, es bleibt vorläufig in der Auswahl und ist zu streichen, falls sich daran nichts ändert. Die beiden Betriebsstundenzähler liegen als Gleitkommazahlen doppelter Genauigkeit vor. Ob das Werkzeug der Typbeschreibung dafür einen Datentyp anbietet, war zum Zeitpunkt der Auswahl offen. Der Zeit- und Synchronisationsstatus des Powercenters schließlich war zum Zeitpunkt der Auswahl noch nicht am Testaufbau erprobt. Alle drei Punkte werden in @sec:umsetzung wieder aufgegriffen, wo die Zuordnung zu Datentypen und Transformationen erfolgt.


Was diese Auswahl nicht festlegt, ist die Form, in der die Datenpunkte im Modell erscheinen. Benennung, Datentyp, Skalierung, Byte-Reihenfolge und der Versatz zwischen Registerkarte und Telegramm sind Gegenstand von @sec:umsetzung. Die Auswahl legt allein fest, welche Register gelesen werden und aus welchem Grund.
