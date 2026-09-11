#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Ausgewählte Datenpunkte<sec:datenpunkte>

Die Kriterien aus @sec:auswahlkriterien werden im Folgenden auf beide Gerätetypen angewandt, zuerst auf das #acro("ECPD") und anschließend auf das Powercenter. Grundlage ist die Registerkarte der Gerätefamilie @src:sentronregistermap, deren Einträge nach @sec:quellenlage am Testaufbau gegengeprüft wurden. Das Ergebnis ist in der Arbeitsmappe des Anforderungskatalogs als eigene Aufstellung je Gerätetyp festgehalten, in der jede Zeile den Registerplatz, das Datenformat, den vorgeschlagenen Variablennamen und die Begründung der Aufnahme enthält. Der vorliegende Abschnitt gibt die Auswahl gruppenweise wieder und führt die Begründung. Die vollständigen Aufstellungen mit jedem einzelnen Register stehen in #ref(<apx:datenpunkte_ecpd>, supplement: [Anhang]) und #ref(<apx:datenpunkte_powercenter>, supplement: [Anhang]).

Die Darstellung folgt dabei einer Regel. Eine Reduktion um rund drei Viertel des Registerraums ist nur dann ein Ergebnis und keine Behauptung, wenn die nicht aufgenommenen Register ebenso begründet sind wie die aufgenommenen. Beide Seiten werden deshalb gleichrangig behandelt, und jede Ausschlussgruppe wird auf das Kriterium zurückgeführt, das sie begründet.

==== Datenpunkte des ECPD

Die Gruppe des Live-Zustands umfasst fünf Register und beantwortet die Frage, in welchem Zustand sich ein Abgang befindet. Der Schalterstatus in Register 3110 unterscheidet planmäßiges Ausschalten von störungsbedingtem Auslösen und bildet zusätzlich die Standby-Zustände des elektronischen Schaltpfads ab, womit er UC-02 unmittelbar unterstützt. Register 3113 meldet zurück, ob ein Fernschaltbefehl ausgeführt wurde, und ist die Voraussetzung dafür, dass UC-05 nicht bei der Absendung des Befehls endet. Das Sammelregister 2560 enthält sämtliche Alarme des Geräts. Der Verbindungszustand und die Empfangsfeldstärke aus Register 2622 unterstützen UC-04, wobei die Feldstärke die Verschlechterung einer Funkstrecke sichtbar macht, bevor die Verbindung abreißt. Der Verbindungszustand ist dabei der einzige Datenpunkt dieser Auswahl, der nicht aus dem Registersatz des #acro("ECPD") selbst stammt. Die Registerkarte führt ihn beim Powercenter als Feld über alle 24 Endgeräteplätze, dessen erster Platz auf Register 16484 liegt, sodass der Platz des Geräts mit der Adresse $n$ die Registernummer $16483+n$ erhält @src:sentronregistermap. Geführt wird er gleichwohl am Objekt des Endgeräts, weil er dessen Zustand beschreibt und eine Abbildung des vollständigen Feldes am Powercenter nach K-04 24 fremde Geräte in ein Objekt mischte. Als einzige Registeradresse der Typbeschreibung ist er damit je Instanz nachzuführen, worauf @sec:modelldoku gesondert hinweist.


Aus dem Sammelregister 2560 sind 27 Alarmdatenpunkte vorgesehen und damit alle für das #acro("ECPD") belegten Bits. Diese Gruppe zeigt die Wirkung von K-07 am deutlichsten. Sie hebt die Zahl der Datenpunkte je Gerät von 37 auf 64, ohne die Abfragelast um ein einziges Register zu erhöhen, weil alle Bits aus demselben Register stammen. Vorausgesetzt ist dabei, dass sich die einzelnen Bits in der Typbeschreibung herauslösen lassen. Dass das mit der eingesetzten Werkzeugkette nicht gelingt und der Registerinhalt stattdessen als eine Zahl übertragen wird, zeigt erst die Umsetzung in @sec:umsetzung. Die Auswahl der Register bleibt davon unberührt, die Zahl der Datenpunkte nicht. Die Bits 14 und 17 entfallen, da sie zur Fehlerlichtbogenerkennung einer anderen Gerätevariante gehören und auf dem #acro("ECPD") nicht gesetzt werden können, die Bits 21 bis 23 sind in der Bitfeldbeschreibung nicht vergeben. Beide Ausschlüsse folgen K-06. Die Alarme sind zugleich der Punkt, an dem das Modell allein nicht genügt, denn 13 der 27 Bits sind nach @sec:registerraum ab Werk abgeschaltet. Welche Bits betroffen sind, weist @tab:apx_ecpd_alarme aus.


