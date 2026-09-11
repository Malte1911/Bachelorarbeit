#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== SENTRON Powercenter<sec:powercenter>


Da die in @sec:ecpd beschriebenen Schutzschaltgeräte über keine eigene netzwerkseitige Schnittstelle verfügen, benötigt die Gerätereihe eine Komponente, die die Funkstrecke auf das Ethernet-Netz der Liegenschaft umsetzt. Diese Aufgabe übernimmt der Datentransceiver SENTRON Powercenter. Er koppelt bis zu 24 Endgeräte an, sammelt deren Messwerte und Zustände, speichert sie über einen begrenzten Zeitraum und stellt sie an seinen netzwerkseitigen Schnittstellen bereit. Baulich ist er auf den Installationsverteiler zugeschnitten, belegt eine Teilungseinheit und wird mit $24space.thin"V"$ Gleichspannung versorgt, die sich über steckbare Klemmen an weitere Geräte durchschleifen lässt @src:sentronsystemhandbuch. Die folgenden Angaben sind, soweit nicht anders angegeben, dem Systemhandbuch der Gerätefamilie entnommen @src:sentronsystemhandbuch.

Das Gerät ist in drei Varianten verfügbar, die sich in ihren Schnittstellen und Sicherheitsfunktionen unterscheiden und nicht denselben Umfang an Endgeräten unterstützen. @tab:powercenter stellt sie einander gegenüber.

