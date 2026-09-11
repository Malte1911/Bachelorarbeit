// Anwenderdokumentation zur Integrationsvorlage.
//
// Diese Datei ist der MASTER der Unterlage. Sie ersetzt die fruehere Fassung
// resources/anwenderdokumentation_ecpd.md, die nur noch als Vorlage der
// Umwandlung aufzubewahren ist. Aenderungen gehoeren ausschliesslich hierher,
// damit die Unterlage nicht zweimal gepflegt werden muss.
//
// Eingebunden wird die Datei aus content/999_appendix.typ. Sie traegt deshalb
// keine eigene Ueberschrift der obersten Ebene; die Ueberschriftsebenen setzen
// unterhalb von "Anwenderdokumentation zur Integrationsvorlage" an.
//
// Bewusst nicht verwendet sind #acro und die uebrigen Hilfsfunktionen der
// Arbeit. Die Unterlage ist ein eigenstaendiges Erzeugnis fuer Errichter und
// Projektierung und soll sich ohne das Abkuerzungsverzeichnis der Arbeit lesen
// lassen.

// Die Referenz der Datenpunkte traegt zehn Spalten und steht deshalb quer.
#let doku_breitseite(inhalt) = page(
  flipped: true,
  margin: (top: 3.5cm, bottom: 3cm, left: 2.5cm, right: 2.5cm),
  inhalt,
)

#figure(
  outlined: false,
  table(
    columns: (9em, 1fr),
    inset: 6pt,
    align: (left + horizon, left),
    [*Gegenstand*], [Zwei Typbeschreibungen (JSON), erzeugt mit dem SENTRON Power Device Engineer. Die eine beschreibt das elektronische Schutzschaltgerät SENTRON 5TY1 COM und ist Gegenstand dieser Unterlage, die andere den Datentransceiver SENTRON Powercenter],
    [*Zielplattform*], [Desigo CC, Anbindung über Modbus TCP am SENTRON Powercenter],
    [*Stand*], [11.09.2026, Entwurf zur Durchsicht],
    [*Adressaten*], [Personal der Inbetriebnahme im Verteiler und Personal der Projektierung im Leitsystem],
    [*Erstellt mit*], [Power Device Engineer V9.1.0, geprüft an Powercenter 1100 (Firmware 7.3.0) und ECPD 5TY1-3MF16 COM (Firmware 5.5.0)],
  ),
  caption: [Kopfdaten der Anwenderdokumentation]
)<tab:apxdoc_kopf>


=== Voraussetzungen und Grenzen<apxdoc:voraussetzungen>

==== Was die Vorlage leistet

Abgebildet sind 37 Register des ECPD, ausgewählt danach, ob sie eine Tätigkeit im laufenden Betrieb unterstützen. Daraus entstehen in Desigo CC 37 Datenpunkte, von denen einer das Sammelregister der 27 Alarme als eine Zahl führt (siehe @apxdoc:alarme). Die vollständige Aufstellung steht in @apxdoc:referenz.

Nicht abgebildet ist die Parametrierung des Geräts. Grenzwerte, Hysteresen, Schutzeinstellungen und Zeitkonfiguration bleiben in SENTRON Powerconfig.


==== Erforderliche Einstellungen in Powerconfig<apxdoc:powerconfig>

Ohne die folgenden drei Schritte liefert das Modell unvollständige oder gar keine Werte.

*Alarme einschalten.* 13 der 27 Alarme des Geräts sind ab Werk deaktiviert und liefern ohne vorherige Einstellung dauerhaft den Wert null. Betroffen sind unter anderem beide RCM-Alarme, die zu den aussagekräftigsten Meldungen des Geräts zählen. Welche Alarme betroffen sind, weist die Spalte Werkszustand in @apxdoc:bitbelegung aus.

*Fernschalten über Modbus freischalten.* Das elektronische Schalten über Modbus ist ab Werk gesperrt. Der zugehörige Schalter besitzt in der Registerkarte keine Registeradresse und lässt sich deshalb ausschließlich über Powerconfig setzen. Bleibt er aus, weist das Gerät jeden Schaltbefehl ab, obwohl andere schreibende Zugriffe angenommen werden. Der Datenpunkt `remote_control_electronic_switching_enabled` bildet diesen Zustand lesend ab und ist bei einem wirkungslosen Schaltbefehl die erste Stelle, an der nachzusehen ist. Zum Schutz der freigeschalteten Schnittstelle siehe den Sicherheitshinweis in @apxdoc:inbetriebnahme.

*Stammdaten setzen.* Anlagenkennzeichen und Einbauort sind im Modell nur lesend geführt, da sich Zeichenketten über die Vorlage nicht beschreiben lassen. Beide werden in Powerconfig vergeben. Das gilt ebenso für die Phasenzuordnung und den eingestellten Nennstrom.

