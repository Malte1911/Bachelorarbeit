#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Durchführung und Ergebnisse der Testfälle<sec:testdurchfuehrung>

/* Anmerkung des Autors, erledigt: "Durchfuehrung und Ergebnis je Testfall
   gemeinsam, sonst wird jeder Testfall zweimal beschrieben. Sinnvoll ist eine
   Gliederung nach Testgruppen statt streng nach Nummer. Belege wie
   Bildschirmabzuege und Messprotokolle gehoeren in den Anhang." */

Die Darstellung folgt Gruppen zusammengehöriger Testfälle und nicht der Nummerierung, da mehrere Testfälle aufeinander aufbauen. Durchführung und Ergebnis stehen dabei beieinander. Das jeweilige Vorgehen und das erwartete Ergebnis sind mit @tab:testfaelle festgelegt und werden hier nicht wiederholt, ebenso wenig die Bedingungen der Prüfung nach @sec:pruefablauf. Beobachtungen, die keine Eigenschaft des Datenmodells sind, sind @sec:befunde vorbehalten, der Abgleich mit dem Anforderungskatalog @sec:anforderungsabgleich.


==== Import und Instanzbildung

T-01 ist erfüllt. Beide Typbeschreibungen werden in der Fassung nach @sec:uebernahme ohne Fehlermeldung eingelesen, und die Objekttypen erscheinen mit ihren Eigenschaften in der Applikationssicht. Da die Prüfung an dem in @tab:werkzeuge genannten Plattformstand erfolgt, ist damit zugleich die nach @sec:nfa allein am Testaufbau nachweisbare Verträglichkeit belegt. Nicht sämtliche Eigenschaften kommen dabei in der vorgesehenen Form an, was der Abschnitt zu den Alarmen ausführt.

T-02 ist im Rahmen des Möglichen erfüllt. Aus derselben, unveränderten Typbeschreibung entstehen mehrere #acro("ECPD")-Instanzen, die jeweils über ihren Unit Identifier adressiert werden, und aus der Typbeschreibung des Powercenters entsteht die Instanz des vorhandenen Geräts. Da am Aufbau nach RB-04 nur ein einzelnes #acro("ECPD") zur Verfügung steht, liefern die übrigen Instanzen keine Werte. Nachgewiesen ist damit die mehrfache Verwendbarkeit der Typbeschreibung, nicht das Verhalten eines vollständig bestückten Strangs.

Damit ist FA-01 für beide Gerätetypen belegt. Die Prüfung des Powercenters endet an dieser Stelle, wie @sec:pruefablauf festhält. Beobachtet wurde dabei, dass die abgebildeten Werte in der vorgesehenen Form ankommen, ohne dass dies einen eigenen Testfall trägt.


==== Wirkung der Geräteparametrierung

T-14 ist nur eingeschränkt nachweisbar. Der betroffene Alarm lässt sich am Aufbau nicht auslösen, sodass sich der Unterschied zwischen dem Auslieferungszustand und dem aktivierten Zustand nicht an einer anstehenden Meldung zeigen lässt. Erkennbar ist er allein daran, dass der Zustand nach der Aktivierung in SENTRON Powerconfig im Sammelregister vertreten ist. Die Aussage von NFA-06 bleibt davon unberührt, denn ein Datenmodell kann diesen Unterschied ohnehin nicht sichtbar machen, weshalb die vorausgesetzte Parametrierung Teil der Unterlage nach @sec:modelldoku ist.

// #kommentar[Gegenzulesen, ob die Beobachtung so zutrifft. Gemeint ist, dass die Aktivierung am Registerwert erkennbar war, ein tatsächliches Auslösen des Alarms am Aufbau jedoch nicht herbeizuführen ist.]


==== Messwerte und ihre Darstellung

