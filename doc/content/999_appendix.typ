// Anhang
// Die Tabellen dieses Anhangs geben die Auswahl aus Abschnitt "Ausgewaehlte
// Datenpunkte" vollstaendig wieder. Sie sind aus den Blaettern "Datenpunkte
// ECPD" und "Datenpunkte Powercenter" der Arbeitsmappe Requirements.xlsx
// erzeugt und dort auch mit der Begruendung je Zeile hinterlegt.
//
// functions.typ darf hier nicht importiert werden, da insertAppendix diese
// Datei seinerseits inkludiert und daraus ein zyklischer Import entstuende.
// Sichtbare Arbeitskommentare sind in dieser Datei deshalb nicht moeglich.

#import "../config/acronyms.typ": *

// Ohne diese Zeile numeriert Typst die Unterkapitel des Anhangs als 1.1, da die
// Ueberschrift "Anhang" in functions.typ mit einer eigenen Numerierung gesetzt
// und der Zaehler zuvor zurueckgesetzt wird.
#set heading(numbering: "A.1")

// Die Regeln aus main.typ greifen hier nicht, weil insertAppendix ausserhalb des
// Dokumentkoerpers ausgefuehrt wird. Ohne sie heissen die Tabellen "Table" statt
// "Tabelle" und die langen Tabellen brechen nicht ueber Seiten um.
#set figure.caption(separator: [: ])
#show figure.where(kind: table): set figure(supplement: [Tabelle])
#show figure: set block(breakable: true)

== Aufgenommene Datenpunkte des ECPD<apx:datenpunkte_ecpd>

Die Aufstellung gibt die 38 Register wieder, die nach den Kriterien aus @sec:auswahlkriterien in das Objektmodell des #acro("ECPD") übernommen sind, sowie die 27 Alarmdatenpunkte, die aus dem Sammelregister 2560 gebildet werden. Die Variablennamen sind Vorschläge und werden in @sec:umsetzung auf die Eigenschaften der Typbeschreibung abgebildet. Der Index $n$ bezeichnet die Stelle des Endgeräts am Powercenter und läuft von 1 bis 24.

#figure(
  text(size: 8pt)[#table(
    columns: (4.5em, 1fr, 1fr, 4em, 1fr),
    inset: 4pt,
    align: (left + horizon, left, left, center + horizon, left),
    table.header(
      [*Register*], [*Bezeichnung*], [*Variablenname*], [*Zugriff*], [*Format und Einheit*],
    ),
    [2560], [Alarm Zustand (Sammel-Bitfeld)], [`alarm_state`], [RO], [U32 Bitfeld],
    [3110], [Schalter Status], [`switch_status`], [RO], [U16: 0=unbek., 1=AUS, 2=EIN, 3=Ausgelöst, 4=Ausgelöst/Hebel blockiert, 5=Standby, 6=Standby tripped],
    [3113], [Schaltzustand ändern (Rückmeldung)], [`switching_state_feedback`], [RO], [U16: 0=ON, 1=ON Fehler, 2=STBY, 3=STBY Fehler, 4=OFF, 5=OFF Fehler],
    [16484+n], [Device Status (Funkverbindung)], [`device_status`], [RO], [U16: 0=IDLE, 1=Offline, 2=Verbinden, 3=Verbunden],
    [2622], [Funk Empfangssignalstärke RSSI], [`radio_rssi`], [RO], [S16 / dBm],
    [3076], [Strom], [`current`], [RO], [FP32 / A],
    [3080], [Maximalwert Strom], [`current_maximum`], [RO], [FP32 / A],
    [3082], [Spannung], [`voltage`], [RO], [FP32 / V],
    [3084], [Netzfrequenz], [`line_frequency`], [RO], [FP32 / Hz],
    [3086], [Wirkleistung], [`active_power`], [RO], [FP32 / W],
    [3092], [Leistungsfaktor], [`power_factor`], [RO], [FP32],
    [3072], [Temperatur], [`temperature`], [RO], [FP32 / °C],
    [3330], [AC Differenzstrom Tiefpass (RCM)], [`residual_current_ac_lowpass`], [RO], [FP32 / A],
    [2578], [Betriebsstundenzähler gesamt], [`operating_hours_total`], [RO], [FP64 / s],
    [2562], [Betriebsstundenzähler mit Belastungsstrom], [`operating_hours_with_load_current`], [RO], [FP64 / s],
    [2593], [Anzahl mechanischer Schaltspiele], [`mechanical_switching_cycles`], [RO], [FP32],
    [2602], [Anzahl der Auslösungen], [`trip_counter`], [RO], [FP32],
    [2624], [Anzahl der Kurzschlussauslösungen], [`short_circuit_trip_counter`], [RO], [FP32],
    [2673], [Anzahl verzögerter Auslösungen], [`delayed_trip_counter`], [RO], [FP32],
    [2726], [Zähler für Änderung geschützter Parameter], [`protected_parameter_change_counter`], [RO], [U16],
    [2679], [Status Gerätetest], [`device_test_status`], [RO], [U16: 0=unbek., 1=erfolgreich, 2=fehlgeschlagen, 3=nicht durchgeführt, 4=abgebrochen],
    [2635], [Letzter Status RCD Test], [`rcd_test_status`], [RO], [U16: 0–12, Fehlercode],
    [2680], [Automatisches Wiedereinschalten (ARD aktiv)], [`auto_reclosing_active`], [RO], [U16: 0=unbek., 1=ARD aktiv],
    [3693], [Kommando elektronisches Schalten], [`command_electronic_switching`], [CMD], [U16: 0=STANDBY, 1=ON],
    [3692], [Auslösemeldung quittieren], [`command_acknowledge_trip`], [CMD], [U16 = 0x0815],
    [5225], [RCM Alarm und Vor-Alarm zurücksetzen], [`command_reset_rcm_alarm`], [CMD], [U16 = 0x0815],
    [2678], [Gerätetest ausführen], [`command_device_test`], [CMD], [U16 = 0x0815],
    [97], [Blinkmodus zur Gerätelokalisierung], [`command_blink_mode`], [CMD], [U16: 0=stopp, 1=10 s blinken],
    [3694], [Kommando mechanisches Trennen (optional)], [`command_mechanical_disconnect`], [CMD], [U16 = 0x0815],
    [29], [Anlagenkennzeichen (Name)], [`asset_identifier`], [RW], [UCHAR\[32\]],
    [45], [Einbauort], [`installation_location`], [RW], [UCHAR\[22\]],
    [13], [Seriennummer], [`device_serial_number`], [RO], [UCHAR\[16\]],
    [3], [Artikelnummer], [`device_name`], [RO], [UCHAR\[20\]],
    [22], [Software Version], [`software_version`], [RO], [UCHAR\[4\]],
    [145], [Phasen Information], [`phase_information`], [RW], [U16: 0=n. v., 1=L1, 2=L2, 3=L3],
    [5376], [Eingestellter Nennstrom des Gerätes], [`rated_current_setting`], [RW], [U16 (16000 = 16 A)],
    [5425], [Fernsteuerung elektronisches Schalten (Status)], [`remote_control_electronic
    _switching_enabled`], [RW (lesend nutzen)], [U16: 0=inaktiv, 1=aktiv],
    [3671], [Letzte Trip Log OID], [`last_trip_log_oid`], [RO], [U16],
  )],
  caption: [Aufgenommene Register des #acro("ECPD") mit Bezeichnung, vorgeschlagenem Variablennamen, Zugriffsart und Datenformat]
)<tab:apx_ecpd_register>

