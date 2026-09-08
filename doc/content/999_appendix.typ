// Anhang
// Die Tabellen dieses Anhangs geben die Auswahl aus Abschnitt "Ausgewaehlte
// Datenpunkte" vollstaendig wieder. Sie sind aus den Blaettern "Datenpunkte
// ECPD" und "Datenpunkte Powercenter" der Arbeitsmappe Requirements.xlsx
// erzeugt, aus der auch die Spalte "Begruendung der Aufnahme" stammt.
//
// functions.typ darf hier nicht importiert werden, da insertAppendix diese
// Datei seinerseits inkludiert und daraus ein zyklischer Import entstuende.
// Sichtbare Arbeitskommentare sind in dieser Datei deshalb nicht moeglich.

#import "../config/acronyms.typ": *

// Ohne diese Zeile numeriert Typst die Unterkapitel des Anhangs als 1.1, da die
// Ueberschrift "Anhang" in functions.typ mit einer eigenen Numerierung gesetzt
// und der Zaehler zuvor zurueckgesetzt wird.
#set text(lang: "de")
#set heading(numbering: "A.1", supplement: [Abschnitt])

// Die Regeln aus main.typ greifen hier nicht, weil insertAppendix ausserhalb des
// Dokumentkoerpers ausgefuehrt wird. Ohne sie heissen die Tabellen "Table" statt
// "Tabelle" und die langen Tabellen brechen nicht ueber Seiten um.
#set figure.caption(separator: [: ])
#show figure.where(kind: table): set figure(supplement: [Tabelle])
#show figure: set block(breakable: true)

// Die beiden Registeraufstellungen tragen sieben bzw. acht Spalten und passen im
// Hochformat nicht mehr lesbar auf die Seite. Sie stehen deshalb quer.
#let breitseite(inhalt) = page(
  flipped: true,
  margin: (top: 3.5cm, bottom: 3cm, left: 2.5cm, right: 2.5cm),
  inhalt,
)

== Aufgenommene Datenpunkte des ECPD<apx:datenpunkte_ecpd>

@tab:apx_ecpd_register führt die nach @sec:datenpunkte aufgenommenen Register, @tab:apx_ecpd_alarme die Alarmdatenpunkte. Der Index $n$ bezeichnet die Stelle des Endgeräts am Powercenter und läuft von 1 bis 24. Die Zeile des nach @sec:umsetzung gestrichenen Registers 22 ist nachrichtlich geführt und zählt beim Nachweis nicht mit. Eine Spalte für die Skalierung entfällt, da der Faktor nach @sec:umsetzung durchgehend eins beträgt; die beiden Ausnahmen sind in der Spalte des Formats vermerkt. Fehlt neben dem Anwendungsfall die Anforderung, folgt die Aufnahme unmittelbar dem Anwendungsfall, was @sec:wuerdigung ausführt.

