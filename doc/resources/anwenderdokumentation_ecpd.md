# Integrationsvorlage SENTRON ECPD für Desigo CC

**Anwenderdokumentation zum Objektmodell**

| | |
|---|---|
| Gegenstand | Typbeschreibung (JSON) für das elektronische Schutzschaltgerät SENTRON 5TY1 COM, erzeugt mit dem SENTRON Power Device Engineer |
| Zielplattform | Desigo CC, Anbindung über Modbus TCP am SENTRON Powercenter |
| Stand | 26.08.2026, Entwurf zur Durchsicht |
| Adressaten | Personal der Inbetriebnahme im Verteiler und Personal der Projektierung im Leitsystem |
| Erstellt mit | Power Device Engineer V9.1.0, geprüft an Powercenter 1100 (Firmware 7.3.0) und ECPD 5TY1-3MF16 COM (Firmware 5.5.0) |
---

## 1 Voraussetzungen und Grenzen
### 1.1 Was die Vorlage leistet

Abgebildet sind 37 Register des ECPD, ausgewählt danach, ob sie eine Tätigkeit im laufenden Betrieb tragen. Die vollständige Aufstellung steht in Kapitel 5.

Nicht abgebildet ist die Parametrierung des Geräts. Grenzwerte, Hysteresen, Schutzeinstellungen und Zeitkonfiguration bleiben in SENTRON Powerconfig.
### 1.2 Erforderliche Einstellungen in Powerconfig

Ohne die folgenden drei Schritte liefert das Modell unvollständige oder gar keine Werte.

**Alarme einschalten.** 13 der 27 Alarme des Geräts sind ab Werk deaktiviert und liefern ohne vorherige Einstellung dauerhaft den Wert null. Betroffen sind unter anderem beide RCM-Alarme, die zu den aussagekräftigsten Meldungen des Geräts zählen. Welche Alarme betroffen sind, weist die Spalte Werkszustand in Kapitel 5.2 aus.

**Fernschalten über Modbus freischalten.** Das elektronische Schalten über Modbus ist ab Werk gesperrt. Der zugehörige Schalter trägt in der Registerkarte keine Registeradresse und lässt sich deshalb nicht über Modbus, sondern ausschließlich über Powerconfig setzen. Bleibt er aus, weist das Gerät den Schaltbefehl ab, obwohl andere schreibende Zugriffe angenommen werden und die Schaltfunktion als geschützter Parameter freigegeben ist. Der Datenpunkt `remote_control_electronic_switching_enabled` bildet diesen Zustand lesend ab und ist der erste Punkt, an dem bei einem wirkungslosen Schaltbefehl nachzusehen ist. Zu beachten sind etwaige Cyber-Security-Vorgaben in der Anwendung. **MODBUS IST UNVERSCHLÜSSELT, JEDER AUF DEM NETZWERK KANN MITLESEN UND EIGENE BEFEHLE SENDEN!**

**Stammdaten setzen.** Anlagenkennzeichen und Einbauort sind im Modell nur lesend geführt, da sich Zeichenketten über die Vorlage nicht beschreiben lassen. Beide werden in Powerconfig vergeben. Das gilt ebenso für die Phasenzuordnung und den eingestellten Nennstrom.

Für geschützte Parameter ist zu beachten, dass ihre Änderung eine Freigabe voraussetzt, bei der innerhalb einer vorgegebenen Zeit die Taste am Gerät zu drücken ist. Alternativ lässt sich der Zugriff über eine Benutzerrolle mit Vollzugriff freischalten.

### 1.3 Bekannte Grenzen

| Grenze | Auswirkung | Umgang |
|---|---|---|
| Die Alarme aus Register 2560 lassen sich nicht in Einzeldatenpunkte zerlegen, es wird gegen den Einsatz im produktiven Umfeld abgeraten (bei Bedarf PLC davorschalten) | Das Sammelregister kommt als eine Zahl an, nicht als 27 einzelne Meldungen | Bitbelegung in Kapitel 5.2, Auswertung im Projekt, siehe Kapitel 3.4 |
| Kein Energiezähler im Registersatz | Das Gerät misst nur die momentane Wirkleistung, keine Arbeit in kWh | Bei Bedarf im Archiv von Desigo CC über die Zeit integrieren |
| Zeichenketten sind nicht beschreibbar | Anlagenkennzeichen und Einbauort sind in der Leitwarte sichtbar, aber nicht änderbar | In Powerconfig setzen |
| Register 22 (Software Version) ist nicht dekodierbar | Der Firmwarestand erscheint nicht im Modell | Über Powerconfig ablesen. Ein Firmware-Update ist ohnehin nur dort möglich |
| Betriebsstunden liegen in Sekunden vor | Der Skalierungsfaktor lässt nur drei Dezimalstellen zu, 1/3600 ist damit nicht darstellbar | Umrechnung in der Darstellung von Desigo CC |
| Das Abfrageintervall gilt für den gesamten Treiber | Stammdaten und Zählerstände werden im selben Takt gelesen wie der Schalterzustand | Siehe Kapitel 3.1 |
| Ein Datenpunkt kennt nur eine Richtung | Schaltbefehl und Rückmeldung sind zwei getrennte Eigenschaften | Bereits im Modell berücksichtigt |

