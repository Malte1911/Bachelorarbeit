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
    [Zielplattform, in die die Typbeschreibung importiert und in der instanziiert wird.],
    [V 9],

    [QModMaster],
    [Unabhängige Gegenprobe der Registerwerte am Datentransceiver, getrennt vom Datenmodell.],
    [V 0.5.2],
  ),
  caption: [Eingesetzte Werkzeuge, ihre Aufgabe im Rahmen der Arbeit und ihr Versionsstand]
)<tab:werkzeuge>

#kommentar[Bitte die vier Versionsstände eintragen und beim Modbus-Werkzeug zusätzlich den Produktnamen, da die Zeile sonst keinen Nachvollzug erlaubt. Falls weitere Werkzeuge zum Einsatz kamen, die für die Ergebnisse bedeutsam sind, gehören sie in dieselbe Tabelle.]


Zwei Einträge der Tabelle verdienen eine Erläuterung.


Der Stand von Desigo CC ist nicht nur eine Angabe zur Reproduzierbarkeit, sondern berührt eine Anforderung. NFA-04 fordert die Lauffähigkeit unter dem Stand V9.0, während die für die Analyse verfügbare Engineering-Dokumentation die Stände V5.1 und V7 abdeckt (siehe @sec:quellenlage). Die in @tab:modbustreiber zusammengetragenen Eigenschaften des Modbus-Treibers stammen aus dieser Dokumentation und sind am eingesetzten Stand nachzuvollziehen. Wo Beobachtung und Dokumentation auseinandergehen, wie beim Abfrageintervall vermerkt, gilt nach @sec:quellenlage die Beobachtung am Gerät. #kommentar[Bitte ergänzen, welcher Stand von Desigo CC am Testaufbau tatsächlich installiert ist und ob es sich um eine vollständige Installation oder um eine Testinstanz handelt. Weicht der Stand von dem in NFA-04 geforderten V9.0 ab, ist das kein Mangel des Aufbaus, muss aber im Anforderungsabgleich ausgewiesen werden.]


Das unabhängige Modbus-Werkzeug ist kein Hilfsmittel der Bequemlichkeit, sondern folgt unmittelbar aus dem in @sec:quellenlage festgelegten Umgang mit der Herstellerdokumentation. Zeigt ein Datenpunkt in Desigo CC einen unerwarteten Wert, so lässt sich ohne einen zweiten, vom Datenmodell unabhängigen Zugang nicht entscheiden, ob die Ursache im Objektmodell, in der Registerkarte oder im Verhalten des Geräts liegt. Erst der direkte Blick auf das Register trennt diese drei Fälle. Der Zugang ist deshalb bereits in @sec:kommunikationsstrecke als eigener Weg auf denselben Registerraum beschrieben.

/* Claude: Abschnitt nach der Vorgabe aus dem Kommentar ausformuliert
   (Werkzeuge mit Versionsstand fuer die Reproduzierbarkeit, Powerconfig, PDE,
   Desigo CC und das unabhaengige Modbus-Werkzeug).

   Die Versionsstaende sind bewusst nicht erfunden, sondern stehen als roter
   Arbeitskommentar in der Tabelle. Beim Modbus-Werkzeug fehlt zusaetzlich der
   Produktname, weil er sich aus keiner Datei des Projekts ergibt.

   Die beiden Erlaeuterungen greifen den Vorbehalt zu NFA-04 und die Begruendung
   des zweiten Modbus-Zugangs auf, damit die Tabelle nicht als blosse Liste
   stehen bleibt. */
