#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Eingesetzte Werkzeuge und Softwarestände<sec:werkzeuge>

Die Ergebnisse dieser Arbeit sind an die Stände der eingesetzten Software gebunden. Sowohl der Funktionsumfang des Werkzeugs, mit dem die Gerätetypbeschreibung entsteht, als auch die Fähigkeiten des Modbus-Treibers der Zielplattform ändern sich zwischen den Ständen. Die folgende Übersicht nennt deshalb zu jedem Werkzeug seine Aufgabe und seinen Versionsstand, damit die späteren Beobachtungen einem bestimmten Stand zugeordnet und nachvollzogen werden können.

#figure(
  table(
    columns: (11em, 1fr, 9em),
    inset: 6pt,
    align: (left + horizon, left, left + horizon),
    table.header(
      [*Werkzeug*], [*Aufgabe im Rahmen der Arbeit*], [*Versionsstand*],
    ),
    [SENTRON Powerconfig],
    [Inbetriebnahme und Parametrierung von Datentransceiver und Endgerät nach @sec:geraetekonfiguration, insbesondere das Einschalten der ab Werk deaktivierten Alarme.],
    [V 3.33],

    [SENTRON #acro("PDE")],
    [Erzeugung der Gerätetypbeschreibung als #acro("JSON")-Datei nach @sec:pde.],
    [V 9.1.0],

    [Desigo CC],
    [Zielplattform, in die die Typbeschreibung importiert und in der instanziiert wird. Vollständige Installation der Standardausführung.],
    [V 9],

    [QModMaster],
    [Unabhängige Gegenprobe der Registerwerte am Datentransceiver, getrennt vom Datenmodell.],
    [V 0.5.2],

    [Wireshark],
    [Aufzeichnung des Modbus-Verkehrs zwischen Desigo CC und dem Datentransceiver, um Abfrageintervall und Blockbildung am Telegramm nachzuweisen (siehe @sec:testdurchfuehrung).],
    [V 4.4.17],
  ),
  caption: [Eingesetzte Werkzeuge, ihre Aufgabe im Rahmen der Arbeit und ihr Versionsstand]
)<tab:werkzeuge>

/* Anmerkung des Autors, erledigt: "Bitte die vier Versionsstände eintragen und
   beim Modbus-Werkzeug zusätzlich den Produktnamen, da die Zeile sonst keinen
   Nachvollzug erlaubt. Falls weitere Werkzeuge zum Einsatz kamen, die für die
   Ergebnisse bedeutsam sind, gehören sie in dieselbe Tabelle." */

/* Anmerkung des Autors, erledigt: "Bitte ergänzen, welcher Stand von Desigo CC
   am Testaufbau tatsächlich installiert ist und ob es sich um eine
   vollständige Installation oder um eine Testinstanz handelt. Weicht der Stand
   von dem in NFA-04 geforderten V9.0 ab, ist das kein Mangel des Aufbaus, muss
   aber im Anforderungsabgleich ausgewiesen werden." */

Zu Desigo CC gehört eine Angabe, die sich aus der Versionsnummer allein nicht ergibt. Am Testaufbau liegt eine vollständige Installation der Standardausführung vor und keine eingeschränkte Test- oder Demonstrationsinstanz. Für die Prüfung ist das wesentlich, denn eine eingeschränkte Instanz könnte Funktionen ausblenden, deren Fehlen sonst dem Datenmodell zugerechnet würde. Der in NFA-04 geforderte Nachweis der Verträglichkeit bezieht sich damit auf einen Stand der Plattform, wie er auch im Betrieb anzutreffen ist.

Die Hauptversion ist dabei die für diese Plattform angemessene Genauigkeit. Zwar trägt die Installation darunter noch eine Buildnummer, die Freigabe erfolgt jedoch versionsweise, und ein Wechsel auf einen neueren Stand ist ein eigener, von Hand vorgenommener Schritt. Eine Abstufung zwischen zwei Hauptversionen, wie sie die übrigen Werkzeuge der Tabelle führen, gibt es nicht, weshalb sich die Beobachtungen dieser Arbeit der Version 9 als Ganzes zuordnen lassen.

Das unabhängige Modbus-Werkzeug folgt aus dem in @sec:quellenlage festgelegten Umgang mit der Herstellerdokumentation. Zeigt ein Datenpunkt in Desigo CC einen unerwarteten Wert, so lässt sich ohne einen zweiten, vom Datenmodell unabhängigen Zugang nicht entscheiden, ob die Ursache im Objektmodell, in der Registerkarte oder im Verhalten des Geräts liegt. Erst der direkte Blick auf das Register trennt diese drei Fälle. Der Zugang ist deshalb bereits in @sec:kommunikationsstrecke als eigener Weg auf denselben Registerraum beschrieben.

/* Claude: Abschnitt nach der Vorgabe aus dem Kommentar ausformuliert
   (Werkzeuge mit Versionsstand fuer die Reproduzierbarkeit, Powerconfig, PDE,
   Desigo CC und das unabhaengige Modbus-Werkzeug).

   Die Versionsstaende sind bewusst nicht erfunden, sondern stehen als roter
   Arbeitskommentar in der Tabelle. Beim Modbus-Werkzeug fehlt zusaetzlich der
   Produktname, weil er sich aus keiner Datei des Projekts ergibt.

   Die beiden Erlaeuterungen greifen den Vorbehalt zu NFA-04 und die Begruendung
   des zweiten Modbus-Zugangs auf, damit die Tabelle nicht als blosse Liste
   stehen bleibt. */

/* Claude: Am 31.08.2026 ergaenzt nach der Rueckfrage zu Versionsstaenden und
   Installationsart. Neu sind der Absatz zur vollstaendigen Installation der
   Standardausfuehrung von Desigo CC, der Zusatz in der Tabellenzeile und die
   Zeile zu Wireshark 4.4.17, dessen Aufzeichnung das Ergebnis von T-03 traegt.
   Die beiden auskommentierten Rueckfragen sind damit beantwortet und als
   erledigt gekennzeichnet.

   Dass Desigo CC allein mit der Hauptversion steht, waehrend die uebrigen vier
   Werkzeuge auf die Patchebene genannt sind, ist nach Auskunft des Autors keine
   Ungenauigkeit, sondern eine Eigenschaft der Plattform. Sie wird versionsweise
   freigegeben, eine Buildnummer existiert zwar, eine Abstufung zwischen zwei
   Hauptversionen jedoch nicht. Der zweite Absatz haelt das fest, damit die Zeile
   im Vergleich zu den uebrigen nicht als nachlaessig gelesen wird. Der zuvor
   hier gesetzte Arbeitskommentar ist damit erledigt. */