Die Messwerte umfassen acht Register. Aufgenommen sind Strom, Spannung, Netzfrequenz, Wirkleistung, Leistungsfaktor, Temperatur und der Differenzstrom des #acro("RCM")-Tiefpasses als Momentanwerte sowie der vom Gerät gespeicherte Maximalwert des Stroms. Der Maximalwert ist der in @sec:auswahlkriterien beschriebene Grenzfall von K-05, denn eine Stromspitze zwischen zwei Abfragen ist im Archiv nicht mehr herstellbar. Der Differenzstrom unterstützt UC-07 in besonderer Weise, da er den Isolationszustand als Verlauf zeigt und damit eine Verschlechterung erkennbar macht, bevor das Gerät abschaltet.


Fünf Register der Registerkarte, die dort als Messwerte geführt werden, sind nicht aufgenommen, und dieser Ausschluss berührt FA-03. Die Anforderung verlangt die Sichtbarkeit sämtlicher Messwerte des #acro("ECPD"), und @sec:fa hält ausdrücklich fest, dass die Reduktion ihr nur so lange nicht entgegensteht, wie kein Messwert entfällt. Für Schein- und Blindleistung in den Registern 3088 und 3090 greift K-05, da beide sich aus der abgebildeten Wirkleistung und dem Leistungsfaktor bilden lassen. Für die Mittelwerte von Temperatur und Strom in den Registern 3074 und 3078 greift K-05 ebenfalls, allerdings mit einer Einschränkung. Der Gerätemittelwert wird über den in Register 3586 beziehungsweise 3597 parametrierten Zeitraum gebildet, während Desigo CC über die abgetasteten Werte mittelt. Beide Größen sind verwandt, aber nicht identisch, weshalb diese Abweichung im Anforderungsabgleich auszuweisen ist. Für den AC-Differenzstrom schließlich führt die Registerkarte zwei Werte, den Tiefpasswert in Register 3330 und den Wert der Grundfrequenz in Register 3338. Aufgenommen ist allein der Tiefpasswert, der den Isolationszustand als Verlauf abbildet. Der zweite Wert beschreibt dieselbe Größe in einem anderen Auswertungsband und begründet für den Betreiber keine eigene Tätigkeit, weshalb hier K-01 greift und nicht K-05, denn aus dem einen Wert lässt sich der andere nicht bilden.


Die Netzfrequenz in Register 3084 ist dagegen aufgenommen, obwohl sie an jedem Endgerät denselben Wert zeigt und je Strang damit bis zu 24-fach erfasst wird. Eine andere Möglichkeit besteht nicht. Das Powercenter misst die Frequenz nicht, und aus den übrigen Datenpunkten lässt sie sich nicht bilden. Bliebe sie außen vor, fehlte dem Modell ein sehr relevanter Messwert vollständig. Die Doppelung wird deshalb bewusst in Kauf genommen.

Die Gruppe der Zähler und der Wartung umfasst sieben Register und deckt UC-07 nahezu allein ab. Betriebsstunden gesamt und unter Belastungsstrom, mechanische Schaltspiele sowie die nach Ursache getrennten Zähler für Auslösungen, Kurzschlussauslösungen und verzögerte Auslösungen erlauben es, einen Einsatz vorzubereiten, ohne zuvor vor Ort zu prüfen. Eine Häufung von Auslösungen an einem Abgang weist dabei auf ein Problem der Anlage hin und nicht auf einen Gerätefehler. Der Zähler der Änderungen an geschützten Parametern in Register 2726 gehört ebenfalls in diese Gruppe und ist die Ergänzung zu K-03. Die geschützten Parameter selbst bleiben außerhalb des Modells, ihre Veränderung wird über diesen einen Zähler gleichwohl sichtbar, was für den Betreiber sicherheits- und haftungsrelevant ist.


Prüfung und Betriebsart umfassen drei Register. Der Status des Gerätetests und der Fehlercode des #acro("RCD")-Tests unterstützen gemeinsam UC-06 und sind die lesende Hälfte dessen, was FA-08 verlangt. Der Zustand des automatischen Wiedereinschaltens erklärt dem Betreiber, weshalb ein Abgang selbsttätig zurückgekehrt ist. Die in @sec:stakeholder benannte Grenze bleibt dabei bestehen, denn diese Datenpunkte unterstützen die wiederkehrende Prüfung und ersetzen sie nicht.


