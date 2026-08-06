#import "../../config/acronyms.typ": *
#include "../../config/config.typ"

== Schaltkreisschutzgeräte (ECPD)<sec:ecpd>

Den Ausgangspunkt der Datenerfassung bilden die kommunikations- und messfähigen SENTRON-Schutzschaltgeräte, deren Daten in dieser Arbeit in Desigo CC abgebildet werden sollen. Die folgenden Stichpunkte fassen die Eigenschaften des Systems und des in dieser Arbeit betrachteten #acro("ECPD") 5TY1 COM zusammen; sie sind dem Systemhandbuch der Gerätefamilie entnommen @src:sentronsystemhandbuch.

/* Stichpunkte aus dem Systemhandbuch, noch in Fließtext zu überführen.
   Die Seitenangaben in den Kommentaren beziehen sich auf
   resources/datasheets/MAN_L1V30827018A_RS-AC_009_de_de-DE.pdf. */

*Einordnung der Gerätefamilie* /* Kap. 3, S. 21 f. */

- Schutzschaltgeräte mit Kommunikations- und Messfunktion erfüllen zunächst ihre klassische Schutzaufgabe, erfassen darüber hinaus aber elektrische Kenngrößen wie Energie, Wirkleistung, Strom, Spannung, Netzfrequenz und Temperatur @src:sentronsystemhandbuch
- Dadurch werden Energieverbräuche bis in den Endstromkreis aufgeschlüsselt; über Alarmschwellwerte und die Messung von Differenzströmen in mehreren Frequenzbereichen lassen sich Fehlerursachen genauer lokalisieren @src:sentronsystemhandbuch
- Die Geräte kommunizieren drahtlos über ein Funkprotokoll mit einem übergeordneten Datentransceiver, dem SENTRON Powercenter (siehe @sec:powercenter); eine eigene Modbus-Schnittstelle besitzen sie nicht @src:sentronsystemhandbuch
- Zur Familie zählen unter anderem Leitungsschutzschalter 5SL6 COM, Brandschutzschalter 5SV6 COM, Hilfs- und Fehlersignalschalter 5ST3 COM, Sicherungen 3NA COM, Differenzstromüberwachungsgeräte 5SV8 COM, digitale Ein-/Ausgangsmodule 5TT4 COM sowie das #acro("ECPD") 5TY1 COM @src:sentronsystemhandbuch
- Die Inbetriebnahme und Parametrierung erfolgt über die Software SENTRON Powerconfig für den PC oder SENTRON Powerconfig mobile @src:sentronsystemhandbuch

*Elektronisches Schutzschaltgerät 5TY1 COM* /* Kap. 3.8, S. 33 f. */

- Das #acro("ECPD") schaltet mittels Leistungshalbleiter und kennt neben den Zuständen ON (stromleitend) und OFF zusätzlich den Zustand Standby (STBY, nicht leitend beziehungsweise hochohmig) @src:sentronsystemhandbuch /* Autorennotiz: Zustand beachten, on/off/standby -- die Unterscheidung ist für das Datenmodell relevant */
- Der Standby-Zustand erlaubt es, Verbraucher gezielt abzuschalten oder einen Stromkreis nach einer Überlastauslösung wieder zuzuschalten @src:sentronsystemhandbuch
- Bis auf die Grundfunktionen lassen sich die Gerätefunktionen aktiv ein- und ausschalten sowie parametrieren; unter anderem ist einstellbar, wie sich das Gerät je nach Auslöseursache -- etwa Kurzschluss oder Überlast -- anschließend verhält @src:sentronsystemhandbuch
- Die Empfindlichkeit der RCD-Auslösung ist als geschützter Parameter zwischen sensitiv ($18,0 space.thin "mA"$), Standard ($22,5 space.thin "mA"$) und robust ($27,0 space.thin "mA"$) umstellbar @src:sentronsystemhandbuch
- Ein zyklischer Selbsttest überwacht das Gerät auf Anomalien und schaltet es im Bedarfsfall ab, um einen sicheren Zustand herzustellen @src:sentronsystemhandbuch
- Nennspannung $230 space.thin "V"$ AC bei einem Funktionsbereich von $85 space.thin "V"$ bis $255 space.thin "V"$; die integrierte Überspannungsschutzfunktion (Power Overvoltage Protection) ist standardmäßig aktiv @src:sentronsystemhandbuch
- Das #acro("ECPD") wird vom SENTRON Powercenter 1000 erst ab Firmware-Version 3.0 und ohne Funktionserweiterungen unterstützt; für die per Firmware-Update nachgelieferten Gerätefunktionen ist ein Powercenter 1100 oder 2000 erforderlich @src:sentronsystemhandbuch /* → begründet die Gerätewahl im Testaufbau */