#breitseite[
#figure(
  text(size: 8pt, lang: "de", hyphenate: true)[#table(
    columns: (4.5em, 1fr, 1fr, 3.4em, 1fr, 5.6em, 4.4em, 1.65fr),
    // Siehe die Aufstellung des Powercenters: beide Registertabellen tragen
    // denselben verringerten senkrechten Innenabstand.
    inset: (x: 4pt, y: 3pt),
    align: (left + horizon, left, left, center + horizon, left, left + horizon, left + horizon, left),
    table.header(
      [*Register*], [*Bezeichnung*], [*Variablenname*], [*Zugriff*], [*Format und Einheit*], [*Anwendungsfall und Anforderung*], [*Nachweis*], [*Begründung der Aufnahme*],
    ),
    [2560], [Alarm Zustand (Sammel-Bitfeld)], [`alarm_state`], [RO], [U32 Bitfeld], [UC-03, FA-04, FA-05], [T-05, T-06], [Liefert sämtliche Geräte- und Auslösealarme aus einem einzigen Register.],

    [3110], [Schalter Status], [`switch_status`], [RO], [U16: 0=unbek., 1=AUS, 2=EIN, 3=Ausgelöst, 4=Ausgelöst/Hebel blockiert, 5=Standby, 6=Standby tripped], [UC-02, UC-05], [T-05, T-08], [Unterscheidet planmäßiges Ausschalten von störungsbedingtem Auslösen und bildet die Standby-Zustände ab.],

    [3113], [Schaltzustand ändern (Rückmeldung)], [`switching_state_feedback`], [RO], [U16: 0=ON, 1=ON Fehler, 2=STBY, 3=STBY Fehler, 4=OFF, 5=OFF Fehler], [UC-05, FA-06], [T-05, T-08], [Ohne diesen Wert bleibt offen, ob ein Fernschaltbefehl gewirkt hat.],

    [16483+n], [Device Status (Funkverbindung)], [`device_status`], [RO], [U16: 0=IDLE, 1=Offline, 2=Verbinden, 3=Verbunden], [UC-04, FA-10], [T-05, T-11], [Überwachung der Funkstrecke auf der Ebene des einzelnen Endgeräts.],

    [2622], [Funk Empfangssignalstärke RSSI], [`radio_rssi`], [RO], [S16 / dBm], [UC-04, FA-10], [T-05, T-11], [Eine über Wochen sinkende Feldstärke kündigt den Verbindungsabbruch an, bevor er eintritt.],

    [3076], [Strom], [`current`], [RO], [FP32 / A], [UC-02, UC-07, FA-03], [T-04, T-05], [Auslastung des Abgangs und Grundlage für Überlasterkennung und Lastverschiebung.],

    [3080], [Maximalwert Strom], [`current_maximum`], [RO], [FP32 / A], [UC-07, FA-03], [T-04, T-05], [Eine Stromspitze zwischen zwei Abfragen ist im Archiv nicht mehr herstellbar.],

    [3082], [Spannung], [`voltage`], [RO], [FP32 / V], [UC-02, UC-07, FA-03], [T-04, T-05], [Macht Über- und Unterspannungsereignisse im Verlauf nachvollziehbar.],

    [3084], [Netzfrequenz], [`line_frequency`], [RO], [FP32 / Hz], [UC-02, FA-03], [T-04, T-05], [Zweite Kenngröße der Netzqualität, vom Powercenter nicht gemessen und nicht ableitbar.],

    [3086], [Wirkleistung], [`active_power`], [RO], [FP32 / W], [UC-02, UC-07, FA-03], [T-04, T-05], [Lastgang je Abgang und mangels Arbeitszähler die einzige Leistungsgröße des Geräts.],

    [3092], [Leistungsfaktor], [`power_factor`], [RO], [FP32], [UC-07, FA-03], [T-04, T-05], [Erkennt nichtlineare oder fehlerhafte Verbraucher und schlecht ausgelastete Netzteile.],

    [3072], [Temperatur], [`temperature`], [RO], [FP32 / °C], [UC-02, UC-07, FA-03], [T-04, T-05], [Erwärmung durch Überlast oder lose Klemmstelle und damit unmittelbarer Brandschutzindikator.],

    [3330], [AC Differenzstrom Tiefpass (RCM)], [`residual_current_ac_lowpass`], [RO], [FP32 / A], [UC-07, FA-03], [T-04, T-05], [Zeigt den Isolationszustand als Verlauf und damit eine Verschlechterung vor der Abschaltung.],

    [2578], [Betriebsstundenzähler gesamt], [`operating_hours_total`], [RO], [FP64 / s], [UC-07], [T-05], [Nutzungsdauer des Geräts als Grundlage der Austauschplanung.],

    [2562], [Betriebsstundenzähler mit Belastungsstrom], [`operating_hours_with
    _load_current`], [RO], [FP64 / s], [UC-07], [T-05], [Thermische Vorbelastung, da nur Zeiten oberhalb des Schwellstroms zählen.],

    [2593], [Anzahl mechanischer Schaltspiele], [`mechanical_switching_cycles`], [RO], [FP32], [UC-07], [T-05], [Verschleiß der Schaltkontakte und damit Restlebensdauer.],

    [2602], [Anzahl der Auslösungen], [`trip_counter`], [RO], [FP32], [UC-07], [T-05], [Eine Häufung von Auslösungen weist auf ein Problem der Anlage hin, nicht auf einen Gerätefehler.],

    [2624], [Anzahl der Kurzschlussauslösungen], [`short_circuit_trip_counter`], [RO], [FP32], [UC-07], [T-05], [Kurzschlussauslösungen belasten das Schaltvermögen erheblich.],

    [2673], [Anzahl verzögerter Auslösungen], [`delayed_trip_counter`], [RO], [FP32], [UC-07], [T-05], [Überlastauslösungen als Hinweis auf dauerhaft zu hohe Last am Abgang.],

    [2726], [Zähler für Änderung geschützter Parameter], [`protected_parameter
    _change_counter`], [RO], [U16], [UC-07], [T-05], [Macht die Änderung geschützter Parameter sichtbar, ohne sie abzubilden; Ergänzung zu K-03.],

    [2679], [Status Gerätetest], [`device_test_status`], [RO], [U16: 0=unbek., 1=erfolgreich, 2=fehlgeschlagen, 3=nicht durchgeführt, 4=abgebrochen], [UC-06, FA-08], [T-05, T-09], [Ergebnis der über Register 2678 angestoßenen Prüfung.],

    [2635], [Letzter Status RCD Test], [`rcd_test_status`], [RO], [U16: 0--12, Fehlercode], [UC-06, FA-08], [T-05, T-09], [Macht ein fehlgeschlagenes Prüfergebnis ohne Einsatz vor Ort auswertbar.],

    [2680], [Automatisches Wiedereinschalten (ARD aktiv)], [`auto_reclosing_active`], [RO], [U16: 0=unbek., 1=ARD aktiv], [UC-02], [T-05], [Erklärt dem Betreiber, weshalb ein Abgang selbsttätig zurückgekehrt ist.],

    [3693], [Kommando elektronisches Schalten], [`command_electronic_switching`], [CMD], [U16: 0=STANDBY, 1=ON], [UC-05, FA-06], [T-08], [Fernwiedereinschaltung nach einer Auslösung ohne Einsatz vor Ort.],

    [3692], [Auslösemeldung quittieren], [`command_acknowledge_trip`], [CMD], [U16 = 0x0815], [UC-03, FA-04], [T-01], [Quittierung der Auslösemeldung wie bei jeder anderen Meldung der Plattform.],

    [5225], [RCM Alarm und Vor-Alarm zurücksetzen], [`command_reset_rcm_alarm`], [CMD], [U16 = 0x0815], [UC-03, FA-04], [T-01], [Rücksetzen der beiden #acro("RCM")-Alarme nach behobenem Isolationsfehler.],

    [2678], [Gerätetest ausführen], [`command_device_test`], [CMD], [U16 = 0x0815], [UC-06, FA-08], [T-09], [Anstoß der wiederkehrenden Prüfung aus der Leitwarte.],

    [97], [Blinkmodus zur Gerätelokalisierung], [`command_blink_mode`], [CMD], [U16: 0=stopp, 1=10 s blinken], [UC-08, FA-06], [T-01], [Findet das richtige Gerät unter bis zu 24 baugleichen im Verteiler.],

    [3694], [Kommando mechanisches Trennen (optional)], [`command_mechanical_disconnect`], [CMD], [U16 = 0x0815], [UC-05, FA-06], [T-01], [Galvanische Ferntrennung, nicht fernrückstellbar und nur unter der Freigabe am Gerät aufgenommen.],

    [29], [Anlagenkennzeichen (Name)], [`asset_identifier`], [RW], [UCHAR\[32\]], [UC-09, FA-03], [T-05], [Ohne Kennzeichen bleibt eine Störungsmeldung für den Betreiber unbrauchbar.],

    [45], [Einbauort], [`installation_location`], [RW], [UCHAR\[22\]], [UC-09, FA-03], [T-05], [Verortung des Abgangs in Gebäude und Verteiler.],

    [13], [Seriennummer], [`device_serial_number`], [RO], [UCHAR\[16\]], [UC-09], [T-05], [Eindeutige Gerätezuordnung für Anlagendokumentation und Gewährleistung.],

    [3], [Artikelnummer], [`device_name`], [RO], [UCHAR\[20\]], [UC-09], [T-05], [Typidentifikation und Ersatzteilbeschaffung im Servicefall.],

    [22], [Software Version], [`software_version`], [RO], [UCHAR\[4\]], [UC-09], [--], [Firmwarestand für den Sicherheitsabgleich; wegen gemischter Kodierung nicht dekodierbar und nach @sec:umsetzung aus der Auswahl gestrichen.],

    [145], [Phasen Information], [`phase_information`], [RW], [U16: 0=n. v., 1=L1, 2=L2, 3=L3], [UC-09, FA-03], [T-05], [Erst mit der Phasenzuordnung ist eine Schieflastbetrachtung über alle Abgänge möglich.],

    [5376], [Eingestellter Nennstrom des Gerätes], [`rated_current_setting`], [RW], [U16 in mA (16000 = 16 A), Faktor 0,001], [UC-02, UC-09], [T-05], [Bezugsgröße der in Prozent angegebenen Stromgrenzwerte; ohne sie ist der Messwert nicht einzuordnen.],

    [5425], [Fernsteuerung elektronisches Schalten (Status)], [`remote_control_electronic
    _switching_enabled`], [RW], [U16: 0=inaktiv, 1=aktiv], [UC-05], [T-05, T-08], [Nur lesend genutzt. Reines Diagnosemerkmal: steht der Wert auf null, bleibt jeder Schaltbefehl wirkungslos.],

    [3671], [Letzte Trip Log OID], [`last_trip_log_oid`], [RO], [U16], [UC-03, UC-07], [T-05], [Ändert sich nur bei einer Auslösung und dient damit als Auslöser für das Nachlesen des Auslöseprotokolls.],
  )],
  caption: [Aufgenommene Register des #acro("ECPD") mit Bezeichnung, vorgeschlagenem Variablennamen, Zugriffsart, Datenformat, tragendem Anwendungsfall, Nachweis und Begründung der Aufnahme]
)<tab:apx_ecpd_register>
]

