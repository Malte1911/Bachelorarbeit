#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== SENTRON Powercenter<sec:powercenter>
// Claude: ändere mal den begriff gebäudeüblich, der ist irgendwie komisch
Da die in @sec:ecpd beschriebenen Schutzschaltgeräte über keine eigene netzwerkseitige Schnittstelle verfügen, benötigt die Gerätereihe eine Komponente, die die Funkstrecke auf ein gebäudeübliches Netz umsetzt. Diese Aufgabe übernimmt der Datentransceiver SENTRON Powercenter. Er koppelt bis zu 24 Endgeräte an, sammelt deren Messwerte und Zustände, speichert sie über einen begrenzten Zeitraum und stellt sie an seinen netzwerkseitigen Schnittstellen bereit. Baulich ist er auf den Installationsverteiler zugeschnitten, belegt eine Teilungseinheit und wird mit $24space.thin"V"$ Gleichspannung versorgt, die sich über steckbare Klemmen an weitere Geräte durchschleifen lässt @src:sentronsystemhandbuch. Die folgenden Angaben sind, soweit nicht anders angegeben, dem Systemhandbuch der Gerätefamilie entnommen @src:sentronsystemhandbuch.

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
    [Zwei Ethernet-Anschlüsse mit Switch-Funktion, verbesserte Speicherung der historischen Messwerte, zusätzlich das gesicherte Protokoll #acro("HTTPS") über eine REST-#acro("API"), ein frontseitig aktivierbarer Schreibschutz sowie eine rollenbasierte Zugriffskontrolle (#acro("RBAC")). Unterstützt Endgeräte älterer und neuerer Firmwarestände und damit den vollen Funktionsumfang des elektronischen Schutzschaltgeräts.],

    [Powercenter 2000],
    [Baut auf der Hardware des Powercenter 1100 auf und bietet dieselben Gerätefunktionen. Ergänzt werden eine #acro("MQTT")-Schnittstelle zur nativen Anbindung an Cloud-Dienste sowie ein integrierter Webserver, über den sich Mess- und Statuswerte unmittelbar im Browser abrufen lassen.],
  ),
  caption: [Varianten des SENTRON Powercenter und ihre kennzeichnenden Eigenschaften @src:sentronsystemhandbuch],
)<tab:powercenter>


=== Schnittstellen<sec:powercenter_schnittstellen>

Zur Feldebene hin besteht ausschließlich die in @sec:ecpd beschriebene Funkstrecke. Jedes Endgerät muss dem Funknetz des Datentransceivers beitreten und erhält dabei eine Geräteadresse, die standardmäßig fortlaufend von 1 bis 24 vergeben wird und sich bei der Inbetriebnahme auch manuell festlegen lässt.

Für den lokalen Zugriff vor Ort steht eine Bluetooth-Schnittstelle nach dem Standard Bluetooth Low Energy zur Verfügung. Sie unterstützt genau eine aktive Verbindung, wird über eine sechsstellige PIN abgesichert und schaltet sich nach $180space.thin"s"$ ohne Nutzung wieder ab. Da sich Funkstrecke und Bluetooth-Verbindung dasselbe Funkmodul teilen, ist der erreichbare Durchsatz begrenzt. Das Handbuch weist diese Schnittstelle deshalb ausdrücklich der Inbetriebnahme zu und empfiehlt für die Datenübertragung den Weg über Ethernet.

Die Anbindung an übergeordnete Systeme erfolgt über die Ethernet-Schnittstelle, auf der je nach Variante bis zu drei Protokolle nebeneinander bereitstehen. Modbus #acro("TCP") überträgt unverschlüsselt und ohne Authentifizierung, weshalb das Handbuch Zugangsbeschränkungen ausdrücklich dem übergeordneten System und dem Netz zuweist. Am Powercenter 1100 und 2000 lässt sich diese Verbindung separat ein- und abschalten. Das gesicherte Protokoll #acro("HTTPS") über eine REST-#acro("API") ist mit #acro("TLS") verschlüsselt, dient diesen beiden Varianten als Standardweg für die Inbetriebnahmesoftware und ist das einzige Protokoll, auf das die rollenbasierte Zugriffskontrolle wirkt. Für die Kommunikation über Modbus #acro("TCP") stehen keine Benutzer zur Verfügung. Die #acro("MQTT")-Schnittstelle des Powercenter 2000 schließlich richtet sich an Cloud-Dienste und wird über dieselbe Ethernet-Schnittstelle bereitgestellt. Ein Zugriff über das lokale Netz hinaus ist nach dem Handbuch über eine #acro("VPN")-Verbindung oder ein weiteres Gateway vorgesehen.

