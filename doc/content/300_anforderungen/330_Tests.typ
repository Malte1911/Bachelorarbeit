#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Testfälle<sec:testfaelle>

Eine Anforderung ist nur dann brauchbar, wenn sich feststellen lässt, ob sie erfüllt ist. Der vorliegende Abschnitt ordnet den Anforderungen aus @sec:anforderungen daher Testfälle zu und legt für jeden fest, woran die Erfüllung erkannt wird. Die Testfälle werden hier definiert, nicht durchgeführt; die Strategie ihrer Ausführung, die Durchführung selbst und die Ergebnisse sind Gegenstand des Validierungsteils. Die Trennung ist beabsichtigt: Die Prüfkriterien entstehen aus den Anforderungen und damit vor der Entwicklung des Datenmodells, nicht nachträglich aus dem, was sich am fertigen Modell zeigen lässt.


=== Arten des Nachweises<sec:nachweisarten>

Die Anforderungen richten sich, wie in @sec:anforderungskatalog dargelegt, nicht sämtlich an dasselbe Artefakt. Entsprechend unterscheiden sich die Nachweise in ihrer Art.

Der Nachweis am Testaufbau ist die Regel. Er besteht darin, an der realen Anlage einen Zustand herbeizuführen und in Desigo CC zu beobachten, was dort ankommt. Er ist die einzige Nachweisform, die auch die Geräteseite und die Übertragungsstrecke einschließt, und damit die einzige, die Fehler in der Registerkarte oder unerwartetes Geräteverhalten aufdecken kann.

Der Nachweis am Artefakt prüft das Datenmodell und die zugehörigen Dateien ohne laufende Anlage, etwa den Import einer Typbeschreibung oder die Vollständigkeit der Eigenschaften eines Objekttyps. Er ist wiederholbar und unabhängig vom Zustand der Geräte, sagt aber nichts über die tatsächlich übertragenen Werte aus.

Der Nachweis durch Begutachtung betrifft jene Anforderungen, die sich einer Messung entziehen, insbesondere die Dokumentation und die Anleitung. Er besteht in einer Durchsicht anhand vorher festgelegter Kriterien und ist damit die schwächste, für NFA-01 und NFA-02 aber einzig mögliche Form.


=== Übersicht der Testfälle<sec:testuebersicht>

