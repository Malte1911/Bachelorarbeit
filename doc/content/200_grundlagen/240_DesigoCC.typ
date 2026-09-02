#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Desigo CC<sec:desigocc>

Desigo CC ist eine Gebäudemanagementplattform der Siemens AG. Sie ist auf der Managementebene angesiedelt, führt also nicht selbst Regelaufgaben aus, sondern bündelt die Daten unterlagerter Systeme, stellt sie dar, archiviert sie, wertet sie aus und ermöglicht deren Bedienung. Ihr kennzeichnendes Merkmal ist die gewerkeübergreifende Anlage. Brandschutz, Sicherheits- und Zutrittstechnik, Videoüberwachung, Heizung, Lüftung und Klima, Beleuchtung und Energiemanagement werden nicht in getrennten Anwendungen, sondern in einer einzigen Bedienoberfläche mit durchgängigem Bedienkonzept geführt @src:desigoccdatasheet. Für den Betreiber bedeutet das, dass ein zusätzliches Gewerk keine zusätzliche Leitwarte und keine zweite Bedienlogik nach sich zieht. Ein zweites Merkmal ist die Offenheit gegenüber Fremdsystemen, die über Erweiterungsmodule für offene Protokolle hergestellt wird und die Plattform von einer herstellergebundenen Lösung unterscheidet @src:desigoccdatasheet.


=== Aufbau und Skalierung<sec:desigocc_aufbau>

Die Plattform folgt einer Server-Client-Architektur. Der Server hält sämtliche Daten des Systems, während die Clients allein der Darstellung und der Bedienung dienen @src:desigoccdatasheet. In der kleinsten Ausbaustufe laufen Server und Client auf demselben Rechner. Für größere Anlagen lassen sich installierte Clients, Browser-Clients und Windows-Anwendungen ergänzen, die sich im Funktionsumfang, nicht aber im Bedienkonzept unterscheiden @src:desigoccdatasheet.

Zwei Mechanismen erlauben die Skalierung darüber hinaus. Ein #acro("FEP") ist eine Erweiterung des Servers, die auf eigener Hardware läuft und zusätzliche Ressourcen für die Anbindung von Subsystemen bereitstellt. Über ihn lassen sich die Treiber der Feldsysteme auf mehrere Rechner verteilen @src:desigoccenghelp. In einem verteilten System werden darüber hinaus mehrere eigenständig laufende Projekte miteinander verbunden, sodass sie sich für Projektierung und Betrieb als ein einziges System darstellen. Die Dokumentation unterscheidet dabei die vollvermaschte Anordnung, in der jeder Server mit jedem anderen verbunden ist, von der hierarchischen, in der mehrere überwachte Systeme einem übergeordneten zugeordnet sind @src:desigoccenghelp. Neben der reinen Größe ist damit auch eine Trennung nach Standorten oder nach Gewerken möglich.

Innerhalb der Plattform werden sämtliche Daten unabhängig von ihrer Herkunft als Objekte mit Eigenschaften abgebildet. Erst diese einheitliche Abbildung macht es möglich, dass Anzeige, Archivierung, Auswertung und Alarmierung für alle Gewerke denselben Mechanismen folgen. Die Bedienoberfläche trennt dabei einen Betriebsmodus, in dem überwacht, bedient und ausgewertet wird, von einem Engineering-Modus, in dem die Projektierung erfolgt @src:desigoccdatasheet.


=== Ereignis- und Alarmverarbeitung<sec:desigocc_alarme>

Die Verarbeitung von Ereignissen ist die zentrale Aufgabe der Plattform. Tritt ein Zustand auf, der den Bediener betrifft, so wird daraus ein Ereignis, das in einer Ereignisliste erscheint, nach Priorität eingeordnet und in einer Summenanzeige zusammengefasst wird. Zu jedem Ereignis lassen sich Meldetexte und Handlungsanweisungen hinterlegen, und der Bediener quittiert es und setzt es nach Behebung der Ursache zurück @src:desigoccdatasheet. Ergänzend kann die Plattform Ereignisse automatisch weitermelden, etwa per E-Mail oder Kurznachricht, und aus ihnen Folgeaktionen ableiten @src:desigoccdatasheet.