Als Kommandos sind sechs schreibende Register aufgenommen, die den in FA-06 gezogenen Rahmen ausfüllen. Das elektronische Schalten unterstützt UC-05, die Quittierung der Auslösemeldung UC-03, das Rücksetzen der #acro("RCM")-Alarme ebenfalls UC-03, der Anstoß des Gerätetests UC-06 und der Blinkmodus zur Lokalisierung UC-08. Der Blinkmodus ist relevant, da ein Servicetechniker im Verteiler bis zu 24 baugleiche Geräte vorfindet. Das sechste Kommando, das mechanische Trennen in Register 3694, ist der einzige Grenzfall der Auswahl. Es lässt sich als Befehl des laufenden Betriebs auffassen und fällt damit unter FA-06, es wirkt jedoch nicht rückstellbar, denn ein Register für das mechanische Einschalten existiert nicht. Ein aus der Ferne ausgelöstes Trennen erzwingt somit stets einen Einsatz vor Ort. Aufgenommen ist es unter dem Vorbehalt, dass die zugehörige Freigabe am Gerät gesetzt sein muss.


Die Stammdaten umfassen sieben Register und unterstützen UC-09 sowie die von FA-03 geforderte Beschriftung. Anlagenkennzeichen und Einbauort machen aus einer Störungsmeldung eine verwertbare Information, Seriennummer und Artikelnummer dienen der Anlagendokumentation, die Phasenzuordnung erlaubt die Betrachtung der Schieflast, der ungleichen Belastung der drei Außenleiter, über alle Abgänge eines Verteilers. Zwei Register dieser Gruppe haben eine besondere Aufgabe. Der eingestellte Nennstrom in Register 5376 ist zwingend erforderlich, weil die Stromgrenzwerte des Geräts in Prozent des Nennstroms angegeben sind und ein Messwert ohne diese Bezugsgröße nicht einzuordnen ist. Der Freigabestatus des elektronischen Schaltens in Register 5425 wird ausschließlich lesend genutzt und ist ein reines Diagnosemerkmal, das erklärt, weshalb ein Schaltbefehl wirkungslos bleibt. Der Nutzen dieses Datenpunkts hat sich im Verlauf der Arbeit bestätigt, wie @sec:befunde zeigt.


Die letzte Gruppe besteht aus einem einzigen Register. Das #acro("ECPD") führt intern ein Auslöseprotokoll und legt darin zu jeder Auslösung einen Eintrag mit Zeitpunkt und Messwerten ab. Das Protokoll selbst wird über ein eigenes, mehrstufiges Leseverfahren abgerufen, das nach K-01 nicht in das Modell aufgenommen ist. Register 3671 enthält die Kennung des jüngsten Eintrags und ändert sich deshalb bei jeder neuen Auslösung. Der Datenpunkt kostet ein einziges Register und zeigt an, dass eine weitere Auslösung hinzugekommen ist, auch wenn der zugehörige Alarm noch ansteht oder bereits quittiert wurde. Aus dem Alarmbit allein ließe sich das nicht erkennen.


#figure(
  table(
    columns: (12em, 5em, 7em, 1fr),
    inset: 6pt,
    align: (left + horizon, center + horizon, center + horizon, left + horizon),
    table.header(
      [*Gruppe*], [*Register*], [*Datenpunkte (vorgesehen)*], [*Zugehörige Anwendungsfälle*],
    ),
    [Live-Zustand], [5], [5], [UC-02, UC-04, UC-05],
    [Alarme aus Register 2560], [keines zusätzlich], [27], [UC-03],
    [Messwerte], [8], [8], [UC-02, UC-07],
    [Zähler und Wartung], [7], [7], [UC-07],
    [Prüfung und Betriebsart], [3], [3], [UC-06],
    [Kommandos], [6], [6], [UC-03, UC-05, UC-06, UC-08],
    [Stammdaten], [7], [7], [UC-09],
    [Ereignis-Trigger], [1], [1], [UC-03, UC-07],
    [*Summe je Gerät*], [*37*], [*64*], [],
    [*Strang mit 24 Endgeräten*], [*888*], [*1536*], [],
  ),
  caption: [Aufgenommene Datenpunkte des #acro("ECPD") nach Gruppen, gegliedert nach gelesenen Registern und daraus vorgesehenen Datenpunkten. Das Sammelregister 2560 ist in der Gruppe des Live-Zustands bereits mitgezählt, weshalb die 27 Alarme kein weiteres Register kosten. Die Schlusszeile rechnet die Summe auf einen voll bestückten Strang hoch und führt allein dessen Endgeräte]
)<tab:datenpunkte_ecpd>

