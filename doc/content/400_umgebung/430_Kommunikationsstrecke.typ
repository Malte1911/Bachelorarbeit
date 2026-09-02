#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Kommunikationsstrecke und Netzwerkanbindung<sec:kommunikationsstrecke>

Zwischen dem parametrierten Gerät und dem Objektmodell in Desigo CC liegt die Kommunikationsstrecke. Sie ist Voraussetzung dafür, dass überhaupt Werte fließen, und wird deshalb vor der Entwicklung des Datenmodells eingerichtet. Der Import der Typbeschreibung gehört nicht hierher, sondern ist Gegenstand von @sec:uebernahme und wird von T-01 geprüft.


Die Strecke beginnt am Datentransceiver, der die Endgeräte hinter einer einzigen #acro("IP")-Adresse bündelt und den Modbus-Registerraum über den in @sec:modbus_tcp beschriebenen Port 502 bereitstellt. Die Randbedingungen RB-05 bis RB-07 aus @tab:rb richten sich dabei an den Betrieb der Lösung beim Kunden und sind am Laboraufbau nicht eigens nachzuweisen, da sie nach @sec:testabdeckung keine geforderte Eigenschaft der Lösung beschreiben, sondern die Voraussetzungen ihres Betriebs. Der Testaufbau ist demgegenüber eine geschlossene Umgebung, in der die Modbus-Schnittstelle des Powercenters für die Anbindung eingeschaltet ist.

/* Anmerkung des Autors, erledigt: "die spezifische ip adresse ist aus meiner
   Sicht echt nicht relevant. ich würde an beiden stellen einfach nur über die
   ip adresse an sich reden. gleiches gilt mit setup von subnetzwerken und so,
   der netzwerkaspekt ist einfach kein großer fokus der arbeit" */

Die Topologie dieser Umgebung ist einfach und wird hier logisch beschrieben, da die vergebenen Adressen für sich genommen nichts tragen, was sich auf eine andere Anlage übertragen ließe. Der Rechner mit Desigo CC und das Powercenter hängen an demselben Switch und liegen in demselben #acro("VLAN"), sodass zwischen beiden weder ein Gateway noch eine Route liegt. Das Powercenter trägt dabei eine fest vergebene Adresse und bezieht sie nicht über #acro("DHCP"), weil die in Desigo CC eingerichtete Schnittstelle nach @sec:desigoccmechanik auf eine bestimmte Adresse verweist und ein Wechsel diese Zuordnung zerstören würde. Die Zuordnung von Rollen folgt aus @sec:desigocc: Desigo CC tritt als Modbus-Client auf, das Powercenter als Server, der den Registerraum unter Port 502 bereitstellt.

Den Zugang in dieses Segment regelt eine vorgelagerte Firewall. Für den Aufbau sind dort die Ports 80 und 443 für #acro("HTTP") und #acro("HTTPS") sowie der Port 502 für Modbus #acro("TCP") freigegeben, wobei die ersten beiden den Zugang von SENTRON Powerconfig nach @sec:geraetekonfiguration tragen und der letzte den laufenden Datenpfad. Weitere Dienste des Powercenters sind von außen nicht erreichbar. Innerhalb des Segments wirkt diese Freigabe nicht, da Desigo CC und Powercenter dort unmittelbar benachbart sind. Der Schutz liegt somit an der Segmentgrenze und entspricht der Sache nach dem, was RB-06 verlangt. Ein Nachweis liegt darin gleichwohl nicht, denn ein einzelner Laboraufbau in einem gemeinsamen #acro("VLAN") sagt nichts über eine Kundenanlage mit mehreren Strängen aus.


Auf der Gegenseite trägt ein eigens angelegter Treiber die Kommunikation. Er wird im Projekt in Desigo CC erzeugt, einem Netzwerk zugeordnet und gestartet, wie es @sec:desigoccmechanik beschreibt. Der Treiber hat auf die Gestalt des Datenmodells keinen Einfluss, bestimmt aber, ob und wie schnell Werte eintreffen. Das Abfrageintervall, das nach @sec:konzept einheitlich für alle angebundenen Geräte gilt, wird am Treiber auf eine Sekunde konfiguriert. Die Blockbildungsgrenze bleibt auf dem Vorgabewert des Treibers, sodass die Zusammenfassung benachbarter Register allein dessen eigener Regel folgt. Welche Last daraus auf der Leitung entsteht, ist keine Frage der Einstellung mehr, sondern am Telegrammverkehr abzulesen und in @sec:testdurchfuehrung gemessen.

#kommentar[Zu bestätigen ist, dass die Blockbildungsgrenze am Aufbau tatsächlich unverändert geblieben ist. Trifft das zu, gehört der Vorgabewert des Treibers als Zahl an diese Stelle, damit sich die in @sec:testdurchfuehrung gemessene Blockbildung nachvollziehen lässt.]