### 1.4 Was im Projekt anzulegen bleibt

Die Vorlage beschreibt den Gerätetyp und die Adressierung. Sie enthält bewusst nichts, was an der einzelnen Anlage hängt. Im Projekt anzulegen sind Alarmklassen und die Zuordnung der Meldungen zu Dringlichkeitsstufen, Grafiken, Symbole und Textgruppen für die Bedienoberfläche, die Archivierung und Trenddarstellung sowie die Liste der tatsächlich vorhandenen Geräteinstanzen.

---

## 2 Inbetriebnahme im Verteiler

Der Ablauf entspricht der gewohnten Inbetriebnahme der Gerätefamilie und wird hier nur so weit beschrieben, wie er die spätere Anbindung festlegt.

1. Powercenter über Ethernet (oder Bluetooth, nicht zu empfehlen) erreichen und bei der Erstinbetriebnahme einen Administrator anlegen. Ein Standardpasswort existiert nicht.
2. Endgeräte über den aufgedruckten Code koppeln. Mit der Kopplung erhält jedes Endgerät seine Geräteadresse, die fortlaufend ab 1 vergeben wird.
3. Die in Kapitel 1.2 genannten Einstellungen vornehmen.
4. Modbus TCP am Powercenter einschalten. Die Schnittstelle ist ab Werk aus und lässt sich am Powercenter 1100 getrennt aktivieren.

**Für die Projektierung festzuhalten** sind die IP-Adresse des Powercenters und die vergebenen Geräteadressen. Die Geräteadresse aus Schritt 2 ist zugleich der Unit Identifier, unter dem das Gerät später über Modbus angesprochen wird. Der Datentransceiver selbst antwortet unter 255. Die Adressvergabe der Inbetriebnahme legt damit unmittelbar die Adressierung im Leitsystem fest.

**Sicherheitshinweis.** Modbus TCP kennt weder Verschlüsselung noch Authentifizierung, und die rollenbasierte Zugriffskontrolle des Powercenters wirkt ausschließlich auf die HTTPS-Kommunikation. Der Schutz muss deshalb vollständig auf Netzebene erfolgen. Die Schnittstelle ist nur dort einzuschalten, wo sie für die Anbindung benötigt wird, die Verbindung gehört in ein eigenes Netzsegment, und ein Zugriff über das lokale Netz hinaus ist an eine VPN-Verbindung oder ein vorgelagertes Gateway zu binden. Das gilt verschärft, sobald das Fernschalten freigeschaltet ist.

---

## 3 Integration in Desigo CC

### 3.1 Modbus-Treiber anlegen

Der Treiber wird im Projekt eigens erzeugt, einem Netzwerk zugeordnet und gestartet. Für diese Vorlage ist dabei eine Einstellung maßgeblich.

**Abfrageintervall.** Das Intervall wird am Treiber eingestellt und gilt für sämtliche Datenpunkte aller an diesem Treiber angebundenen Geräte. Eine nach Geräten oder Datenpunktgruppen abgestufte Abfrage steht nicht zur Verfügung. Als Orientierung gilt die Empfehlung des Systemhandbuchs, jedes Gerät höchstens einmal je Sekunde abzufragen. Eine schnellere Abfrage bringt ohnehin keinen Gewinn, da die Messwerte frühestens alle zwei Sekunden aktualisiert werden.

Zur Größenordnung: Ein vollständig bestückter Strang aus einem Powercenter und 24 Endgeräten belegt mit dieser Vorlage 905 Register. Die Grenze des Treibers liegt deutlich höher, die Abfragedauer je Durchlauf wächst jedoch mit jedem angebundenen Gerät.