Für geschützte Parameter ist zu beachten, dass ihre Änderung eine Freigabe voraussetzt, bei der innerhalb einer vorgegebenen Zeit die Taste am Gerät zu drücken ist. Alternativ lässt sich der Zugriff über eine Benutzerrolle mit Vollzugriff freischalten.


==== Bekannte Grenzen

#figure(
  outlined: false,
  text(size: 9pt)[#table(
    columns: (1.2fr, 1fr, 1fr),
    inset: 5pt,
    align: (left, left, left),
    table.header(
      [*Grenze*], [*Auswirkung*], [*Umgang*],
    ),
    [Die Alarme aus Register 2560 lassen sich nicht in Einzeldatenpunkte zerlegen. Vom Einsatz im produktiven Umfeld wird abgeraten; bei Bedarf ist eine Steuerung vorzuschalten.],
    [Das Sammelregister kommt als eine Zahl an, nicht als 27 einzelne Meldungen],
    [Bitbelegung in @apxdoc:bitbelegung, Auswertung im Projekt nach @apxdoc:alarme],

    [Kein Energiezähler im Registersatz],
    [Das Gerät misst nur die momentane Wirkleistung, keine Arbeit in kWh],
    [Bei Bedarf im Archiv von Desigo CC über die Zeit integrieren],

    [Zeichenketten sind nicht beschreibbar],
    [Anlagenkennzeichen und Einbauort sind in der Leitwarte sichtbar, aber nicht änderbar],
    [In Powerconfig setzen],

    [Register 22 (Software Version) ist nicht dekodierbar],
    [Der Firmwarestand erscheint nicht im Modell],
    [Über Powerconfig ablesen; ein Firmware-Update ist ohnehin nur dort möglich],

    [Betriebsstunden liegen in Sekunden vor],
    [Der Skalierungsfaktor lässt nur drei Dezimalstellen zu, $1 slash 3600$ ist damit nicht darstellbar],
    [Umrechnung in der Darstellung von Desigo CC],

    [Das Abfrageintervall gilt für den gesamten Treiber],
    [Stammdaten und Zählerstände werden im selben Takt gelesen wie der Schalterzustand],
    [Siehe @apxdoc:treiber],

    [Ein Datenpunkt kennt nur eine Richtung],
    [Schaltbefehl und Rückmeldung sind zwei getrennte Eigenschaften],
    [Bereits im Modell berücksichtigt],

    [Drei Anfragen je Abfragezyklus lesen Coils],
    [Das Powercenter beantwortet sie mit einem Ausnahmecode; in einer Telegrammaufzeichnung erscheinen deshalb Fehlerantworten, ohne dass ein Wert fehlt],
    [Kein Eingriff nötig. Betroffen sind die Adressen der Register 97, 2560 und 3693],
  )],
  caption: [Bekannte Grenzen der Vorlage mit ihrer Auswirkung und dem vorgesehenen Umgang]
)<tab:apxdoc_grenzen>


==== Was im Projekt anzulegen bleibt

Die Vorlage beschreibt den Gerätetyp und die Adressierung. Sie enthält bewusst nichts, was an der einzelnen Anlage hängt. Im Projekt anzulegen sind Alarmklassen und die Zuordnung der Meldungen zu Dringlichkeitsstufen, Grafiken, Symbole und Textgruppen für die Bedienoberfläche, die Archivierung und Trenddarstellung sowie die Liste der tatsächlich vorhandenen Geräteinstanzen.


=== Inbetriebnahme im Verteiler<apxdoc:inbetriebnahme>

Der Ablauf entspricht der gewohnten Inbetriebnahme der Gerätefamilie und wird hier nur so weit beschrieben, wie er die spätere Anbindung festlegt.

+ Powercenter über Ethernet erreichen, alternativ über Bluetooth, was nicht zu empfehlen ist. Bei der Erstinbetriebnahme ist ein Administrator anzulegen; ein Standardpasswort existiert nicht.
+ Endgeräte über den aufgedruckten Code koppeln. Mit der Kopplung erhält jedes Endgerät seine Geräteadresse, die fortlaufend ab 1 vergeben wird.
+ Die in @apxdoc:powerconfig genannten Einstellungen vornehmen.
+ Modbus TCP am Powercenter einschalten. Die Schnittstelle ist ab Werk aus und lässt sich am Powercenter 1100 getrennt aktivieren.

*Für die Projektierung festzuhalten* sind die IP-Adresse des Powercenters und die vergebenen Geräteadressen. Die Geräteadresse aus Schritt 2 ist zugleich der Unit Identifier, unter dem das Gerät später über Modbus angesprochen wird. Der Datentransceiver selbst antwortet unter 255. Die Adressvergabe der Inbetriebnahme legt damit unmittelbar die Adressierung im Leitsystem fest.