Die folgenden Alarmdatenpunkte entstehen sämtlich aus dem Bitfeld des Registers 2560 und belegen kein weiteres Register. Die Spalte zum Werkszustand gibt an, ob ein Alarm ab Werk eingeschaltet ist. Die mit _aus_ gekennzeichneten Alarme liefern ohne vorherige Einstellung in SENTRON Powerconfig dauerhaft den Wert null, worauf NFA-06 zielt. Ereignisbasierte Alarme besitzen keinen Schalter und sind stets wirksam.

#figure(
  text(size: 8pt)[#table(
    columns: (3em, 1fr, 1fr, 7em),
    inset: 4pt,
    align: (center + horizon, left, left, center + horizon),
    table.header(
      [*Bit*], [*Bezeichnung*], [*Variablenname*], [*Werkszustand*],
    ),
    [0], [Alarm Betriebsstunden mit Belastungsstrom], [`alarm_operating_hours_with_load_current`], [aus],
    [1], [Alarm Betriebsstunden], [`alarm_operating_hours`], [aus],
    [2], [Alarm Schaltspiele], [`alarm_switching_cycles`], [aus],
    [3], [Alarm Auslösezähler], [`alarm_trip_counter`], [aus],
    [4], [Alarm Temperaturüberschreitung], [`alarm_temperature_exceeded`], [ein],
    [5], [Alarm 1 Überstrom], [`alarm_overcurrent_1`], [ein],
    [6], [Alarm 2 Überstrom], [`alarm_overcurrent_2`], [aus],
    [7], [Alarm 1 Unterstrom], [`alarm_undercurrent_1`], [aus],
    [8], [Alarm 2 Unterstrom], [`alarm_undercurrent_2`], [aus],
    [9], [Alarm 1 Überspannung], [`alarm_overvoltage_1`], [aus],
    [10], [Alarm 2 Überspannung], [`alarm_overvoltage_2`], [aus],
    [11], [Alarm 1 Unterspannung], [`alarm_undervoltage_1`], [aus],
    [12], [Alarm 2 Unterspannung], [`alarm_undervoltage_2`], [aus],
    [13], [Schalter ausgelöst], [`alarm_switch_tripped`], [ereignisbasiert],
    [15], [Auslösung Überspannung], [`alarm_overvoltage_trip`], [ereignisbasiert],
    [16], [Alarm Kurzschlussauslösezähler], [`alarm_short_circuit_trip_counter`], [ein],
    [18], [Selbsttest fehlgeschlagen], [`alarm_self_test_failed`], [ereignisbasiert],
    [19], [Auslösung Unterspannung], [`alarm_undervoltage_trip`], [ereignisbasiert],
    [20], [Auslösung Fehlerstrom], [`alarm_residual_current_trip`], [ereignisbasiert],
    [24], [RCM Vor-Alarm], [`alarm_rcm_pre_alarm`], [aus],
    [25], [RCM Alarm], [`alarm_rcm`], [aus],
    [26], [Verzögerte Auslösung], [`alarm_delayed_trip`], [ereignisbasiert],
    [27], [Unverzögerte Auslösung], [`alarm_instantaneous_trip`], [ereignisbasiert],
    [28], [ARD fehlgeschlagen], [`alarm_ard_failed`], [ereignisbasiert],
    [29], [Übertemperaturabschaltung], [`alarm_overtemperature_shutdown`], [ereignisbasiert],
    [30], [Alarm für verzögerte Auslösungen], [`alarm_delayed_trip_counter`], [ein],
    [31], [Alarm EIN blockiert], [`alarm_switch_on_blocked`], [ereignisbasiert],
  )],
  caption: [Aus dem Sammelregister 2560 gebildete Alarmdatenpunkte des #acro("ECPD") und ihr Zustand im Auslieferungszustand]
)<tab:apx_ecpd_alarme>

