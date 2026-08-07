#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Power Device Engineer<sec:pde>

Der #acro("PDE") ist das Werkzeug, mit dem das in dieser Arbeit entwickelte Datenmodell erzeugt wird. Die folgenden Stichpunkte fassen die für die Arbeit relevanten Eigenschaften des Werkzeugs zusammen; sie sind der Online-Hilfe zur Version V9.1.0 entnommen @src:pdemanual.

/* Stichpunkte aus der Produktdokumentation, noch in Fließtext zu überführen.
   Die Angaben in den eckigen Klammern sind die Topic-IDs der Quelldateien
   (NonCHM/en-US/<ID>.html), vgl. resources/pde_referenz.md. */

*Einordnung des Werkzeugs* /* [15977535755], [28037698955], [16027603467] */

- Standalone-Anwendung zur Spezifikation, Konfiguration und Integration Modbus-fähiger Geräte in SENTRON-Applikationen @src:pdemanual
- Ergebnis jeder Bearbeitung ist eine #acro("JSON")-Datei, die die Gerätekommunikation gegenüber der übergeordneten Applikation beschreibt @src:pdemanual
- Werkzeugkette: Gerätemanual und Modbus-Registerliste $arrow$ #acro("PDE") $arrow$ #acro("JSON") $arrow$ Import in die Zielapplikation $arrow$ Anlegen der Geräteinstanz $arrow$ Monitoring @src:pdemanual
- Als Zielapplikationen nennt die Dokumentation ausschließlich SENTRON Powermanager V9.0 und SENTRON Powercenter 3000 V1.11.0; Desigo CC wird nicht erwähnt @src:pdemanual /* → der Weg Powercenter → Desigo CC ist Eigenleistung dieser Arbeit und nicht über diese Quelle belegbar */
- Voraussetzung für die Arbeit mit dem Werkzeug sind das Gerätemanual und die Modbus-Registerdetails des einzubindenden Geräts @src:pdemanual

*Arbeitsablauf: fünf Schritte auf drei Wizard-Seiten* /* [16027603467] */

+ Create New Device Type -- Gerätetypnamen festlegen
+ Configure Features -- Geräteeigenschaften und Kommunikationsmerkmale
+ Configure Properties -- Datenpunkte mit Adressen, Datentypen und Transformationen
+ Configure Device -- Messpunkte für Default-, Favorites- und Trend-Darstellung
+ Generate JSON File -- Validieren und Speichern

#figure(
  image("../../resources/img/pde/wizard1_device_features.png", width: 90%),
  caption: [Wizard-Seite _Device Features_ des #acro("PDE") @src:pdemanual]
)<img:pde_device_features>

*Konfigurationsumfang* /* [33770546571], [33770547723] */

- Sieben Feature-Schalter auf der ersten Wizard-Seite: RTU Communication Only, Digital Inputs, Power Period, Offset, Web Page, Byte Swap sowie die Endian Byte Order (Big oder Little) @src:pdemanual
- Datenpunkte werden in die drei Wurzelgruppen Value (Messwerte), State (digitale Eingänge) und Parameter (Geräteparameter) eingeordnet @src:pdemanual
- Je Datenpunkt konfigurierbar: Beschreibung in Deutsch und Englisch, Datentyp, Einheit, Anzeige, Faktor, Archivierung, Aktivierung sowie Funktionscode, Register, Subindex und Transformationstyp @src:pdemanual
- Unterstützte Datentypen: INT, UINT, LONG, ULONG, STRING, FLOAT, BOOLEAN, #acro("BLOB") und DateTime nach IEC 60870-5; als Transformationen stehen unter anderem #acro("BCD"), Packed #acro("BCD") und MOD10 zur Verfügung @src:pdemanual
- Kommandos (Digital Output, Write Value) existieren ausschließlich unter der Gruppe Command; der Kommandowert wird entweder im #acro("PDE") fest hinterlegt oder erst in der konsumierenden Applikation vergeben @src:pdemanual
- Ein Bulk Upload über ein Excel-Template beschleunigt die Erfassung, ist jedoch für Oberschwingungen, #acro("BLOB"), #acro("BCD"), MOD10 und DateTime nicht verfügbar @src:pdemanual

*Online-Modus* /* [33187168907] */

- Dient der Prüfung der Konfiguration gegen ein physisches Gerät, bevor die #acro("JSON")-Datei in einer Applikation eingesetzt wird; verfügbar ist er ausschließlich im Abschnitt Device Properties @src:pdemanual
- Verbindung wahlweise über Modbus #acro("TCP")/#acro("IP") oder über ein Modbus-Gateway für #acro("RTU")-Geräte; erst bei Device Status _Connected_ lassen sich Echtzeitwerte abrufen @src:pdemanual
- Neun Kombinationen aus Datentyp und Transformationstyp werden im Online-Modus nicht unterstützt, darunter #acro("BLOB"), DateTime, STRING, BOOLEAN sowie sämtliche #acro("BCD")- und MOD10-Varianten @src:pdemanual /* → begründet die Validierung am Hardware-Testaufbau, vgl. Kapitel Validierung */

*Restriktionen des Werkzeugs* /* [30675608203], [16027603467], [33770547723] */

- Maximal fünf benutzerdefinierte Untergruppen, und zwar ausschließlich unterhalb von Value @src:pdemanual
- In der Device Configuration maximal sieben Gruppen mit je maximal sieben Messpunkten @src:pdemanual
- Skalierungsfaktoren mit höchstens drei Dezimalstellen, Zeichenketten mit höchstens 250 Zeichen @src:pdemanual
- Für Geräte-, Gruppen- und Datenpunktnamen sind nur Ziffern, lateinische Buchstaben, der Unterstrich sowie die deutschen Umlaute und das Eszett zulässig @src:pdemanual
- Enthält die Konfiguration fehlerhafte Feldangaben, ist das Speichern der #acro("JSON")-Datei nicht möglich @src:pdemanual
- Werden Name oder Typ eines Datenpunkts nach dem produktiven Einsatz geändert, werden alle Funktionen der Applikation gestört, die bestehende Instanzen dieses Gerätetyps verwenden @src:pdemanual /* → Argument für Namensstabilität und Versionierung, verwertbar in der kritischen Würdigung */
