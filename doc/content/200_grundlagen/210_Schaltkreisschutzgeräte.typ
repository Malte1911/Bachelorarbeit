#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Schaltkreisschutzgeräte<sec:ecpd>

Ein elektrischer Endstromkreis ist mehreren Gefährdungen ausgesetzt, die sich in ihrer physikalischen Ursache und in ihrer Wirkung unterscheiden. Eine dauerhafte Überlastung erwärmt die Leitung über die zulässige Grenze hinaus, ein Kurzschluss führt binnen Millisekunden zu sehr hohen Strömen, ein Fehlerstrom gegen Erde gefährdet Personen, und ein serieller oder paralleler Störlichtbogen kann einen Brand auslösen, ohne dass Überstrom oder Fehlerstrom auftreten. Da keine dieser Gefährdungen mit demselben Mechanismus zu beherrschen ist, hat sich für jede von ihnen eine eigene Gerätefamilie mit einer eigenen Produktnorm herausgebildet. Gebräuchlich sind für diese Familien die englischen Kurzbezeichnungen #acro("MCB"), #acro("RCD"), #acro("RCBO"), #acro("AFDD"), #acro("MCCB") und #acro("RCM"), die auch in der Produktdokumentation der Hersteller verwendet werden. @tab:schutzgeraete ordnet sie den zugehörigen Aufgaben und Normen zu.

