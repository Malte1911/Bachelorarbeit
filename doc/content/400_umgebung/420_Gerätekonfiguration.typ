#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Konfiguration der Geräte<sec:geraetekonfiguration>

Die Geräte des Testaufbaus sind vor der Anbindung an Desigo CC zu parametrieren. Diese Parametrierung erfolgt nach der in @sec:fa begründeten Arbeitsteilung ausschließlich über SENTRON Powerconfig und ist damit selbst nicht Teil des Datenmodells. Sie wird hier dennoch beschrieben, weil das Datenmodell auf einem so eingerichteten Gerät aufsetzt und einzelne Datenpunkte ohne sie ohne Aussage bleiben.


Der Zugang zum Powercenter erfolgt über die Bluetooth-Schnittstelle vor Ort oder über die REST-#acro("API") im Netz @src:sentronsystemhandbuch. Am Testaufbau wird ausschließlich der Weg über das Netz genutzt. SENTRON Powerconfig kommt nach RB-01 in der Desktop-Variante zum Einsatz und erreicht das Powercenter über dessen Ethernet-Schnittstelle, sodass die Parametrierung beider Geräte über diesen einen Zugang läuft. Der Weg über #acro("BLE") und mit ihm die mobile Anwendung bleiben aus den in @sec:rb genannten Gründen ungenutzt. Bei der Erstinbetriebnahme ist zwingend ein Administrator anzulegen, ein Standardpasswort existiert nicht. Anschließend wird die Modbus-#acro("TCP")-Schnittstelle eingeschaltet, die sich am Powercenter 1100 separat aktivieren und abschalten lässt. RB-05 begrenzt diese Aktivierung ausdrücklich auf den Aufbau, an dem sie für die Anbindung benötigt wird. 
// #kommentar[Bitte ergänzen, ob am Powercenter neben Modbus #acro("TCP") und dem Zugang für die Parametrierung weitere Schnittstellen aktiv sind. Falls die rollenbasierte Zugriffskontrolle über den angelegten Administrator hinaus eingerichtet wurde, gehört das ebenfalls hierher.]


Jedes Endgerät tritt dem Funknetz des Datentransceivers über einen aufgedruckten Code bei, der Gerätetyp, Adresse und Installationscode trägt (siehe @sec:ecpd_konnektivitaet). Mit der Kopplung erhält das Endgerät seine Geräteadresse, die standardmäßig fortlaufend ab 1 vergeben wird. Diese Adresse ist zugleich der Unit Identifier, unter dem das Gerät später über Modbus angesprochen wird, während der Datentransceiver selbst unter 255 antwortet (siehe @sec:powercenter_modbus). Die Adressvergabe der Inbetriebnahme legt damit unmittelbar die Adressierung im Datenmodell fest. Am Testaufbau ist nach @sec:testaufbau ein einziges Endgerät gekoppelt, das dadurch die Adresse 1 erhält. Unter diesem Unit Identifier erscheint das #acro("ECPD") in allen weiteren Kapiteln.


Von besonderer Bedeutung für die Prüfung sind die Alarme, von denen nach @sec:registerraum nur ein kleinerer Teil ab Werk aktiv ist. Ohne die zugehörige Einstellung wäre ein Teil der abgebildeten Datenpunkte am Testaufbau nicht beobachtbar, ohne dass dies etwas über das Datenmodell aussagen würde. Am Testaufbau werden deshalb alle Alarme eingeschaltet, die einen solchen Schalter besitzen, worauf NFA-06 zielt und was T-14 gegen den Auslieferungszustand prüft. Die zugehörigen Grenzwerte und Hysteresen bleiben auf den Voreinstellungen des Geräts. Ein Herabsetzen einzelner Grenzwerte war nicht erforderlich, da die im folgenden Absatz beschriebene Herabsetzung des Nennstroms sämtliche in Prozent angegebenen Stromgrenzwerte mitzieht. Der Eingriff verschiebt allein den Zeitpunkt, zu dem ein Alarm anspricht, und lässt das Verhalten des zugehörigen Datenpunkts unberührt. // #kommentar[Wird im Validierungsteil ein Alarm mit einem zu Prüfzwecken herabgesetzten Grenzwert ausgelöst, gehört der geänderte Wert an die betreffende Stelle, damit die Beobachtung nicht dem Auslieferungszustand zugeschrieben wird.]


Eine eigene Festlegung betrifft den Nennstrom. Der Aufbau verwendet nach @sec:testaufbau die $16space.thin"A"$-Variante des #acro("ECPD"), deren Nennstrom sich nach @sec:ecpd_geraet zusätzlich parametrieren lässt und am Testaufbau auf $10space.thin"A"$ herabgesetzt ist. Der Grund liegt bei T-06. Die verfügbare Last erreicht rund $15,7space.thin"A"$ und bliebe am unveränderten Nennstrom unterhalb der Auslöseschwelle, sodass sich weder eine Auslösung noch der zugehörige Alarm in vertretbarer Zeit beobachten ließe. Mit dem herabgesetzten Wert entspricht die Last dem 1,57-fachen des eingestellten Nennstroms. Ergänzend ist der Zeitraum der verzögerten Auslösung auf den kleinsten einstellbaren Wert gesetzt, damit sich der Vorgang innerhalb einer beaufsichtigten Zeitspanne beobachten lässt. Die Grenzwerte der Alarme bleiben demgegenüber unverändert. Sie sind nach @sec:datenpunkte in Prozent des Nennstroms angegeben und wandern mit dessen Herabsetzung ohne eigenen Eingriff mit, sodass ein einzelner Grenzwert für T-06 nicht anzutasten war. Dieselbe Bezugsgröße gilt für sämtliche Stromgrenzwerte des Geräts, die sich am Testaufbau folglich alle auf diese $10space.thin"A"$ beziehen.