### 3.2 Typbeschreibung importieren

Die JSON-Datei wird als Objektmodell importiert. Sie trägt zu jeder Eigenschaft bereits Registeradresse, Funktionscode, Datentyp, Einheit und Skalierungsfaktor, sodass keine getrennte Adressbelegung anzulegen ist.

### 3.3 Geräteinstanzen anlegen

Eine Kommunikationsschnittstelle ist durch IP-Adresse und Unit Identifier bestimmt und trägt genau ein Gerät. Ein vollständiger Strang erscheint deshalb nicht als ein Gerät mit Untergeräten, sondern als eine Reihe getrennter Schnittstellen mit derselben IP-Adresse und unterschiedlichem Unit Identifier.

| Gerät | IP-Adresse | Unit Identifier | Port |
|---|---|---|---|
| Powercenter (Datentransceiver) | IP des Powercenters | 255 | 502 |
| ECPD Nr. 1 bis 24 | IP des Powercenters | Geräteadresse aus der Kopplung, 1 bis 24 | 502 |

Je Strang entstehen so bis zu 25 Schnittstellen. Für das Powercenter selbst existiert keine eigene Vorlage, es wird über Powerconfig betreut.

Ein Datenpunkt der Vorlage hängt an der Stelle des Geräts am Powercenter. `device_status` liegt auf Register 16484+n, wobei n der Geräteadresse entspricht. Diese Adresse ist je Instanz nachzuführen, alle übrigen Register sind bei allen Geräten identisch.

### 3.4 Alarme auswerten

Das Gerät meldet seine 27 Alarme als Bitfeld in einem einzigen Register. Eine Zerlegung in einzelne Datenpunkte ist über diese Werkzeugkette nicht möglich, weshalb `alarm_state` als vorzeichenlose Ganzzahl ankommt und die Auswertung im Projekt stattfindet.

Kapitel 5.2 führt zu jedem Bit die Meldung, seine Wertigkeit im Register und den Werkszustand. Zu beachten ist dabei, dass eine Bedingung ohne Maskierung stets den gesamten Registerinhalt prüft. Ein Vergleich gegen die Wertigkeit eines einzelnen Bits trifft deshalb nur zu, solange kein weiteres Bit gesetzt ist. Da eine Auslösung typischerweise mehrere Bits zugleich setzt, ist ein solcher Vergleich für sicherheitsrelevante Meldungen nicht geeignet.

Für die nach Dringlichkeit gestaffelte Zuordnung der Meldungen zu Alarmklassen bietet sich folgende Einteilung an, die im Projekt zu prüfen und an die Anlage anzupassen ist.

| Stufe | Bits |
|---|---|
| Höchste Dringlichkeit | 20 Fehlerstrom, 27 Kurzschluss, 29 Übertemperaturabschaltung, 18 Selbsttest fehlgeschlagen |
| Störung | 13, 15, 19, 25, 26, 28, 31 |
| Wartungsmeldung | 0, 1, 2, 3, 16, 30 |
| Vorwarnung | 5 bis 12 und 24 |

### 3.5 Abnahmeprüfung

Nach dem Anlegen der Instanzen empfiehlt sich folgende Reihenfolge.

1. `device_status` prüfen. Steht die Funkverbindung, ist die Strecke vom Leitsystem bis zum Endgerät durchgängig.
2. Einen Messwert bekannter Größenordnung gegenprüfen, etwa `line_frequency`. Ein unplausibler Wert weist darauf hin, dass das Register nicht richtig ausgewertet wird.
3. `rated_current_setting` prüfen. Der Wert muss dem Nennstrom des Geräts entsprechen, bei einem 16-A-Gerät also 16 nach Anwendung des Faktors.
4. Ungültige Messwerte erkennen. Das Powercenter kennzeichnet sie als *Not a Number*. Zusammen mit `device_status` lässt sich so ein ausgefallenes Gerät von einem Gerät mit dem Messwert null unterscheiden.
5. Nur wenn das Fernschalten genutzt werden soll, `remote_control_electronic_switching_enabled` prüfen und anschließend einen Schaltbefehl mit Rückmeldung über `switching_state_feedback` verfolgen.

---

## 4 Vorlage anpassen

Die Vorlage ist keine geschlossene Datei. Sie lässt sich im Power Device Engineer erneut öffnen und bearbeiten, sodass sich Datenpunkte ohne Neuerstellung des Modells ergänzen oder entfernen lassen. Wer mit dem Werkzeug vertraut ist, kann die Vorlage ohne besondere Vorkehrungen an die Bedürfnisse eines Kunden anpassen. Einführende Unterlagen zum Werkzeug stehen intern zur Verfügung.

