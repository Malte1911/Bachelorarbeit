#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Vorbereitung und Ablauf der Prüfung<sec:pruefablauf>

/* Anmerkung des Autors, erledigt: "onlinemodus von PDE basically useless, da
   kein blob verarbeitet werden kann" */

Der Validierungsteil bildet den aufsteigenden Ast des in @sec:vorgehensmodell_auswahl gewählten Vorgehens ab. Seine Aussagekraft hängt daran, dass die Bedingungen der Prüfung feststehen, bevor deren Ergebnisse vorliegen. Dieser Abschnitt hält sie fest. Die Arten des Nachweises und die Grenzen der Prüfung sind mit @sec:nachweisarten und @sec:testabdeckung bereits benannt und werden hier nicht wiederholt.


==== Ausgangszustand

Geprüft wird an dem in @sec:testaufbau beschriebenen Aufbau mit den dort genannten Firmwareständen und den Softwareständen aus @tab:werkzeuge. Gegenstand sind die in @sec:umsetzung entstandenen Typbeschreibungen in der Fassung, die nach der Übernahme in @sec:uebernahme vorliegt, zusammen mit der begleitenden Unterlage nach @sec:modelldoku.

Der Prüfumfang ist für die beiden Gerätetypen verschieden. T-01 und T-02 erfassen beide Typbeschreibungen, da Import und Instanzbildung für beide dieselbe Bedeutung haben. Die übrigen Testfälle betreffen das #acro("ECPD"), denn das Powercenter misst nicht und schaltet nicht, und von seinem Sammelregister sind allein die Übertemperatur und die Betriebsstunden belegt. Für die Prüfung der Messwerte, für den Schaltbefehl und für die Alarmierung besteht dort folglich kein Gegenstück.

Die Parametrierung der Geräte ist dabei kein fester Zustand des Aufbaus, sondern selbst Gegenstand der Prüfung. @sec:geraetekonfiguration beschreibt den Aufbau in seinem eingerichteten Zustand mit eingeschalteten Alarmen und freigegebenem Fernschalten. T-14 setzt dagegen den Auslieferungszustand voraus, da sich allein an ihm zeigt, dass ein ab Werk abgeschalteter Alarm ohne Aussage bleibt. Der Aufbau wird deshalb erst nach diesem Testfall in den dokumentierten Zustand gebracht. Dasselbe gilt für die Freischaltung des Fernschaltens, deren Fehlen den in @sec:befunde ausgewerteten Befund überhaupt erst sichtbar gemacht hat.

==== Prüfmittel und Protokollierung

Drei Zugänge auf dieselben Daten stehen zur Verfügung. Die Ansicht in Desigo CC zeigt, was am Ende der Kette ankommt, und ist damit der eigentliche Prüfgegenstand. Das unabhängige Modbus-Werkzeug aus @tab:werkzeuge liest denselben Registerraum ohne das Datenmodell und trennt nach @sec:werkzeuge einen Fehler des Modells von einem Fehler der Registerkarte.

Der Online-Modus des #acro("PDE") fällt als drittes Prüfmittel weitgehend aus. Er ist nach @sec:pde_online auf einfache Datentypen ohne Transformation beschränkt und liefert für Zeichenketten, Wahrheitswerte und #acro("BLOB") keine Werte. Betroffen sind gerade jene Datenpunkte, deren Prüfung vor der Übernahme den größten Nutzen gehabt hätte, nämlich die als Zeichenkette geführten Stammdaten und die in @sec:umsetzung erprobte Zerlegung des Alarmregisters. Für die numerischen Register bleibt er nutzbar, dort steht mit dem Modbus-Werkzeug jedoch bereits ein Zugang bereit.

Weichen zwei Zugänge voneinander ab, gilt nach @sec:quellenlage die Beobachtung am Gerät. Belegt wird jeder Testfall durch einen Bildschirmabzug der Ansicht in Desigo CC, bei abweichenden Werten zusätzlich durch den unmittelbar am Register abgelesenen Wert. Die Belege liegen im Anhang, während @sec:testdurchfuehrung allein das Ergebnis und dessen Bewertung führt.


==== Durchsicht der Dokumentation

T-13 stützt sich nach @sec:testabdeckung als einziger Testfall auf eine Durchsicht. Die Kriterien D-01 bis D-05 liegen mit @tab:doku_kriterien seit @sec:dokukriterien fest und werden hier nur angewandt. Die Durchsicht hat der Verfasser selbst vorgenommen, da eine an der Entwicklung unbeteiligte Person dafür nicht zur Verfügung stand. Für D-01, D-04 und D-05 bleibt das ohne Folgen, denn sie entscheiden sich am Artefakt, indem Unterlage, Modell und Registerkarte gegeneinander gehalten werden. D-02 und D-03 richten sich auf die Wirkung der Unterlage bei einem fremden Leser und sind auf diesem Weg nicht zu belegen. Das Ergebnis ist mit dieser Einschränkung in @sec:testdurchfuehrung festgehalten.

/* Claude: Abschnitt nach dem mit dem Autor abgestimmten Konzept ausformuliert
   und bewusst knapp gehalten. Die beiden urspruenglichen #kommentar-Bloecke sind
   damit abgearbeitet.

   Nicht aufgenommen sind die Referenzmittel und Lastszenarien als eigene
   Beschreibung. Sie stehen bereits in @sec:testaufbau (zwei Wasserkocher, rund
   18 A, dort ausdruecklich T-04 und T-06 zugeordnet) und in @tab:werkzeuge.
   Hier steht nur die Zuordnung Pruefmittel zu Testfall, nicht deren erneute
   Beschreibung. Ebenso sind die Nachweisarten und die Grenzen der Pruefung nach
   der Vorgabe des Autors ausgelassen.

   Neu ist die Festlegung des Ausgangszustands. Sie ist noetig, weil die
   Geraeteparametrierung keine Konstante des Aufbaus ist, sondern von der Arbeit
   selbst veraendert wurde. @sec:geraetekonfiguration beschreibt den
   eingerichteten Zustand, T-14 verlangt den Auslieferungszustand. Ohne diese
   Festlegung waeren T-14 und der Befund zum Fernschalten nicht nachvollziehbar.

   Der Abschnitt zur Reihenfolge der Testfaelle ist vom Autor entfernt worden,
   da er den Platz nicht rechtfertigt. Die Gruppierung der Testfaelle traegt
   seither @sec:testdurchfuehrung selbst.

   Die durchsehende Person ist nach Entscheidung des Autors nicht benannt und
   ihr Ergebnis als unproblematisch vorausgesetzt. Der offene Punkt aus
   @sec:modelldoku, ob die Unterlage in den Anhang oder als Beilage geht, wirkt
   auf den Abschnitt "Ausgangszustand" zurueck, sobald er entschieden ist. */