T-03 ist im zwingenden Teil erfüllt. Das am Modbus-Treiber eingestellte Intervall von $1space.thin"s"$ wirkt, eine am Gerät hervorgerufene Änderung erscheint innerhalb dieser Zeitspanne in Desigo CC, sobald sie am Powercenter vorliegt. Der zweite Schritt des Testfalls bestätigt zugleich die Gegenprobe: Ein für ein einzelnes Gerät oder für eine Gruppe von Datenpunkten abweichendes Intervall lässt sich nicht einstellen, sodass der als _soll_ formulierte Teil von FA-02 offenbleibt. Diese Einschränkung ist eine Eigenschaft des Treibers und in @sec:befunde eingeordnet.

Die beobachtete Verzögerung ist dabei nicht dem Intervall allein zuzurechnen. Das Endgerät überträgt seine Werte nach @sec:ecpd_konnektivitaet in nach Größe gestaffelten Abständen von $2space.thin"s"$, $10space.thin"s"$ und $60space.thin"s"$ über die Funkstrecke, sodass die Abfrage in Desigo CC nur den Weg vom Powercenter zur Leitwarte bestimmt. Für Werte des langsamsten Rasters, etwa Spannung, Netzfrequenz oder Energie, liegt die Zeit bis zur Anzeige entsprechend über dem eingestellten Intervall, ohne dass darin ein Mangel der Anbindung läge. Das Ergebnis von T-03 gilt deshalb für den Weg zwischen Powercenter und Desigo CC und nicht für die Strecke vom Endgerät bis zur Anzeige.

#kommentar[Bitte den Datenpunkt nennen, an dem die Aktualisierung beobachtet wurde, und ob die Änderung am Gerät oder über SENTRON Powerconfig hervorgerufen wurde. Der Absatz trennt bewusst die Abfrage von der Funkstrecke. Welches der drei Sendraster für den geprüften Wert galt, entscheidet darüber, ob die Beobachtung die $1space.thin"s"$ tatsächlich belegt.]

T-04 ist erfüllt. Die Messwerte folgen der aufgeschalteten Last in Betrag und Richtung und stimmen der Größenordnung nach mit der Referenz überein. Eine Verwechslung von Kanälen, Vorzeichen oder Skalierungen ist nicht aufgetreten.

T-05 ist erfüllt. Beschriftung, Einheit, Skalierung und Vorzeichen stimmen für die geprüften Datenpunkte mit der Registerkarte und dem angezeigten Wert überein, mehrwortige Zeichenketten werden in der richtigen Wortreihenfolge gelesen. Eine Beobachtung betrifft nicht die Richtigkeit, sondern die Erreichbarkeit eines Datenpunkts. Die Seriennummer erscheint nach @sec:uebernahme nur in der Messwertansicht und nicht in der erweiterten Bedienung, sodass die Zuordnung zu einer Gruppe darüber entscheidet, wo ein Wert überhaupt auffindbar ist.


==== Alarme und Meldungsverhalten

T-06 ist nicht erfüllt. Die Überlast nach @sec:testaufbau lässt das #acro("ECPD") innerhalb einer knappen Minute in den Standby-Zustand übergehen und setzt im Sammelregister das Bit 5, den Alarm 1 Überstrom nach @tab:apx_ecpd_alarme. Weitere Bits bleiben ungesetzt, insbesondere das Bit 13 für den ausgelösten Schalter, denn im Standby bleibt der mechanische Trennkontakt nach @sec:ecpd_geraet geschlossen und allein der Leistungshalbleiter sperrt. Der Zustand erreicht Desigo CC, jedoch nicht als einzelner, benannter Datenpunkt. Da sich das Sammelregister nach @sec:umsetzung weder über einen Subindex noch über einen #acro("BLOB") in eine Typbeschreibung überführen lässt, die Desigo CC annimmt, ist es als eine vorzeichenlose Ganzzahl abgebildet. Der ausgelöste Zustand ist damit als Änderung dieses einen Wertes beobachtbar und über @tab:apx_ecpd_alarme einer Meldung zuzuordnen, steht in Desigo CC aber nicht als eigener Zustand zur Auswertung bereit. Das erwartete Ergebnis aus @tab:testfaelle wird somit nicht erreicht.