Die Alarmdatenpunkte entstehen sämtlich aus dem Bitfeld des Registers 2560 und tragen durchgehend UC-03, FA-04 und FA-05 mit dem Nachweis T-05 und T-06, weshalb eigene Spalten dafür entfallen. Die mit _aus_ gekennzeichneten Alarme liefern bis zu ihrer Einstellung in SENTRON Powerconfig dauerhaft null, während ereignisbasierte Alarme keinen Schalter besitzen.

#figure(
  text(size: 8pt, lang: "de", hyphenate: true)[#table(
    columns: (2.6em, 1fr, 1fr, 5.5em, 1.5fr),
    inset: 4pt,
    align: (center + horizon, left, left, center + horizon, left),
    table.header(
      [*Bit*], [*Bezeichnung*], [*Variablenname*], [*Werkszustand*], [*Bedeutung der Meldung*],
    ),
    [0], [Alarm Betriebsstunden mit Belastungsstrom], [`alarm_operating_hours
    _with_load_current`], [aus], [Wartungsintervall auf Grundlage der tatsächlichen thermischen Belastung erreicht.],
    [1], [Alarm Betriebsstunden], [`alarm_operating_hours`], [aus], [Gesamtbetriebsstunden über dem Grenzwert, Austauschintervall erreicht.],
    [2], [Alarm Schaltspiele], [`alarm_switching_cycles`], [aus], [Kontaktverschleiß, Austausch einplanen.],
    [3], [Alarm Auslösezähler], [`alarm_trip_counter`], [aus], [Der Abgang fällt auffällig häufig aus; die Ursache liegt meist im Verbraucher.],
    [4], [Alarm Temperaturüberschreitung], [`alarm_temperature_exceeded`], [ein], [Überlast oder lose Klemmstelle, unmittelbares Brandrisiko.],
    [5], [Alarm 1 Überstrom], [`alarm_overcurrent_1`], [ein], [Vorwarnung vor Überlast, noch ohne Abschaltung.],
    [6], [Alarm 2 Überstrom], [`alarm_overcurrent_2`], [aus], [Der Abgang läuft dicht an der Auslösegrenze.],
    [7], [Alarm 1 Unterstrom], [`alarm_undercurrent_1`], [aus], [Erkennt ausgefallene Verbraucher, die sonst unbemerkt bleiben.],
    [8], [Alarm 2 Unterstrom], [`alarm_undercurrent_2`], [aus], [Deutlicher Lastausfall am Abgang.],
    [9], [Alarm 1 Überspannung], [`alarm_overvoltage_1`], [aus], [Netzqualitätsproblem, das angeschlossene Geräte schädigt.],
    [10], [Alarm 2 Überspannung], [`alarm_overvoltage_2`], [aus], [Akute Gefährdung der Verbraucher.],
    [11], [Alarm 1 Unterspannung], [`alarm_undervoltage_1`], [aus], [Hinweis auf Leitungsüberlastung oder Netzproblem.],
    [12], [Alarm 2 Unterspannung], [`alarm_undervoltage_2`], [aus], [Betriebssicherheit der Verbraucher nicht mehr gewährleistet.],
    [13], [Schalter ausgelöst], [`alarm_switch_tripped`], [ereignisbasiert], [Sammelmeldung der Auslösung; die Ursache liefern die Bits 15, 19, 20, 26 und 27.],
    [15], [Auslösung Überspannung], [`alarm_overvoltage_trip`], [ereignisbasiert], [Der Überspannungsschutz hat abgeschaltet, Hinweis auf ein Netzereignis.],
    [16], [Alarm Kurzschlussauslösezähler], [`alarm_short_circuit
    _trip_counter`], [ein], [Das Schaltvermögen ist erheblich vorbelastet, Gerät prüfen oder tauschen.],
    [18], [Selbsttest fehlgeschlagen], [`alarm_self_test_failed`], [ereignisbasiert], [Das Gerät ist nicht mehr verlässlich schutzwirksam, Austausch einplanen.],
    [19], [Auslösung Unterspannung], [`alarm_undervoltage_trip`], [ereignisbasiert], [Der Unterspannungsauslöser hat abgeschaltet.],
    [20], [Auslösung Fehlerstrom], [`alarm_residual_current_trip`], [ereignisbasiert], [Der Personenschutz hat angesprochen; Prüfung vor dem Wiedereinschalten erforderlich.],
    [24], [RCM Vor-Alarm], [`alarm_rcm_pre_alarm`], [aus], [Frühwarnung: der Isolationswiderstand verschlechtert sich, noch ohne Abschaltung.],
    [25], [RCM Alarm], [`alarm_rcm`], [aus], [Isolationsfehler oberhalb des Grenzwerts, Wartungseinsatz erforderlich.],
    [26], [Verzögerte Auslösung], [`alarm_delayed_trip`], [ereignisbasiert], [Thermisch verzögerte Auslösung und damit Überlast statt Kurzschluss.],
    [27], [Unverzögerte Auslösung], [`alarm_instantaneous_trip`], [ereignisbasiert], [Unverzögerte Auslösung und damit ein echter Fehler in der Installation.],
    [28], [ARD fehlgeschlagen], [`alarm_ard_failed`], [ereignisbasiert], [Die automatische Wiedereinschaltung ist erschöpft, ein Einsatz vor Ort ist nötig.],
    [29], [Übertemperaturabschaltung], [`alarm_overtemperature_shutdown`], [ereignisbasiert], [Das Gerät hat wegen Übertemperatur abgeschaltet, Eskalationsstufe nach Bit 4.],
    [30], [Alarm für verzögerte Auslösungen], [`alarm_delayed_trip_counter`], [ein], [Dauerhafte Überlast am Abgang, im Unterschied zu Bit 26 als Zählerstand.],
    [31], [Alarm EIN blockiert], [`alarm_switch_on_blocked`], [ereignisbasiert], [Das Gerät lässt sich nicht einschalten und erklärt fehlgeschlagene Schaltbefehle.],
  )],
  caption: [Aus dem Sammelregister 2560 gebildete Alarmdatenpunkte des #acro("ECPD"), ihr Zustand im Auslieferungszustand und die Bedeutung der Meldung]
)<tab:apx_ecpd_alarme>