*Sicherheitshinweis.* Modbus TCP kennt weder Verschlüsselung noch Authentifizierung, weshalb der Schutz vollständig auf Netzebene erfolgen muss. Die Schnittstelle ist nur dort einzuschalten, wo die Anbindung sie benötigt, die Verbindung gehört in ein eigenes Netzsegment, und ein Zugriff über das lokale Netz hinaus ist an eine VPN-Verbindung oder ein vorgelagertes Gateway zu binden. Das gilt verschärft, sobald das Fernschalten freigeschaltet ist.


=== Integration in Desigo CC<apxdoc:integration>

==== Modbus-Treiber anlegen<apxdoc:treiber>

Der Treiber wird im Projekt eigens erzeugt, einem Netzwerk zugeordnet und gestartet. Für diese Vorlage sind dabei drei Einstellungen maßgeblich.

*Wortreihenfolge.* Die Geräte legen mehrwortige Werte in Big-Endian-Anordnung ab, und die Typbeschreibung ist entsprechend erzeugt. Der Konfigurationseintrag des Treibers für die Wortreihenfolge ist deshalb auf 0 zu setzen. Stimmen beide Seiten nicht überein, liefert ein richtig adressiertes Register einen unbrauchbaren Wert, ohne dass ein Fehler gemeldet würde. Betroffen sind sämtliche Gleitkommazahlen und Zeichenketten der Vorlage, also alle Messwerte, alle Zählerstände und alle Stammdaten. Der Prüfschritt dafür steht in @apxdoc:abnahme.

*Abfrageintervall.* Das Intervall wird am Treiber eingestellt und gilt für sämtliche Datenpunkte aller an diesem Treiber angebundenen Geräte; eine abgestufte Abfrage steht nicht zur Verfügung. Als Orientierung gilt die Empfehlung des Systemhandbuchs, jedes Gerät höchstens einmal je Sekunde abzufragen. Schneller abzufragen bringt keinen Gewinn, da die Messwerte frühestens alle zwei Sekunden aktualisiert werden. Erprobt ist die Vorlage mit einer Sekunde.

*Blockbildung.* Der Treiber fasst Register, deren Adressabstand einen Grenzwert unterschreitet, selbsttätig zu einem Leseblock zusammen. Der Vorgabewert von 16 ist für diese Vorlage geeignet und braucht nicht verändert zu werden.

Ein voll bestückter Strang aus einem Powercenter und 24 Endgeräten belegt mit dieser Vorlage 904 gelesene Register. Daraus werden ebenso viele Datenpunkte, solange die Alarme nach @apxdoc:alarme als eine Zahl ankommen, und 1554, sobald sie einzeln geführt werden. Die Grenze des Treibers von 35000 Datenpunkten ist in beiden Fällen erst jenseits von 20 Strängen erreicht, während die Abfragedauer je Durchlauf schon vorher mit jedem Gerät wächst. Je Server lassen sich zehn Treiber gleichzeitig betreiben.


==== Typbeschreibung importieren

Die JSON-Datei wird als Objektmodell importiert. Sie enthält zu jeder Eigenschaft bereits Registeradresse, Funktionscode, Datentyp, Einheit und Skalierungsfaktor, sodass keine getrennte Adressbelegung anzulegen ist.


==== Geräteinstanzen anlegen

Eine Kommunikationsschnittstelle ist durch IP-Adresse und Unit Identifier bestimmt und genau einem Gerät zugeordnet. Ein vollständiger Strang erscheint deshalb nicht als ein Gerät mit Untergeräten, sondern als eine Reihe getrennter Schnittstellen mit derselben IP-Adresse und unterschiedlichem Unit Identifier.

*Gateway-Kommunikation.* Bei jedem Endgerät ist der Haken für die Gateway-Kommunikation zu setzen, der daraufhin das Eingabefeld für den Unit Identifier freigibt. Ohne ihn bleibt der Unit Identifier unwirksam, und jede Abfrage erreicht das Powercenter selbst statt des adressierten Endgeräts. Die Einstellung hängt am einzelnen Gerät und ist deshalb bei jeder neuen Instanz erneut vorzunehmen.

#figure(
  outlined: false,
  table(
    columns: (1fr, 1fr, 1fr, 4em),
    inset: 6pt,
    align: (left, left, left, center + horizon),
    table.header(
      [*Gerät*], [*IP-Adresse*], [*Unit Identifier*], [*Port*],
    ),
    [Powercenter (Datentransceiver)], [IP des Powercenters], [255], [502],
    [ECPD Nr. 1 bis 24], [IP des Powercenters], [Geräteadresse aus der Kopplung, 1 bis 24], [502],
  ),
  caption: [Adressierung der Geräte eines Strangs in Desigo CC]
)<tab:apxdoc_adressierung>

Nach @tab:apxdoc_adressierung entstehen je Strang bis zu 25 Schnittstellen. Für das Powercenter liegt eine zweite, bewusst schmal gehaltene Typbeschreibung bei, die allein die Datenpunkte des Datentransceivers führt und auf Import und Instanzbildung geprüft ist. Die Parametrierung des Powercenters bleibt in Powerconfig.