#figure(
  table(
    columns: (auto, 1fr, 1fr, auto),
    inset: 6pt,
    align: (left + horizon, left, left, left + horizon),
    table.header(
      [*ID*], [*Vorgehen*], [*Erwartetes Ergebnis*], [*Anforderung*],
    ),
    [T-01],
    [Die #acro("JSON")-Typbeschreibung in Desigo CC importieren.],
    [Der Import wird ohne Fehlermeldung angenommen; der Objekttyp ist mit allen vorgesehenen Eigenschaften und deren Datentypen, Einheiten und Zustandstexten angelegt.],
    [FA-01, NFA-04],

    [T-02],
    [Aus derselben Typbeschreibung mehrere Instanzen anlegen -- das Powercenter, das vorhandene #acro("ECPD") sowie weitere #acro("ECPD")-Instanzen mit abweichendem Unit Identifier.],
    [Jede Instanz wird einzeln unter ihrer Kommunikationsschnittstelle angelegt und ist über ihren Unit Identifier eindeutig adressiert; die Typbeschreibung ist dabei unverändert mehrfach verwendbar.],
    [FA-01, NFA-05],

    [T-03],
    [Das Abfrageintervall am Modbus-Treiber einstellen, einen Wert am Gerät verändern und die Zeit messen, bis Desigo CC den neuen Wert anzeigt. Anschließend prüfen, ob sich für ein einzelnes Gerät oder für eine Gruppe von Datenpunkten ein davon abweichendes Intervall einstellen lässt.],

    [Desigo CC zeigt den geänderten Wert spätestens nach Ablauf des eingestellten Intervalls an, gerechnet von dem Zeitpunkt an, zu dem der Wert am Powercenter bereitsteht. Davor liegt die Zeit, die das Endgerät nach @sec:ecpd_konnektivitaet für die Übertragung über die Funkstrecke benötigt. Ein je Gerät oder je Datenpunktgruppe abweichendes Intervall steht nicht zur Verfügung, die Einstellung wirkt auf alle Datenpunkte aller angebundenen Geräte gleichermaßen.],

    [FA-02],

    [T-04],
    [Die angezeigten Messwerte mit einer unabhängigen Referenz vergleichen, im Betriebspunkt und bei aufgeschalteter Last.],
    [Alle vorgesehenen Messwerte sind vorhanden und plausibel: Sie folgen der aufgeschalteten Last in Betrag und Richtung und stimmen der Größenordnung nach mit der Referenz überein.],
    [FA-03],

    [T-05],
    [Beschriftung, Einheit, Skalierung und Vorzeichen jedes Datenpunkts gegen die Registerkarte und den angezeigten Wert prüfen.],
    [Kein Datenpunkt ist falsch benannt, falsch skaliert oder ohne Einheit dargestellt; mehrwortige Werte werden vollständig und in der richtigen Wortreihenfolge gelesen.],
    [FA-03],

    [T-06],
    [Am Gerät nacheinander diejenigen Alarmzustände auslösen, die sich am Testaufbau gefahrlos herbeiführen lassen, insbesondere durch Überlast.],
    [Jeder ausgelöste Zustand ist in Desigo CC als eigener, richtig benannter Datenpunkt sichtbar und steht dort zur Auswertung als Meldung bereit; benachbarte Zustände bleiben unverändert.],
    [FA-04],

    [T-07],
    [Bei eingerichteter Alarmkonfiguration einen anstehenden Alarm bearbeiten und nach Behebung quittieren.],
    [Der Alarm ist der vorgesehenen Kategorie zugeordnet, verhält sich in Anzeige und Bedienung wie Alarme anderer Gewerke und lässt sich quittieren; der Zustand am Gerät wird nachgeführt.],
    [FA-04, FA-05],

    [T-08],
    [Aus Desigo CC einen Schaltbefehl an das #acro("ECPD") senden und den Ablauf über das Statusregister verfolgen.],
    [Der Befehl wird angenommen, der Fortschritt ist über den Status der verzögerten Quittierung erkennbar, der erreichte Schaltzustand wird getrennt zurückgemeldet und ein weiterer Befehl ist nach dem Rücksetzen möglich.],
    [FA-06],

    [T-09],
    [Den Gerätetest und den #acro("RCD")-Test aus Desigo CC anstoßen und das Ergebnis auswerten.],
    [Beide Tests werden am Gerät ausgeführt, ihr Ergebnis erscheint in Desigo CC als eigener Datenpunkt und steht dort für den Nachweis der wiederkehrenden Prüfung zur Verfügung.],
    [FA-08],

    [T-10],
    [Während des laufenden Betriebs eine Parametrierung über SENTRON Powerconfig vornehmen.],
    [Beide Zugriffe bestehen nebeneinander; weder bricht die zyklische Abfrage ab noch wird die Parametrierung abgewiesen.],
    [FA-09],

    [T-11],
    [Die Verbindung zu einem Endgerät und anschließend zum Powercenter unterbrechen.],
    [In beiden Fällen wird ein Alarm ausgelöst; die betroffenen Messwerte werden als ungültig gekennzeichnet und nicht als Wert null dargestellt.],
    [FA-10],

    [T-12],
    [Einen Datenpunkt im Modell ergänzen, einen weiteren entfernen, die geänderte Typbeschreibung erneut importieren und die vor der Änderung angelegten Instanzen prüfen.],
    [Die geänderte Typbeschreibung entsteht durch Bearbeitung der bestehenden Datei und nicht durch Neuerstellung. Nach dem Import führt der Objekttyp den ergänzten Datenpunkt und nicht mehr den entfernten. Die übrigen Eigenschaften stimmen in Bezeichnung, Datentyp, Einheit und Registeradresse mit dem Stand vor der Änderung überein, und die zuvor angelegten Instanzen liefern weiterhin Werte.],
    [NFA-03],

    [T-13],
    [Die Unterlage anhand der Kriterien D-01 bis D-05 aus @tab:doku_kriterien durchsehen und das Ergebnis je Kriterium festhalten.],
    [Jedes der fünf Kriterien ist erfüllt. Eine Abweichung wird dem Kriterium zugeordnet, an dem sie auftritt.],
    [NFA-01, NFA-02],

    [T-14],
    [Einen ab Werk deaktivierten Alarm zunächst im Auslieferungszustand und anschließend nach seiner Aktivierung beobachten.],
    [Im Auslieferungszustand bleibt der Datenpunkt ohne Aussage; nach der in der Lösung benannten Parametrierung liefert er den erwarteten Wert.],
    [NFA-06],
  ),
  caption: [Testfälle und ihre Zuordnung zu den Anforderungen aus @tab:fa und @tab:nfa]
)<tab:testfaelle>

=== Kriterien der Durchsicht<sec:dokukriterien>

T-13 ist der einzige Testfall, dessen Nachweis nicht an einer Beobachtung am Aufbau hängt, sondern an einer Durchsicht. Seine Aussagekraft steht und fällt damit, dass die Kriterien vorher feststehen und nicht aus der fertigen Unterlage abgeleitet werden. Sie sind deshalb hier festgelegt, gemeinsam mit dem Testfall und vor der Erstellung der Unterlage, die sich in @sec:modelldoku an ihnen auszurichten hat.

#figure(
  table(
    columns: (7em, 1fr),
    inset: 6pt,
    align: (left + horizon, left),
    table.header(
      [*Kriterium*], [*Erfüllt, wenn*],
    ),
    [D-01],
    [jeder Datenpunkt des Modells in der Referenz mit Register, Datentyp, Einheit und Bedeutung wiederzufinden ist und umgekehrt kein Eintrag der Referenz ohne Entsprechung im Modell bleibt.],

    [D-02],
    [eine sachkundige Person die Integration in Desigo CC allein anhand der Unterlage und ohne Rückfrage an den Verfasser durchführen kann.],

    [D-03],
    [jeder beschriebene Arbeitsschritt erkennbar einem Adressatenkreis zugeordnet ist und beide Kreise die für sie erforderlichen Schritte an einer Stelle finden.],

    [D-04],
    [die vorausgesetzte Geräteparametrierung vollständig benannt ist, einschließlich der Angabe, welcher Datenpunkt ohne sie ohne Aussage bleibt.],

    [D-05],
    [die bekannten Grenzen der Lösung benannt sind und die Unterlage keine Funktion beschreibt, die sich am Testaufbau nicht bestätigt hat.],
  ),
  caption: [Kriterien für die Durchsicht der begleitenden Unterlage nach T-13]
)<tab:doku_kriterien>

#kommentar[Hier Tabelle Overkill? Ich bin grundsätzlich Fan davon, diese Tabellen zu verwenden, das zeigt Struktur aber ich weiß nicht ob es sich lohnt das so oft zu machen]

Die fünf Kriterien unterscheiden sich in dem, was ihre Prüfung voraussetzt. D-01, D-04 und D-05 sind am Artefakt selbst zu entscheiden, indem Unterlage, Modell und Registerkarte gegeneinander gehalten werden. D-02 und D-03 richten sich dagegen auf die Wirkung der Unterlage bei einem Leser und setzen eine an ihrer Erstellung unbeteiligte Person voraus. Welche Form die Durchsicht tatsächlich angenommen hat, hält @sec:pruefablauf fest.


=== Abdeckung und Grenzen der Prüfung<sec:testabdeckung>

Jede funktionale und jede nichtfunktionale Anforderung ist mindestens einem Testfall zugeordnet. FA-01, FA-03 und FA-04 werden von jeweils zwei Testfällen abgedeckt, weil sie unterschiedliche Nachweisarten erfordern. Welcher Testfall am Ende welchen Anwendungsfall trägt und mit welchem Ergebnis, führt @tab:apx_rueckverfolgung im Anhang über die gesamte Kette zusammen. Die Randbedingungen aus @tab:rb sind dagegen nicht Gegenstand von Testfällen. Sie beschreiben die Voraussetzungen der Entstehung und des Betriebs und keine geforderte Eigenschaft der Lösung, weshalb ihre Einhaltung zu dokumentieren und nicht zu prüfen ist.

Zwei Testfälle tragen dabei weniger, als ihre Formulierung nahelegt. T-04 prüft die Plausibilität der Messwerte und nicht deren Genauigkeit, die mit den verfügbaren Mitteln nicht nachweisbar und zudem keine Eigenschaft des Datenmodells wäre. T-13 stützt sich als einziger Testfall auf eine Durchsicht und nicht auf eine Beobachtung. Seine Kriterien stehen mit @tab:doku_kriterien fest, bevor die Unterlage entsteht. Die Unabhängigkeit der durchsehenden Person bleibt daneben eine Bedingung für sich, deren Einlösung @sec:pruefablauf festhält.

Vier Grenzen der Prüfung sind bereits an dieser Stelle zu benennen, weil sie die Reichweite der späteren Aussagen bestimmen. Erstens erfolgt die Validierung an einem einzelnen Testaufbau mit einem Powercenter 1100 (RB-04). Aussagen zum Verhalten bei voller Bestückung mit 24 Endgeräten oder über mehrere Stränge hinweg lassen sich daraus nur rechnerisch abschätzen. Zweitens ist die Gleichwertigkeit des Powercenters 2000 nach RB-02 vorausgesetzt und wird nicht geprüft. Die Registertabelle weist für beide Varianten dieselben Werte aus, weshalb von einer Interoperabilität ausgegangen wird. Drittens prüft kein Testfall die Schutzfunktion der Geräte selbst, die nach @sec:systemanalyse nicht Gegenstand der Arbeit ist und mit den hier verwendeten Mitteln auch nicht sinnvoll zu beurteilen wäre.

Viertens deckt T-06 nicht sämtliche Alarme des #acro("ECPD") ab, sondern nur diejenigen, die sich am Testaufbau gefahrlos herbeiführen lassen. Die Alarmbits des Geräts stehen für sehr unterschiedliche Ursachen, von der Überlast über die Grenzwerte einzelner Messgrößen bis zum Differenzstrom (siehe @tab:registergruppen). Eine Überlast lässt sich durch Aufschalten einer entsprechenden Last erzeugen und ein Verbindungsverlust durch Unterbrechen der Funkstrecke, wobei @sec:testaufbau die Bedingungen festhält, unter denen der Lastversuch am Aufbau vertretbar ist. Ein Fehlerstrom- oder Differenzstromalarm setzt dagegen einen tatsächlichen Strom gegen Erde voraus, der am unter Spannung stehenden Aufbau gezielt herbeizuführen wäre. Das erforderte eine geeignete Prüfeinrichtung und eine entsprechende Absicherung des Arbeitsplatzes und wäre damit ein Aufwand, der außerhalb dessen liegt, was die Prüfung eines Datenmodells rechtfertigt. Hinzu kommt, dass die beiden #acro("RCM")-Alarme ab Werk abgeschaltet sind und vor jeder Beobachtung zunächst zu parametrieren wären, wie T-14 es vorsieht.

Für die Aussagekraft der Prüfung ist diese Lücke von untergeordneter Bedeutung, weil alle Alarme denselben Weg durch das Datenmodell nehmen. Das Gerät führt sämtliche Zustände in einem einzigen Register als Bitfeld (siehe @sec:registerraum). Jeder Alarm wird folglich mit demselben Funktionscode aus demselben Register gelesen und im Objektmodell nach demselben Muster in eine eigene, benannte Eigenschaft zerlegt. Was T-06 nachweist, ist die Tragfähigkeit dieses Musters und nicht die Funktion einer einzelnen Schutzeinrichtung. Ein Alarm, dessen Weg vom Auslösen am Gerät bis zur Anzeige in Desigo CC vollständig beobachtet wurde, belegt dieses Muster bereits. Eine Wiederholung mit weiteren Ursachen prüfte die Schutzfunktion des Geräts, die nach der dritten Grenze nicht Gegenstand der Arbeit ist.

Ein Restrisiko bleibt und ist im Validierungsteil zu benennen. Die Zuordnung der einzelnen Bitpositionen zu den Alarmbezeichnungen stützt sich für die nicht ausgelösten Alarme allein auf die Registerkarte. Eine dort falsch dokumentierte Position fiele beim Test eines anderen Alarms nicht auf, da jeder Alarm nur seine eigene Position belegt. Da die Registerkarte nach @sec:quellenlage nicht ungeprüft als richtig gilt, ist diese Einschränkung bei der Bewertung von FA-04 ausdrücklich zu vermerken.

/* Anmerkung des Autors, erledigt: "Das hier wird noch aktualisiert sobald das
   funktioniert"
   Claude: Der Schaltbefehl funktioniert inzwischen. Der Vorbehalt zu T-08 steht
   in @sec:anforderungsvorbehalte, die Klaerung im Validierungsteil. */

/* Anmerkung des Autors, erledigt:
   "hier bitte nochmal argumentieren dass man nicht einfach Fehlerstrom Alarm
   zum Beispiel testen kann, das aber für die arbeit auch nicht relevant ist.
   ein alarm sollte zum testen ausreichend sein um sicherzustellen dass das
   system grundsätzlich funktioniert mit den alarmen" */

/* Claude: Der frueher eigenstaendige Abschnitt "Anmerkungen zu einzelnen
   Testfaellen" (Label sec:testanmerkungen) ist am 27.08.2026 in diesen
   Abschnitt aufgegangen, um Wiederholungen zu vermeiden. Die Einzelabsaetze zu
   T-02, T-03, T-06/T-07 und T-08 sind entfallen, da dieselben Aussagen in
   @sec:testdurchfuehrung, @sec:befunde und @sec:anforderungsabgleich ein
   zweites Mal stehen; der Absatz zur Reihenfolge von T-06 und T-14 steht
   bereits in @sec:pruefablauf. Erhalten sind T-04 und T-13, auf die
   @sec:modelldoku und @sec:pruefablauf verweisen. Die Verweise auf
   sec:testanmerkungen sind dort auf sec:testabdeckung umgestellt.

   Das Argument zur Alarmabdeckung und der Absatz zum Restrisiko der
   Bitzuordnung sind unveraendert uebernommen. Ein Nachweis an einem einzelnen
   Alarm prueft die uebrigen Bitpositionen nicht mit, und die Registerkarte gilt
   nach @sec:quellenlage nicht ungeprueft als richtig. Falls das zu weit geht,
   ist der letzte Absatz ersatzlos streichbar. */