Die Schlusszeile führt allein die Endgeräte eines Strangs. Was das Powercenter beiträgt, begründet der folgende Abschnitt, und @tab:bilanz_datenpunkte stellt beide Gerätetypen zusammen.

Die Spalte der Datenpunkte gibt aus, was die Auswahl vorsieht. Die 27 Alarme fallen in der umgesetzten Fassung nach @sec:umsetzung in einem einzigen Datenpunkt zusammen, sodass je Gerät 37 Datenpunkte entstehen. Die übrigen Zeilen sind davon nicht berührt.


==== Nicht aufgenommene Register des ECPD

Von den 152 Einträgen, welche die Registerkarte für das #acro("ECPD") ausweist, bleiben 116 unberücksichtigt. Sie verteilen sich auf sieben Gruppen, die sich jeweils einem Kriterium zuordnen lassen. Zwei dieser Gruppen machen zusammen drei Viertel des Ausschlusses aus und verdienen deshalb eine eigene Begründung.

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
    [Abgeleitete und doppelt geführte Messwerte], [5], [K-05, K-01],
    [Status der digitalen Ein- und Ausgänge], [2], [K-01],
    [Gerätezustände ohne Nutzen im laufenden Betrieb], [2], [K-01, K-04],
    [Zeitschaltuhr-Funktionsblöcke], [3], [K-05],
    [Im Auswahlblatt nicht erfasst (Funk-Sendeleistung 1050)], [1], [K-02],
    [*Summe*], [*116*], [],
  ),
  caption: [Nicht aufgenommene Register des #acro("ECPD") und das jeweils maßgebliche Kriterium aus @tab:auswahlkriterien]
)<tab:ausschluss_ecpd>

Vier der kleineren Gruppen verdienen eine Erläuterung, weil ihr Ausschluss auf einer Eigenschaft der Zielplattform oder des Geräts beruht. Die Zeitschaltuhr-Funktionsblöcke liegen als Felder mit gepackten Zeitstempeln vor, die sich in Desigo CC nicht sinnvoll beschreiben lassen, während dieselbe Aufgabe über den Zeitplaner der Plattform und das bereits abgebildete Schaltkommando erfüllt werden kann. Die Protokollregister der verzögerten Quittierung, die die Registerkarte beim Powercenter führt, gehören zum Schreibverfahren über die Funkstrecke und sind vom Modbus-Treiber auszuwerten, für den Betreiber unterstützen sie keine Tätigkeit und fallen damit unter K-01.

Die digitalen Ein- und Ausgänge sind eine Zusatzfunktion, über die sich ein potentialfreier Kontakt einlesen und ein Signal ausgeben lässt. Das Gerät führt ihren Zustand in zwei Registern, die als Bitfeld je zwei Eingänge und zwei Ausgänge abbilden, während die zugehörige Parametrierung nach @sec:ecpd_geraet zu den geschützten Parametern zählt und schon deshalb nach K-03 außen vor bleibt. Was ein solcher Kontakt bedeutet, legt die Beschaltung im einzelnen Verteiler fest und nicht der Gerätetyp. Ein Eingang kann in der einen Anlage eine Schranktür melden und in der nächsten eine Freigabe, weshalb sich für ihn weder eine über Anlagen hinweg gültige Benennung noch eine Begründung der Aufnahme angeben lässt, wie sie @sec:auswahlkriterien für jeden Datenpunkt verlangt. Eine Typbeschreibung, die den Gerätetyp und nicht die Anlage beschreibt, kann diese Register deshalb nicht sinnvoll abbilden. Sie fallen damit unter K-01, und die fehlende Beschaltung am Testaufbau ist die Folge dieser Einordnung und nicht ihr Grund. Dass die Gerätereihe für diese Aufgabe nach @sec:ecpd ein eigenes Ein- und Ausgangsmodul führt, stützt die Einordnung als Zusatzfunktion.

Die vierte Gruppe umfasst zwei Zustandsregister, die für den laufenden Betrieb ohne Aussage sind. Der Sperrzustand der geschützten Parameter bildet den Ablauf der in @sec:ecpd_geraet beschriebenen Freigabe ab und ist außerhalb einer Sitzung mit SENTRON Powerconfig stets derselbe, weshalb K-01 greift. Er ist damit von dem in @sec:datenpunkte aufgenommenen Freigabestatus des elektronischen Schaltens zu unterscheiden, der erklärt, weshalb ein abgebildetes Kommando wirkungslos bleibt. Die lokale Zeitinformation des Endgeräts entfällt nach K-04, da der Zeit- und Synchronisationsstatus je Strang einmal am Powercenter geführt wird und dort nach @sec:datenpunkte über die Güte sämtlicher Zeitstempel entscheidet.