Ein Datenpunkt der Vorlage hängt an der Stelle des Geräts am Powercenter. `device_status` liegt auf Register $16483 + n$, wobei $n$ der Geräteadresse entspricht. Das Powercenter führt diesen Wert als Feld über alle 24 Endgeräteplätze, dessen erster Platz auf Register 16484 liegt. Ein Gerät mit der Adresse 1 belegt damit Register 16484, ein Gerät mit der Adresse 2 Register 16485 und so fort. Diese Adresse ist je Instanz nachzuführen, alle übrigen Register sind bei allen Geräten identisch.


==== Alarme auswerten<apxdoc:alarme>

Das Gerät meldet seine 27 Alarme als Bitfeld in einem einzigen Register. Eine Zerlegung in einzelne Datenpunkte ist über diese Werkzeugkette nicht möglich, weshalb `alarm_state` als vorzeichenlose Ganzzahl ankommt und die Auswertung im Projekt stattfindet.

@apxdoc:bitbelegung führt zu jedem Bit die Meldung, seine Wertigkeit im Register und den Werkszustand. Eine Bedingung ohne Maskierung prüft stets den gesamten Registerinhalt, weshalb ein Vergleich gegen die Wertigkeit eines einzelnen Bits nur zutrifft, solange kein weiteres Bit gesetzt ist. Für sicherheitsrelevante Meldungen ist er damit ungeeignet, da eine Auslösung typischerweise mehrere Bits zugleich setzt.

Für die nach Dringlichkeit gestaffelte Zuordnung der Meldungen zu Alarmklassen bietet sich die Einteilung in @tab:apxdoc_alarmklassen an, die im Projekt zu prüfen und an die Anlage anzupassen ist. Die vier Stufen decken alle 27 belegten Bits ab.

#figure(
  outlined: false,
  table(
    columns: (10em, 1fr),
    inset: 6pt,
    align: (left + horizon, left),
    table.header(
      [*Stufe*], [*Bits*],
    ),
    [Höchste Dringlichkeit], [18 Selbsttest fehlgeschlagen, 20 Auslösung Fehlerstrom, 27 Unverzögerte Auslösung, 29 Übertemperaturabschaltung],
    [Störung], [13, 15, 19, 25, 26, 28, 31],
    [Wartungsmeldung], [0, 1, 2, 3, 16, 30],
    [Vorwarnung], [4 bis 12 und 24],
  ),
  caption: [Vorschlag für die Zuordnung der Alarmbits zu Dringlichkeitsstufen]
)<tab:apxdoc_alarmklassen>


==== Abnahmeprüfung<apxdoc:abnahme>

Nach dem Anlegen der Instanzen empfiehlt sich die folgende Reihenfolge.

+ `device_status` prüfen. Steht die Funkverbindung, ist die Strecke vom Leitsystem bis zum Endgerät durchgängig.
+ Wortreihenfolge an `line_frequency` prüfen. Der Wert ist eine Gleitkommazahl über zwei Register und liegt im Netzbetrieb bei rund $50space.thin"Hz"$. Weicht er um Größenordnungen ab, ist die Wortreihenfolge am Treiber nicht auf Big Endian eingestellt. Die Prüfung kommt ohne Referenzmessgerät aus, weil die Größenordnung von vornherein feststeht.
+ `rated_current_setting` prüfen. Der Wert muss dem Nennstrom des Geräts entsprechen, bei einem 16-A-Gerät somit 16 nach Anwendung des Faktors.
+ Ungültige Messwerte erkennen. Das Powercenter kennzeichnet sie als _Not a Number_. Zusammen mit `device_status` lässt sich so ein ausgefallenes Gerät von einem Gerät mit dem Messwert null unterscheiden.
+ Nur wenn das Fernschalten genutzt werden soll, `remote_control_electronic_switching_enabled` prüfen und anschließend einen Schaltbefehl mit Rückmeldung über `switching_state_feedback` verfolgen.


=== Vorlage anpassen<apxdoc:anpassen>

Die Vorlage lässt sich im Power Device Engineer erneut öffnen, sodass sich Datenpunkte ohne Neuerstellung des Modells ergänzen oder entfernen lassen.

*Namen und Typen bestehender Eigenschaften nicht ändern.* Sobald zu einem Gerätetyp Instanzen angelegt sind, unterbricht eine Änderung des Namens oder des Typs einer Eigenschaft alle Funktionen, die auf ihr aufsetzen. Ergänzen und Entfernen sind unkritisch, Umbenennen ist es nicht. Wird eine Umbenennung dennoch nötig, ist sie wie ein neuer Gerätetyp zu behandeln.

