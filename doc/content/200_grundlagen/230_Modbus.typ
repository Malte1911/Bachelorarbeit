#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#import "../../config/diagrams.typ": abb_modbus_tcp
#include "../../config/config.typ"

== Modbus<sec:modbus>


Modbus ist ein serielles Kommunikationsprotokoll, das ursprünglich 1979 von der Firma Modicon für die Kommunikation zwischen #acro("SPS") entwickelt wurde @src:modbusspec. Es zählt zu den beiden Vorläufern der Feldbustechnik, die sich in der industriellen Automatisierung durch ihr Alter, ihren Funktionsumfang und ihre weltweite Akzeptanz von den übrigen Netzen ihrer Zeit abhoben, und ist als Kommunikationsprofilfamilie CPF 15 in die Normenreihe IEC 61784-2 eingegangen @src:fieldbus. Seine Verbreitung verdankt es der einfachen Anfrage-Antwort-Struktur und der frei zugänglichen Spezifikation @src:modbusspec.


Das Protokoll basiert auf einem Request-Response-Prinzip, bei dem ein anfragendes Gerät (z. B. ein Leitsystem) Anfragen an eines oder mehrere antwortende Geräte (z. B. Sensoren, Aktoren oder Messgeräte) sendet. Die antwortenden Geräte reagieren ausschließlich auf eingehende Anfragen und initiieren keine eigenständige Kommunikation @src:modbusserial.
Modbus kennt drei Übertragungsvarianten. Modbus #acro("RTU") überträgt die Daten in einer kompakten binären Darstellung über serielle Schnittstellen wie RS-232 oder RS-485 @src:modbusserial und wird in der Praxis häufig eingesetzt @src:modbusrtuprotocol. Modbus #acro("ASCII") stellt dieselben Daten als #acro("ASCII")-Zeichen dar, arbeitet dadurch weniger effizient und eignet sich für Geräte oder Verbindungen, welche die Zeitanforderungen von #acro("RTU") nicht erfüllen @src:modbusserial. Modbus #acro("TCP")/#acro("IP") bettet die Nachrichten in TCP/IP-Pakete ein @src:modbustcp und wird vor allem wegen seiner Einfachheit und Kompatibilität verwendet, kennt jedoch keine Verschlüsselung @src:modbustcp2.

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

=== Modbus TCP<sec:modbus_tcp>

Modbus #acro("TCP") überträgt das unveränderte Anwendungsprotokoll über Ethernet und ist damit die Variante, über die ein Gerät im Gebäudenetz an ein übergeordnetes System angebunden wird. Die Modbus Organization hat dafür bei der #acro("IANA") den #acro("TCP")-Port 502 registrieren lassen @src:ianaports, auf dem ein Server standardmäßig erreichbar sein muss @src:modbustcp. Eine vollständige Nachricht wird als #acro("ADU") bezeichnet und besteht aus einem sieben Byte langen Kopf mit der Bezeichnung #acro("MBAP") sowie der #acro("PDU") aus Funktionscode und Daten. Der Kopf ersetzt die bei Modbus #acro("RTU") vorangestellte Geräteadresse ebenso wie die angehängte Prüfsumme @src:modbustcp.


Der Kopf führt vier Felder, die @img:modbustcp im Zusammenhang zeigt. Der Transaction Identifier ordnet Anfrage und Antwort einander zu, indem der Server den empfangenen Wert unverändert zurückgibt. Der Protocol Identifier trägt für Modbus stets den Wert 0. Das Feld Länge nennt die Anzahl der ab dem Unit Identifier folgenden Bytes und erlaubt dem Empfänger damit, die Nachrichtengrenze im Bytestrom von #acro("TCP") zu erkennen. Der Unit Identifier adressiert ein Gerät hinter dem angesprochenen Server. Alle Felder sind in Big-Endian-Reihenfolge codiert. Eine eigene Prüfsumme entfällt, da die Fehlererkennung den darunterliegenden Schichten obliegt @src:modbustcp.

#figure(
  abb_modbus_tcp,
  caption: [Aufbau eines Modbus-#acro("TCP")-Telegramms, oben die Kapselung im Ethernet-Rahmen, unten die Felder der Anwendungsdateneinheit aus #acro("MBAP")-Kopf und Protokolldateneinheit mit ihren Bytepositionen, die Feldbreiten sind nicht maßstäblich @src:modbustcp @src:modbusspec],
)<img:modbustcp>