#figure(
  table(
    columns: (8em, 1fr),
    inset: 7pt,
    align: (left + horizon, left),
    table.header(
      [*Variante*], [*Kennzeichnende Eigenschaften*],
    ),

    [Powercenter 1000],
    [Grundvariante mit einem Ethernet-Anschluss, Bluetooth und Modbus #acro("TCP"). Ausgewählte Messwerte werden bis zu 30 Tage gespeichert. Das elektronische Schutzschaltgerät ist ab Firmware V3.0 grundsätzlich anbindbar, dessen neuere Gerätefunktionen werden jedoch nicht unterstützt.],

    [Powercenter 1100],
    [Zwei Ethernet-Anschlüsse mit Switch-Funktion, verbesserte Speicherung der historischen Messwerte, zusätzlich das gesicherte Protokoll #acro("HTTPS") über eine #acro("REST")-#acro("API"), ein frontseitig aktivierbarer Schreibschutz sowie eine rollenbasierte Zugriffskontrolle (#acro("RBAC")). Unterstützt Endgeräte älterer und neuerer Firmwarestände und damit den vollen Funktionsumfang des elektronischen Schutzschaltgeräts.],

    [Powercenter 2000],
    [Baut auf der Hardware des Powercenter 1100 auf und bietet dieselben Gerätefunktionen. Ergänzt werden eine #acro("MQTT")-Schnittstelle zur nativen Anbindung an Cloud-Dienste sowie ein integrierter Webserver, über den sich Mess- und Statuswerte unmittelbar im Browser abrufen lassen.],
  ),
  caption: [Varianten des SENTRON Powercenter und ihre kennzeichnenden Eigenschaften @src:sentronsystemhandbuch],
)<tab:powercenter>


=== Schnittstellen<sec:powercenter_schnittstellen>


Der Datentransceiver steht zwischen zwei Seiten, die sich in Aufgabe und Protokoll unterscheiden. Gebräuchlich sind dafür die Begriffe _Southbound_ und _Northbound_, die eine vermittelnde Komponente nach der Richtung ihrer Schnittstellen gliedern @src:ai2026. Southbound bezeichnet die Seite zur Feldebene, an der die Endgeräte über ihre jeweiligen Protokolle angebunden werden, Northbound die Seite zum übergeordneten System, an das die gesammelten Daten weitergereicht werden @src:ai2026. Beide Begriffe sind auf das betrachtete Gerät bezogen, sodass dieselbe Verbindung je nach Blickrichtung der einen oder der anderen Seite zufällt.

Auf der Southbound-Seite besteht ausschließlich die in @sec:ecpd beschriebene Funkstrecke. Jedes Endgerät muss dem Funknetz des Datentransceivers beitreten und erhält dabei eine Geräteadresse, die standardmäßig fortlaufend von 1 bis 24 vergeben wird und sich bei der Inbetriebnahme auch manuell festlegen lässt @src:sentronsystemhandbuch @src:sentronregistermap.

Für den lokalen Zugriff vor Ort steht eine Bluetooth-Schnittstelle nach dem Standard #acro("BLE") zur Verfügung @src:sentronsystemhandbuch. Sie unterstützt genau eine aktive Verbindung, wird über eine sechsstellige PIN abgesichert und schaltet sich nach $180space.thin"s"$ ohne Nutzung wieder ab @src:sentronsystemhandbuch. Da sich Funkstrecke und Bluetooth-Verbindung dasselbe Funkmodul teilen, ist der erreichbare Durchsatz begrenzt @src:sentronsystemhandbuch. Das Systemhandbuch weist diese Schnittstelle deshalb ausdrücklich der Inbetriebnahme zu und empfiehlt für die Datenübertragung den Weg über Ethernet @src:sentronsystemhandbuch.

Auf der Northbound-Seite erfolgt die Anbindung an übergeordnete Systeme über die Ethernet-Schnittstelle, auf der je nach Variante bis zu drei Protokolle nebeneinander bereitstehen @src:sentronsystemhandbuch. Modbus #acro("TCP") überträgt unverschlüsselt und ohne Authentifizierung, weshalb das Systemhandbuch Zugangsbeschränkungen ausdrücklich dem übergeordneten System und dem Netz zuweist @src:sentronsystemhandbuch. Am Powercenter 1100 und 2000 lässt sich diese Verbindung separat ein- und abschalten @src:sentronsystemhandbuch. Das gesicherte Protokoll #acro("HTTPS") über eine #acro("REST")-#acro("API") ist mit #acro("TLS") verschlüsselt, dient diesen beiden Varianten als Standardweg für die Inbetriebnahmesoftware und ist das einzige Protokoll, auf das die rollenbasierte Zugriffskontrolle wirkt @src:sentronsystemhandbuch. Für die Kommunikation über Modbus #acro("TCP") stehen keine Benutzer zur Verfügung @src:sentronsystemhandbuch. Die #acro("MQTT")-Schnittstelle des Powercenter 2000 schließlich richtet sich an Cloud-Dienste und wird über dieselbe Ethernet-Schnittstelle bereitgestellt @src:sentronsystemhandbuch. Ein Zugriff über das lokale Netz hinaus ist nach dem Systemhandbuch über eine #acro("VPN")-Verbindung oder ein weiteres Gateway vorgesehen @src:sentronsystemhandbuch.

Die rollenbasierte Zugriffskontrolle erlaubt bis zu fünf lokale Benutzer in drei Rollen @src:sentronsystemhandbuch. Ein Beobachter darf ausschließlich lesen, ein Installateur zusätzlich Parameter schreiben und Befehle absetzen, und ein Administrator verfügt über den vollen Zugriff einschließlich der Kommunikationsparameter und der Benutzerverwaltung @src:sentronsystemhandbuch. Bei der Erstinbetriebnahme ist zwingend ein Administrator anzulegen, ein Standardpasswort existiert nicht @src:sentronsystemhandbuch.


=== Eigenschaften der Modbus-Anbindung<sec:powercenter_modbus>

Modbus als Protokoll wird in @sec:modbus beschrieben. Für den Datentransceiver sind darüber hinaus einige Festlegungen von Bedeutung, die sich aus seiner Rolle als Konzentrator ergeben. Sie stammen aus dem Systemhandbuch @src:sentronsystemhandbuch und aus der Registerkarte der Gerätefamilie @src:sentronregistermap.

Der Datentransceiver tritt als Server auf und bündelt sämtliche unterlagerten Geräte hinter einer einzigen #acro("IP")-Adresse @src:sentronsystemhandbuch. Unterschieden werden sie über den Unit Identifier im Protokollkopf, der zugleich die Geräteadresse ist @src:sentronsystemhandbuch. Die Adressen 1 bis 24 bezeichnen die Endgeräte, die Adresse 255 den Datentransceiver selbst mit seinen eigenen Werten wie Betriebsstunden oder Systemzeit @src:sentronsystemhandbuch. Die Registernummer eines Datenpunkts ist über alle Gerätetypen hinweg gleich, sodass sich ein Gerät allein über den Unit Identifier von einem anderen unterscheidet @src:sentronregistermap. Ist an einer Adresse ein Gerätetyp angemeldet, der einen bestimmten Datenpunkt nicht führt, liefert das zugehörige Register keinen verwertbaren Wert @src:sentronregistermap.

Gelesen wird wahlweise mit den Funktionscodes 0x03 oder 0x04, geschrieben mit 0x06 oder 0x10 @src:sentronsystemhandbuch. Die Register sind ab 1 nummeriert, aber ab 0 adressiert, sodass die Startadresse im Telegramm gegenüber der Registerkarte um eins zu verringern ist @src:sentronregistermap. Als Datenformate treten vorzeichenlose und vorzeichenbehaftete Ganzzahlen, Zeichenketten, Gleitkommazahlen einfacher und doppelter Genauigkeit sowie Zeitstempel auf, angeordnet in Big-Endian-Reihenfolge @src:sentronregistermap. Werte, die breiter als 16 Bit sind, belegen entsprechend mehrere aufeinanderfolgende Register @src:sentronregistermap.

Zwei Eigenschaften betreffen die Verlässlichkeit der gelesenen Werte. Zum einen kennzeichnet der Datentransceiver ungültige Messwerte als Not a Number nach IEEE 754 @src:ieee754, etwa nach einer Unterbrechung der Versorgungsspannung oder der Funkstrecke @src:sentronsystemhandbuch. Zusätzlich gibt ein eigener Datenpunkt den Verbindungszustand jedes Endgeräts an, sodass sich ein tatsächlich gemessener Wert von einem nicht mehr aktualisierten unterscheiden lässt @src:sentronregistermap. Zum anderen ist das System aus Datentransceiver und Endgeräten räumlich verteilt, weshalb ein Schreibzugriff nicht innerhalb der geforderten Antwortzeit quittiert werden kann @src:sentronsystemhandbuch. Für diesen Fall führt der Datentransceiver eine verzögerte Quittierung, deren Zustand über ein eigenes Register abgefragt und nach Abschluss eines Befehls wieder auf den Ruhezustand zurückgesetzt wird @src:sentronsystemhandbuch @src:sentronregistermap. Ohne diesen Mechanismus lässt sich nur etwa alle $10space.thin"s"$ ein Schreibbefehl an dasselbe Endgerät absetzen @src:sentronsystemhandbuch.

Für die Abfrage nennt das Systemhandbuch drei Empfehlungen @src:sentronsystemhandbuch. Ein Gerät sollte nicht häufiger als einmal je Sekunde abgefragt werden, die Endgeräte sind einzeln zu adressieren und sequenziell abzuarbeiten, und mehrere Register sollten blockweise statt einzeln gelesen werden @src:sentronsystemhandbuch. Eine höhere Abfragerate bringt ohnehin keinen Gewinn, da die Messwerte frühestens alle $2space.thin"s"$ aktualisiert werden @src:sentronsystemhandbuch. Zwar unterstützt der Datentransceiver bis zu drei gleichzeitige Modbus-Verbindungen, das Systemhandbuch rät jedoch dazu, betrieblich nur eine zu verwenden, damit sich Schreibbefehle verschiedener Anwendungen nicht überschneiden @src:sentronsystemhandbuch.

/* Claude: Abschnitt nach der Vorgabe aus der Durchsicht ausformuliert
   (generische Beschreibung, Bezug auf das vorangehende Kapitel, Schnittstellen
   southbound und northbound). Der Bezug auf die Aufgabenstellung und die
   Aussage, dass das Datenmodell hier ansetzt, sind entfallen; sie stehen in
   der Analyse. Die Registerkarte selbst wird bewusst nicht ausgewertet.

   Nachtrag vom 11.09.2026: Die Begriffe Southbound und Northbound sind hier
   eingefuehrt und in @sec:integrationswege uebernommen, wo zuvor "nach oben"
   stand. Beleg ist @src:ai2026, ein modulares IoT-Gateway mit derselben
   Rollenverteilung (Southbound-Komponente zu den Feldgeraeten ueber Modbus,
   OPC UA und MQTT, Northbound-Komponente zum uebergeordneten System). Die
   Begriffe stammen urspruenglich aus der Netzarchitektur, wo RFC 7426 sie
   zwar durchgehend verwendet, aber nicht eigens definiert; deshalb ist die
   Gateway-Quelle gewaehlt. */
