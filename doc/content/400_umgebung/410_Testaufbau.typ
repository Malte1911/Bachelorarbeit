#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Testaufbau<sec:testaufbau>

Die Umgebung wird vor der Entwicklung des Datenmodells beschrieben, weil beide nach dem in @sec:vorgehensmodell_auswahl gewählten Vorgehen wechselseitig voneinander abhängen. Welche Datenpunkte sich sinnvoll abbilden lassen, zeigt sich erst am realen Gerät, und was sich am Gerät überhaupt beobachten lässt, bestimmt umgekehrt der Aufbau. Der Testaufbau ist somit die Voraussetzung für die Auswahl der Datenpunkte.


Gegenstand dieses Abschnitts sind ausschließlich die konkreten Exemplare des Laboraufbaus in @img:testaufbau. Die allgemeine Kette aus Endgerät, Datentransceiver und Managementplattform ist in @sec:systemanalyse beschrieben und wird hier nicht wiederholt.


Der Aufbau besteht aus einem SENTRON Powercenter 1100 als Datentransceiver und einem elektronischen Schutzschaltgerät 5TY1-3MF16 COM, also der $16space.thin"A"$ Nennstrom-Variante, als Endgerät, wie es RB-04 vorsieht. Beide Geräte entsprechen damit den in @sec:ecpd und @sec:powercenter beschriebenen Typen. Das Powercenter trägt den Firmwarestand 7.3.0, das #acro("ECPD") den Stand 5.5.0. Sowohl der Umfang der verfügbaren Gerätefunktionen als auch die Registerkarte sind an den Firmwarestand gebunden @src:sentronsystemhandbuch.

/* Anmerkung des Autors, erledigt:
   "Powercenter hat Firmware Version 7.3.0 und ECPD hat Version 5.5.0" */


Ausgeführt ist der Aufbau als Laboraufbau auf einer Hutschiene. Auf derselben Hutschiene sitzt ein Netzteil mit $24space.thin"V"$, welches das Powercenter versorgt, während das #acro("ECPD") über eine gewöhnliche Steckdose mit $230space.thin"V"$ gespeist wird. Der gesamte Aufbau steht in einem Serverschrank in einem Testraum der Siemens AG.


Die Last wird über eine Steckdosenleiste am Abgang des #acro("ECPD") aufgeschaltet. Als Verbraucher dienen zwei Wasserkocher, die zusammen einen Strom von etwa $18space.thin"A"$ aufnehmen. Dieser Wert wurde mit dem #acro("ECPD") selbst gemessen, was zwar nicht der ideale Weg zur Feststellung ist, jedoch für eine Auslösung reicht und es im Testkontext nicht weiter relevant ist. Damit lässt sich sowohl ein Betriebspunkt für den in T-04 geforderten Vergleich der Messwerte herstellen als auch die Überlast erzeugen, die T-06 als einzigen am Aufbau gefahrlos herbeiführbaren Alarm nutzt.


#figure(
  image("../../resources/img/testaufbau.jpg", width: 60%, format: "jpg"),
  caption: [Laboraufbau aus $24space.thin"V"$ Netzteil, Powercenter 1100 und #acro("ECPD") 5TY1 COM],
)<img:testaufbau>

Aus dem Aufbau folgt unmittelbar seine Reichweite. Da nur ein einziges Endgerät zur Verfügung steht, lässt sich das Verhalten eines voll bestückten Strangs mit bis zu 24 Endgeräten nicht messen, sondern nach @sec:testabdeckung nur rechnerisch abschätzen. Ebenso wird die in RB-02 vorausgesetzte Gleichwertigkeit des Powercenters 2000 an diesem Aufbau nicht geprüft. Beide Einschränkungen sind bereits bei den Testfällen benannt und werden im Validierungsteil bei der Bewertung der Ergebnisse wieder aufgegriffen.

/* Anmerkung des Autors, in Fliesstext ueberfuehrt:
   - 24 V Netzteil auch an Hutschiene im Testaufbau installiert, versorgt Powercenter
   - ECPD mit 230V über normale Steckdose
   - Überstrom wird simuliert mit Steckdosenleiste und zwei Wasserkochern,
     Messungen ergeben ca. 18 A Leistung
   - gesamter Aufbau im Testraum hier bei Siemens in einem Serverschrank aus dem Weg */

/* Claude: Abschnitt nach den Vorgaben aus dem Kommentar ausformuliert
   (konkrete Exemplare statt generischer Kette, einleitende Begruendung ueber
   die Kopplung nach @sec:vorgehensmodell_auswahl, Fernzugriff).

   Die nachgereichten Angaben des Autors sind eingearbeitet und die zugehoerigen
   Arbeitskommentare entfallen. Die Notiz "ca. 18 A Leistung" ist im Fliesstext
   als Strom formuliert, da Ampere eine Stromstaerke und keine Leistung ist;
   zwei Wasserkocher an 230 V ergeben bei rund 18 A
   eine Leistung von etwa 4 kW.

   Offen und als roter Arbeitskommentar stehen geblieben sind der Nennstrom des
   ECPD, das Messmittel hinter den 18 A sowie der Zugriffsweg aus der Ferne. */