Für die Modellierung eines Geräts ist entscheidend, dass die Plattform zwei Arten von Alarmen unterscheidet @src:desigoccenghelp. Ein Feldsystemalarm entsteht im unterlagerten System. Die Plattform übernimmt in diesem Fall lediglich den vom Feldgerät gemeldeten Zustand und ordnet ihn über eine Ereignistabelle in ihr eigenes Melde- und Prioritätsschema ein. Ein Managementstationsalarm entsteht dagegen in der Plattform selbst, indem der Wert einer Objekteigenschaft fortlaufend gegen hinterlegte Bedingungen geprüft wird. 

Managementstationsalarme treten in zwei Ausprägungen auf @src:desigoccenghelp. Ein diskreter Alarm vergleicht den Wert einer Eigenschaft mit einzelnen Werten, einer Werteliste oder einem Wertebereich und eignet sich damit für Zustands- und Bitwerte, etwa für einen Schaltzustand oder ein Sammelregister von Meldungen. Ein kontinuierlicher Alarm prüft dagegen gegen eine Schwelle und kennt zu jeder Bedingung eine obere und eine untere Hysterese, was ihn für Messwerte geeignet macht. In beiden Fällen besteht die Konfiguration aus einer Liste von Bedingungen, die genau einen Normalzustand und bis zu zwanzig Alarmzustände enthalten darf, wobei jedem Alarmzustand eine im Projekt vorhandene Alarmklasse sowie ein Meldetext für das Kommen und für das Gehen des Alarms zugeordnet wird @src:desigoccenghelp.


=== Kommunikationsschnittstellen<sec:desigocc_schnittstellen>

Zur Feldebene hin bindet die Plattform Systeme über Treiber an, die jeweils in einem eigenen Erweiterungsmodul bereitgestellt werden. Neben den herstellereigenen Systemen unterstützt sie die offenen Standards BACnet, OPC DA, Modbus #acro("TCP"), #acro("SNMP") und IEC 61850 @src:desigoccdatasheet @src:desigoccenghelp. In den auf Modbus gestützten Anbindungen tritt Desigo CC dabei als Client auf, der die Register der angebundenen Geräte zyklisch abfragt @src:desigoccenghelp.

Nach außen stehen mehrere Wege offen. Eine Webservice-Schnittstelle erlaubt fremden Anwendungen den lesenden und schreibenden Zugriff auf die Daten des Systems @src:desigoccenghelp. Eine mobile Anwendung gibt Ereignisse und Objektzustände auf Endgeräten wieder, und über Benachrichtigungsdienste lassen sich Ereignisse per E-Mail, Kurznachricht oder an Personenrufsysteme weiterleiten @src:desigoccdatasheet.

/* Claude: Abschnitt nach der Vorgabe aus der Durchsicht ausformuliert
   (generische Beschreibung, Alleinstellungsmerkmale, Alarmsystem mit der
   Unterscheidung Feldsystem- und Managementstationsalarm, Kommunikations-
   schnittstellen). Bewusst ohne Bezug auf die Aufgabenstellung. Der
   Importmechanismus des Objektmodells, die Bibliothek der Powermeter und die
   Randbedingungen des Modbus-Treibers bleiben der Analyse vorbehalten.

   Quellenlage: Das Datenblatt @src:desigoccdatasheet betrifft den Stand V9.0,
   ist aber auf den nordamerikanischen Brandschutzmarkt zugeschnitten;
   uebernommen sind nur plattformweite Aussagen. Die Engineering Help
   @src:desigoccenghelp lag in den Staenden V5.1 und V7 vor, die verwendeten
   Aussagen sind dort identisch und nach Auskunft des Autors auch gegenueber
   dem eingesetzten Stand unveraendert (Stand 27.08.2026). */