*Zwischenstände sichern.* Beim Entfernen eines Datentyps aus einer bestehenden Typbeschreibung ist die Dateigröße im Verlauf dieser Arbeit ohne erkennbaren Grund stark angestiegen, woraufhin sich die Datei nicht mehr öffnen ließ. Vor größeren Eingriffen ist deshalb eine Kopie abzulegen.

Nach jeder Änderung ist die Typbeschreibung erneut zu importieren und die Nachführung bestehender Instanzen zu prüfen.


=== Referenz<apxdoc:referenz>

==== Abgebildete Datenpunkte des ECPD

Die Vorlage bildet 37 Register ab, aufgelistet in @tab:apxdoc_referenz. Die Registernummern entsprechen der Registerkarte der Gerätefamilie. Die Spalte _Länge_ gibt an, über wie viele Register sich ein Wert erstreckt; ein mehrwortiger Wert ist stets in dieser Länge zu lesen, andernfalls liefert das Gerät keine verwertbaren Daten. Die Richtung _R_ bedeutet lesend, _W fest_ ein Kommando mit im Modell hinterlegtem Wert und _W dynamisch_ ein Kommando, dessen Wert in Desigo CC vergeben wird.

#doku_breitseite[
#figure(
  outlined: false,
  text(size: 8pt, lang: "de", hyphenate: true)[#table(
    columns: (1fr, 6.5em, 4em, 2.6em, 1fr, 5em, 5em, 3em, 3em, 1.4fr),
    inset: 4pt,
    align: (left, left + horizon, left + horizon, center + horizon, left, left + horizon, left + horizon, center + horizon, center + horizon, left),
    table.header(
      [*Variablenname*], [*Gruppe*], [*Register*], [*Länge*], [*Bezeichnung*], [*Richtung*], [*Datentyp*], [*Einheit*], [*Faktor*], [*Werte und Kodierung*],
    ),
    [`alarm_state`], [State], [2560], [2], [Alarm Zustand (Sammel-Bitfeld)], [R], [UINT 4 Byte], [], [1], [Bitfeld, siehe @apxdoc:bitbelegung],
    [`switch_status`], [State], [3110], [1], [Schalter Status], [R], [UINT 2 Byte], [], [1], [0=unbekannt, 1=AUS, 2=EIN, 3=Ausgelöst, 4=Ausgelöst und Hebel blockiert, 5=Standby, 6=Standby tripped],
    [`switching_state_feedback`], [State], [3113], [1], [Schaltzustand ändern (Rückmeldung)], [R], [UINT 2 Byte], [], [1], [0=ON, 1=ON Fehler, 2=STBY, 3=STBY Fehler, 4=OFF, 5=OFF Fehler],
    [`device_status`], [State], [16483+n], [1], [Device Status (Funkverbindung)], [R], [UINT 2 Byte], [], [1], [0=IDLE, 1=Offline, 2=Verbinden, 3=Verbunden],
    [`radio_rssi`], [State], [2622], [1], [Funk Empfangssignalstärke RSSI], [R], [INT 2 Byte], [dBm], [1], [],
    [`current`], [Value / Current], [3076], [2], [Strom], [R], [FLOAT 4 Byte], [A], [1], [],
    [`current_maximum`], [Value / Current], [3080], [2], [Maximalwert Strom], [R], [FLOAT 4 Byte], [A], [1], [Vom Gerät gespeicherter Extremwert],
    [`voltage`], [Value / Voltage], [3082], [2], [Spannung], [R], [FLOAT 4 Byte], [V], [1], [],
    [`line_frequency`], [Value / Frequency], [3084], [2], [Netzfrequenz], [R], [FLOAT 4 Byte], [Hz], [1], [],
    [`active_power`], [Value / Power], [3086], [2], [Wirkleistung], [R], [FLOAT 4 Byte], [W], [1], [],
    [`power_factor`], [Value / Power Factor], [3092], [2], [Leistungsfaktor], [R], [FLOAT 4 Byte], [], [1], [],
    [`temperature`], [Value / Temperature], [3072], [2], [Temperatur], [R], [FLOAT 4 Byte], [°C], [1], [],
    [`residual_current_ac_lowpass`], [Value / Others], [3330], [2], [AC Differenzstrom Tiefpass (RCM)], [R], [FLOAT 4 Byte], [A], [1], [],
    [`operating_hours_total`], [Value / Counter], [2578], [4], [Betriebsstundenzähler gesamt], [R], [FLOAT 8 Byte], [s], [1], [In Sekunden, Umrechnung in der Anzeige],
    [`operating_hours_with
    _load_current`], [Value / Counter], [2562], [4], [Betriebsstundenzähler mit Belastungsstrom], [R], [FLOAT 8 Byte], [s], [1], [wie Betriebsstundenzähler gesamt],
    [`mechanical_switching_cycles`], [Value / Counter], [2593], [2], [Anzahl mechanischer Schaltspiele], [R], [FLOAT 4 Byte], [], [1], [],
    [`trip_counter`], [Value / Counter], [2602], [2], [Anzahl der Auslösungen], [R], [FLOAT 4 Byte], [], [1], [],
    [`short_circuit_trip_counter`], [Value / Counter], [2624], [2], [Anzahl der Kurzschlussauslösungen], [R], [FLOAT 4 Byte], [], [1], [],
    [`delayed_trip_counter`], [Value / Counter], [2673], [2], [Anzahl verzögerter Auslösungen], [R], [FLOAT 4 Byte], [], [1], [],
    [`protected_parameter
    _change_counter`], [Value / Counter], [2726], [1], [Zähler für Änderung geschützter Parameter], [R], [UINT 2 Byte], [], [1], [],
    [`device_test_status`], [Parameter], [2679], [1], [Status Gerätetest], [R], [UINT 2 Byte], [], [1], [0=unbekannt, 1=erfolgreich, 2=fehlgeschlagen, 3=nicht durchgeführt, 4=abgebrochen],
    [`rcd_test_status`], [Parameter], [2635], [1], [Letzter Status RCD Test], [R], [UINT 2 Byte], [], [1], [0 bis 12, Fehlercode],
    [`auto_reclosing_active`], [Parameter], [2680], [1], [Automatisches Wiedereinschalten (ARD aktiv)], [R], [UINT 2 Byte], [], [1], [0=unbekannt, 1=ARD aktiv],
    [`command_electronic_switching`], [Command], [3693], [1], [Kommando elektronisches Schalten], [W dynamisch], [UINT 2 Byte], [], [1], [0=STANDBY, 1=ON. Freischaltung erforderlich, siehe @apxdoc:powerconfig],
    [`command_acknowledge_trip`], [Command], [3692], [1], [Auslösemeldung quittieren], [W fest], [UINT 2 Byte], [], [1], [fester Wert 0x0815],
    [`command_reset_rcm_alarm`], [Command], [5225], [1], [RCM Alarm und Vor-Alarm zurücksetzen], [W fest], [UINT 2 Byte], [], [1], [fester Wert 0x0815],
    [`command_device_test`], [Command], [2678], [1], [Gerätetest ausführen], [W fest], [UINT 2 Byte], [], [1], [fester Wert 0x0815],
    [`command_blink_mode`], [Command], [97], [1], [Blinkmodus zur Gerätelokalisierung], [W dynamisch], [UINT 2 Byte], [], [1], [0=stopp, 1=10 s blinken],
    [`command_mechanical_disconnect`], [Command], [3694], [1], [Kommando mechanisches Trennen], [W fest], [UINT 2 Byte], [], [1], [fester Wert 0x0815. Nicht rückstellbar, erzwingt einen Einsatz vor Ort],
    [`asset_identifier`], [Parameter], [29], [16], [Anlagenkennzeichen (Name)], [R], [STRING], [], [1], [In Powerconfig setzen],
    [`installation_location`], [Parameter], [45], [11], [Einbauort], [R], [STRING], [], [1], [In Powerconfig setzen],
    [`device_serial_number`], [Parameter], [13], [8], [Seriennummer], [R], [STRING], [], [1], [],
    [`device_name`], [Parameter], [3], [10], [Artikelnummer], [R], [STRING], [], [1], [],
    [`phase_information`], [Parameter], [145], [1], [Phasen Information], [R], [UINT 2 Byte], [], [1], [0=nicht vergeben, 1=L1, 2=L2, 3=L3],
    [`rated_current_setting`], [Parameter], [5376], [1], [Eingestellter Nennstrom des Gerätes], [R], [UINT 2 Byte], [A], [0,001], [16000 entspricht 16 A],
    [`remote_control_electronic
    _switching_enabled`], [Parameter], [5425], [1], [Fernsteuerung elektronisches Schalten (Status)], [R], [UINT 2 Byte], [], [1], [0=inaktiv, 1=aktiv],
    [`last_trip_log_oid`], [State], [3671], [1], [Letzte Trip Log OID], [R], [UINT 2 Byte], [], [1], [Ändert sich bei jeder neuen Auslösung],
  )],
  caption: [Abgebildete Datenpunkte des ECPD mit Registerplatz, Länge, Datentyp, Einheit, Skalierungsfaktor und Kodierung]
)<tab:apxdoc_referenz>
]