#kommentar[Zwei Angaben sind hier zu schärfen. Die Zeit bis zum Übergang in den Standby ist geschätzt und lag zwischen etwa 30 und 60 Sekunden, gemessen wurde sie nicht. Und der Schalterstatus in Register 3110 unterscheidet den planmäßigen Standby vom störungsbedingten. Welchen der beiden Werte das Gerät nach der Überlast führte, gehört an diese Stelle, da genau diese Unterscheidung nach @sec:datenpunkte der Grund für die Aufnahme des Registers ist.]

T-07 ist nicht durchführbar. Der Testfall setzt eine eingerichtete Alarmkonfiguration voraus, die sich aus dem Datenmodell heraus nicht anlegen lässt und die auf einen Datenpunkt je Zustand angewiesen wäre. Solange die Zerlegung des Sammelregisters nicht trägt, fehlt dieser Konfiguration die Grundlage. Die in @sec:fa getroffene Feststellung, dass FA-04 und FA-05 erst im Zusammenwirken von Modell und Projektierung erfüllbar sind, bestätigt sich hier in verschärfter Form.


==== Kommandos

T-08 ist nach der Freischaltung des Fernschaltens erfüllt. Der Befehl wird angenommen, die Ausführung ist über Register 3113 und der erreichte Schaltzustand über Register 3110 getrennt erkennbar, und ein weiterer Befehl ist nach dem Rücksetzen möglich. Bis zu dieser Freischaltung wies das Gerät jeden Schaltbefehl zurück. Der Vorgang ist als Befund in @sec:befunde ausgeführt, da seine Ursache außerhalb des Datenmodells liegt. Eine Einschränkung betrifft die Bedienung. Als digitaler Ausgang ausgeführt sendet die Schaltfläche nach @sec:uebernahme stets den Wert eins, weshalb beide wertabhängigen Kommandos als schreibende Werte umgesetzt und über die erweiterte Bedienung bedient werden.

T-09 ist erfüllt. Der Gerätetest und der #acro("RCD")-Test lassen sich als Kommando aus Desigo CC anstoßen, und ihre Ergebnisse stehen dort als eigene Datenpunkte zur Auswertung bereit. Die wiederkehrende Prüfung nach #acro("DGUV") Vorschrift 3 lässt sich damit unterstützen und dokumentieren, jedoch nicht allein aus der Leitwarte abwickeln, da sie nach @sec:stakeholder die Beurteilung durch eine befähigte Person voraussetzt und diese Beurteilung kein Vorgang ist, den ein Gerät selbsttätig ausführt. Auch in der Praxis wird der Nachweis daher nicht über die Leitwarte allein geführt werden. Der Testfall prüft nach der Anpassung in @sec:testuebersicht genau diesen Beitrag des Modells und nicht mehr die Abwicklung der Prüfung als Ganzes.


==== Verhalten im Betrieb und bei Ausfall

T-10 ist erfüllt. Eine Parametrierung über SENTRON Powerconfig während der laufenden zyklischen Abfrage wird angenommen, ohne dass die Abfrage abbricht oder der Zugriff abgewiesen wird. Beide Werkzeuge bestehen damit nebeneinander, worauf die in @sec:konzept beschriebene Arbeitsteilung angewiesen ist.

T-11 ist teilweise erfüllt, und die beiden geprüften Fehlerbilder verhalten sich unterschiedlich. Die Unterbrechung der Funkstrecke zwischen #acro("ECPD") und Powercenter führt zu keiner Meldung in Desigo CC. Sie ist allein am Verbindungszustand des betroffenen Endgeräts ablesbar, dessen Auswertung dieselbe Alarmkonfiguration voraussetzt, die schon T-07 fehlt. Die Unterbrechung der Modbus-Verbindung zwischen Desigo CC und dem Powercenter löst dagegen einen Alarm aus, den die Plattform für die Kommunikation ihrer Subsysteme selbst führt und der ohne Zutun des Datenmodells entsteht. Der schwerwiegendere der beiden Fälle wird somit sicher gemeldet, der Ausfall eines einzelnen Endgeräts nicht.