== Aufgenommene Datenpunkte des Powercenters<apx:datenpunkte_powercenter>

@tab:apx_pc_register führt die Register, die ausschließlich das Powercenter selbst betreffen; die Felder über alle 24 Endgeräte stehen nach K-04 im Objektmodell des jeweiligen Endgeräts. Den Nachweis tragen für sämtliche Zeilen T-01 und T-02, weshalb eine eigene Spalte dafür entfällt.

#breitseite[
#figure(
  text(size: 8pt, lang: "de", hyphenate: true)[#table(
    columns: (4.5em, 1fr, 1fr, 3.4em, 1fr, 5.2em, 1.65fr),
    // Der senkrechte Innenabstand ist in den beiden Registeraufstellungen um
    // einen Punkt verringert. Ohne das rutscht die Unterschrift der
    // Powercenter-Aufstellung allein auf die Folgeseite, weil die letzte Zeile
    // den Satzspiegel bis auf wenige Millimeter ausfuellt.
    inset: (x: 4pt, y: 3pt),
    align: (left + horizon, left, left, center + horizon, left, left + horizon, left),
    table.header(
      [*Register*], [*Bezeichnung*], [*Variablenname*], [*Zugriff*], [*Format und Einheit*], [*Anwendungsfall*], [*Begründung der Aufnahme*],
    ),
    [2560], [Alarm Zustand (Sammel-Bitfeld)], [`alarm_state`], [RO], [U32 Bitfeld], [UC-03], [Alarme des Datentransceivers selbst; belegt sind nur Übertemperatur und Betriebsstunden.],

    [3072], [Temperatur], [`temperature`], [RO], [FP32 / °C], [UC-02, UC-07], [Bester verfügbarer Anhaltspunkt für das Klima im Verteiler, da das Gerät dort zentral sitzt.],

    [2629], [Zeit- und Synchronisationsstatus], [`time_sync_status`], [RO], [U8\[8\]: PARAM_DATE_TIME + SYNC_STATUS], [UC-07], [Entscheidet über die Güte sämtlicher Zeitstempel des Strangs.],

    [2633], [Aktiver Funkkanal], [`active_radio_channel`], [RO], [U16: 0--26], [UC-04], [Ein Kanal mit Überlappung erklärt gehäufte Verbindungsabbrüche eines ganzen Strangs.],

    [2578], [Betriebsstundenzähler gesamt], [`operating_hours_total`], [RO], [FP64 / s], [UC-07], [Nutzungsdauer des Datentransceivers als Grundlage der Austauschplanung.],

    [1123], [Zähler Parameteränderung Powercenter], [`parameter_change_counter
    _powercenter`], [RO], [U16], [UC-07], [Ein Register statt 24 Einzelzählern, die an den Endgeräten ohnehin geführt sind.],

    [528], [Aktuelle IP-Adresse], [`current_ip_address`], [RO], [U32], [UC-04], [Erreichbarkeit des Geräts und im Störungsfall die erste Information für IT und Service.],

    [529], [Aktuelle Subnetzmaske], [`current_subnet_mask`], [RO], [U32], [UC-04], [Zuordnung zum Netzsegment.],

    [530], [Aktuelle Gateway Adresse], [`current_gateway_address`], [RO], [U32], [UC-04], [Diagnose des Routings bei einem Kommunikationsausfall.],

    [512], [Ethernet MAC Adresse], [`ethernet_mac_address`], [RO], [UCHAR\[6\]], [UC-04], [Unveränderliche Kennung für die Netzdokumentation.],

    [769], [Bluetooth Status], [`bluetooth_status`], [RO], [U16], [UC-04], [Sicherheitsrelevant: zeigt, ob der lokale Zugang für die Inbetriebnahme im Regelbetrieb offen steht.],

    [1024], [Datum/Zeit (UTC)], [`date_time_utc`], [RW], [U32, UNIX_TS seit 01.01.1970], [UC-07], [Zeitsynchronisation aus Desigo CC, falls am Standort kein Zeitserver vorgesehen ist.],

    [29], [Anlagenkennzeichen (Name)], [`asset_identifier`], [RW], [UCHAR\[32\]], [UC-09], [Beschriftung des Objekts nach FA-03.],

    [45], [Einbauort], [`installation_location`], [RW], [UCHAR\[22\]], [UC-09], [Verortung des Verteilers im Gebäude.],

    [13], [Seriennummer], [`device_serial_number`], [RO], [UCHAR\[16\]], [UC-09], [Eindeutige Zuordnung für Anlagendokumentation und Gewährleistung.],

    [3], [Artikelnummer], [`device_name`], [RO], [UCHAR\[20\]], [UC-09], [Typidentifikation und Ersatzteilbeschaffung.],

    [22], [Software Version], [`software_version`], [RO], [UCHAR\[4\]], [UC-09], [Firmwarestand des Datentransceivers; die Kodierung entspricht der des #acro("ECPD") und ist nach @sec:umsetzung ebenfalls nicht dekodierbar.],
  )],
  caption: [Aufgenommene Register des Powercenters mit Bezeichnung, vorgeschlagenem Variablennamen, Zugriffsart, Datenformat, tragendem Anwendungsfall und Begründung der Aufnahme]
)<tab:apx_pc_register>
]

