#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Ausgangslage und Motivation<sec:ausgangslage>


In einem größeren Gebäude werden Heizung, Lüftung, Beleuchtung und Sicherheitstechnik nicht einzeln vor Ort bedient. Sie laufen auf einer gemeinsamen Bedienoberfläche zusammen, die als Gebäudeleitebene bezeichnet wird. Wer dort arbeitet, sieht den Zustand der Anlagen am Bildschirm, statt ihn im Gebäude nachsehen zu müssen.

Für die elektrische Energieverteilung endet dieser Überblick früh. Sichtbar ist in der Regel nur, wie viel Energie ein ganzer Verteiler bezieht. Ein Verteiler teilt die Versorgung eines Gebäudeabschnitts in einzelne Endstromkreise auf, in die Leitungen zu einer Steckdosenreihe, einer Beleuchtungsgruppe oder einem einzelnen Verbraucher. Jeder dieser Stromkreise wird als Abgang bezeichnet und ist durch ein eigenes Schutzgerät abgesichert. Ob ein Abgang eingeschaltet ist, welche Leistung er bezieht und weshalb sein Schutzgerät abgeschaltet hat, lässt sich bislang nur am Verteiler selbst ablesen und nicht am Arbeitsplatz des Betreibers.

Die Gerätetechnik kann diese Lücke inzwischen schließen. Mit den SENTRON #acro("ECPD") steht eine Reihe elektronischer Schutzgeräte zur Verfügung, die den Abgang wie bisher schützen, darüber hinaus seine Messwerte erfassen und sich aus der Ferne ein- und ausschalten lassen. Eine eigene Netzwerkverbindung besitzen sie nicht. Ihre Werte gehen über eine Funkstrecke an ein zugehöriges Gerät im selben Verteiler, das SENTRON Powercenter, und erst dieses stellt sie im Gebäudenetz bereit @src:sentronsystemhandbuch. Den Aufbau dieser Kette zeigt @img:systemaufbau in @sec:systemanalyse. Ein Verteiler mit bis zu 24 solcher Abgänge liefert damit ein Bild je Stromkreis, das eine einzelne Messung am Verteilereingang nicht erreicht.

Nutzen entsteht aus diesen Daten allerdings erst, wenn sie dauerhaft beobachtet, aufgezeichnet und zusammen mit den übrigen Gewerken betrachtet werden. Genau diese Aufgabe erfüllt Desigo CC, die Gebäudemanagementplattform der Siemens AG @src:desigoccdatasheet. Damit liegen beide Enden der Kette vor, die Geräte auf der einen und die Plattform auf der anderen Seite. Eine Verbindung dazwischen besteht bislang nicht. Woran sie scheitert und welcher Aufwand daraus in jedem Projekt entsteht, behandelt @sec:problemstellung.

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
   eigentliche Luecke dort und nicht hier entfaltet wird.

   Der Verweis auf @img:systemaufbau ist ein Vorwaertsverweis in Kapitel 3. Die
   Abbildung zeigt genau die hier beschriebene Kette (ECPD, Funkstrecke,
   Powercenter, Gebaeudenetz, Desigo CC); eine zweite Abbildung dafuer in der
   Einleitung waere eine Dopplung. */