Der Funktionscode ist nicht Teil der Registerkarte. Die Vorlage liest mit FC3 und schreibt mit FC6. Das Powercenter nimmt daneben FC4 lesend und FC16 schreibend an, sodass eine abweichende Belegung einzelner Datenpunkte möglich bliebe.


==== Bitbelegung des Alarmregisters 2560<apxdoc:bitbelegung>

Die Spalte Wertigkeit gibt den Zahlenwert an, den das Bit im Register beiträgt. Die Spalte Werkszustand gibt an, ob der Alarm ab Werk wirksam ist. Ereignisbasierte Alarme besitzen keinen Schalter und sind stets wirksam. Die Bits 14, 17 und 21 bis 23 sind für dieses Gerät nicht belegt.

#figure(
  outlined: false,
  text(size: 9pt)[#table(
    columns: (3em, 7em, 1fr, 8em),
    inset: 4pt,
    align: (right + horizon, right + horizon, left, left + horizon),
    table.header(
      [*Bit*], [*Wertigkeit*], [*Meldung*], [*Werkszustand*],
    ),
    [0], [1], [Alarm Betriebsstunden mit Belastungsstrom], [aus],
    [1], [2], [Alarm Betriebsstunden], [aus],
    [2], [4], [Alarm Schaltspiele], [aus],
    [3], [8], [Alarm Auslösezähler], [aus],
    [4], [16], [Alarm Temperaturüberschreitung], [ein],
    [5], [32], [Alarm 1 Überstrom], [ein],
    [6], [64], [Alarm 2 Überstrom], [aus],
    [7], [128], [Alarm 1 Unterstrom], [aus],
    [8], [256], [Alarm 2 Unterstrom], [aus],
    [9], [512], [Alarm 1 Überspannung], [aus],
    [10], [1024], [Alarm 2 Überspannung], [aus],
    [11], [2048], [Alarm 1 Unterspannung], [aus],
    [12], [4096], [Alarm 2 Unterspannung], [aus],
    [13], [8192], [Schalter ausgelöst], [ereignisbasiert],
    [15], [32768], [Auslösung Überspannung], [ereignisbasiert],
    [16], [65536], [Alarm Kurzschlussauslösezähler], [ein],
    [18], [262144], [Selbsttest fehlgeschlagen], [ereignisbasiert],
    [19], [524288], [Auslösung Unterspannung], [ereignisbasiert],
    [20], [1048576], [Auslösung Fehlerstrom], [ereignisbasiert],
    [24], [16777216], [RCM Vor-Alarm], [aus],
    [25], [33554432], [RCM Alarm], [aus],
    [26], [67108864], [Verzögerte Auslösung], [ereignisbasiert],
    [27], [134217728], [Unverzögerte Auslösung], [ereignisbasiert],
    [28], [268435456], [ARD fehlgeschlagen], [ereignisbasiert],
    [29], [536870912], [Übertemperaturabschaltung], [ereignisbasiert],
    [30], [1073741824], [Alarm für verzögerte Auslösungen], [ein],
    [31], [2147483648], [Alarm EIN blockiert], [ereignisbasiert],
  )],
  caption: [Bitbelegung des Alarmregisters 2560 mit Wertigkeit und Werkszustand]
)<tab:apxdoc_bits>