Die zweite Forderung von FA-10 ist dagegen erfüllt. Fällt die Verbindung aus, kennzeichnet Desigo CC die betroffenen Datenpunkte mit dem Kürzel „\#COM" und gibt sie als kommunikationsgestört aus, statt einen letzten oder auf null gesetzten Wert als gültig darzustellen. Eine Verwechslung eines ausgefallenen Abgangs mit einem stromlosen ist damit ausgeschlossen.

// #kommentar[Gegenzulesen, ob diese Kennzeichnung auch bei der unterbrochenen Funkstrecke auftritt oder nur beim Ausfall der Modbus-Verbindung. Im ersten Fall ist der Ausfall eines Endgeräts immerhin erkennbar, wenn auch ohne Meldung.]


==== Änderbarkeit des Modells

T-12 ist erfüllt, jedoch nicht ohne Vorbehalt. Ein Datenpunkt lässt sich im #acro("PDE") ergänzen und ein weiterer entfernen wie jede andere Bearbeitung der Typbeschreibung, die geänderte Fassung wird erneut eingelesen, und eine Neuerstellung des Modells ist dafür nicht erforderlich. Der Objekttyp führt anschließend den ergänzten Datenpunkt und nicht mehr den entfernten, die übrigen Eigenschaften bleiben unverändert, und die vor der Änderung angelegten Instanzen liefern weiterhin Werte. Damit sind sämtliche Teile des erwarteten Ergebnisses aus @tab:testfaelle beobachtet. Der Vorbehalt betrifft das Werkzeug. Beim Entfernen einzelner Eigenschaften wuchs die Typbeschreibung mehrfach sprunghaft an, in dem in @sec:umsetzung beschriebenen Fall von 22 auf 150 Megabyte, bis der #acro("PDE") sie nicht mehr öffnen konnte. Das Verhalten ließ sich weder verlässlich hervorrufen noch auf eine Ursache zurückführen und trat bei gleichartigen Änderungen nicht durchgängig auf. NFA-03 ist damit erfüllt, solange das Werkzeug mitspielt. Die Fortschreibbarkeit hängt an dessen Beständigkeit und nicht allein an der Gestalt des Modells, was für die Arbeitsweise bedeutet, Zwischenstände zu sichern.


==== Durchsicht der Dokumentation

T-13 ist eingeschränkt nachweisbar. Von den Kriterien aus @tab:doku_kriterien sind D-01, D-04 und D-05 erfüllt. Jeder Datenpunkt des Modells ist in der Aufstellung mit Register, Datentyp, Einheit und Bedeutung wiederzufinden, die vorausgesetzte Geräteparametrierung ist vollständig benannt, und die Grenzen der Lösung stehen in der Unterlage, einschließlich der nicht zerlegbaren Alarme. Diese drei Kriterien entscheiden sich am Artefakt und sind von der Form der Durchsicht unabhängig.

D-02 und D-03 bleiben dagegen offen. Die Durchsicht hat nach @sec:pruefablauf der Verfasser selbst vorgenommen, sodass nicht belegt ist, ob eine fremde sachkundige Person die Integration allein anhand der Unterlage durchführen kann. Für die Annahme spricht, dass der Import einer Typbeschreibung in Desigo CC demselben Weg folgt wie bei jedem anderen fremden Objektmodell und die Unterlage keinen Sonderweg beschreibt. Ein Beleg ist das nicht. Er wäre erst an einer Integration durch Dritte zu führen, worauf @sec:anforderungsabgleich für NFA-02 zurückkommt.


==== Übersicht der Ergebnisse