Die rollenbasierte Zugriffskontrolle erlaubt bis zu fünf lokale Benutzer in drei Rollen. Ein Beobachter darf ausschließlich lesen, ein Installateur zusätzlich Parameter schreiben und Befehle absetzen, und ein Administrator verfügt über den vollen Zugriff einschließlich der Kommunikationsparameter und der Benutzerverwaltung. Bei der Erstinbetriebnahme ist zwingend ein Administrator anzulegen, ein Standardpasswort existiert nicht.


=== Eigenschaften der Modbus-Anbindung<sec:powercenter_modbus>

Modbus als Protokoll wird in @sec:modbus beschrieben. Für den Datentransceiver sind darüber hinaus einige Festlegungen von Bedeutung, die sich aus seiner Rolle als Konzentrator ergeben.

Der Datentransceiver tritt als Server auf und bündelt sämtliche unterlagerten Geräte hinter einer einzigen #acro("IP")-Adresse. Unterschieden werden sie über den Unit Identifier im Protokollkopf, der zugleich die Geräteadresse ist. Die Adressen 1 bis 24 bezeichnen die Endgeräte, die Adresse 255 den Datentransceiver selbst mit seinen eigenen Werten wie Betriebsstunden oder Systemzeit. Die Registernummer eines Datenpunkts ist über alle Gerätetypen hinweg gleich, sodass sich ein Gerät allein über den Unit Identifier von einem anderen unterscheidet. Ist an einer Adresse ein Gerätetyp angemeldet, der einen bestimmten Datenpunkt nicht führt, liefert das zugehörige Register keinen verwertbaren Wert.

Gelesen wird wahlweise mit den Funktionscodes 0x03 oder 0x04, geschrieben mit 0x06 oder 0x10. Die Register sind ab 1 nummeriert, aber ab 0 adressiert, sodass die Startadresse im Telegramm gegenüber der Registerkarte um eins zu verringern ist. Als Datenformate treten vorzeichenlose und vorzeichenbehaftete Ganzzahlen, Zeichenketten, Gleitkommazahlen einfacher und doppelter Genauigkeit sowie Zeitstempel auf, angeordnet in Big-Endian-Reihenfolge. Werte, die breiter als 16 Bit sind, belegen entsprechend mehrere aufeinanderfolgende Register.

Zwei Eigenschaften betreffen die Verlässlichkeit der gelesenen Werte. Zum einen kennzeichnet der Datentransceiver ungültige Messwerte als Not a Number nach IEEE 754, etwa nach einer Unterbrechung der Versorgungsspannung oder der Funkstrecke. Zusätzlich gibt ein eigener Datenpunkt den Verbindungszustand jedes Endgeräts an, sodass sich ein tatsächlich gemessener Wert von einem nicht mehr aktualisierten unterscheiden lässt. Zum anderen ist das System aus Datentransceiver und Endgeräten räumlich verteilt, weshalb ein Schreibzugriff nicht innerhalb der geforderten Antwortzeit quittiert werden kann. Für diesen Fall führt der Datentransceiver eine verzögerte Quittierung, deren Zustand über ein eigenes Register abgefragt und nach Abschluss eines Befehls wieder auf den Ruhezustand zurückgesetzt wird. Ohne diesen Mechanismus lässt sich nur etwa alle $10space.thin"s"$ ein Schreibbefehl an dasselbe Endgerät absetzen.

Für die Abfrage nennt das Handbuch drei Empfehlungen. Ein Gerät sollte nicht häufiger als einmal je Sekunde abgefragt werden, die Endgeräte sind einzeln zu adressieren und sequenziell abzuarbeiten, und mehrere Register sollten blockweise statt einzeln gelesen werden. Eine höhere Abfragerate bringt ohnehin keinen Gewinn, da die Messwerte frühestens alle $2space.thin"s"$ aktualisiert werden. Zwar unterstützt der Datentransceiver bis zu drei gleichzeitige Modbus-Verbindungen, das Handbuch rät jedoch dazu, betrieblich nur eine zu verwenden, damit sich Schreibbefehle verschiedener Anwendungen nicht überschneiden.

/* Claude: Abschnitt nach der Vorgabe aus der Durchsicht ausformuliert
   (generische Beschreibung, Bezug auf das vorangehende Kapitel, Schnittstellen
   nach unten und nach oben). Der Bezug auf die Aufgabenstellung und die
   Aussage, dass das Datenmodell hier ansetzt, sind entfallen; sie stehen in
   der Analyse. Die Registerkarte selbst wird bewusst nicht ausgewertet. */
