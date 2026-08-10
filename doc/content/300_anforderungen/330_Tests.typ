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
    [Datenpunkte verschiedenen Abfragegruppen zuordnen und einen Wert am Gerät verändern.],
    [Der Wert wird innerhalb des für seine Gruppe eingestellten Intervalls nachgeführt; Gruppen mit unterschiedlichem Intervall aktualisieren nachweislich unterschiedlich schnell.],
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
    [Am Gerät nacheinander verschiedene Alarmzustände auslösen, unter anderem durch Überlast und durch Auslösen der #acro("RCD")-Funktion.],
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
    [Eine Prüfung nach #acro("DGUV") aus Desigo CC anstoßen und das Ergebnis auswerten.],
    [Die Prüfung wird am Gerät ausgeführt, das Ergebnis erscheint in Desigo CC und wird dort mit Zeitstempel dokumentiert.],
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
    [Einen Datenpunkt im Modell ergänzen, einen weiteren entfernen und die geänderte Typbeschreibung erneut importieren.],
    [Die Änderung ist ohne Neuerstellung des Modells möglich; bestehende Instanzen bleiben verwendbar oder der erforderliche Nachführungsaufwand ist benannt.],
    [NFA-03],

    [T-13],
    [Die Dokumentation und die Anleitung anhand festgelegter Kriterien durchsehen lassen.],
    [Ein sachkundiger Dritter kann die Integration allein anhand der Anleitung nachvollziehen; beide Adressatenkreise finden die für sie erforderlichen Schritte.],
    [NFA-01, NFA-02],

    [T-14],
    [Einen ab Werk deaktivierten Alarm zunächst im Auslieferungszustand und anschließend nach seiner Aktivierung beobachten.],
    [Im Auslieferungszustand bleibt der Datenpunkt ohne Aussage; nach der in der Lösung benannten Parametrierung liefert er den erwarteten Wert.],
    [NFA-06],
  ),
  caption: [Testfälle und ihre Zuordnung zu den Anforderungen aus @tab:fa und @tab:nfa]
)<tab:testfaelle>


=== Anmerkungen zu einzelnen Testfällen<sec:testanmerkungen>

Mehrere Testfälle verdienen eine Erläuterung, weil ihr Ergebnis nicht allein von der Güte des Datenmodells abhängt.

T-02 ist durch den Testaufbau begrenzt. Für die Validierung steht nur ein einzelnes #acro("ECPD") zur Verfügung (RB-04). Der Testfall kann daher nachweisen, dass sich aus einer Typbeschreibung mehrere Instanzen mit unterschiedlichem Unit Identifier anlegen lassen, nicht aber, dass ein voll bestückter Strang im Betrieb trägt. Instanzen ohne zugehöriges Gerät liefern keine Werte; ihr Nutzen für den Nachweis beschränkt sich auf die Wiederverwendbarkeit der Typbeschreibung. Die Aussage zu NFA-05 bleibt insoweit auf das Anlegen beschränkt und ist im Validierungsteil entsprechend zu kennzeichnen.

T-04 prüft die Plausibilität. Die Genauigkeit der vom #acro("ECPD") erfassten Größen ist mit den verfügbaren Mitteln nicht nachweisbar und wäre auch keine Eigenschaft des Datenmodells, sondern des Geräts. Geprüft wird daher, ob der richtige Wert an der richtigen Stelle ankommt. Die übertragenen Werte sollen dem tatsächlichen Betriebszustand entsprechen, der aufgeschalteten Last folgen und keine Verwechslung von Kanälen, Vorzeichen oder Skalierungen erkennen lassen. Eine Abweichung gegenüber der Referenz innerhalb der Gerätetoleranz ist unerheblich.