== Aufgenommene Datenpunkte des Powercenters<apx:datenpunkte_powercenter>

Die Aufstellung gibt die 17 Register wieder, die ausschließlich das Powercenter selbst betreffen. Die Felder über alle 24 Endgeräte sind nach dem Kriterium K-04 nicht enthalten und stehen im Objektmodell des jeweiligen Endgeräts.

#figure(
  text(size: 8pt)[#table(
    columns: (4.5em, 1fr, 1fr, 4em, 1fr),
    inset: 4pt,
    align: (left + horizon, left, left, center + horizon, left),
    table.header(
      [*Register*], [*Bezeichnung*], [*Variablenname*], [*Zugriff*], [*Format und Einheit*],
    ),
    [2560], [Alarm Zustand (Sammel-Bitfeld)], [`alarm_state`], [RO], [U32 Bitfeld],
    [3072], [Temperatur], [`temperature`], [RO], [FP32 / °C],
    [2629], [Zeit- und Synchronisationsstatus], [`time_sync_status`], [RO], [U8\[8\]: PARAM_DATE_TIME + SYNC_STATUS],
    [2633], [Aktiver Funkkanal], [`active_radio_channel`], [RO], [U16: 0–26],
    [2578], [Betriebsstundenzähler gesamt], [`operating_hours_total`], [RO], [FP64 / s],
    [1123], [Zähler Parameteränderung Powercenter], [`parameter_change_counter
    _powercenter`], [RO], [U16],
    [528], [Aktuelle IP-Adresse], [`current_ip_address`], [RO], [U32],
    [529], [Aktuelle Subnetzmaske], [`current_subnet_mask`], [RO], [U32],
    [530], [Aktuelle Gateway Adresse], [`current_gateway_address`], [RO], [U32],
    [512], [Ethernet MAC Adresse], [`ethernet_mac_address`], [RO], [UCHAR\[6\]],
    [769], [Bluetooth Status], [`bluetooth_status`], [RO], [U16],
    [1024], [Datum/Zeit (UTC)], [`date_time_utc`], [RW], [U32, UNIX_TS seit 01.01.1970],
    [29], [Anlagenkennzeichen (Name)], [`asset_identifier`], [RW], [UCHAR\[32\]],
    [45], [Einbauort], [`installation_location`], [RW], [UCHAR\[22\]],
    [13], [Seriennummer], [`device_serial_number`], [RO], [UCHAR\[16\]],
    [3], [Artikelnummer], [`device_name`], [RO], [UCHAR\[20\]],
    [22], [Software Version], [`software_version`], [RO], [UCHAR\[4\]],
  )],
  caption: [Aufgenommene Register des Powercenters mit Bezeichnung, vorgeschlagenem Variablennamen, Zugriffsart und Datenformat]
)<tab:apx_pc_register>

Am Powercenter sind im Sammelregister 2560 nur zwei Bits belegt, da das Gerät weder misst noch schaltet.

#figure(
  text(size: 8pt)[#table(
    columns: (3em, 1fr, 1fr, 7em),
    inset: 4pt,
    align: (center + horizon, left, left, center + horizon),
    table.header(
      [*Bit*], [*Bezeichnung*], [*Variablenname*], [*Werkszustand*],
    ),
    [4], [Alarm Temperaturüberschreitung], [`alarm_temperature_exceeded`], [ein],
    [1], [Alarm Betriebsstunden], [`alarm_operating_hours`], [aus],
  )],
  caption: [Aus dem Sammelregister 2560 gebildete Alarmdatenpunkte des Powercenters]
)<tab:apx_pc_alarme>