Am Powercenter sind im Sammelregister 2560 nur zwei Bits belegt, da das Gerät weder misst noch schaltet. @tab:apx_pc_alarme weist beide aus.

#figure(
  text(size: 8pt, lang: "de", hyphenate: true)[#table(
    columns: (2.6em, 1fr, 1fr, 5.5em, 1.5fr),
    inset: 4pt,
    align: (center + horizon, left, left, center + horizon, left),
    table.header(
      [*Bit*], [*Bezeichnung*], [*Variablenname*], [*Werkszustand*], [*Bedeutung der Meldung*],
    ),
    [1], [Alarm Betriebsstunden], [`alarm_operating_hours`], [aus], [Wartungsintervall des Datentransceivers erreicht.],
    [4], [Alarm Temperaturüberschreitung], [`alarm_temperature_exceeded`], [ein], [Übertemperatur im Verteiler; der Grenzwert liegt deutlich unter dem des #acro("ECPD").],
  )],
  caption: [Aus dem Sammelregister 2560 gebildete Alarmdatenpunkte des Powercenters]
)<tab:apx_pc_alarme>

Die nicht aufgenommenen Register sind nicht Zeile für Zeile geführt. @tab:ausschluss_ecpd weist die Ausschlussgruppen mit Umfang und tragendem Kriterium aus, die Begründung der einzelnen Zeile steht in der Arbeitsmappe des Anforderungskatalogs.

