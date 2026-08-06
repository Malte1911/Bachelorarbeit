#import "../../config/acronyms.typ": *
#include "../../config/config.typ"

== SENTRON Powercenter<sec:powercenter>

Das SENTRON Powercenter bildet das Bindeglied zwischen den Schutzschaltgeräten aus @sec:ecpd und den übergeordneten Systemen. Es ist damit die Schnittstelle, an der das in dieser Arbeit entwickelte Datenmodell ansetzt. Die folgenden Stichpunkte sind dem Systemhandbuch der Gerätefamilie entnommen @src:sentronsystemhandbuch.

/* Stichpunkte aus dem Systemhandbuch, noch in Fließtext zu überführen.
   Die Seitenangaben in den Kommentaren beziehen sich auf
   resources/datasheets/MAN_L1V30827018A_RS-AC_009_de_de-DE.pdf. */

*Aufgabe im System* /* Kap. 3 und 3.1, S. 21 ff. */

- Der Datentransceiver SENTRON Powercenter steht im Mittelpunkt des Systems: Er sammelt die Messwerte der gekoppelten Schutzschaltgeräte und überträgt sie an übergeordnete Systeme @src:sentronsystemhandbuch
- An ein Powercenter lassen sich bis zu 24 kommunikationsfähige SENTRON-Geräte innerhalb eines Schaltanlagenfeldes oder Installationsverteilers drahtlos anbinden @src:sentronsystemhandbuch
- Ausgewählte Messwerte werden bis zu 30 Tage im Gerät gespeichert und stehen damit auch nach einer Unterbrechung der übergeordneten Verbindung zur Verfügung @src:sentronsystemhandbuch
- Die Gerätevarianten unterscheiden sich im Funktionsumfang: Das Powercenter 1100 ergänzt gegenüber dem Powercenter 1000 zwei Ethernet-Anschlüsse mit Switch-Funktion, eine verbesserte Speicherfunktion, das gesicherte Protokoll https über eine REST-#acro("API"), einen Schreibschutzschalter und eine rollenbasierte Zugriffskontrolle; das Powercenter 2000 bietet zusätzlich eine #acro("MQTT")-Schnittstelle zur Cloud-Anbindung sowie einen integrierten Webserver @src:sentronsystemhandbuch

*Kommunikationswege* /* Kap. 4.4, S. 52 ff.; Kap. 6.13, S. 112; Kap. 6.15, S. 115 */

- _Funkverbindung zu den Endgeräten:_ proprietäres Funkprotokoll zu maximal 24 Geräten; die Schutzschaltgeräte selbst sind darüber nicht direkt für übergeordnete Systeme erreichbar @src:sentronsystemhandbuch
- _Bluetooth Low Energy:_ lokaler Zugriff vor Ort über ein mobiles Endgerät, verschlüsselt mit einem 128-Bit-AES-CCM-Algorithmus und abgesichert über eine sechsstellige PIN; es wird nur eine aktive Verbindung unterstützt und der Modus schaltet sich nach 180 Sekunden ohne Nutzung ab @src:sentronsystemhandbuch
- _Ethernet mit Modbus #acro("TCP"):_ unverschlüsselter Zugriff aus dem lokalen Netz, der von übergeordneten Systemen genutzt wird; beim Powercenter 1100/2000 separat zu- und abschaltbar @src:sentronsystemhandbuch
- _Ethernet mit https über REST-#acro("API"):_ über TLS verschlüsselte Alternative zu Modbus #acro("TCP"), Standardweg für die Inbetriebnahmesoftware SENTRON Powerconfig und Grundlage des integrierten Webservers @src:sentronsystemhandbuch
- _#acro("MQTT") (nur Powercenter 2000):_ native Anbindung an Cloud-Dienste über dieselbe Ethernet-Schnittstelle @src:sentronsystemhandbuch
- Für den Zugriff über das lokale Netz hinaus verweist das Handbuch auf eine #acro("VPN")-Verbindung oder ein vorgelagertes Gateway @src:sentronsystemhandbuch

*Powercenter als Modbus-Gateway* /* Kap. 6.12 und 6.12.1, S. 105 ff. */