13 der 27 Alarme sind ab Werk abgeschaltet. Sie liefern ohne die Einstellung in Powerconfig dauerhaft null, ohne dass dies in der Leitwarte erkennbar wäre.

/* Offene Punkte der Unterlage, aus der Markdown-Fassung uebernommen und vor
   ihrer Freigabe zu klaeren:

   1. Die Abschnitte "Bekannte Grenzen" und "Alarme auswerten" setzen voraus,
      dass die Alarme als eine Zahl uebertragen werden. Falls doch eine
      Zerlegung gelingt, sind beide Stellen und die Referenz anzupassen.
   2. Abschnitt "Modbus-Treiber anlegen": Der am Testaufbau eingestellte Wert
      des Abfrageintervalls von einer Sekunde steht inzwischen in
      @sec:kommunikationsstrecke und gehoert als Empfehlung auch hierher.
   3. Referenz, Gruppe von residual_current_ac_lowpass: derzeit
      "Value / Others". Sobald die tatsaechliche Ablage feststeht, hier und in
      der Arbeitsmappe nachziehen.
   4. Referenz: Die Zuordnung FC3 lesend und FC6 schreibend ist die Konvention,
      nicht aus der Registerkarte belegt. Gegen das Modell pruefen.
   5. Alarmklassen: Die Staffelung ist ein Vorschlag aus der Arbeitsmappe und im
      Projekt zu pruefen.
   6. Abschnitt "Vorlage anpassen": Der Verweis auf die internen Unterlagen zum
      Werkzeug ist bewusst allgemein gehalten. Falls ein konkreter Ablageort
      genannt werden soll, gehoert er dorthin.
   7. Ein Deckblatt mit Dokumentnummer, Freigabe und Revisionsstand fehlt und
      waere bei einer eigenstaendigen Auslieferung zu ergaenzen. Innerhalb des
      Anhangs traegt @tab:apxdoc_kopf diese Angaben ersatzweise. */

