#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Power Device Engineer<sec:pde>
#kommentar("Zu ausführlich?")
Der #acro("PDE") ist eine eigenständige Anwendung der Siemens AG zur Spezifikation, Konfiguration und Integration beliebiger Modbus-fähiger Geräte in SENTRON-Applikationen. Ergebnis jeder Bearbeitung ist eine #acro("JSON")-Datei, die die Kommunikation eines Gerätetyps gegenüber der konsumierenden Applikation vollständig beschreibt @src:pdemanual. Das Werkzeug erzeugt also keine Geräteinstanz, sondern eine Typbeschreibung, aus der die Zielapplikation anschließend beliebig viele gleichartige Geräte ableiten kann. Die folgenden Angaben beziehen sich auf die Online-Hilfe zur Version V9.1.0 @src:pdemanual.

Die vom Werkzeug vorgesehene Kette ist durchgängig festgelegt. Ausgangspunkt sind das Gerätemanual und die Modbus-Registerdetails des einzubindenden Geräts, die beide vorliegen müssen, bevor mit der Bearbeitung begonnen werden kann. Daraus entsteht im #acro("PDE") die Typbeschreibung, die als #acro("JSON")-Datei gespeichert und in die Zielapplikation eingelesen wird. Dort wird je physischem Gerät eine Instanz angelegt, und erst danach beginnt die eigentliche Überwachung @src:pdemanual.


=== Arbeitsablauf<sec:pde_ablauf>

Die Bearbeitung folgt einem Assistenten aus drei Seiten, den die Dokumentation in fünf Schritte gliedert. @tab:pde_schritte fasst sie zusammen.

