#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Kommunikationsstrecke und Netzwerkanbindung<sec:kommunikationsstrecke>

Zwischen dem parametrierten Gerät und dem Objektmodell in Desigo CC liegt die Kommunikationsstrecke. Sie ist Voraussetzung dafür, dass überhaupt Werte fließen, und wird deshalb vor der Entwicklung des Datenmodells eingerichtet. Der Import der Typbeschreibung gehört nicht hierher, sondern ist Gegenstand von @sec:uebernahme und wird von T-01 geprüft.


Die Strecke beginnt am Datentransceiver, der die Endgeräte hinter einer einzigen #acro("IP")-Adresse bündelt und den Modbus-Registerraum über den in @sec:modbus_tcp beschriebenen Port 502 bereitstellt. Da Modbus #acro("TCP") weder Verschlüsselung noch Authentifizierung kennt und die rollenbasierte Zugriffskontrolle des Powercenters ausschließlich auf die #acro("HTTPS")-Kommunikation wirkt @src:sentronsystemhandbuch, muss der Schutz vollständig auf Netzebene erfolgen. Genau hierauf zielen die Randbedingungen RB-05 bis RB-07 aus @tab:rb, die die Modbus-Schnittstelle auf die Aufbauten begrenzen, in denen sie benötigt wird, die Verbindung in einem eigenen Netzsegment halten und einen Zugriff über das lokale Netz hinaus an eine #acro("VPN")-Verbindung oder ein vorgelagertes Gateway binden.


Diese Randbedingungen richten sich an den Betrieb der Lösung beim Kunden und sind am Laboraufbau nicht eigens nachzuweisen. Sie beschreiben nach @sec:testabdeckung keine geforderte Eigenschaft der Lösung, sondern die Voraussetzungen ihrer Entstehung und ihres Betriebs, weshalb ihre Einhaltung zu dokumentieren und nicht zu prüfen ist. Der Testaufbau ist demgegenüber eine geschlossene Umgebung, in der die Modbus-Schnittstelle des Powercenters für die Anbindung eingeschaltet ist. #kommentar[Bitte die #acro("IP")-Adressen von Powercenter und Desigo-CC-Server sowie das verwendete Subnetz ergänzen. Die Angaben tauchen bei der Einrichtung der Schnittstellen in Desigo CC wieder auf und gehören deshalb zur Nachvollziehbarkeit des Aufbaus.]
- die spezifische ip adresse ist aus meiner Sicht echt nicht relevant. ich würde an beiden stellen einfach nur über die ip adresse an sich reden. gleiches gilt mit setup von subnetzwerken und so, der netzwerkaspekt ist einfach kein großer fokus der arbeit


Auf der Gegenseite trägt ein eigens angelegter Treiber die Kommunikation. Er wird im Projekt erzeugt, einem Netzwerk zugeordnet und gestartet, wie es @sec:desigoccmechanik beschreibt. Der Treiber hat auf die Gestalt des Datenmodells keinen Einfluss, bestimmt aber, ob und wie schnell Werte eintreffen. Für den Testaufbau ist dabei eine Eigenschaft aus @tab:modbustreiber unmittelbar wirksam. Das Abfrageintervall wird am Treiber eingestellt und gilt einheitlich für alle Datenpunkte aller angebundenen Geräte, sodass sich die Abfragelast am eingesetzten Stand allein über die Zahl der abgebildeten Datenpunkte und über dieses eine Intervall steuern lässt. #kommentar[Bitte das am Testaufbau eingestellte Abfrageintervall nennen und, sofern zutreffend, die eingestellte Blockbildungsgrenze. Das Intervall ist der Bezugspunkt für T-03 und zugleich der Punkt, an dem sich die Empfehlung des Systemhandbuchs von höchstens einer Abfrage je Sekunde und Gerät im Aufbau niederschlägt.]



Die Adressierung auf der Zielseite folgt der Trennung von Gerätetyp und Geräteinstanz. Eine Schnittstelle ist durch die #acro("IP")-Adresse und den Unit Identifier bestimmt, und unter ihr steht genau ein Gerät @src:desigoccenghelp. Ein vollständiger Strang aus Datentransceiver und Endgeräten erscheint in Desigo CC damit nicht als ein Gerät mit Untergeräten, sondern als eine Reihe getrennter Schnittstellen mit derselben #acro("IP")-Adresse und unterschiedlichem Unit Identifier. Am Testaufbau sind das der Datentransceiver unter 255 und das Endgerät unter seiner bei der Kopplung vergebenen Adresse (siehe @sec:geraetekonfiguration).


Zur Kommunikationsstrecke gehört schließlich ein Weg, der am Datenmodell vorbeiführt. Für die Gegenprobe der Registerwerte wird neben Desigo CC ein unabhängiges Modbus-Werkzeug auf denselben Registerraum gerichtet, das in @sec:werkzeuge genannt ist. Dieser zweite Zugang ist kein Beiwerk, sondern die Voraussetzung dafür, einen Fehler im Datenmodell von einem abweichenden Geräteverhalten zu unterscheiden, wie es der Umgang mit der Herstellerdokumentation nach @sec:quellenlage verlangt. Das Systemhandbuch rät allerdings dazu, betrieblich nur eine Modbus-Verbindung zu verwenden, damit sich Schreibbefehle verschiedener Anwendungen nicht überschneiden (siehe @sec:powercenter_modbus). Für die Prüfung ist der parallele Zugriff daher auf lesende Gegenproben zu beschränken oder zeitlich gegen den Betrieb des Treibers abzugrenzen.

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