- Das Powercenter tritt als Modbus-#acro("TCP")-Server auf und stellt die Daten aller unterlagerten Endgeräte über eine einzige #acro("IP")-Adresse bereit; die Endgeräte sind selbst nicht Teil des Modbus-Netzes @src:sentronsystemhandbuch
- Die Zuordnung eines Datenpunkts erfolgt zweistufig über die #acro("IP")-Adresse des Powercenters und die Geräteadresse (Unit Identifier) des jeweiligen Geräts; die Geräteadresse 255 (0xFF) adressiert das Powercenter selbst, etwa für dessen Betriebsstunden oder die Systemzeit @src:sentronsystemhandbuch /* Widerspruch in der Quelle: S. 105 nennt die Geräteadressen "1-4 für das jeweils unterlagerte Schutzgerät", S. 106 vergibt in Powerconfig mobile fortlaufend 1-24. Am Testaufbau prüfen. */
- Die Registernummer eines Datenpunkts ist bei allen Gerätetypen gleich; unterschieden werden die Geräte ausschließlich über die im Modbus-Header übertragene Unit Identifier @src:sentronsystemhandbuch /* → zentrale Voraussetzung dafür, dass ein einziges Datenmodell für alle Instanzen eines Gerätetyps genügt */
- Lesezugriffe erfolgen mit den Funktionscodes 0x03 oder 0x04, Schreibzugriffe mit 0x06 oder 0x10; die Register werden ab 1 nummeriert, aber ab 0 adressiert, sodass die Startadresse im Protokoll um eins zu dekrementieren ist @src:sentronsystemhandbuch
- Unterstützte Datenformate sind U8, U16, U32, S16, UCHAR, FP32 und FP64 nach IEEE 754 sowie Zeitstempel und Systemzeit; die Übertragung erfolgt in Big-Endian-Anordnung @src:sentronsystemhandbuch
- Ungültige Messwerte werden als _Not a Number_ nach IEEE 754 gekennzeichnet; zusätzlich ist der Datenpunkt „Gerätestatus" auszuwerten, der mit dem Wert 3 eine bestehende Verbindung zum Endgerät anzeigt @src:sentronsystemhandbuch
- Das Handbuch empfiehlt, jedes Gerät höchstens einmal pro Sekunde abzufragen, die Endgeräte sequenziell abzuarbeiten und Register blockweise zu lesen; die Messwerte werden frühestens alle zwei Sekunden aktualisiert @src:sentronsystemhandbuch
- Da das System räumlich verteilt ist, quittiert das Powercenter Schreibzugriffe verzögert (Delayed Acknowledge): Register 4096 führt den Status, wobei 0x01 einen laufenden Auftrag, 0x02 den Erfolg und 0x03 das Fehlschlagen anzeigt; erst nach dem manuellen Zurücksetzen auf 0x00 ist ein weiterer Schreibbefehl möglich, ohne diesen Mechanismus nur etwa alle zehn Sekunden @src:sentronsystemhandbuch
- Eine vollständige Übersicht der Datenpunkte und Register aller Gerätetypen wird als eigene Modbus-Register-Map bereitgestellt @src:sentronregistermap

*Flexible Einbindung und deren Grenzen* /* Kap. 3.1, S. 23; Kap. 6.12, S. 105; Kap. 6.14, S. 113 */

- Weil Modbus #acro("TCP") offen spezifiziert und weit verbreitet ist (siehe @sec:modbus), kann das Powercenter ohne herstellerspezifische Treiber in unterschiedliche übergeordnete Systeme eingebunden werden; das Handbuch nennt hierfür ausdrücklich das Energiemonitoring-System SENTRON Powermanager, die IoT-Datenplattform SENTRON Powercenter 3000 sowie SCADA- und Monitoring-Systeme @src:sentronsystemhandbuch /* → genau an dieser Stelle setzt die Anbindung an Desigo CC an */
- Ein Powercenter unterstützt gleichzeitig bis zu drei Modbus-#acro("TCP")-Verbindungen sowie parallel eine Bluetooth-Verbindung; das Handbuch rät jedoch dazu, operativ nur eine Modbus-Verbindung zu verwenden, um Überschneidungen von Befehlen zu vermeiden @src:sentronsystemhandbuch
- Die Modbus-#acro("TCP")-Kommunikation ist unverschlüsselt und kennt keine Benutzerverwaltung; die rollenbasierte Zugriffskontrolle des Powercenters wirkt ausschließlich auf die https-Kommunikation, sodass Zugangsbeschränkungen im übergeordneten System oder Netzwerk umzusetzen sind @src:sentronsystemhandbuch /* → verwertbar in der Bewertung der Praxistauglichkeit */
