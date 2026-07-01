#import "../../config/acronyms.typ": *
#include "../../config/config.typ"

== Modbus


Modbus ist ein serielles Kommunikationsprotokoll, das ursprünglich 1979 von der Firma Modicon für die Kommunikation zwischen #acro("SPS") entwickelt wurde @src:modbusspec. Aufgrund seiner einfachen Struktur, seiner Offenheit und seiner Robustheit hat es sich zu einem De-facto-Standard in der industriellen Automatisierungstechnik entwickelt und ist bis heute weit verbreitet @src:fieldbus.


Das Protokoll basiert auf einem Request-Response-Prinzip, bei dem ein anfragendes Gerät (z. B. ein Leitsystem) Anfragen an eines oder mehrere antwortende Geräte (z. B. Sensoren, Aktoren oder Messgeräte) sendet. Die antwortenden Geräte reagieren ausschließlich auf eingehende Anfragen und initiieren keine eigenständige Kommunikation @src:modbusserial.

Modbus unterstützt verschiedene Übertragungsvarianten:

- *Modbus #acro("RTU")*: Eine kompakte binäre Darstellung der Daten, die über serielle Schnittstellen wie RS-232 oder RS-485 übertragen wird @src:modbusserial. Modbus #acro("RTU") wird in der Praxis häufig eingesetzt @src:modbusrtuprotocol.

- *Modbus #acro("ASCII")*: Eine zeichenbasierte Darstellung, bei der Daten als #acro("ASCII")-Zeichen übertragen werden. Diese Variante ist weniger effizient als #acro("RTU"), ermöglicht jedoch Kommunikation mit Geräten oder über Verbindungen, die nicht die #acro("RTU") Timing-Anforderungen erfüllen können @src:modbusserial.

- *Modbus #acro("TCP")/#acro("IP")*: Eine Adaption des Protokolls für Ethernet-Netzwerke, bei der Modbus-Nachrichten in TCP/IP-Pakete eingebettet werden @src:modbustcp. Es wird vor allem aufgrund seiner Einfachheit und Kompatibilität verwendet, jedoch ist es nicht verschlüsselt @src:modbustcp2.

Das Protokoll definiert vier Datenbereiche, auf die über standardisierte Funktionscodes zugegriffen wird:


#figure(
  table(
    columns: (auto, 1fr, 1fr),
    inset: 10pt,
    align: horizon,
    table.header(
      [*Datentyp*], [*Bezeichnung*], [*Zugriff*],
    ),
    [Diskrete Ausgänge],
    [Coils],
    [Lesen / Schreiben],
    [Diskrete Eingänge],
    [Discrete Inputs],
    [Nur Lesen],
    [Analoge Ausgänge],
    [Holding Registers],
    [Lesen / Schreiben],
    [Analoge Eingänge],
    [Input Registers],
    [Nur Lesen]
  ),
  caption: [Datenbereiche und Zugriffsrechte des Modbus-Protokolls]

)

Jede Modbus-Nachricht besteht aus der Adresse des antwortenden Geräts, einem Funktionscode, den Nutzdaten sowie einem Fehlerprüffeld @src:modbusserial. Der Kommunikationsablauf folgt dabei stets demselben Schema: Das anfragende Gerät sendet eine Request-Nachricht, woraufhin das adressierte Gerät mit einer Response-Nachricht antwortet. Im Fehlerfall wird anstelle einer regulären Antwort eine Ausnahme-Response (Exception Response) zurückgesendet @src:modbusspec.

Ein wesentlicher Vorteil von Modbus liegt in seiner Einfachheit und Interoperabilität: Da das Protokoll offen spezifiziert und lizenzfrei ist, wird es von einer Vielzahl von Herstellern unterstützt. Allerdings weist Modbus auch Einschränkungen auf: Das Protokoll bietet keine nativen Mechanismen für Sicherheit, Authentifizierung oder Verschlüsselung, was in modernen vernetzten Umgebungen ein erhebliches Sicherheitsrisiko darstellen kann @src:modbussecurity.