// #kommentar[Zu ergänzen ist der kleinste einstellbare Zeitraum der verzögerten Auslösung als Zahlenwert, damit der Versuch wiederholbar ist.]

Ein Teil der Geräteeinstellungen ist als geschützter Parameter ausgeführt und im Auslieferungszustand deaktiviert. Ihre Änderung setzt voraus, dass der Bereich freigegeben und innerhalb einer vorgegebenen Zeit die Taste am Gerät gedrückt wird, alternativ lässt sich der Zugriff über eine Benutzerrolle mit Vollzugriff freischalten @src:sentronsystemhandbuch. Betroffen sind neben der Empfindlichkeit der Fehlerstromauslösung und dem Verhalten nach einer Auslösung auch die Freigabe des Fernschaltens. Am Testaufbau bleiben diese Einstellungen bis auf eine Ausnahme im Auslieferungszustand.


Die Ausnahme betrifft das Fernschalten über Modbus und berührt zugleich die Sicherheitsbetrachtung. Da die Schnittstelle nach @sec:modbus_tcp keine Authentifizierung kennt, führt das Gerät für das unauthentifizierte Fernschalten über Modbus einen eigenen Schalter, der ab Werk ausgeschaltet ist. Dieser Schalter trägt in der Registerkarte keine Registeradresse und lässt sich folglich nicht über Modbus selbst, sondern nur über SENTRON Powerconfig setzen @src:sentronregistermap. Am Testaufbau ist er eingeschaltet, da UC-05 und der zugehörige Testfall T-08 ohne ihn nicht durchführbar wären. Vertretbar ist das nur in der geschlossenen Umgebung des Laboraufbaus; im späteren Betrieb hängt diese Freischaltung unmittelbar an den Randbedingungen RB-05 bis RB-07, die den Zugang zur Modbus-Schnittstelle auf Netzebene begrenzen (siehe @sec:kommunikationsstrecke).



Dass diese Freischaltung überhaupt erforderlich ist, geht aus der zugänglichen Produktdokumentation nicht hervor. Der Punkt wird zusammen mit dem zunächst abweichenden Verhalten des Geräts beim Schaltbefehl als Befund in @sec:befunde ausgewertet.



Eine letzte Festlegung betrifft nicht das Gerät, sondern die Zählweise. Die Register sind in der Registerkarte ab 1 nummeriert, im Telegramm jedoch ab 0 adressiert (siehe @sec:powercenter_modbus). Zwischen der Registerkarte und dem Datenmodell besteht damit ein Versatz von eins, der auf beiden Seiten übereinstimmend eingestellt sein muss. Wo diese Einstellung im Datenmodell vorgenommen wird, beschreibt @sec:umsetzung.


/* Claude: Abschnitt nach der Vorgabe aus dem Kommentar ausformuliert
   (Parametrierung ueber Powerconfig, ab Werk deaktivierte Alarme nach
   @sec:registerraum, Aktivieren der Modbus-Schnittstelle). Ergaenzt wurden die
   Adressvergabe bei der Kopplung, weil daraus der Unit Identifier folgt, die
   geschuetzten Parameter wegen ihres Bezugs zu T-08 sowie der Adressversatz.

   Die Antworten des Autors sind eingearbeitet und die zugehoerigen Notizen
   entfallen:
   - Zugang ueber die Desktop-Variante von Powerconfig und Ethernet. Der Text
     ordnet das dem im Systemhandbuch genannten Netzzugang zu und verweist fuer
     die Begruendung der Desktop-Variante auf RB-01 und @sec:rb.
   - Geraeteadresse 1, da nur ein einziges Endgeraet gekoppelt ist.
   - Alle schaltbaren Alarme eingeschaltet, Grenzwerte auf den Voreinstellungen
     und nur zu Pruefzwecken vereinzelt herabgesetzt.
   - Eingeschaltet ist der Schalter fuer das unauthentifizierte Fernschalten
     via Modbus (Registerkarte, ohne Registeradresse, nur ueber Powerconfig
     setzbar), da er sich als Ursache der zuvor abgewiesenen Schreibzugriffe
     auf den Schaltbefehl herausgestellt hat. Die uebrigen geschuetzten
     Parameter bleiben unveraendert.

   Die Ursache der zuvor abgewiesenen Schreibzugriffe steht bewusst nicht hier.
   Nach Entscheidung des Autors bleibt die Klaerung dem Validierungsteil
   vorbehalten, weshalb dieser Abschnitt nur die Einstellung des Testaufbaus
   nennt und mit zwei Saetzen auf @sec:befunde verweist. Der ausformulierte
   Befund samt Quelle src:siemenssupport2026 liegt als Arbeitskommentar in
   content/600_validierung/630_Befunde.typ bereit. Kapitel 3 fuehrt den
   Vorbehalt zu FA-06 und die Vorbemerkung zu T-08 unveraendert weiter.



   Nicht erfunden und als roter Arbeitskommentar offen geblieben sind die
   weiteren aktiven Schnittstellen am Powercenter, die rollenbasierte
   Zugriffskontrolle und die konkret herabgesetzten Grenzwerte. */

/* Claude: Am 02.09.2026 gekuerzt. Der Alarmabsatz zaehlte die ab Werk
   abgeschalteten Bits samt RCM-Alarmen und Wert null erneut auf, obwohl
   @sec:registerraum sie herleitet und der Satz ohnehin dorthin verweist.
   Erhalten ist, was den Testaufbau beschreibt, naemlich dass alle Alarme mit
   Schalter eingeschaltet sind. */