#figure(
  table(
    columns: (15em, 1fr, 8em),
    inset: 6pt,
    align: (left + horizon, left, left + horizon),
    table.header(
      [*Gerätefamilie*], [*Aufgabe im Stromkreis*], [*Produktnorm*],
    ),

    [Leitungsschutzschalter\ (#acro("MCB"))],
    [Schützt die Leitung vor Erwärmung durch Überlast und trennt bei Kurzschluss. Die Auslösekennlinie ist über die Charakteristikklasse fest vorgegeben.],
    [IEC 60898-1 @src:iec60898],

    [Fehlerstromschutzschalter\ (#acro("RCD"))],
    [Trennt den Stromkreis, sobald die Summe der zu- und abfließenden Ströme einen Bemessungsfehlerstrom überschreitet, und dient damit dem Personenschutz.],
    [IEC 61008-1 @src:iec61008],

    [Fehlerstromschutzschalter\ mit Überstromschutz\ (#acro("RCBO"))],
    [Vereint Fehlerstrom- und Überstromschutz in einem Gerät und ersetzt so die Reihenschaltung aus #acro("RCD") und #acro("MCB").],
    [IEC 61009-1 @src:iec61009],

    [Brandschutzschalter\ (#acro("AFDD"))],
    [Erkennt Störlichtbögen anhand ihres Strom- und Spannungsmusters und schaltet ab, bevor der Lichtbogen einen Brand auslöst.],
    [IEC 62606 @src:iec62606],

    [Leistungsschalter\ (#acro("MCCB"))],
    [Schützt vorgelagerte Verteilungsebenen mit höheren Bemessungsströmen und erlaubt eine einstellbare, zeitlich gestaffelte Auslösung.],
    [IEC 60947-2 @src:iec60947],

    [Differenzstrom-\ Überwachungsgerät\ (#acro("RCM"))],
    [Misst den Differenzstrom fortlaufend und meldet dessen Anstieg, ohne selbst abzuschalten. Ermöglicht damit das Erkennen einer Isolationsverschlechterung vor der Auslösung.],
    [IEC 62020-1 @src:iec62020],
  ),
  caption: [Gerätefamilien des Endstromkreisschutzes, ihre Aufgabe und die jeweils führende Produktnorm],
)<tab:schutzgeraete>

#kommentar("Die Standards muss ich nochmal richtig prüfen, hier also unter vorbehalt.")

// #kommentar[Prüfung offen: Die Ausgabestände und Erscheinungsjahre der sechs Produktnormen in @tab:schutzgeraete sind Katalogeinträgen von IEC und CENELEC entnommen und nicht am Normtext selbst verifiziert. Vor Abgabe gegen den DIN-Katalog gegenlesen, einschließlich der Änderungen A1 und A2. Am unsichersten sind IEC 61008-1 und IEC 61009-1, für die jeweils die dritte Ausgabe von 2010 angesetzt ist. Die Zuordnung Geräteart zu Produktnorm selbst ist für #acro("RCD"), #acro("RCM") und den Leistungsschalter zusätzlich durch das Systemhandbuch @src:sentronsystemhandbuch gedeckt.]

Allen genannten Familien ist eine Eigenschaft gemeinsam, die für die vorliegende Betrachtung entscheidend ist. Sie arbeiten autark und geben ihren Zustand nicht nach außen ab. Ob ein Abgang eingeschaltet ist, ob eine Auslösung stattgefunden hat und welche der Schutzfunktionen sie ausgelöst hat, ist ausschließlich am Gerät selbst erkennbar. Ebenso wenig liegen Betriebsgrößen wie Strom, Spannung oder Temperatur vor, aus denen sich eine anbahnende Störung ableiten ließe. Die Verteilung bleibt damit für jedes übergeordnete System eine unbeobachtete Ebene, und jede Aussage über ihren Zustand setzt voraus, dass eine Person den Verteiler öffnet.

Genau an dieser Stelle setzen Schutzschaltgeräte mit Kommunikations- und Messfunktion an. Sie erfüllen unverändert ihre normative Schutzaufgabe, erfassen darüber hinaus jedoch Messgrößen und Betriebszustände und stellen diese über eine Kommunikationsschnittstelle bereit. Siemens führt unter der Bezeichnung SENTRON eine solche Gerätereihe, die neben Leitungs- und Brandschutzschaltern auch Sicherungen, Fernantriebe, Differenzstrommessgeräte, digitale Ein- und Ausgangsmodule sowie nachrüstbare Hilfs- und Fehlersignalschalter für nicht kommunikationsfähige Hauptgeräte umfasst @src:sentronsystemhandbuch. Erfasst werden je nach Gerätetyp unter anderem Temperatur, Strom, Spannung, Netzfrequenz, Wirk-, Blind- und Scheinleistung, Energie, Differenzströme, der Schaltzustand, Betriebsstunden, mechanische Schaltspiele sowie nach Ursache getrennte Auslösezähler @src:sentronsystemhandbuch. Wesentlich ist dabei, dass die Schutzfunktion von der Kommunikationsfunktion unabhängig bleibt. Fällt die Kommunikation aus, schützen die Geräte weiterhin @src:sentronsystemhandbuch.


=== Elektronisches Schutzschaltgerät 5TY1 COM<sec:ecpd_geraet>

Innerhalb dieser Reihe nimmt das elektronische Schutzschaltgerät 5TY1 COM eine Sonderstellung ein, die sich nicht allein aus seiner Kommunikationsfähigkeit ergibt. Es fasst mehrere Schutzfunktionen zusammen, die sonst auf mehrere Geräte verteilt sind. Neben dem Überlast- und Kurzschlussschutz mit einer Auslösecharakteristik in Anlehnung an die Klasse B enthält es eine Fehlerstromschutzfunktion in Anlehnung an IEC/EN 61009-1 und IEC/EN 62423 sowie eine Differenzstromüberwachung in Anlehnung an IEC 62020-1, ausgeführt als Gerät vom Typ F mit einem Messbereich von $3space.thin"mA"$ bis zur Auslöseschwelle der Fehlerstromschutzfunktion. Hinzu kommt eine zuschaltbare Überspannungsschutzfunktion. Das Gerät belegt zwei Teilungseinheiten, arbeitet bei einer Nennspannung von $230space.thin"V"$ im Bereich von $85space.thin"V"$ bis $255space.thin"V"$ und ist in den Nennstromstufen $6space.thin"A"$, $10space.thin"A"$ und $16space.thin"A"$ erhältlich, wobei der Nennstrom zusätzlich parametrierbar ist @src:sentronsystemhandbuch.

Das eigentliche Unterscheidungsmerkmal liegt jedoch in der Ausführung des Schaltpfads. Das Gerät verfügt neben dem mechanischen Trennkontakt über einen Leistungshalbleiter und kennt dadurch einen dritten Betriebszustand, der als Standby bezeichnet wird. In diesem Zustand ist der Halbleiter hochohmig, der Stromkreis also nicht leitend, ohne dass der mechanische Kontakt geöffnet wurde @src:sentronsystemhandbuch. Ein Rückschalten in den leitenden Zustand ist damit ohne Eingriff vor Ort möglich, etwa um Standby-Verbraucher gezielt abzuschalten oder nach einer Überlastauslösung wieder zuzuschalten. Halbleiterbasierte Schaltpfade sind gegenüber dem rein elektromechanischen Kontakt verschleißfrei und um Größenordnungen schneller, erfordern jedoch eine Beherrschung der Verlustleistung und der Überspannungen beim Abschalten und sind deshalb Gegenstand aktueller Forschung @src:rodrigues2021. Wird das Gerät hingegen per Befehl in den Zustand OFF ausgelöst, öffnet der mechanische Trennkontakt. Ein Fernschalten ist danach nicht mehr möglich, das Gerät muss vor Ort mechanisch wieder eingeschaltet werden @src:sentronsystemhandbuch.

Aus der elektronischen Ausführung folgt eine zweite Eigenschaft, die klassische Schutzschaltgeräte nicht besitzen. Ein erheblicher Teil des Geräteverhaltens ist parametrierbar. Die Empfindlichkeit der Fehlerstromauslösung lässt sich von $22,5space.thin"mA"$ auf $18,0space.thin"mA"$ oder $27,0space.thin"mA"$ ändern, und je Auslöseursache ist einstellbar, wie sich das Gerät nach der Auslösung verhält, bis hin zum automatischen Wiedereinschalten über die #acro("ARD")-Funktion @src:sentronsystemhandbuch. Da diese Einstellungen die Schutzwirkung selbst betreffen, sind sie als geschützte Parameter ausgeführt. Ihre Änderung setzt voraus, dass der Bereich freigegeben und anschließend innerhalb einer vorgegebenen Zeit die Taste am Gerät gedrückt wird. Alternativ lässt sich das Fernschalten über eine Benutzerrolle mit Vollzugriff freigeben. Jede Änderung geschützter Parameter wird im Gerät protokolliert, und im Auslieferungszustand sind die betreffenden Funktionen deaktiviert @src:sentronsystemhandbuch.

Schließlich führt das Gerät einen zyklischen Selbsttest durch, der interne Funktionen prüft und das Gerät im Fehlerfall in einen sicheren Zustand schaltet. Ergänzend lässt sich ein Test der Fehlerstromschutzfunktion anstoßen, bei dem ein Testsignal in den Messkreis eingebracht und dessen Erkennung geprüft wird. Die Ergebnisse werden mit Zeitstempel im Gerät abgelegt, das bis zu 60 Testeinträge, bis zu 126 Meldungen und bis zu 100 Auslösungen speichert @src:sentronsystemhandbuch.


=== Anbindung an übergeordnete Systeme<sec:ecpd_konnektivitaet>

Für die Frage, wie die beschriebenen Daten ein übergeordnetes System erreichen, ist eine Eigenschaft der gesamten Gerätereihe maßgeblich. Keines der Endgeräte besitzt eine eigene Ethernet- oder Feldbusschnittstelle. Die Geräte kommunizieren ausschließlich drahtlos und jeweils in einer Punkt-zu-Punkt-Verbindung mit einem übergeordneten Datentransceiver, der als SENTRON Powercenter bezeichnet wird. Die Endgeräte kommunizieren nicht untereinander, die Topologie ist damit sternförmig und nicht vermascht @src:sentronsystemhandbuch.

Die Funkstrecke arbeitet im $2,4space.thin"GHz"$-Band mit 16 wählbaren Kanälen und basiert auf dem Standard Zigbee Pro, von dem sie in den Identifikationsdatenpunkten und in den Kommandos zum Anstoßen eines Firmware-Updates herstellerspezifisch abweicht @src:sentronsystemhandbuch. Die Kopplung eines Endgeräts erfolgt über einen aufgedruckten Code, der Gerätetyp, Adresse und Installationscode trägt. Nach der Kopplung wird der Installationscode ersetzt, sodass jede Verbindung einzeln verschlüsselt ist. Die Sendeleistung ist einstellbar, was die Reichweite und damit die Angreifbarkeit begrenzt, und die Empfangsfeldstärke steht als eigener Wert (#acro("RSSI")) zur Verfügung, aus dem sich die Güte der Verbindung beurteilen lässt @src:sentronsystemhandbuch. Die Funkkommunikation lässt sich nicht abschalten. Wird sie gestört, werden keine Daten übertragen, was sich am Verbindungsstatus des betroffenen Endgeräts erkennen lässt @src:sentronsystemhandbuch.

Die Endgeräte senden ihre Werte nicht einheitlich, sondern in nach Größe gestaffelten Intervallen. Temperatur, Strom, Differenzstrom und die Leistungen werden alle $2space.thin"s"$ übertragen, Schaltzustand und Schaltspielzähler alle $10space.thin"s"$ und zusätzlich bei jeder Änderung, während Spannung, Netzfrequenz, Leistungsfaktor, Energie, Betriebsstunden, Alarmzustand und Empfangsfeldstärke im Abstand von $60space.thin"s"$ folgen @src:sentronsystemhandbuch. Die Aktualität eines Werts im übergeordneten System ist damit nach oben durch die Funkstrecke begrenzt und nicht allein durch die Abfrage.

Ein einzelnes Schutzschaltgerät ist für ein übergeordnetes System folglich nicht erreichbar. Jeder Zugang zu seinen Daten führt über den Datentransceiver, der die Endgeräte ankoppelt und ihre Werte an einer netzwerkseitigen Schnittstelle bereitstellt. Dieser wird im folgenden Abschnitt beschrieben.

/* Claude: Abschnitt nach der Vorgabe aus der Durchsicht ausformuliert
   (Geraetefamilien mit Quellen, Alleinstellungsmerkmale des ECPD, Upstream-
   Konnektivitaet). Bewusst ohne Bezug auf die Aufgabenstellung, den gewaehlten
   Integrationsweg oder das Datenmodell. Die Registerinhalte des Geraets sind
   hier nicht aufgefuehrt, sie gehoeren zur Analyse des Registerraums.
   Die Normzuordnungen in @tab:schutzgeraete sind neue Eintraege in
   quellen.bib; Ausgabestand und Jahr sind dort mit einem Vorbehalt versehen
   und vor Abgabe gegen den DIN-Katalog zu pruefen. */