#figure(
  table(
    columns: (2em, 11em, 1fr),
    inset: 7pt,
    align: (left + horizon, left + horizon, left),
    table.header(
      [], [*Schritt*], [*Inhalt*],
    ),

    [1], [Gerätetyp anlegen],
    [Festlegen des Gerätetypnamens. Zulässig sind ausschließlich Buchstaben, Ziffern, Umlaute und der Unterstrich.],

    [2], [Merkmale festlegen],
    [Angaben zu Firmware, Modell und Hersteller sowie sieben Schalter für Kommunikationsmerkmale des Geräts, darunter der Betrieb ausschließlich über Modbus #acro("RTU"), das Vorhandensein digitaler Eingänge, ein Adressversatz, ein Webserver, die Byte-Reihenfolge und deren Tausch.],

    [3], [Eigenschaften konfigurieren],
    [Anlegen der Datenpunkte mit Registeradresse, Funktionscode, Datentyp, Transformationstyp, Subindex, Einheit, Skalierungsfaktor sowie den Schaltern für Archivierung und zyklische Abfrage.],

    [4], [Darstellung konfigurieren],
    [Auswahl der Messpunkte, die in der Zielapplikation als Vorbelegung, als Favoriten und in Trenddarstellungen erscheinen.],

    [5], [#acro("JSON") erzeugen],
    [Prüfen und Speichern der Typbeschreibung. Solange ein Feld fehlerhaft belegt ist, verweigert das Werkzeug das Speichern.],
  ),
  caption: [Arbeitsschritte des #acro("PDE") nach der Online-Hilfe @src:pdemanual],
)<tab:pde_schritte>

Die Byte-Reihenfolge aus dem zweiten Schritt verdient Beachtung, weil sie über die Auswertung jedes mehrwortigen Werts entscheidet. Das Werkzeug unterscheidet Big und Little Endian und erlaubt zusätzlich einen Tausch der Bytes innerhalb der Wörter, sodass sich vier Anordnungen ergeben. Weichen die Annahmen des Werkzeugs von der Anordnung im Gerät ab, liefert ein an sich richtig adressiertes Register einen unbrauchbaren Wert @src:pdemanual.

Im dritten Schritt sind die Datenpunkte in einer festen Gruppenstruktur abzulegen. Die Dokumentation kennt die Wurzelgruppen für Messwerte, für digitale Zustände und für Geräteparameter, unterhalb der Messwerte weitere fachliche Untergruppen wie Spannung, Strom, Leistung oder Zähler sowie eine eigene Gruppe für schreibende Datenpunkte. Eigene Untergruppen lassen sich nur unterhalb der Messwerte und nur in begrenzter Zahl anlegen @src:pdemanual. Die Zuordnung ist damit nicht allein eine Frage der Übersicht, denn die Zielapplikation leitet aus Gruppe und Einheit ab, welche Datenpunkte sie für bestimmte Darstellungen überhaupt zur Auswahl stellt @src:pdemanual.


=== Datentypen und Transformationen<sec:pde_datentypen>

Das Werkzeug unterstützt vorzeichenbehaftete und vorzeichenlose Ganzzahlen unterschiedlicher Breite, Gleitkommazahlen, Wahrheitswerte, Zeichenketten sowie die beiden Sonderformen #acro("BLOB") und Zeitstempel @src:pdemanual. Über den Transformationstyp wird festgelegt, wie der Registerinhalt vor der Weitergabe umzurechnen ist. Neben der unveränderten Übernahme stehen unter anderem die Umsetzung aus dem #acro("BCD")-Format und die Zusammensetzung mehrerer Register nach dem Modulo-10-Verfahren zur Verfügung, wobei nicht jede Kombination aus Datentyp und Transformation zulässig ist @src:pdemanual.

Ein #acro("BLOB") beschreibt einen strukturierten Datenblock, der sich über einen zusammenhängenden Registerbereich erstreckt und typischerweise Identifikations- und Diagnoseinformationen eines Geräts trägt. Er wird über die Startadresse und die Anzahl der Bytes angegeben, und innerhalb des Blocks werden einzelne Messpunkte über Position und Länge herausgeschnitten @src:pdemanual. Damit lassen sich Registerbereiche erschließen, die sich nicht sinnvoll in Einzeldatenpunkte zerlegen lassen.


=== Prüfung gegen ein reales Gerät<sec:pde_online>

Das Werkzeug kennt neben dem Offline-Betrieb einen Online-Modus, in dem es sich mit einem physischen Gerät verbindet und die konfigurierten Datenpunkte mit ihren tatsächlichen Werten anzeigt. Er dient dazu, die Konfiguration zu prüfen, bevor die Typbeschreibung in eine Applikation übernommen wird @src:pdemanual. Verbunden wird über Modbus #acro("TCP") oder, sofern das entsprechende Merkmal gesetzt ist, über ein Gateway zu einem Gerät mit Modbus #acro("RTU"). Der Online-Modus ist allerdings auf einfache Datentypen ohne Transformation beschränkt. Für Zeichenketten, Wahrheitswerte, #acro("BLOB"), Zeitstempel sowie sämtliche #acro("BCD")- und Modulo-10-Transformationen lassen sich die Werte nicht abrufen @src:pdemanual.


=== Zielapplikationen und Übernahme der Typbeschreibung<sec:pde_ziel>

Als Zielapplikationen nennt die Dokumentation den SENTRON Powermanager und das SENTRON Powercenter 3000, zu deren jeweiligen Versionsständen die Werkzeugversion ausdrücklich kompatibel ist @src:pdemanual. Beide verfolgen dasselbe Ziel, unterscheiden sich aber in ihrer Bauform. Der Powermanager ist eine unter Windows installierte Energiemanagementsoftware, die auf einen Datenbankserver aufsetzt und für den Betrieb umfangreicher Anlagen mit Auswertungen und Berichten ausgelegt ist @src:powermanager. Das Powercenter 3000 ist demgegenüber eine vorinstallierte, unmittelbar einsatzbereite Monitoring-Software, die über eine Web-Oberfläche im Unternehmensnetz bedient wird und die aufgenommenen Daten auf Wunsch an Cloud-Anwendungen weiterreicht @src:poc3000.

In beiden Fällen ist die #acro("JSON")-Datei das Übergabeformat. Sie wird über die Bedienoberfläche der Zielapplikation eingelesen, wodurch der beschriebene Gerätetyp dort bekannt wird und für das Anlegen von Geräteinstanzen zur Verfügung steht @src:pdejsonimport. Erst mit dem Anlegen einer Instanz werden die Kommunikationsparameter des einzelnen Geräts ergänzt, während die Typbeschreibung selbst unverändert für alle Geräte desselben Typs gilt.


/* Claude: Abschnitt nach der Vorgabe aus der Durchsicht ausformuliert. Die vom
   Autor benannte Fundstelle zur Uebernahme der JSON-Geraetedateien
   (@src:pdejsonimport, Beitrags-ID 109798692) ist im Abschnitt Zielapplikationen
   eingearbeitet; die Beitragsseite selbst laedt ihren Inhalt per JavaScript nach
   und war maschinell nicht auslesbar, weshalb dort nur die Aussage steht, dass
   der Import ueber die Bedienoberflaeche der Zielapplikation erfolgt. Der genaue
   Menuepfad im Powercenter 3000 ist bewusst nicht angegeben, da er nicht
   belegbar war. Zum Eintrag in quellen.bib gehoert ein entsprechender Vorbehalt.

   Der Hinweis, dass Desigo CC in der PDE-Dokumentation nicht vorkommt und der
   Weg vom Powercenter zu Desigo CC damit Eigenleistung der Arbeit ist, steht
   bewusst nicht hier, sondern in der Analyse der Integrationswege. In den
   Grundlagen werden nur die dokumentierten Zielapplikationen genannt.

   Die harten Grenzen des Werkzeugs (Anzahl eigener Gruppen, Messpunkte je
   Gruppe, Dezimalstellen im Faktor, Bulk-Upload) sind hier nur dem Sinn nach
   erwaehnt; die vollstaendige Aufstellung liegt in resources/pde_referenz.md
   und gehoert in den Entwicklungsteil. */
