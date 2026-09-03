#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#import "../../config/diagrams.typ": abb_testaufbau
#include "../../config/config.typ"

== Testaufbau<sec:testaufbau>

Die Umgebung wird vor der Entwicklung des Datenmodells beschrieben, weil beide nach dem in @sec:vorgehensmodell_auswahl gewählten Vorgehen wechselseitig voneinander abhängen. Welche Datenpunkte sich sinnvoll abbilden lassen, zeigt sich erst am realen Gerät, und was sich am Gerät überhaupt beobachten lässt, bestimmt umgekehrt der Aufbau. Der Testaufbau ist somit die Voraussetzung für die Auswahl der Datenpunkte.


Gegenstand dieses Abschnitts sind ausschließlich die konkreten Exemplare des Laboraufbaus. @img:testaufbau zeigt sie als Lichtbild, @img:testaufbau_schema ihre Verschaltung, die auf dem Lichtbild nicht zu erkennen ist. Die allgemeine Kette aus Endgerät, Datentransceiver und Managementplattform ist in @sec:systemanalyse beschrieben und wird hier nicht wiederholt.


Der Aufbau besteht aus einem SENTRON Powercenter 1100 als Datentransceiver und einem elektronischen Schutzschaltgerät 5TY1-3MF16 COM, also der $16space.thin"A"$ Nennstrom-Variante, als Endgerät, wie es RB-04 vorsieht. Beide Geräte entsprechen damit den in @sec:ecpd und @sec:powercenter beschriebenen Typen. Das Powercenter trägt den Firmwarestand 7.3.0, das #acro("ECPD") den Stand 5.5.0. Sowohl der Umfang der verfügbaren Gerätefunktionen als auch die Registerkarte sind an den Firmwarestand gebunden @src:sentronsystemhandbuch.

/* Anmerkung des Autors, erledigt:
   "Powercenter hat Firmware Version 7.3.0 und ECPD hat Version 5.5.0" */


Ausgeführt ist der Aufbau als Laboraufbau auf einer Hutschiene. Auf derselben Hutschiene sitzt ein Netzteil mit $24space.thin"V"$, welches das Powercenter versorgt, während das #acro("ECPD") über eine gewöhnliche Steckdose mit $230space.thin"V"$ gespeist wird. Der gesamte Aufbau steht in einem Serverschrank in einem Testraum der Siemens AG.


Die Last wird über eine Steckdosenleiste am Abgang des #acro("ECPD") aufgeschaltet. Als Verbraucher dienen zwei Wasserkocher mit je $1800space.thin"W"$, die bei $230space.thin"V"$ zusammen rund $15class("normal", ",")7space.thin"A"$ aufnehmen. Der Wert ist aus den Leistungsangaben der Geräte gerechnet. Damit lässt sich sowohl ein Betriebspunkt für den in T-04 geforderten Vergleich der Messwerte herstellen als auch die Überlast erzeugen, die T-06 als einzigen am Aufbau gefahrlos herbeiführbaren Alarm nutzt.

// #kommentar[Falls der am #acro("ECPD") abgelesene Stromwert des Lastversuchs vorliegt, gehört er als gemessener Wert neben den gerechneten. Die zuvor an dieser Stelle genannten $18space.thin"A"$ waren unzutreffend.]

Dass diese Überlast am Aufbau vertretbar ist, beruht nicht auf der Kürze des Versuchs, sondern darauf, dass der Prüfstrom unterhalb der Belastbarkeit jedes Glieds der Kette bleibt. Der Testraum ist mit $16space.thin"A"$ abgesichert und während der Versuche ausschließlich mit dem Testaufbau belegt, Steckdose und Steckdosenleiste sind für denselben Strom bemessen. Die rund $15class("normal", ",")7space.thin"A"$ liegen darunter und damit unterhalb jedes Stroms, bei dem die vorgelagerte Absicherung anspricht, unabhängig von deren Bauart. Die Auslösung findet ausschließlich am #acro("ECPD") statt, dessen eingestellter Nennstrom nach @sec:geraetekonfiguration auf $10space.thin"A"$ herabgesetzt ist. Der Prüfstrom entspricht damit dem 1,57-fachen dieses Werts und liegt über dem 1,45-fachen, ab dem die Auslösecharakteristik der Klasse B nach @sec:ecpd_geraet eine Auslösung innerhalb einer Stunde vorsieht. Ohne diese Herabsetzung bliebe die Last unterhalb der Auslöseschwelle des Geräts.