/* Claude: Durchsicht der Unterlage am 11.09.2026. Geaendert wurde Folgendes.

   INHALTLICHE FEHLER
   1. "905 Register" je voll bestuecktem Strang war eine ueberholte Zahl. Nach
      @tab:bilanz_datenpunkte sind es 904 gelesene Register (24 x 37 + 16).
      Der Satz nennt jetzt zusaetzlich die Datenpunktzahl, und zwar in beiden
      Faellen: 904, solange die Alarme als eine Zahl ankommen, 1554 mit
      zerlegten Alarmen. Beides gegen die Treibergrenze von 35000 gestellt.
   2. Die Staffelung der Alarmklassen liess Bit 4 (Alarm Temperatur-
      ueberschreitung) aus. Von den 27 belegten Bits waren nur 26 zugeordnet.
      Bit 4 steht jetzt bei der Vorwarnung, neben den uebrigen Grenzwertalarmen.
   3. Dieselbe Tabelle nannte Bit 27 "Kurzschluss". Nach @tab:apxdoc_bits heisst
      die Meldung "Unverzoegerte Ausloesung"; Kurzschluss ist Bit 16 und dort der
      Zaehleralarm. Die vier Meldungen der hoechsten Stufe tragen jetzt den
      Wortlaut der Bitbelegung und stehen aufsteigend.
   4. Der Stand in @tab:apxdoc_kopf lag auf dem 26.08.2026, also vor der
      Korrektur der Geraeteadresse (16483+n) und vor der Messung des
      Telegrammverkehrs. Jetzt 11.09.2026.

   FEHLENDE ANGABEN
   5. Der Treiberabschnitt nannte nur das Abfrageintervall. Ergaenzt sind die
      Wortreihenfolge (Big Endian, Konfigurationseintrag auf 0) und die
      Blockbildung (Vorgabewert 16). Die Wortreihenfolge ist die folgenreichste
      Einstellung der ganzen Anbindung: Stimmt sie nicht, liefern saemtliche
      Gleitkommazahlen und Zeichenketten stillschweigend Unsinn. Quelle ist
      @sec:umsetzung und @tab:modbustreiber.
   6. Die Abnahmepruefung hat dafuer einen benannten Pruefschritt bekommen
      (Netzfrequenz gegen die bekannte Groessenordnung), wie es @sec:umsetzung
      fuer diese Unterlage ankuendigt. Der Abschnitt traegt jetzt das Label
      @apxdoc:abnahme.
   7. Die Kopfdaten nannten als Gegenstand nur die Typbeschreibung des ECPD,
      ausgeliefert werden aber zwei Dateien. Die des Powercenters ist jetzt
      genannt.
   8. Die Spalte "Laenge" der Referenz war nicht erklaert. Der Hinweis, dass ein
      mehrwortiger Wert genau in dieser Laenge zu lesen ist, steht jetzt davor.
   9. Neue Zeile in @tab:apxdoc_grenzen zu den drei Coil-Anfragen je Zyklus, die
      das Powercenter nach @sec:testdurchfuehrung mit einem Ausnahmecode
      beantwortet. Wer den Verkehr aufzeichnet, sieht sonst Fehlerantworten ohne
      Erklaerung.
  10. Der Funktionscode-Satz nennt jetzt auch FC4 und FC16, die das Powercenter
      nach @sec:powercenter_modbus annimmt.

   OFFEN GEBLIEBEN
   - Punkt 4 der Liste darueber (FC3/FC6 gegen das Modell pruefen) ist nicht
     abschliessend geklaert, weil die JSON-Dateien nicht im Projektverzeichnis
     liegen. @sec:umsetzung spricht von "Funktionscodes 3 und 4" lesend, was
     sich auf das Angebot des Powercenters beziehen duerfte, nicht auf die
     Belegung der Vorlage. Am Modell nachzusehen.
   - Die Unterlage fuehrt keine Referenz der 16 Powercenter-Datenpunkte,
     obwohl die zweite Typbeschreibung mit ausgeliefert wird. Die Angaben
     stuenden in #ref(<apx:datenpunkte_powercenter>, supplement: [Anhang])
     bereit, wuerden hier aber eine eigene Tabelle verlangen. Mit dem Autor
     abzustimmen.
   - Die Laengen- und Registerangaben der Referenz sind nicht Zeile fuer Zeile
     gegen die Registerkarte geprueft worden, da die Arbeitsmappe hier nicht
     vorliegt. Stichproben (Anlagenkennzeichen 16 Register, Alarmregister
     2 Register, Betriebsstunden 4 Register) stimmen mit der Arbeit ueberein. */

/* Claude: Am 07.09.2026 tragen die sechs Tabellen dieser Unterlage
   `outlined: false` und erscheinen damit nicht mehr im Tabellenverzeichnis der
   Arbeit. Grund ist, dass jede dort gelistete Tabelle im Fliesstext erwaehnt
   sein soll, die Unterlage nach @apx:anwenderdoku aber im Wortlaut unveraendert
   wiedergegeben ist und deshalb keine Verweise der Arbeit aufnehmen kann.
   Die Nummerierung laeuft weiter, die Tabellen behalten also ihre Nummern. */