==== Datenpunkte des Powercenters

Für das Powercenter fällt die Reduktion deutlicher aus, und zwar aus einem einzigen Grund. Von den 211 Einträgen der Registerkarte entfallen 126 auf Funkparameter, überwiegend auf Felder je Endgeräteplatz, dazu auf Schalterzustände, Zähler von Parameteränderungen sowie Pairing-, Verbindungs- und Identifikationszustände. Sie sämtlich am Powercenter abzubilden hieße, jeden dieser Werte doppelt zu führen und bis zu 24 fremde Geräte in ein Objekt zu mischen. K-04 löst diese Doppelung zugunsten des Endgeräts auf und begründet damit den größten Teil des Ausschlusses.


Aufgenommen sind 16 Register, die ausschließlich das Powercenter selbst betreffen. Das Sammelregister 2560 enthält auch hier die Alarme, von denen beim Powercenter nur die Übertemperatur und die Betriebsstunden belegt sind, da das Gerät weder misst noch schaltet. Die Temperatur des Powercenters ist der beste verfügbare Anhaltspunkt für das Klima im Verteiler, weil das Gerät dort zentral sitzt. Der Zeit- und Synchronisationsstatus entscheidet über die Güte sämtlicher Zeitstempel des Strangs, denn eine abweichende Uhr des Datentransceivers entwertet jedes Auslöseprotokoll der angeschlossenen Endgeräte. Der aktive Funkkanal erklärt gehäufte Verbindungsabbrüche eines ganzen Strangs und ergänzt damit die Empfangsfeldstärke der einzelnen Endgeräte.


Fünf Register beschreiben die Netzanbindung mit Adresse, Subnetzmaske, Gateway und Hardwareadresse sowie dem Zustand der Bluetooth-Schnittstelle. Sie unterstützen UC-04 aus der Sicht des IT-Betriebs, und der Zustand der Bluetooth-Schnittstelle ist darüber hinaus sicherheitsrelevant, weil er zeigt, ob der lokale Zugang für die Inbetriebnahme im Regelbetrieb offen steht. Die zugehörigen Konfigurationsregister sind demgegenüber nach K-02 und K-03 ausgeschlossen, da sie einmalig eingerichtet werden und einem geschützten Zugriff unterliegen. Abgebildet werden folglich die Ist-Werte, nicht deren Einstellung. Als einziger schreibender Datenpunkt ist die Uhrzeit aufgenommen, was den Fall abdeckt, dass am Standort kein Zeitserver vorgesehen ist. Die Stammdaten entsprechen denen des #acro("ECPD").


Aus dieser Auswahl entsteht in @sec:umsetzung eine eigene Typbeschreibung, die gegenüber der des #acro("ECPD") deutlich kleiner ausfällt. Der Schwerpunkt der Umsetzung liegt beim Endgerät, da dort die Messwerte, die Zählerstände und die Schaltfunktion liegen, während das Powercenter Zustands- und Diagnoseangaben des Strangs bereitstellt.


==== Bilanz der Reduktion

Die Wirkung der Kriterien lässt sich beziffern, und zwar zunächst je Gerätetyp. Für das #acro("ECPD") weist die Registerkarte nach @sec:registerraum 152 Einträge aus, von denen 37 Register gelesen werden und aus denen in Desigo CC 64 Datenpunkte vorgesehen sind. Für das Powercenter stehen 16 gelesene Register und 18 vorgesehene Datenpunkte 211 Einträgen gegenüber. Der abgebildete Registerraum sinkt damit beim Endgerät um rund 76 und beim Datentransceiver um rund 92 Prozent, während die in der Leitwarte verfügbare Information deutlich weniger stark abnimmt, weil die Alarme aus einem einzigen Register gewonnen werden.

Die für den Betrieb maßgebliche Bezugsgröße ist der voll bestückte Strang, da ein Datentransceiver nach @sec:powercenter bis zu 24 Endgeräte bedient und in einer Anlage stets mehrere Abgänge zu schützen sind. Ein solcher Strang umfasst 3859 Einträge der Registerkarte, von denen 904 Register gelesen werden und aus denen 1554 Datenpunkte vorgesehen sind. Das ist eine Reduktion des abgebildeten Registerraums um rund 77 Prozent. Der Wert folgt dem Endgerät und nicht dem Datentransceiver, weil dieser je Strang nur einmal vorkommt.