Die Adressierung auf der Zielseite folgt der Trennung von Gerätetyp und Geräteinstanz. Eine Schnittstelle ist durch die #acro("IP")-Adresse und den Unit Identifier bestimmt, und unter ihr steht genau ein Gerät @src:desigoccenghelp. Ein vollständiger Strang aus Datentransceiver und Endgeräten erscheint in Desigo CC damit nicht als ein Gerät mit Untergeräten, sondern als eine Reihe getrennter Schnittstellen mit derselben #acro("IP")-Adresse und unterschiedlichem Unit Identifier. Am Testaufbau sind das der Datentransceiver unter 255 und das Endgerät unter seiner bei der Kopplung vergebenen Adresse (siehe @sec:geraetekonfiguration). Beide Kennungen sind keine Festlegung dieses Aufbaus. Die 255 ist am Powercenter fest vergeben, und die Adresse des Endgeräts entsteht bei der Kopplung, sodass in jeder Anlage dieselbe Regel gilt.


Zur Kommunikationsstrecke gehört schließlich ein Weg, der am Datenmodell vorbeiführt. Für die Gegenprobe der Registerwerte wird neben Desigo CC das in @sec:werkzeuge begründete unabhängige Modbus-Werkzeug auf denselben Registerraum gerichtet. Das Systemhandbuch rät allerdings dazu, betrieblich nur eine Modbus-Verbindung zu verwenden, damit sich Schreibbefehle verschiedener Anwendungen nicht überschneiden (siehe @sec:powercenter_modbus). Für die Prüfung ist der parallele Zugriff daher auf lesende Gegenproben zu beschränken oder zeitlich gegen den Betrieb des Treibers abzugrenzen.

/* Claude: Abschnitt nach der Vorgabe aus dem Kommentar ausformuliert
   (Netzsegment, Adressierung, Fernzugriff, Modbus-Treiber als Voraussetzung
   des Datenflusses). Der Import der Typbeschreibung ist wie gefordert nicht
   beschrieben, sondern an @sec:uebernahme verwiesen.

   Ergaenzt wurde der Schlussabsatz zum zweiten, unabhaengigen Modbus-Zugang.
   Er gehoert sachlich zur Kommunikationsstrecke und traegt zugleich den
   Hinweis des Systemhandbuchs, dass betrieblich nur eine Verbindung genutzt
   werden soll.

   Die Randbedingungen RB-05 bis RB-07 sind nach Ruecksprache nicht mehr als
   am Aufbau erfuellt dargestellt, sondern als Voraussetzungen des spaeteren
   Betriebs, die nach @sec:testabdeckung zu dokumentieren und nicht zu pruefen
   sind. Der Fernzugriff ist hier ganz entfallen und nur in @sec:testaufbau
   kurz erwaehnt.

   Nicht erfunden und als roter Arbeitskommentar offen gelassen sind die
   IP-Adressen und das eingestellte Abfrageintervall. */

/* Claude: Am 31.08.2026 nach der Rueckfrage zur Netzdokumentation ergaenzt.
   Aufgenommen sind logische Topologie (ein Switch, ein VLAN, kein Gateway im
   Datenpfad), die Rollen als Modbus-Client und -Server, der Port 502, die
   Freigaben auf der Firewall und die feste Adresse des Powercenters. Bewusst
   nicht aufgenommen sind die vergebenen IP-Adressen; sie tragen nichts, was
   sich auf eine andere Anlage uebertragen liesse, was die Anmerkung des Autors
   darueber ebenfalls festhielt.

   Die Unit Identifier standen bereits im Absatz zur Adressierung. Ergaenzt ist
   dort nur der Satz, dass beide Kennungen nicht dem Testaufbau eigen sind,
   sondern aus Geraet und Kopplung folgen.

   VLAN und DHCP sind neu in config/acronyms.typ aufgenommen, da beide zuvor
   nicht im Verzeichnis standen.

   Nachgetragen nach Auskunft des Autors: Die Firewall ist dem Segment
   vorgelagert und nicht die des Desigo-CC-Rechners. Ihr genauer Ort ist nicht
   bekannt und fuer die Aussage ohne Belang, weshalb der Text nur von einer
   vorgelagerten Firewall spricht. Daraus folgt der Zusatz, dass die Freigabe
   innerhalb des Segments nicht wirkt und der Schutz an dessen Grenze liegt.
   Die Erwaehnung von DHCP bleibt auf Entscheidung des Autors stehen; der Satz
   behauptet ohnehin nur, dass das Powercenter seine Adresse nicht dynamisch
   bezieht. */

/* Claude: Am 02.09.2026 gekuerzt, drei Stellen.

   Die Absaetze zwei und drei fuehrten die Sicherheitsargumentation ein
   viertes Mal vollstaendig aus (fehlende Verschluesselung, RBAC nur auf
   HTTPS, Schutz auf Netzebene, Inhalt von RB-05 bis RB-07 im Wortlaut). Sie
   steht als Protokolleigenschaft in @sec:modbus und als Folgerung in
   @sec:integrationswege. Erhalten ist allein die hier neue Aussage, dass die
   Randbedingungen am Laboraufbau nicht nachzuweisen sind.

   Die Herleitung des einheitlichen Abfrageintervalls ist durch einen Verweis
   auf @sec:konzept ersetzt; hier steht jetzt nur noch der eingestellte Wert,
   also die Angabe, die den Testaufbau tatsaechlich beschreibt.

   Die Begruendung des zweiten Modbus-Zugangs stand gleichlautend in
   @sec:werkzeuge und in @sec:pruefablauf. Sie verbleibt in @sec:werkzeuge, wo
   das Werkzeug eingefuehrt wird; hier steht nur noch die Einschraenkung auf
   lesende Gegenproben, die den Aufbau der Strecke betrifft. */