**Namen und Typen bestehender Eigenschaften nicht ändern.** Sobald zu einem Gerätetyp Instanzen angelegt sind, unterbricht eine Änderung des Namens oder des Typs einer Eigenschaft alle Funktionen, die auf ihr aufsetzen. Ergänzen und Entfernen sind unkritisch, Umbenennen ist es nicht. Wird eine Umbenennung dennoch nötig, ist sie wie ein neuer Gerätetyp zu behandeln.

**Zwischenstände sichern.** Beim Entfernen eines Datentyps aus einer bestehenden Typbeschreibung ist die Dateigröße im Verlauf dieser Arbeit unerwartet stark angestiegen, woraufhin sich die Datei nicht mehr öffnen ließ. Eine Erklärung dafür ließ sich nicht finden. Vor größeren Eingriffen sollte deshalb eine Kopie abgelegt werden.

Nach jeder Änderung ist die Typbeschreibung erneut zu importieren und die Nachführung bestehender Instanzen zu prüfen.

---

## 5 Referenz

### 5.1 Abgebildete Datenpunkte des ECPD

37 Register. Die Registernummern entsprechen der Registerkarte der Gerätefamilie. Richtung *R* bedeutet lesend, *W fest* ein Kommando mit im Modell hinterlegtem Wert, *W dynamisch* ein Kommando, dessen Wert in Desigo CC vergeben wird.