T-06 und T-07 prüfen unterschiedliche Artefakte. Das Objektmodell kann die Zustände des Geräts nur bereitstellen, ob daraus eine Meldung wird, entscheidet die Alarmkonfiguration in Desigo CC (siehe @sec:fa). T-06 prüft daher allein, ob die einzelnen Zustände richtig und vollständig in Desigo CC ankommen und dort ausgewertet werden können. Erst T-07 prüft das Verhalten der daraus gebildeten Meldung und setzt eine für den Testaufbau eingerichtete Alarmkonfiguration voraus, die selbst nicht Teil der Integrationsvorlage ist.

T-06 und T-14 sind voneinander abhängig. Ein Alarm, der ab Werk deaktiviert ist, liefert dauerhaft den Wert null (siehe @sec:registerraum). Wird T-06 im Auslieferungszustand der Geräte durchgeführt, schlägt er für einen Teil der Alarme zwangsläufig fehl, ohne dass dies etwas über das Modell aussagt. T-14 ist daher vor T-06 durchzuführen und dessen Ergebnis bei der Bewertung zu berücksichtigen.

#kommentar("Das hier wird noch aktualisiert sobald das funktioniert")

T-08 steht unter dem in @sec:anforderungsvorbehalte genannten Vorbehalt. Der Schreibzugriff für das elektronische Schalten wird am Testaufbau derzeit mit einer Ausnahmemeldung zurückgewiesen. Der Testfall ist dennoch aufzunehmen und durchzuführen: Sein Ergebnis ist unabhängig davon verwertbar, da es entweder die Erfüllung von FA-06 belegt oder die Beobachtung bestätigt und damit selbst ein Ergebnis der Arbeit darstellt.

T-11 prüft zwei verschiedene Fehlerbilder. Der Ausfall eines Endgeräts wird über den Verbindungsstatus sichtbar, während der Ausfall des Powercenters die Modbus-Verbindung selbst betrifft und vom Treiber der Zielplattform erkannt wird. Beide Fälle müssen in der Leitwarte unterscheidbar bleiben, weil sie zu unterschiedlichen Maßnahmen führen.

T-13 ist der einzige Testfall ohne objektives Kriterium. Seine Aussagekraft hängt vollständig davon ab, dass die Durchsicht von einer Person vorgenommen wird, die nicht an der Entwicklung beteiligt war, und dass die Kriterien vor der Durchsicht festliegen. Beides ist im Validierungsteil festzuhalten.


=== Abdeckung und Grenzen der Prüfung<sec:testabdeckung>

Jede funktionale und jede nichtfunktionale Anforderung ist mindestens einem Testfall zugeordnet; FA-01, FA-03 und FA-04 werden von jeweils zwei Testfällen abgedeckt, weil sie unterschiedliche Nachweisarten erfordern. Die Randbedingungen aus @tab:rb sind nicht Gegenstand von Testfällen. Sie beschreiben keine geforderte Eigenschaft der Lösung, sondern die Voraussetzungen ihrer Entstehung und ihres Betriebs; ihre Einhaltung ist zu dokumentieren, nicht zu prüfen.

Drei Grenzen der Prüfung sind bereits an dieser Stelle zu benennen, weil sie die Reichweite der späteren Aussagen bestimmen. Erstens erfolgt die Validierung an einem einzelnen Testaufbau mit einem Powercenter 1100 (RB-04); Aussagen zum Verhalten bei voller Bestückung mit 24 Endgeräten oder über mehrere Stränge hinweg lassen sich daraus nicht messen, sondern nur rechnerisch abschätzen. Zweitens ist die Gleichwertigkeit des Powercenters 2000 nach RB-02 vorausgesetzt und wird nicht geprüft. Die vorhandene Dokumentation zur Registertabelle zeigt die gleichen Features/Werte für Modbus für die beiden Varianten auf, weswegen von einer Interoperabilität der beiden Produktvarianten ausgegangen wird. Drittens prüft kein Testfall die Schutzfunktion der Geräte selbst; sie ist nach @sec:systemanalyse nicht Gegenstand der Arbeit und wäre mit den hier verwendeten Mitteln auch nicht sinnvoll zu beurteilen.