Drei weitere Festlegungen gehören zum Versuch. Die Last wird ausschließlich unter Aufsicht aufgeschaltet und spätestens nach zwei Minuten wieder abgeworfen, unabhängig davon, ob das Gerät zuvor abgeschaltet hat. Erreicht wurde diese Grenze nicht, da das #acro("ECPD") nach @sec:testdurchfuehrung deutlich früher in den Standby-Zustand überging. Zum Abschalten stehen der Bedienhebel des #acro("ECPD"), der Schaltbefehl aus Desigo CC und die vorgelagerte Absicherung unabhängig voneinander zur Verfügung, wofür der Serverschrank während des Versuchs geöffnet bleibt. Verantwortlich für den Aufbau und für die Durchführung der Lastversuche ist Andreas Soffner als verantwortliche Elektrofachkraft der Abteilung. // Referenz im Text auf Abbildungen fehlt


#figure(
  image("../../resources/img/testaufbau.jpg", width: 60%, format: "jpg"),
  caption: [Laboraufbau aus $24space.thin"V"$ Netzteil, Powercenter 1100 und #acro("ECPD") 5TY1 COM],
)<img:testaufbau>

#figure(
  abb_testaufbau,
  caption: [Verschaltung des Testaufbaus mit Einspeisung und Laststrom, der Funkstrecke zwischen #acro("ECPD") und Powercenter, der Modbus-Anbindung an Desigo CC über Ethernet sowie dem unabhängigen Modbus-Werkzeug zur Gegenprobe],
)<img:testaufbau_schema>

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

/* Claude: Am 31.08.2026 nach Angabe des Autors korrigiert und ergaenzt. Die
   zuvor genannten 18 A waren falsch. Zwei Wasserkocher mit je 1800 W ziehen bei
   230 V zusammen rund 15,7 A, der Wert ist gerechnet und nicht gemessen. Damit
   bleibt der Pruefstrom unter den 16 A von Absicherung, Steckdose und
   Steckdosenleiste, was die alte Fassung nicht leistete.

   Der Absatz zur Sicherheit des Lastversuchs ist neu und beantwortet die
   Rueckfrage nach vorgelagerter Absicherung, Leitungsfuehrung, ueberwachter
   Dauer, Abschaltmoeglichkeit und verantwortlicher Person.

   Bewusst nicht geschrieben ist eine Charakteristikklasse der vorgelagerten
   Absicherung. Sie wird nicht gebraucht: Bei 15,7 A liegt der Strom unter deren
   Nennstrom von 16 A, weshalb sie unabhaengig von Bauart und Kennlinie nicht
   anspricht. Eine erfundene Klasse waere weder belegbar noch noetig.

   Die Auslösung traegt allein das ECPD, dessen eingestellter Nennstrom nach
   @sec:geraetekonfiguration auf 10 A herabgesetzt ist. 15,7 A entsprechen dem
   1,57-fachen und liegen ueber dem grossen Pruefstrom des 1,45-fachen der
   Klasse B, weshalb die beobachtete Auslösung der Charakteristik entspricht.
   Am unveraenderten Nennstrom von 16 A waeren es 0,98-fach gewesen, also
   unterhalb jeder Auslöseschwelle. Ohne die Herabsetzung waere T-06 nicht
   durchfuehrbar gewesen. */

/* Claude: Am 31.08.2026 ergaenzt ist das schematische Verbindungsdiagramm
   @img:testaufbau_schema. Es liegt als `abb_testaufbau` in config/diagrams.typ
   und verwendet die dortigen Bausteine dg_geraet, dg_werkzeug und dg_legende.

   Neu ist eine vierte Kantenart. Diese Abbildung ist die einzige, die neben dem
   Datenpfad auch den Stromkreis zeigt, weshalb `dg_linie_strom` in der
   Akzentfarbe hinzugekommen ist. Der Ton stammt wie alle uebrigen aus
   config/colors.typ und traegt hier eine Linie, keinen Text. Alle vier Arten
   sind in der Legende der Abbildung ausgewiesen.

   Die Angaben im Diagramm stammen aus diesem Abschnitt, aus
   @sec:geraetekonfiguration (Unit Identifier, eingestellter Nennstrom),
   @sec:kommunikationsstrecke (Abfrageintervall) und @tab:werkzeuge
   (QModMaster). Aendert sich eine davon, ist das Diagramm mitzufuehren. */