| Nr | Variablenname | Gruppe | Register | Länge | Bezeichnung | Richtung | Datentyp | Einheit | Faktor | Werte und Kodierung |
|---:|---|---|---|---:|---|---|---|---|---|---|
| 1 | `alarm_state` | State | 2560 | 2 | Alarm Zustand (Sammel-Bitfeld) | R | UINT 4 Byte | | 1 | Bitfeld, siehe 5.2 |
| 2 | `switch_status` | State | 3110 | 1 | Schalter Status | R | UINT 2 Byte | | 1 | 0=unbekannt, 1=AUS, 2=EIN, 3=Ausgelöst, 4=Ausgelöst und Hebel blockiert, 5=Standby, 6=Standby tripped |
| 3 | `switching_state_feedback` | State | 3113 | 1 | Schaltzustand ändern (Rückmeldung) | R | UINT 2 Byte | | 1 | 0=ON, 1=ON Fehler, 2=STBY, 3=STBY Fehler, 4=OFF, 5=OFF Fehler |
| 4 | `device_status` | State | 16484+n | 1 | Device Status (Funkverbindung) | R | UINT 2 Byte | | 1 | 0=IDLE, 1=Offline, 2=Verbinden, 3=Verbunden |
| 5 | `radio_rssi` | State | 2622 | 1 | Funk Empfangssignalstärke RSSI | R | INT 2 Byte | dBm | 1 | |
| 6 | `current` | Value / Current | 3076 | 2 | Strom | R | FLOAT 4 Byte | A | 1 | |
| 7 | `current_maximum` | Value / Current | 3080 | 2 | Maximalwert Strom | R | FLOAT 4 Byte | A | 1 | Vom Gerät gespeicherter Extremwert |
| 8 | `voltage` | Value / Voltage | 3082 | 2 | Spannung | R | FLOAT 4 Byte | V | 1 | |
| 9 | `line_frequency` | Value / Frequency | 3084 | 2 | Netzfrequenz | R | FLOAT 4 Byte | Hz | 1 | |
| 10 | `active_power` | Value / Power | 3086 | 2 | Wirkleistung | R | FLOAT 4 Byte | W | 1 | |
| 11 | `power_factor` | Value / Power Factor | 3092 | 2 | Leistungsfaktor | R | FLOAT 4 Byte | | 1 | |
| 12 | `temperature` | Value / Temperature | 3072 | 2 | Temperatur | R | FLOAT 4 Byte | °C | 1 | |
| 13 | `residual_current_ac_lowpass` | Value / Others | 3330 | 2 | AC Differenzstrom Tiefpass (RCM) | R | FLOAT 4 Byte | A | 1 | |
| 14 | `operating_hours_total` | Value / Counter | 2578 | 4 | Betriebsstundenzähler gesamt | R | FLOAT 8 Byte | s | 1 | In Sekunden, Umrechnung in der Anzeige |
| 15 | `operating_hours_with_load_current` | Value / Counter | 2562 | 4 | Betriebsstundenzähler mit Belastungsstrom | R | FLOAT 8 Byte | s | 1 | wie Nr. 14 |
| 16 | `mechanical_switching_cycles` | Value / Counter | 2593 | 2 | Anzahl mechanischer Schaltspiele | R | FLOAT 4 Byte | | 1 | |
| 17 | `trip_counter` | Value / Counter | 2602 | 2 | Anzahl der Auslösungen | R | FLOAT 4 Byte | | 1 | |
| 18 | `short_circuit_trip_counter` | Value / Counter | 2624 | 2 | Anzahl der Kurzschlussauslösungen | R | FLOAT 4 Byte | | 1 | |
| 19 | `delayed_trip_counter` | Value / Counter | 2673 | 2 | Anzahl verzögerter Auslösungen | R | FLOAT 4 Byte | | 1 | |
| 20 | `protected_parameter_change_counter` | Value / Counter | 2726 | 1 | Zähler für Änderung geschützter Parameter | R | UINT 2 Byte | | 1 | |
| 21 | `device_test_status` | Parameter | 2679 | 1 | Status Gerätetest | R | UINT 2 Byte | | 1 | 0=unbekannt, 1=erfolgreich, 2=fehlgeschlagen, 3=nicht durchgeführt, 4=abgebrochen |
| 22 | `rcd_test_status` | Parameter | 2635 | 1 | Letzter Status RCD Test | R | UINT 2 Byte | | 1 | 0 bis 12, Fehlercode |
| 23 | `auto_reclosing_active` | Parameter | 2680 | 1 | Automatisches Wiedereinschalten (ARD aktiv) | R | UINT 2 Byte | | 1 | 0=unbekannt, 1=ARD aktiv |
| 24 | `command_electronic_switching` | Command | 3693 | 1 | Kommando elektronisches Schalten | W dynamisch | UINT 2 Byte | | 1 | 0=STANDBY, 1=ON. Freischaltung erforderlich, siehe 1.2 |
| 25 | `command_acknowledge_trip` | Command | 3692 | 1 | Auslösemeldung quittieren | W fest | UINT 2 Byte | | 1 | fester Wert 0x0815 |
| 26 | `command_reset_rcm_alarm` | Command | 5225 | 1 | RCM Alarm und Vor-Alarm zurücksetzen | W fest | UINT 2 Byte | | 1 | fester Wert 0x0815 |
| 27 | `command_device_test` | Command | 2678 | 1 | Gerätetest ausführen | W fest | UINT 2 Byte | | 1 | fester Wert 0x0815 |
| 28 | `command_blink_mode` | Command | 97 | 1 | Blinkmodus zur Gerätelokalisierung | W dynamisch | UINT 2 Byte | | 1 | 0=stopp, 1=10 s blinken |
| 29 | `command_mechanical_disconnect` | Command | 3694 | 1 | Kommando mechanisches Trennen | W fest | UINT 2 Byte | | 1 | fester Wert 0x0815. Nicht rückstellbar, erzwingt einen Einsatz vor Ort |
| 30 | `asset_identifier` | Parameter | 29 | 16 | Anlagenkennzeichen (Name) | R | STRING | | 1 | In Powerconfig setzen |
| 31 | `installation_location` | Parameter | 45 | 11 | Einbauort | R | STRING | | 1 | In Powerconfig setzen |
| 32 | `device_serial_number` | Parameter | 13 | 8 | Seriennummer | R | STRING | | 1 | |
| 33 | `device_name` | Parameter | 3 | 10 | Artikelnummer | R | STRING | | 1 | |
| 34 | `phase_information` | Parameter | 145 | 1 | Phasen Information | R | UINT 2 Byte | | 1 | 0=nicht vergeben, 1=L1, 2=L2, 3=L3 |
| 35 | `rated_current_setting` | Parameter | 5376 | 1 | Eingestellter Nennstrom des Gerätes | R | UINT 2 Byte | A | 0,001 | 16000 entspricht 16 A |
| 36 | `remote_control_electronic_switching_enabled` | Parameter | 5425 | 1 | Fernsteuerung elektronisches Schalten (Status) | R | UINT 2 Byte | | 1 | 0=inaktiv, 1=aktiv |
| 37 | `last_trip_log_oid` | State | 3671 | 1 | Letzte Trip Log OID | R | UINT 2 Byte | | 1 | Ändert sich bei jeder neuen Auslösung |