Als Vergleichsfall führt die Bilanz zusätzlich den Strang aus einem Powercenter und einem einzigen Endgerät, wie ihn der Testaufbau nach @sec:testaufbau abbildet. Er umfasst 363 Einträge, von denen 53 Register gelesen werden und aus denen 82 Datenpunkte vorgesehen sind, was einer Reduktion um rund 85 Prozent entspricht. Dass der Anteil höher ausfällt als beim voll bestückten Strang, liegt am Gewicht des Datentransceivers, dessen Registerraum am stärksten schrumpft und der hier einem statt 24 Endgeräten gegenübersteht. Der voll bestückte Strang bleibt deshalb die maßgebliche Angabe, während der Vergleichsfall zeigt, wie die Reduktion an dem Aufbau ausfällt, an dem sie geprüft wurde.


Die Angabe bezieht sich auf die Einträge der Registerkarte und nicht auf die tatsächliche Kommunikationslast. Ein Eintrag umfasst nach @sec:registerraum je nach Format ein oder mehrere Register, und der Treiber fasst benachbarte Register nach @tab:modbustreiber selbsttätig zu Leseblöcken zusammen. Welcher Umfang daraus tatsächlich übertragen wird, weist erst die Aufzeichnung in @sec:testdurchfuehrung mit 69 gelesenen Registerworten je Abfragezyklus eines #acro("ECPD") aus. Eine Messung des vollständig abgebildeten Registerraums als Vergleichsgröße liegt nicht vor, weshalb die Reduktion der Abfragelast begründet zu erwarten, aber nicht in derselben Höhe belegt ist. Für das #acro("ECPD") allein decken sich beide Betrachtungen weitgehend, da den 37 von 152 Einträgen 69 von 294 lesbaren Registerworten gegenüberstehen.


#figure(
  // Mit der sechsten Spalte wird die Kopfzeile zweizeilig, wodurch die Tabelle
  // zuvor eine Seite vor ihrer Unterschrift umbrach und dort nur noch die
  // letzte Zeile stand. Der Block haelt sie zusammen.
  block(breakable: false)[#table(
    columns: (1fr, 5.4em, 5.4em, 6.8em, 6.8em, 5.2em),
    inset: (x: 6pt, y: 6pt),
    align: (left + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
    table.header(
      [*Bezugsgröße*], [*Register-\ karte*], [*Gelesene Register*], [*Datenpunkte vorgesehen*], [*Datenpunkte umgesetzt*], [*Reduktion*],
    ),
    [Ein #acro("ECPD")], [152], [37], [64], [37], [$76space.thin"%"$],
    [Ein Powercenter], [211], [16], [18], [16], [$92space.thin"%"$],
    [Strang mit einem Endgerät], [363], [53], [82], [53], [$85space.thin"%"$],
    [Voll bestückter Strang mit 24 Endgeräten], [3859], [904], [1554], [904], [$77space.thin"%"$],
  )],
  caption: [Bilanz der Datenauswahl je Gerätetyp sowie für einen Strang mit einem und mit 24 Endgeräten. Die Reduktion bezieht sich auf den abgebildeten Registerraum, also auf die gelesenen Register gegenüber den Einträgen der Registerkarte. Die vorgesehenen Datenpunkte zählen die Alarme des Sammelregisters einzeln, die umgesetzten führen sie je Gerät als einen Wert]
)<tab:bilanz_datenpunkte>

Die beiden Spalten der Datenpunkte unterscheiden sich allein in den Alarmen. Vorgesehen ist je belegtem Bit des Sammelregisters ein eigener Datenpunkt, umgesetzt ist nach @sec:umsetzung ein einziger Wert je Gerät, der den gesamten Registerinhalt als Zahl führt. Die Auswahl der Register ist davon nicht berührt, weshalb die Reduktion des abgebildeten Registerraums in beiden Fällen gleich ausfällt. Für die Anzeige in der Leitwarte ist der Unterschied dagegen erheblich und bei FA-04 und FA-05 in @sec:anforderungsabgleich ausgewiesen.


