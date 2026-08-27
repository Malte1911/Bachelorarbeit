#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Übernahme in Desigo CC<sec:uebernahme>

Mit der Typbeschreibung liegt eine Datei vor, deren Tauglichkeit sich erst auf der Zielseite erweist. Dieser Abschnitt beschreibt, was beim Einlesen aus ihr wird, welche Einstellungen die Zielplattform darüber hinaus verlangt und an welchen Stellen das Ergebnis von dem abweicht, was die Typbeschreibung nahelegt. Die Kommunikationsstrecke ist dabei nach @sec:kommunikationsstrecke bereits eingerichtet und wird hier nur insoweit aufgegriffen, wie die Übernahme sie berührt.

Der Umfang dessen, was hier überhaupt gestaltet werden kann, ist eng gezogen. Was in Desigo CC ankommt, ist auf das begrenzt, was der #acro("PDE") in die Typbeschreibung schreiben kann. Alles Weitere ist Projektierung und fällt damit demjenigen zu, der die Anlage einrichtet.


==== Einrichtung der Zielplattform

Die Anbindung setzt eine Erweiterung voraus, die über den Projektmanager von Desigo CC installiert wird und die Geräte des SENTRON Powermanagers in der Applikationssicht führt. Erst mit ihr steht der Weg offen, über den die Typbeschreibung eingelesen und die Geräte angelegt werden.

Innerhalb des Projekts wird anschließend ein Treiber für das Subsystemnetzwerk angelegt, der die Modbus-Kommunikation verwaltet. An ihm wird das Abfrageintervall auf eine Sekunde gesetzt. Dieser Wert folgt unmittelbar aus der in @tab:modbustreiber beschriebenen Eigenschaft, dass das Intervall für sämtliche Datenpunkte aller angebundenen Geräte gilt. Da alle Register in demselben Takt gelesen werden, bestimmt der am schnellsten benötigte Wert die Einstellung für alle übrigen, und das ist mit dem Schalterzustand ein Datenpunkt der Gruppe des Live-Zustands. Zugleich ist eine Sekunde die Untergrenze, die das Systemhandbuch für die Abfrage eines Geräts empfiehlt @src:sentronsystemhandbuch, sodass sich beide Vorgaben an derselben Stelle treffen.

Beim Anlegen der Geräte ist eine Einstellung erforderlich, die sich aus der Dokumentation nicht ergibt. Für jedes #acro("ECPD") ist die Kommunikation ausdrücklich als Gateway-Kommunikation zu konfigurieren, da der Unit Identifier andernfalls unwirksam bleibt und das Gerät nicht antwortet. Der Grund liegt in der Bauform des Strangs. Das Powercenter ist kein Gerät mit Untergeräten, sondern ein Übersetzer, der die Funkstrecke auf Modbus abbildet und die Endgeräte hinter einer einzigen #acro("IP")-Adresse führt. Dieselbe Unterscheidung findet sich im #acro("PDE") wieder, dessen Online-Modus ein Feld für den Unit Identifier nur dann anbietet, wenn das Gerät als über ein Gateway erreichbar gekennzeichnet ist @src:pdemanual. Ohne diese Kennzeichnung adressiert die Zielplattform stets das Powercenter selbst.

#kommentar[Die genaue Bezeichnung der Einstellung in der Bedienoberfläche ist einzutragen, damit der Schritt nachvollziehbar bleibt. Zu ergänzen ist außerdem, ob die Einstellung je Gerät oder je Schnittstelle vorgenommen wird und ob sie auch für das Powercenter unter dem Unit Identifier 255 erforderlich ist.]


==== Import und Instanzen

Der Import der Typbeschreibung wird angenommen, und der Objekttyp erscheint mit seinen Eigenschaften in der Applikationssicht. Damit ist der in @sec:desigoccmechanik beschriebene Weg über den #acro("PDE") am Testaufbau bestätigt, was nicht selbstverständlich ist, da Desigo CC nach @sec:pde_ziel keine dokumentierte Zielapplikation des Werkzeugs ist. Die Entsprechung der beiden #acro("JSON")-Formate trägt somit für die Datentypen, die beide Seiten unterstützen. Wo sie das nicht tut, endet der Weg, was der Abschnitt zu den Alarmen zeigt.

