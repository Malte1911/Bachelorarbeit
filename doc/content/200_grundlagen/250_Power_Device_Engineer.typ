#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Power Device Engineer<sec:pde>

/* #kommentar("Zu ausführlich?") */

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
    [Festlegen des Gerätetypnamens aus einem eingeschränkten Zeichensatz.],

    [2], [Merkmale festlegen],
    [Angaben zu Firmware, Modell und Hersteller sowie Schalter für Kommunikationsmerkmale des Geräts, darunter ein Adressversatz und die Byte-Reihenfolge.],

    [3], [Eigenschaften konfigurieren],
    [Anlegen der Datenpunkte mit Registeradresse, Funktionscode, Datentyp, Transformationstyp, Subindex, Einheit, Skalierungsfaktor sowie den Schaltern für Archivierung und zyklische Abfrage.],

    [4], [Darstellung konfigurieren],
    [Auswahl der Messpunkte, die in der Zielapplikation als Vorbelegung, als Favoriten und in Trenddarstellungen erscheinen.],

    [5], [#acro("JSON") erzeugen],
    [Prüfen und Speichern der Typbeschreibung. Solange ein Feld fehlerhaft belegt ist, verweigert das Werkzeug das Speichern.],
  ),
  caption: [Arbeitsschritte des #acro("PDE") nach der Online-Hilfe @src:pdemanual],
)<tab:pde_schritte>

Zwei Festlegungen aus diesem Ablauf wirken über das Werkzeug hinaus. Die Byte-Reihenfolge entscheidet über die Auswertung jedes mehrwortigen Werts, wobei das Werkzeug Big und Little Endian unterscheidet und zusätzlich einen Tausch der Bytes innerhalb der Wörter erlaubt. Die Datenpunkte sind zudem in einer festen Gruppenstruktur abzulegen, aus der die Zielapplikation gemeinsam mit der Einheit ableitet, welche Datenpunkte sie für bestimmte Darstellungen überhaupt zur Auswahl stellt @src:pdemanual.


=== Datentypen und Transformationen<sec:pde_datentypen>

Das Werkzeug unterstützt vorzeichenbehaftete und vorzeichenlose Ganzzahlen unterschiedlicher Breite, Gleitkommazahlen, Wahrheitswerte, Zeichenketten sowie die beiden Sonderformen #acro("BLOB") und Zeitstempel. Ein #acro("BLOB") beschreibt dabei einen strukturierten Datenblock über einen zusammenhängenden Registerbereich, aus dem einzelne Messpunkte über Position und Länge herausgeschnitten werden. Über den Transformationstyp wird festgelegt, wie der Registerinhalt vor der Weitergabe umzurechnen ist, etwa aus dem #acro("BCD")-Format oder durch Zusammensetzung mehrerer Register nach dem Modulo-10-Verfahren, wobei nicht jede Kombination aus Datentyp und Transformation zulässig ist @src:pdemanual.


=== Prüfung gegen ein reales Gerät<sec:pde_online>

Das Werkzeug kennt neben dem Offline-Betrieb einen Online-Modus, in dem es sich mit einem physischen Gerät verbindet und die konfigurierten Datenpunkte mit ihren tatsächlichen Werten anzeigt. Er dient dazu, die Konfiguration zu prüfen, bevor die Typbeschreibung in eine Applikation übernommen wird. Der Modus ist allerdings auf einfache Datentypen ohne Transformation beschränkt, sodass sich die Werte für Zeichenketten, Wahrheitswerte, #acro("BLOB"), Zeitstempel sowie sämtliche #acro("BCD")- und Modulo-10-Transformationen nicht abrufen lassen @src:pdemanual.


=== Zielapplikationen und Übernahme der Typbeschreibung<sec:pde_ziel>

Als Zielapplikationen nennt die Dokumentation den SENTRON Powermanager @src:powermanager und das SENTRON Powercenter 3000 @src:poc3000, zu deren jeweiligen Versionsständen die Werkzeugversion ausdrücklich kompatibel ist @src:pdemanual. In beiden Fällen ist die #acro("JSON")-Datei das Übergabeformat. Sie wird über die Bedienoberfläche der Zielapplikation eingelesen, wodurch der beschriebene Gerätetyp dort bekannt wird und für das Anlegen von Geräteinstanzen zur Verfügung steht @src:pdejsonimport. Erst mit dem Anlegen einer Instanz werden die Kommunikationsparameter des einzelnen Geräts ergänzt, während die Typbeschreibung selbst unverändert für alle Geräte desselben Typs gilt.


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

   Abschnitt am 31.08.2026 gekuerzt, weil sich fast jedes Detail in
   @sec:umsetzung wiederholt, dort am konkreten Fall. Entfallen sind die
   Bauformbeschreibung von Powermanager und Powercenter 3000, der eigene
   BLOB-Absatz, die Ausfuehrungen zu BCD und Modulo-10, zwei Saetze zur
   Byte-Reihenfolge sowie in der Tabelle die Zeichensatzregel und die
   Aufzaehlung der sieben Merkmalsschalter. @src:powermanager und
   @src:poc3000 haengen jetzt als reine Nennung an den beiden Produktnamen,
   damit sie nicht aus dem Literaturverzeichnis fallen.

   Die Unterabschnitte pde_datentypen und pde_online sind entgegen der
   urspruenglichen Ueberlegung nicht zusammengelegt, weil beide Labels aus
   540 und 610 heraus einzeln referenziert werden.

   Die harten Grenzen des Werkzeugs (Anzahl eigener Gruppen, Messpunkte je
   Gruppe, Dezimalstellen im Faktor, Bulk-Upload) sind hier nur dem Sinn nach
   erwaehnt; die vollstaendige Aufstellung liegt in resources/pde_referenz.md
   und gehoert in den Entwicklungsteil. */