Der Funktionscode ist nicht Teil der Registerkarte. Gelesen wird mit FC3, geschrieben mit FC6.

### 5.2 Bitbelegung des Alarmregisters 2560

Die Spalte Wertigkeit gibt den Zahlenwert an, den das Bit im Register beiträgt. Die Spalte Werkszustand gibt an, ob der Alarm ab Werk wirksam ist. Ereignisbasierte Alarme besitzen keinen Schalter und sind stets wirksam. Die Bits 14, 17 und 21 bis 23 sind für dieses Gerät nicht belegt.

| Bit | Wertigkeit | Meldung | Werkszustand |
|---:|---:|---|---|
| 0 | 1 | Alarm Betriebsstunden mit Belastungsstrom | aus |
| 1 | 2 | Alarm Betriebsstunden | aus |
| 2 | 4 | Alarm Schaltspiele | aus |
| 3 | 8 | Alarm Auslösezähler | aus |
| 4 | 16 | Alarm Temperaturüberschreitung | ein |
| 5 | 32 | Alarm 1 Überstrom | ein |
| 6 | 64 | Alarm 2 Überstrom | aus |
| 7 | 128 | Alarm 1 Unterstrom | aus |
| 8 | 256 | Alarm 2 Unterstrom | aus |
| 9 | 512 | Alarm 1 Überspannung | aus |
| 10 | 1024 | Alarm 2 Überspannung | aus |
| 11 | 2048 | Alarm 1 Unterspannung | aus |
| 12 | 4096 | Alarm 2 Unterspannung | aus |
| 13 | 8192 | Schalter ausgelöst | ereignisbasiert |
| 15 | 32768 | Auslösung Überspannung | ereignisbasiert |
| 16 | 65536 | Alarm Kurzschlussauslösezähler | ein |
| 18 | 262144 | Selbsttest fehlgeschlagen | ereignisbasiert |
| 19 | 524288 | Auslösung Unterspannung | ereignisbasiert |
| 20 | 1048576 | Auslösung Fehlerstrom | ereignisbasiert |
| 24 | 16777216 | RCM Vor-Alarm | aus |
| 25 | 33554432 | RCM Alarm | aus |
| 26 | 67108864 | Verzögerte Auslösung | ereignisbasiert |
| 27 | 134217728 | Unverzögerte Auslösung | ereignisbasiert |
| 28 | 268435456 | ARD fehlgeschlagen | ereignisbasiert |
| 29 | 536870912 | Übertemperaturabschaltung | ereignisbasiert |
| 30 | 1073741824 | Alarm für verzögerte Auslösungen | ein |
| 31 | 2147483648 | Alarm EIN blockiert | ereignisbasiert |

13 der 27 Alarme sind ab Werk abgeschaltet. Sie liefern ohne die Einstellung in Powerconfig dauerhaft null, ohne dass dies in der Leitwarte erkennbar wäre.

---

<!--
Offene Punkte für die Durchsicht, vor der Umwandlung nach Word zu klären:

1. Kapitel 1.3 und 3.4 setzen voraus, dass die Alarme als eine Zahl übertragen
   werden. Falls doch eine Zerlegung gelungen ist, sind beide Stellen und die
   Tabelle in 5.1 anzupassen.
2. Kapitel 3.1, Abfrageintervall: Der am Testaufbau eingestellte Wert fehlt.
   Sinnvoll wäre eine konkrete Empfehlung statt nur der Obergrenze aus dem
   Systemhandbuch.
3. Kapitel 5.1, Gruppe von residual_current_ac_lowpass: derzeit "Value / Others".
   Sobald die tatsächliche Ablage feststeht, hier und in der Arbeitsmappe
   nachziehen.
4. Kapitel 5.1: Die Zuordnung FC3 lesend und FC6 schreibend ist die Konvention,
   nicht aus der Registerkarte belegt. Gegen das Modell prüfen.
5. Kapitel 3.4, Alarmklassen: Die Staffelung ist ein Vorschlag aus der
   Arbeitsmappe und im Projekt zu prüfen.
6. Kapitel 4: Der Verweis auf die internen Unterlagen zum Werkzeug ist bewusst
   allgemein gehalten. Falls ein konkreter Ablageort genannt werden soll,
   gehört er hierher.
7. Ein Deckblatt mit Dokumentnummer, Freigabe und Revisionsstand fehlt und
   wäre bei der Umwandlung nach Word zu ergänzen.
-->