Die Instanzen entstehen aus derselben Typbeschreibung, indem jeder Instanz ihre Kommunikationsparameter mitgegeben werden. Die Typbeschreibung selbst bleibt dabei unverändert, worin sich die in @sec:konzept getroffene Trennung von Gerätetyp und Geräteinstanz praktisch bestätigt.

Für das Powercenter verläuft der Weg gleich. Auch seine Typbeschreibung wird angenommen, der Objekttyp erscheint in der Applikationssicht, und aus ihm entsteht eine Instanz unter der Kommunikationsschnittstelle des Geräts. Die abgebildeten Werte kommen in der vorgesehenen Form an. Über Import und Instanzbildung hinaus ist die Typbeschreibung des Powercenters nach @sec:pruefablauf nicht geprüft.


==== Darstellung und Bedienung

Die Messwerte erscheinen vollständig und mit den erwarteten Größenordnungen. Eine Beobachtung betrifft jedoch die Frage, an welcher Stelle der Bedienoberfläche ein Datenpunkt auftaucht. Die Seriennummer des Geräts wird in der Messwertansicht geführt, erscheint in der erweiterten Bedienung dagegen nicht. Beide Ansichten treffen damit eine eigene Auswahl aus denselben Eigenschaften, was die in @sec:umsetzung getroffene Gruppenzuordnung im Nachhinein bestätigt. Sie entscheidet nicht allein über die Übersicht, sondern darüber, wo ein Datenpunkt überhaupt erreichbar ist.

#kommentar[Zu klären ist, worauf diese Auswahl beruht, ob also die Gruppe der Eigenschaft, ihr Datentyp oder eine Einstellung der Ansicht darüber entscheidet. Solange das offen ist, bleibt es bei der Beobachtung. Betroffen sind vermutlich sämtliche Zeichenketten und nicht allein die Seriennummer, was am Aufbau leicht nachzusehen ist.]

Deutlicher zeigt sich die Wirkung der Modellierung an den Kommandos. @img:bedienung_digitalausgaenge gibt die Bedienoberfläche in dem Zustand wieder, in dem die beiden schaltbaren Kommandos als digitale Ausgänge angelegt waren. Der Blinkmodus lässt sich darüber bedienen, da er einer positiven Logik folgt und der Wert eins den Blinkmodus einschaltet. Das elektronische Schalten lässt sich so nicht bedienen, weil es dieser Logik gerade nicht folgt. Der Wert null bezeichnet beim #acro("ECPD") den Standby-Zustand, während die Schaltfläche stets den Wert eins sendet. Ein Ausschalten ist auf diesem Weg nicht möglich.

#figure(
  image("../../resources/img/button_no_workey.png", width: 100%, format: "png"),
  caption: [Bedienoberfläche von Desigo CC mit den beiden als digitale Ausgänge angelegten Kommandos. Der Blinkmodus ist bedienbar, das elektronische Schalten nicht, da die Schaltfläche nur den Wert eins sendet],
)<img:bedienung_digitalausgaenge>

Die Ursache liegt im Zusammenspiel beider Werkzeuge. Ein im #acro("PDE") als digitaler Ausgang angelegtes Kommando erscheint in Desigo CC als Schaltfläche, und die Plattform fragt den Zustand des Geräts vor dem Schalten nicht ab. Sie kann deshalb weder den anstehenden Zustand anzeigen noch den jeweils entgegengesetzten Wert senden. Über die erweiterte Bedienung bleibt das Kommando gleichwohl vollständig nutzbar, da sich dort jeder zulässige Wert und damit auch die Null von Hand setzen lässt. Der Mangel betrifft somit die Bedienbarkeit und nicht die Funktion.

#kommentar[Diese Einschätzung geht auf eine Auskunft von Andreas Ulmer zurück. Der vorhandene Eintrag @src:ulmer2026 bezieht sich auf die mobile Anwendung und passt hier nicht. In quellen.bib ist ein zweiter Eintrag mit dem Datum dieser Auskunft anzulegen und an dieser Stelle zu zitieren.]