Die Zahl der gelesenen Register ist dabei die für den Betrieb maßgebliche Größe. Gezählt sind die Einträge der Registerkarte, von denen einzelne nach K-07 je nach Datenformat mehrere aufeinanderfolgende Register belegen. Das Systemhandbuch empfiehlt, jedes Gerät höchstens einmal je Sekunde abzufragen und die Endgeräte sequenziell abzuarbeiten @src:sentronsystemhandbuch. Da der Treiber der Zielplattform benachbarte Register selbsttätig zu Leseblöcken zusammenfasst @src:desigoccenghelp, fällt die verbleibende Last je Gerät deutlich geringer aus als die Zahl der Einträge vermuten lässt. Die Messung in @sec:testdurchfuehrung beziffert sie für das #acro("ECPD") auf zwölf Anfragen je Abfragezyklus, von denen neun die 37 aufgenommenen Einträge als insgesamt 69 Registerworte in Blöcken zwischen einem und 42 Wörtern abholen. Ein voll bestückter Strang mit 24 Endgeräten käme damit rechnerisch auf 288 Anfragen je Zyklus zuzüglich derjenigen des Powercenters. Von den 37 Einträgen des #acro("ECPD") entfallen 5 auf die Gruppe des Live-Zustands, deren Werte am schnellsten aktuell sein müssen.


Diese Unterscheidung nach Aktualität ist in der Arbeitsmappe zu jedem Datenpunkt vermerkt, lässt sich am eingesetzten Stand nach @sec:konzept jedoch nicht umsetzen. Die Angaben zum Zyklus sind deshalb als Vorgabe für die Projektierung und für eine spätere Weiterentwicklung zu verstehen und nicht als Bestandteil der Typbeschreibung. Sie erhöhen zugleich das Gewicht der Reduktion.


Zwei Datenpunkte der Auswahl stehen unter einem Vorbehalt, der sich erst bei der Umsetzung klären lässt. Das Register der Softwareversion ist wegen einer gemischten Kodierung derzeit nicht dekodierbar und widerspricht damit K-06, es bleibt vorläufig in der Auswahl und ist zu streichen, falls sich daran nichts ändert. Der Zeit- und Synchronisationsstatus des Powercenters war zum Zeitpunkt der Auswahl noch nicht am Testaufbau erprobt. Beide Punkte werden in @sec:umsetzung wieder aufgegriffen, wo die Zuordnung zu Datentypen und Transformationen erfolgt.


Was diese Auswahl nicht festlegt, ist die Form, in der die Datenpunkte im Modell erscheinen. Benennung, Datentyp, Skalierung, Byte-Reihenfolge und der Versatz zwischen Registerkarte und Telegramm sind Gegenstand von @sec:umsetzung. Die Auswahl legt allein fest, welche Register gelesen werden und aus welchem Grund.


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

/* Claude: Der zweite Teil des VORBEHALTs darueber (Straenge je Treiberinstanz)
   ist am 11.09.2026 erledigt. Die Engineering Help nennt im Thema
   "Modbus Driver" zehn gleichzeitig laufende Treiber je Server und hoechstens
   35000 Datenpunkte je Treiber. Die Grenze steht jetzt als Zeile
   "Mengengeruest" in @tab:modbustreiber und ist im Absatz darunter belegt.
   Der erste Teil (Register 1050 im Auswahlblatt nachtragen) bleibt offen. */

/* Claude: Am 02.09.2026 an drei Stellen gekuerzt. Die ab Werk abgeschalteten
   Alarmbits sind auf den Verweis nach @sec:registerraum reduziert, die
   DGUV-Grenze auf den bereits vorhandenen Verweis nach @sec:stakeholder, und
   die Herleitung des einheitlichen Abfrageintervalls am Ende der Bilanz
   entfaellt, da sie im selben Absatz ueber @sec:konzept schon angefuehrt ist. */

/* Claude: Am 11.09.2026 sind die vier Stellen nachgezogen, die @sec:umsetzung
   im Abschnitt zu den Alarmen als offen benennt. Die Zahlen der Auswahl setzten
   voraus, dass sich das Sammelregister zerlegen laesst; umgesetzt ist ein
   einziger Datenpunkt je Geraet.

   Geaendert ist nicht die Auswahl, sondern ihre Beschriftung. Die Spalte in
   @tab:datenpunkte_ecpd heisst jetzt "Datenpunkte (vorgesehen)",
   @tab:bilanz_datenpunkte fuehrt daneben eine Spalte "Datenpunkte umgesetzt"
   mit 37 / 16 / 53 / 904. Der Unterschied betrifft ausschliesslich die Alarme,
   beim ECPD 27 und beim Powercenter 2 Bits, und ist im Absatz unter der Tabelle
   benannt. Der Absatz zu den Alarmen fuehrt die Zerlegung jetzt als
   Voraussetzung ein und verweist nach vorn auf @sec:umsetzung.

   Die Reduktionsangaben bleiben unberuehrt, weil sie ueber gelesene Register
   rechnen. Abstract, Kurzfassung und @sec:zusammenfassung nennen ohnehin nur
   904 gelesene Register und 77 Prozent, dort war nichts nachzuziehen.

   @tab:bilanz_datenpunkte steht wegen der sechsten Spalte in einem
   `block(breakable: false)`. Ohne ihn brach sie um und liess nur die letzte
   Zeile bei der Unterschrift stehen. */