== Rückverfolgbarkeit von Anwendungsfall bis Ergebnis<apx:rueckverfolgung>

@tab:apx_rueckverfolgung führt die über @sec:usecases, @sec:fa, @sec:nfa, @sec:testfaelle und @sec:anforderungsabgleich verteilten Zuordnungen an einer Stelle zusammen. Sie enthält keine Aussage, die nicht bereits an einer dieser Stellen steht.

#figure(
  text(size: 8pt, lang: "de", hyphenate: true)[#table(
    columns: (6em, 5em, 1fr, 4.5em, 7em, 6.5em),
    // Verringerter senkrechter Innenabstand wie in den Registeraufstellungen,
    // damit die Unterschrift auf der Seite der letzten Zeilen bleibt.
    inset: (x: 4pt, y: 3pt),
    align: (left + horizon, left + horizon, left, left + horizon, left + horizon, left + horizon),
    table.header(
      [*Anwendungsfall*], [*Anforderung*], [*Umsetzung im Modell*], [*Testfall*], [*Nachweis*], [*Ergebnis*],
    ),
    [UC-01], [FA-01], [Typbeschreibungen für #acro("ECPD") und Powercenter, Instanz je Unit Identifier], [T-01, T-02], [@sec:uebernahme], [erfüllt],

    [UC-01], [FA-09], [Konfigurations- und Schutzregister nach K-02 und K-03 nicht im Modell], [T-10], [@sec:testdurchfuehrung], [erfüllt],

    [UC-01], [NFA-05], [Trennung von Gerätetyp und Geräteinstanz], [T-02], [@sec:konzept], [teilweise erfüllt],

    [UC-02], [FA-02], [zyklische Abfrage am Modbus-Treiber, Zyklusvorgabe je Datenpunkt in der Arbeitsmappe], [T-03], [@sec:kommunikationsstrecke], [erfüllt],

    [UC-02, UC-07, UC-09], [FA-03], [Gruppe der Messwerte, acht Register mit Bezeichnung, Einheit, Skalierung und Vorzeichen], [T-04, T-05], [#ref(<apx:datenpunkte_ecpd>, supplement: [Anhang])], [erfüllt],

    [UC-03], [FA-04], [`alarm_state` aus Register 2560, Bitzuordnung nach @tab:apx_ecpd_alarme], [T-06, T-07], [@sec:umsetzung], [nicht erfüllt],

    [UC-03], [FA-05], [ohne Entsprechung im Modell, Alarmkategorien sind Projektierung], [T-07], [@sec:umsetzung], [nicht erfüllt],

    [UC-04], [FA-10], [`device_status`, `radio_rssi` und Auswertung von _Not a Number_], [T-11], [@sec:testdurchfuehrung], [teilweise erfüllt],

    [UC-05, UC-08], [FA-06], [Kommandogruppe aus sechs schreibenden Registern mit festem und dynamischem Kommandowert], [T-08], [@sec:uebernahme], [erfüllt],

    [UC-06], [FA-08], [Kommandos für Geräte- und #acro("RCD")-Test, Statusregister 2679 und 2635], [T-09], [@sec:testdurchfuehrung], [erfüllt],

    [UC-10], [NFA-01], [Dokumentation des Integrationswegs in dieser Arbeit und in der Unterlage], [T-13], [@sec:modelldoku], [erfüllt],

    [UC-10], [NFA-02], [Unterlage für Errichter und Betreiber in einem Dokument], [T-13], [@sec:modelldoku], [teilweise erfüllt],

    [UC-10], [NFA-03], [Gruppenstruktur der Typbeschreibung, im #acro("PDE") erneut bearbeitbar], [T-12], [@sec:testdurchfuehrung], [erfüllt],

    [UC-10], [NFA-04], [Import auf dem Plattformstand nach @tab:werkzeuge], [T-01], [@sec:testdurchfuehrung], [erfüllt],

    [--], [NFA-06], [Angabe der vorausgesetzten Parametrierung, Werkszustand nach @tab:apx_ecpd_alarme], [T-14], [@sec:geraetekonfiguration], [erfüllt],
  )],
  caption: [Rückverfolgbarkeit vom Anwendungsfall über die Anforderung und das tragende Element des Datenmodells zum Testfall und zum Ergebnis]
)<tab:apx_rueckverfolgung>

Zwei Stellen bleiben offen. NFA-06 entspringt als einzige Anforderung keinem Anwendungsfall, sondern einer Eigenschaft der Geräte (@sec:nfa), und die Zähler-, Wartungs- und Stammdaten des #acro("ECPD") erscheinen nicht in der Matrix, da sie über UC-07 und UC-09 in der Auswahl stehen, ohne dass eine Anforderung sie verlangt. Beides ist in @sec:wuerdigung ausgeführt.

== Anwenderdokumentation zur Integrationsvorlage<apx:anwenderdoku>

Die folgende Unterlage ist das dritte Ergebnis dieser Arbeit und Gegenstand von NFA-01, NFA-02 und T-13, weshalb sie hier vollständig wiedergegeben ist. Wiedergegeben ist der Stand vom 26.08.2026, in Gliederung und Wortlaut unverändert und allein im Satz an diese Arbeit angepasst. Sie richtet sich an den Anwender der Vorlage, weshalb sie @sec:datenpunkte und @sec:umsetzung an mehreren Stellen wiederholt; ihre Referenz führt dieselben Datenpunkte wie #ref(<apx:datenpunkte_ecpd>, supplement: [Anhang]), dort jedoch aus der Sicht der Projektierung.

#include "../content/990_anwenderdokumentation.typ"