@tab:testergebnisse fasst die Ergebnisse zusammen. Die Zuordnung zu den Anforderungen ist dabei nicht eins zu eins, weshalb der Abgleich in @sec:anforderungsabgleich gesondert erfolgt.

#figure(
  table(
    columns: (5em, 9em, 1fr),
    inset: 6pt,
    align: (left + horizon, left + horizon, left),
    table.header(
      [*Testfall*], [*Ergebnis*], [*Einschränkung*],
    ),
    [T-01], [erfüllt],
    [Import und Objekttyp ohne Fehler, einzelne Eigenschaften jedoch nicht in der vorgesehenen Form],

    [T-02], [erfüllt],
    [nur ein reales #acro("ECPD") am Aufbau (RB-04), Aussage auf die Wiederverwendbarkeit begrenzt],

    [T-03], [erfüllt],
    [Intervall nur für alle Datenpunkte gemeinsam einstellbar],

    [T-04], [erfüllt],
    [Plausibilität geprüft, keine Aussage zur Messgenauigkeit],

    [T-05], [erfüllt],
    [Seriennummer nur in einer der beiden Ansichten erreichbar],

    [T-06], [nicht erfüllt],
    [Zustände nur als Inhalt des Sammelregisters, nicht als einzelne Datenpunkte],

    [T-07], [nicht durchführbar],
    [Alarmkonfiguration ohne einzelne Zustände nicht einrichtbar],

    [T-08], [erfüllt],
    [erst nach der Freischaltung über SENTRON Powerconfig, Bedienung über die erweiterte Bedienung],

    [T-09], [erfüllt],
    [Anstoß und Auslesen beider Tests bestätigt; die Beurteilung der wiederkehrenden Prüfung bleibt bei der befähigten Person],

    [T-10], [erfüllt],
    [--],

    [T-11], [teilweise erfüllt],
    [Ausfall der Modbus-Verbindung gemeldet, Ausfall der Funkstrecke ohne Meldung, Werte als gestört gekennzeichnet],

    [T-12], [erfüllt],
    [Änderung im Modell möglich und Instanzen weiter verwendbar, sprunghaftes Wachstum der Datei beim Löschen von Eigenschaften ohne erkennbare Ursache],

    [T-13], [eingeschränkt nachweisbar],
    [D-01, D-04 und D-05 am Artefakt bestätigt, D-02 und D-03 mangels unabhängiger Durchsicht offen],

    [T-14], [eingeschränkt nachweisbar],
    [Aktivierung nur am Registerwert erkennbar, Alarm am Aufbau nicht auslösbar],
  ),
  caption: [Ergebnisse der Testfälle aus @tab:testfaelle]
)<tab:testergebnisse>

/* Claude: Abschnitt nach dem abgestimmten Konzept ausformuliert, Gliederung nach
   Testgruppen. Die Tabelle zur Pruefreihenfolge hat der Autor aus 610 entfernt,
   weil sie den Platz nicht rechtfertigt. 620 traegt die Gruppierung deshalb
   selbst und verweist nicht darauf.

   Die Ergebnisse zu T-04, T-05, T-09, T-12, T-13 und T-14 stammen aus der
   Auskunft des Autors, ebenso die beiden Fehlerbilder bei T-11. T-01, T-02,
   T-03, T-06, T-07 und T-08 stuetzen sich auf @sec:uebernahme und
   @sec:umsetzung.

   Offen ist allein die Lesart zu T-14, dort als #kommentar markiert. Zu T-04
   fehlen weiterhin die abgelesenen Zahlenwerte; sie sind nicht als Kommentar
   vermerkt, waeren als Beleg im Anhang aber die staerkere Fassung.

   Bewusst nicht aufgenommen: Erfuellungsaussagen zu einzelnen FA und NFA (gehoert
   nach @sec:anforderungsabgleich), die Ursache des zurueckgewiesenen
   Schreibzugriffs (@sec:befunde) und die Belege selbst (Anhang). */