/* Claude: @tab:bilanz_datenpunkte fuehrt seit dem 11.09.2026 wieder den Strang
   aus einem Powercenter und einem Endgeraet (363 / 53 / 82), der bis zum
   08.09.2026 der Bezugsfall der Bilanz war und beim Wechsel auf den voll
   bestueckten Strang herausgefallen ist. Er steht jetzt als Vergleichszeile
   neben dem voll bestueckten Strang, weil er der am Testaufbau nach RB-04
   tatsaechlich geprueften Konstellation entspricht.

   Neu ist ausserdem die Spalte "Reduktion", damit sich die vier Bezugsgroessen
   unmittelbar vergleichen lassen. Die Werte sind das Verhaeltnis der gelesenen
   Register zu den Eintraegen der Registerkarte, gerundet: 37/152 = 76 Prozent,
   16/211 = 92 Prozent, 53/363 = 85 Prozent, 904/3859 = 77 Prozent. Die ersten
   beiden und der letzte standen schon im Text, der Vergleichsfall ist im neuen
   Absatz darueber ergaenzt. Dass der Anteil beim kleinen Strang hoeher liegt,
   ist dort erklaert und nicht als besseres Ergebnis dargestellt.

   Falls die Spalte den Satzspiegel sprengt, ist sie der erste Kandidat zum
   Streichen, die Zahlen stehen auch im Fliesstext. */

/* Claude: @tab:datenpunkte_ecpd hat am 11.09.2026 eine Schlusszeile fuer einen
   voll bestueckten Strang bekommen, 24 x 37 = 888 Register und
   24 x 64 = 1536 Datenpunkte. Die Zeile "Summe" heisst jetzt "Summe je Geraet",
   damit die beiden Bezugsgroessen auseinandergehalten werden.

   Gegenprobe zu @tab:bilanz_datenpunkte, die den Strang einschliesslich
   Powercenter fuehrt: 888 + 16 = 904 gelesene Register und
   1536 + 18 = 1554 Datenpunkte. Beide Tabellen stimmen damit ueberein. Der
   Satz unter der Tabelle sagt ausdruecklich, dass die Schlusszeile das
   Powercenter noch nicht enthaelt, damit die 888 nicht gegen die 904 gelesen
   werden. */

/* Claude: Am 07.09.2026 nach einem Gutachterhinweis praezisiert. Die 85 Prozent
   sind das Verhaeltnis 53 zu 363 und damit eine Aussage ueber Eintraege der
   Registerkarte, nicht ueber die gemessene Kommunikationslast. Der Satz nennt
   deshalb den abgebildeten Registerraum, und der neue Absatz trennt beide
   Groessen und verweist auf die 69 Registerworte je ECPD-Zyklus aus
   @sec:testdurchfuehrung.

   Zahlenbasis aus der Spalte "Laenge" der Registerkarte, Geraetespalten
   "5TY1 COM ECPD" und "POC 1100": ECPD 152 Eintraege = 307 Registerworte
   (lesbar 140 Eintraege = 294 Worte), Powercenter 211 Eintraege = 3471 Worte
   (lesbar 201 Eintraege = 1192 Worte), Strang 363 Eintraege = 3778 Worte
   (lesbar 1486 Worte). Fuer das ECPD allein decken sich Eintrags- und
   Wortbetrachtung (37/152 = 76 Prozent gegenueber 69/294 = 77 Prozent), fuer
   den Strang nicht, weil die Powercenter-Eintraege deutlich laenger sind.
   Diese Zahlen sind hier nicht in den Text uebernommen, sie stuenden bereit,
   falls die Bilanz um eine wortbezogene Angabe ergaenzt werden soll.

   Mitgefuehrt sind der Abstract, die Kurzfassung, @sec:zusammenfassung und
   @sec:nachhaltigkeit. Die aelteren Anmerkungen oben nennen die 85 Prozent
   weiterhin als Reduktion schlechthin und sind als Verlauf stehen geblieben. */