Aus der seriellen Herkunft des Protokolls folgt eine Längenbegrenzung von 253 Byte für die #acro("PDU") und 260 Byte für die #acro("ADU") @src:modbusspec. Eine einzelne Anfrage kann damit höchstens 125 Register lesen und 123 Register schreiben @src:modbusspec, sodass ein umfangreicher Registerraum blockweise abzufragen ist.


Besondere Bedeutung für diese Arbeit hat der Unit Identifier. Sitzt hinter der #acro("IP")-Adresse ein Gateway, benennt das Feld das Endgerät, an das die Anfrage weitergereicht wird. Wird ein Server unmittelbar angesprochen, ist das Feld entbehrlich, und der Implementation Guide empfiehlt dem Client dafür den nicht signifikanten Wert 0xFF, lässt den Wert 0 aber ebenso zu @src:modbustcp. Die Empfehlung gilt dem Aufbau der Anfrage und nicht der Auslegung des Werts im Gerät. Der in @sec:powercenter_modbus beschriebene Datentransceiver ist ein solches Gateway und belegt den Wert 255 mit einer eigenen Bedeutung, nämlich sich selbst.


/* Claude: Abschnitt und Abbildung neu angelegt und nach der Durchsicht auf
   etwa die Haelfte gekuerzt. Entfallen sind die Angaben zur parametrierbaren
   Portnummer, zum lokalen Client-Port, zu mehreren gleichzeitigen
   Transaktionen, die Herleitung der 253 Byte aus dem RS-485-Rahmen sowie die
   Begruendung des Werts 0xFF ueber die Neuvergabe von IP-Adressen.

   Die Angaben stammen aus den beiden bereits verwendeten Primaerquellen der
   Modbus Organization, dem Messaging Implementation Guide (@src:modbustcp)
   fuer MBAP-Kopf, Port 502, Big-Endian, fehlende Pruefsumme und Unit
   Identifier sowie der Application Protocol Specification (@src:modbusspec)
   fuer die Groessengrenzen und die Registerzahlen je Funktionscode. Neu
   recherchiert und in quellen.bib ergaenzt wurde @src:ianaports als Beleg fuer
   die Portregistrierung.

   Zur Rueckfrage aus der Durchsicht: Die sieben Byte sind richtig. Der
   Messaging Implementation Guide fuehrt in Abschnitt 3.1.3 die vier Felder
   Transaction Identifier (2 Byte), Protocol Identifier (2 Byte), Length
   (2 Byte) und Unit Identifier (1 Byte) auf und stellt danach ausdruecklich
   fest: "The header is 7 bytes long." Der Transaction Identifier ist darin
   bereits enthalten. Die Abbildung ist so geaendert, dass die Ausdehnung der
   beiden Einheiten nicht mehr an duennen Klammern haengt, sondern an
   geschlossenen Baendern ueber genau den zugehoerigen Feldern.

   Die Abbildung liegt als `abb_modbus_tcp` in config/diagrams.typ. Sie
   verwendet eine abweichende Kodierung (Schachtelung statt Kanten), was dort
   im Quelltext vermerkt und in der Legende der Abbildung ausgewiesen ist. Die
   Feldbreiten sind bewusst nicht massstaeblich. */

/* Claude: Absatz zum Unit Identifier nach der Anmerkung des Betreuers
   eingegrenzt. Belegstelle im Messaging Implementation Guide ist 4.4.1.2
   "Build a MODBUS Request", S. 23, also eine Vorgabe an den Client und keine
   Aussage ueber Geraeteverhalten. Wortlaut: "On TCP/IP, the MODBUS server is
   addressed using its IP address; therefore, the MODBUS Unit Identifier is
   useless. The value 0xFF has to be used. [...] 0xFF is recommended for the
   'Unit Identifier' as non-significant value. Remark: The value 0 is also
   accepted to communicate directly to a MODBUS/TCP device."
   Der Guide schwankt selbst zwischen "has to be used" und "is recommended",
   und 0x00 ist ausdruecklich zugelassen. Die alte Formulierung ("ist das Feld
   ohne Aussage und traegt den nicht signifikanten Wert 0xFF") war deshalb zu
   stark und liess 0x00 weg.

   Der Schlusssatz ist neu und loest einen Widerspruch zu @sec:powercenter_modbus
   auf, wo 255 als Adresse des Datentransceivers selbst gefuehrt wird. Bei
   diesem Geraet ist 0xFF gerade nicht nicht-signifikant. */