Aus dieser Beobachtung folgt die Festlegung, beide Kommandos wie die übrigen vier als schreibende Werte auszuführen. Eine Schaltfläche, die vorhanden ist, den Zustand nicht anzeigt und nur in eine Richtung wirkt, ist irreführender als gar keine. Die in @sec:umsetzung beschriebene Zuordnung der sechs Kommandos ist somit nicht am Werkzeug hergeleitet, sondern das Ergebnis dieser Übernahme.


==== Was die Übernahme offenlässt

An dieser Stelle hat sich auch gezeigt, dass die Zerlegung des Alarmregisters nicht trägt. Der Befund ist in @sec:umsetzung ausgeführt, weil er dort eine Festlegung des Modells erzwingt. Für die Übernahme bleibt festzuhalten, dass die Grenze nicht beim Erzeugen der Typbeschreibung sichtbar wird, sondern erst bei ihrem Einlesen.

Die Alarmierung ist damit vollständig Sache der Projektierung. Was an dieser Stelle ergänzt würde, um die Meldungen zum Laufen zu bringen, müsste ein Techniker bei jeder Einrichtung erneut leisten, da es nicht in der Typbeschreibung abgelegt werden kann. Das ist nicht allein ein Mangel. Welche Meldung in einer Anlage als dringend gilt, welche in der Leitwarte erscheint und welche stumm bleibt, hängt am Betreiber und an der Anlage, und diese Entscheidung lässt sich in der Entwicklung eines Gerätetyps nicht sinnvoll vorwegnehmen. Die in @sec:fa getroffene Feststellung, dass FA-04 und FA-05 erst im Zusammenwirken von Modell und Projektierung erfüllbar sind, bestätigt sich hier von der praktischen Seite. Sie gilt allerdings verschärft, denn das Modell schafft die Voraussetzung für diese Projektierung derzeit nicht in der vorgesehenen Form.

/* Claude: Abschnitt aus den Stichpunkten des Autors ausformuliert. Alle sieben
   Notizen sind aufgegangen:
   - Powermanager-Erweiterung ueber den Projektmanager -> Einrichtung
   - Treiber fuer das Subsystemnetzwerk und Abfrageintervall 1 s -> Einrichtung,
     mit Begruendung ueber @tab:modbustreiber und die Empfehlung des
     Systemhandbuchs
   - Gateway-Kommunikation je ECPD -> Einrichtung, als eigener Befund
   - Begrenzung auf das, was der PDE bietet, samt der Ueberlegung zur
     Alarmprojektierung -> Vorspann und letzter Abschnitt
   - Bildschirmabzug zu den Schaltflaechen -> Darstellung und Bedienung
   - BLOB-Befund -> nur kurz aufgegriffen, ausgefuehrt ist er in @sec:umsetzung
   - Seriennummer nur in der Messwertansicht -> Darstellung und Bedienung

   Zur Gateway-Kommunikation ist die Parallele zum Online-Modus des PDE
   ergaenzt, wo ein Feld fuer den Unit Identifier ebenfalls nur bei
   Gateway-Anbindung erscheint (belegt ueber @src:pdemanual, siehe
   doc/resources/pde_referenz.md, Abschnitt 9). Das erklaert die Beobachtung,
   ohne ihr vorzugreifen.

   Die Notiz "funktioniert aber sowieso nicht von daher lowkey irrelevant" ist
   nicht als Abwertung uebernommen. Der Gedanke, dass die Alarmprojektierung
   sinnvollerweise beim Errichter liegt, ist sachlich gefuehrt und mit der
   bereits in @sec:fa getroffenen Feststellung verknuepft.

   Offen und als #kommentar markiert sind drei Punkte: die genaue Bezeichnung
   der Gateway-Einstellung, die Ursache dafuer, dass die Seriennummer nur in
   einer der beiden Ansichten erscheint, und der fehlende Bibliographieeintrag
   zur Auskunft von Andreas Ulmer. Der vorhandene Eintrag src:ulmer2026 betrifft
   die mobile Anwendung und ist hier bewusst nicht zitiert.

   Nicht aufgenommen ist T-01 und T-02 als Nachweis. Der Abschnitt beschreibt
   die Entwicklung, die Pruefung gehoert nach @sec:testdurchfuehrung. */
