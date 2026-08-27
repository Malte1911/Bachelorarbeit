#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Ausgangslage und Motivation<sec:ausgangslage>

Der Betrieb einer Liegenschaft wird über eine Leitebene geführt, auf der Heizung, Lüftung, Beleuchtung und Sicherheitstechnik in einer gemeinsamen Oberfläche zusammenlaufen. Die elektrische Energieverteilung ist dort üblicherweise bis zur Ebene der Verteilung abgebildet, der einzelne Endstromkreis dagegen nicht. Welcher Abgang in Betrieb ist, welche Leistung er bezieht und aus welchem Grund ein Schutzgerät ausgelöst hat, ist am Verteiler abzulesen und nicht am Arbeitsplatz des Betreibers.

Die Gerätetechnik hat diese Lücke inzwischen geschlossen. Mit den SENTRON #acro("ECPD") steht eine Reihe elektronischer Schaltkreisschutzgeräte zur Verfügung, die neben der Schutzfunktion je Endstromkreis misst, sich aus der Ferne schalten lässt und ihren Zustand über ein zugehöriges Kommunikationsgerät, das SENTRON Powercenter, im Gebäudenetz bereitstellt @src:sentronsystemhandbuch. Ein Verteiler mit bis zu 24 solcher Abgänge liefert damit eine Auflösung, die eine zentrale Messung nicht erreicht.

Der Nutzen dieser Daten entsteht jedoch nicht am Gerät, sondern erst dort, wo sie beobachtet, archiviert und mit den übrigen Gewerken zusammen betrachtet werden. Mit Desigo CC führt die Siemens AG eine Gebäudemanagementplattform, die genau diese Aufgabe erfüllt @src:desigoccdatasheet. Beide Enden der Kette sind somit vorhanden, eine Verbindung dazwischen existiert nicht. Woran sie derzeit scheitert und welcher Aufwand daraus in jedem Projekt entsteht, behandelt @sec:problemstellung.

/* Claude: Abschnitt neu angelegt und bewusst schmal gehalten, damit er sich
   nicht mit den uebrigen Unterkapiteln ueberschneidet. Ausgespart sind deshalb
   die Einordnung in den Stand der Technik (@sec:standdertechnik), die
   Gerätefamilien und der Aufbau des ECPD (@sec:ecpd), die fehlende
   Objektmodellbibliothek der Zielplattform (@sec:systemanalyse) sowie der
   wiederkehrende Zuordnungsaufwand nach @src:wang2018, der in
   @sec:auswahlkriterien und @sec:nachhaltigkeit traegt. Der Abschnitt leistet
   nur die Hinfuehrung: Lücke im Betrieb, Geraetetechnik schliesst sie, beide
   Enden liegen vor.

   Der letzte Absatz endet als Ueberleitung auf @sec:problemstellung, damit die
   eigentliche Luecke dort und nicht hier entfaltet wird. */
