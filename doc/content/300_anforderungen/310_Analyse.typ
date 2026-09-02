#import "../../config/acronyms.typ": *
#include "../../config/config.typ"
#import "../../config/functions.typ": *
#import "../../config/diagrams.typ": abb_systemaufbau, abb_konzept

/* Claude: Die leere Seite unter der Kapitelueberschrift ist behoben. Ursache war
   das `#set page(...)` in config/config.typ. Diese Datei wird von jeder
   Unterkapiteldatei per `#include` eingebunden, und eine Seiten-Regel im
   Dokumentfluss erzwingt in Typst einen Seitenumbruch. Dadurch begann jedes
   Unterkapitel auf einer neuen Seite und die Kapitelueberschrift stand allein.
   Die Regel ist entfernt, die Seitenraender setzt main.typ ohnehin einmalig fuer
   das gesamte Dokument. Die Aenderung wirkt auf alle Kapitel. */

== Analyse<sec:analyse>

Bevor Anforderungen an das Datenmodell formuliert werden können, ist zu klären, in welcher Umgebung die Lösung entstehen soll, wer sie später nutzt, über welchen Weg die Daten der Schutzschaltgeräte überhaupt in Desigo CC gelangen können, mit welchen Mitteln das Zielsystem sie abbildet und welcher Datenbestand auf diesem Weg zur Verfügung steht. Der vorliegende Abschnitt untersucht diese Fragen nacheinander und leitet aus den Ergebnissen Anwendungsfälle ab, die den Übergang zu den Anforderungen bilden.


=== Systemaufbau und Systemgrenzen<sec:systemanalyse>

Die in @sec:ecpd bis @sec:desigocc beschriebenen Komponenten stehen im Betrieb nicht nebeneinander, sondern in einer festen Kette. Die #acro("ECPD") vom Typ 5TY1 COM sitzen als Endstromkreisschutz im Installationsverteiler, erreichen über die Funkstrecke ausschließlich das SENTRON Powercenter, und erst dieses stellt die Daten über das Gebäudenetz bereit, wo Desigo CC sie abfragen kann. @img:systemaufbau zeigt diese Kette zusammen mit den beiden Werkzeugen, die nicht Teil des laufenden Datenpfads sind, für den Lebenszyklus der Lösung aber maßgeblich sind. SENTRON Powerconfig dient der Inbetriebnahme und Parametrierung der Geräte und setzt dabei stets am Powercenter an, entweder über #acro("BLE") vor Ort oder über dessen REST-#acro("API") im Netz @src:sentronsystemhandbuch. Das Werkzeug liegt als Desktop-Anwendung und als mobile Anwendung vor, von denen diese Arbeit ausschließlich die Desktop-Anwendung einsetzt (siehe @sec:rb). Auch für dieses Werkzeug bleibt ein einzelnes Endgerät unmittelbar unerreichbar, denn seine Parametrierung reicht das Powercenter über die Funkstrecke weiter. Der #acro("PDE") erzeugt demgegenüber die Gerätetypbeschreibung als #acro("JSON")-Datei (siehe @sec:pde).

#figure(
  abb_systemaufbau,
  caption: [Datenpfad vom #acro("ECPD") über die Funkstrecke zum Powercenter, von dort über Modbus #acro("TCP") im Gebäudenetz zu Desigo CC, seitlich angetragen die Werkzeuge SENTRON Powerconfig und #acro("PDE") mit ihren jeweiligen Zugriffspunkten],
)<img:systemaufbau>

Eine Einheit aus einem Powercenter und den ihm zugeordneten Endgeräten wird im Folgenden als _Strang_ bezeichnet. Eine Liegenschaft kann mehrere solcher Stränge enthalten. Der konkrete Laboraufbau, an dem die Lösung erprobt wird, ist von dieser allgemeinen Betrachtung zu unterscheiden und wird im Kapitel zur Systemumgebung beschrieben. //Claude: Referenz??

Aus der Kette ergibt sich die Systemgrenze der Arbeit. Gegenstand ist die Abbildung zwischen dem Modbus-Registerraum, den das Powercenter bereitstellt, und dem Objektmodell in Desigo CC. Nicht Gegenstand sind die Schutzfunktion der Geräte selbst, die Funkstrecke zwischen Endgerät und Powercenter, die elektrotechnische Installation sowie die Systemarchitektur von Desigo CC einschließlich ihrer Redundanz- und Betriebskonzepte. Welche Gestalt die Lösung innerhalb dieser Grenze annimmt, ist an dieser Stelle noch offen und wird erst in @sec:konzept aus den Ergebnissen der folgenden Abschnitte abgeleitet.

Für die Ausgangslage ist dabei bedeutsam, dass die betrachtete Gerätereihe in Desigo CC bislang nicht zur Verfügung steht. Das Erweiterungsmodul "Modbus TCP Power Devices" bringt eine Bibliothek vorgefertigter Objektmodelle für diverse Siemens-Niederspannungsgeräten für Gebäude mit, jedoch weder das #acro("ECPD") noch das Powercenter sind darin enthalten @src:desigoccenghelp. Rückwärtskompatibilität zu einer Vorgängerlösung ist folglich keine Anforderung.

/* Claude: Der Kommentar aus der ersten Pruefungsrunde ("ist das hier zu frueh
   beschrieben, wie der Aufbau aussehen wird?") ist abgearbeitet. Der Abschnitt
   beschreibt jetzt nicht mehr den Datenpfad, sondern nur noch die Systemgrenze
   und die Ausgangslage; die Kette selbst ist in Kapitel 2 beschrieben und wird
   hier nur noch ueber die Abbildung in Erinnerung gerufen. Entfallen sind die
   beiden Saetze, die vorwegnahmen, wo das Datenmodell ansetzt und mit welchem
   Werkzeug es entsteht. Stattdessen verweist der Schlusssatz auf @sec:konzept.

   Die Abbildung ist kein Platzhalter mehr, sondern das mit fletcher gezeichnete
   Diagramm `abb_systemaufbau` aus config/diagrams.typ. Systemgrenze und
   Werkzeuge sind darin wie besprochen abgesetzt. */


=== Stakeholderanalyse<sec:stakeholder>

Das Datenmodell wird von unterschiedlichen Personengruppen mit deutlich verschiedenen Erwartungen genutzt. Die folgende Einordnung unterscheidet sie nach ihrer Rolle im Lebenszyklus der Lösung und benennt jeweils die Erwartung, aus der später Anforderungen abgeleitet werden. Die Stakeholder arbeiten von der Entwicklung über die Inbetriebnahme bis zum laufenden Betrieb mit dem Modell.

#figure(
  table(
    columns: (12em, auto, auto),
    inset: 7pt,
    align: (left + horizon, left, center + horizon),
    table.header(
      [*Interessengruppe*], [*Erwartung an die Lösung*], [*Einfluss*],
    ),
    [Betreiber und Facility Management],
    [Möchte auf einen Blick erkennen, ob ein Abgang in Betrieb ist, und im Störungsfall wissen, welcher Stromkreis an welchem Ort betroffen ist. Erwartet, dass sich die neuen Geräte in der Bedienung nicht von den übrigen Gewerken unterscheiden.],
    [hoch],

    [Instandhaltungspersonal und Elektrofachkraft],
    [Benötigt belastbare Diagnoseinformationen, um einen Einsatz vorzubereiten, und will unnötige Fahrten vermeiden. Erwartet zudem Unterstützung bei der wiederkehrenden Prüfung und deren Dokumentation sowie eine frühzeitige Meldung, wenn der zyklische Selbsttest eines Geräts einen Fehler feststellt.],
    [hoch],


    [Systemintegrator und Errichter],
    [Will die Geräte eines Verteilers mit vertretbarem Aufwand anlegen können, ohne jeden Datenpunkt einzeln zu projektieren. Für ihn zählt die Wiederverwendbarkeit des Modells über Projektgrenzen hinweg.],
    [hoch],

    [Desigo-CC-Administrator],
    [Erwartet ein Modell, das sich in die vorhandene Objekt-, Alarm- und Archivstruktur einfügt und mit der eingesetzten Systemversion verträglich ist.],
    [mittel],

    [IT- und Netzwerkbetrieb],
    [Achtet darauf, dass ein unverschlüsseltes Feldprotokoll das Gebäudenetz nicht öffnet. Erwartet von der Lösung keine Sicherheitsarchitektur, sondern eine belastbare Aussage darüber, welche Eigenschaften das gewählte Protokoll mitbringt und welche Voraussetzungen daraus für das eigene Netzkonzept folgen.],
    [gering],

    [Endkunde ohne eigene Entwicklung],
    [Hat kein Interesse an der Integrationsvorlage als solcher und soll idealerweise nicht bemerken, dass sie existiert. Die Geräte sollen in Desigo CC einfach vorhanden sein.],
    [gering],

    [Endkunde mit eigener Entwicklung],
    [Will das #acro("ECPD") selbst einbinden und dabei auf einer nachvollziehbaren, dokumentierten Vorlage aufsetzen, die er an eigene Bedürfnisse anpassen kann.],
    [mittel],

    [Siemens-Entwicklung und Produktmanagement],
    [Verfolgt dasselbe Interesse wie der selbst entwickelnde Endkunde, allerdings mit dem Ziel einer fertigen Lösung, die einem Projekt ohne weitere Entwicklungsarbeit beigegeben werden kann. Trägt die Lösung über die Arbeit hinaus.],
    [hoch],
  ),
  caption: [Interessengruppen, ihre Erwartungen an das Datenmodell und ihr Einfluss auf dessen Gestaltung]
)<tab:stakeholder>

Zwischen diesen Gruppen bestehen zwei Spannungsfelder, die die Gestaltung des Modells unmittelbar betreffen. Das erste verläuft zwischen dem Endkunden ohne eigene Entwicklung und dem selbst entwickelnden Endkunden: Ersterer verlangt eine Lösung, die fertig und ohne Erklärung funktioniert, letzterer eine, die offen und veränderbar ist. Beides ist nur vereinbar, wenn das Modell zwar unmittelbar einsetzbar, in seiner Struktur aber modular und dokumentiert ist. Das zweite Spannungsfeld verläuft zwischen dem Betreiber, der möglichst viele Informationen in der Leitwarte sehen möchte, und dem Instandhaltungspersonal sowie dem Systemintegrator, für die jeder zusätzliche Datenpunkt Projektierungs- und Kommunikationsaufwand bedeutet. Dass dieser Aufwand erheblich ausfällt, ist dabei nicht allein die Einschätzung der Beteiligten. Die Zuordnung der Datenpunkte eines Gebäudeleitsystems zu einer einheitlichen Beschreibung erfolgt nach dem Stand der Technik überwiegend von Hand und bleibt arbeitsintensiv und kostentreibend @src:wang2018. Dieses Spannungsfeld ist der eigentliche Grund dafür, dass die Auswahl der Datenpunkte einen eigenen Arbeitsschritt darstellt und nicht nebenbei erledigt werden kann.

Eine Gruppe ist dabei gesondert einzuordnen. Der IT- und Netzwerkbetrieb ist zwar von der Lösung berührt, seine Erwartung lässt sich jedoch nicht allgemeingültig erfüllen, da Netzarchitektur, Zonenmodell, Zugriffsregeln und Betriebskonzepte bei jedem Kunden eigenen Vorgaben folgen. Ein Sicherheitskonzept für die Anbindung entsteht deshalb im jeweiligen Projekt und nicht in einer generischen Integrationsvorlage. Diese Arbeit benennt allein die sicherheitsrelevanten Eigenschaften des gewählten Übertragungswegs und die Voraussetzungen seines Betriebs (siehe @sec:integrationswege), während die Ausgestaltung der Netzsicherheit selbst nicht Gegenstand der Arbeit ist.

Eine Erwartung des Instandhaltungspersonals verdient dabei eine Einordnung, weil sie leicht überdehnt wird. Das #acro("ECPD") führt einen zyklischen Selbsttest durch und kann dessen Ergebnis melden (siehe @sec:ecpd_geraet). Damit lassen sich Gerätefehler früh sichtbar machen, die andernfalls erst bei einer wiederkehrenden Prüfung nach #acro("DGUV") Vorschrift 3 auffielen und dann Austausch und erneute Prüfung nach sich ziehen würden. Die wiederkehrende Prüfung selbst lässt sich dadurch jedoch nicht ersetzen, da sie die Beurteilung durch eine befähigte Person voraussetzt. Die Erwartung richtet sich folglich auf die Unterstützung und die Dokumentation der Prüfung aus.

Die Gruppen mit dem höchsten Einfluss, also Betreiber, Instandhaltung, Systemintegrator und Produktmanagement, knüpfen ihre Erwartungen dabei an vergleichsweise wenige Eigenschaften, nämlich die Verlässlichkeit der Zustandsanzeige, die Aussagekraft der Alarme, die Wiederverwendbarkeit des Modells und die Nachvollziehbarkeit seiner Struktur. Diese vier Eigenschaften bilden den Maßstab, an dem die Lösung in der Validierung zu messen ist.

/* Claude: Der offene Punkt aus der Durchsicht (Selbsttest des ECPD, Verhaeltnis
   zur DGUV-Pruefung) ist eingearbeitet: als Erwartung in der Tabellenzeile zur
   Instandhaltung und als eigener Absatz mit der Abgrenzung, dass die
   wiederkehrende Pruefung nicht ersetzbar ist. Die Auswirkung auf FA-08 und die
   Frage, welche Test- und Selbsttestregister dafuer tatsaechlich abgebildet
   werden, bleibt dem Anforderungskatalog und dem Entwicklungsteil vorbehalten. */


=== Analyse der Integrationswege<sec:integrationswege>

Die Frage, über welchen Weg die Daten in Desigo CC gelangen, ist der Ausgangspunkt jeder weiteren Festlegung, denn sie entscheidet über den verfügbaren Datenumfang, über die Möglichkeit schreibender Zugriffe und über die einzusetzende Werkzeugkette. Der folgende Abschnitt trifft dabei keine Entwurfsentscheidung, sondern grenzt den Lösungsraum ab. Er stellt fest, welche Wege technisch überhaupt bestehen, und bildet damit die Voraussetzung dafür, dass die Anforderungen im folgenden Abschnitt realistisch formuliert werden können. Ein Weg ist nur dann gangbar, wenn er auf beiden Seiten unterstützt wird, also sowohl vom Powercenter als Datenquelle als auch von Desigo CC als Zielsystem. Desigo CC bindet Fremdsysteme über Erweiterungsmodule für offene Protokolle ein, für die die Engineering-Dokumentation eigene Kapitel zu BACnet, Modbus #acro("TCP"), OPC DA, #acro("SNMP") und IEC 61850 führt @src:desigoccenghelp.

Aus dem Schnittstellenangebot des Powercenters (siehe @sec:powercenter_schnittstellen) und den Gegebenheiten der Feldebene ergeben sich sechs denkbare Wege. Die Bezeichner W1 bis W6 dienen allein der Verweisbarkeit innerhalb dieses Abschnitts.

Drei Wege scheiden ohne nähere Bewertung aus. Der unmittelbare Zugriff auf das Endgerät (W1) ist technisch versperrt, da die Schutzschaltgeräte keine Modbus-Schnittstelle besitzen und ausschließlich über die Funkstrecke mit dem Powercenter kommunizieren @src:sentronsystemhandbuch. Die #acro("BLE")-Schnittstelle des Powercenters (W2) ist als örtlicher Zugang ausgelegt, unterstützt nur eine aktive Verbindung und schaltet sich nach $180space.thin"s"$ ohne Nutzung ab @src:sentronsystemhandbuch, womit sie für den zyklischen Dauerbetrieb ausfällt. Die Cloud-Anbindung über #acro("MQTT") (W5) steht allein am Powercenter 2000 zur Verfügung @src:sentronsystemhandbuch, während der Testaufbau ein Powercenter 1100 vorsieht, und zählt zudem nicht zu den von Desigo CC unterstützten Feldprotokollen @src:desigoccenghelp.

Modbus #acro("TCP") über das Powercenter (W3) ist auf beiden Seiten unterstützt. Das Powercenter tritt als Modbus-#acro("TCP")-Server auf und stellt die Daten aller unterlagerten Endgeräte über eine einzige #acro("IP")-Adresse bereit, wobei die Unterscheidung der Geräte über den Unit Identifier erfolgt @src:sentronsystemhandbuch. Lesende wie schreibende Zugriffe sind möglich, und auf der Gegenseite steht mit dem Erweiterungsmodul „Modbus TCP" ein vollständiger Treiber bereit, in dem Desigo CC als Client auftritt @src:desigoccenghelp. Die Ausgestaltung dieses Wegs wird in @sec:desigoccmechanik gesondert untersucht.

Die REST-Schnittstelle über #acro("HTTPS") (W4) ist der Modbus-Variante sicherheitstechnisch überlegen, da sie über #acro("TLS") verschlüsselt ist und der rollenbasierten Zugriffskontrolle des Powercenters unterliegt @src:sentronsystemhandbuch. Sie ist jedoch herstellerspezifisch, sodass in Desigo CC kein generisches Erweiterungsmodul dafür bereitsteht @src:desigoccenghelp und eine Anbindung eine Eigenentwicklung über das Software Development Kit erforderte. Ebenso wenig ließe sich der #acro("PDE") nutzen, dessen Ergebnis ausdrücklich eine Beschreibung der Modbus-Kommunikation ist @src:pdemanual. Die vorgesehene Werkzeugkette entfiele damit vollständig.

Bleibt der Umweg über ein vorgelagertes Fremdsystem (W6). Die vom #acro("PDE") unterstützten Zielapplikationen sind der SENTRON Powermanager und das SENTRON Powercenter 3000 @src:pdemanual. Von beiden lässt sich allein der Powermanager an Desigo CC koppeln, da er nach oben OPC DA bereitstellt @src:sentronsoftwareguide und Desigo CC dieses Protokoll auf der Feldebene unterstützt @src:desigoccdatasheet, während das Powercenter 3000 dafür ausschließlich #acro("MQTT") anbietet. Gangbar ist der Weg somit, er führt jedoch ein zweites Leitsystem mit eigener Datenhaltung, eigener Alarmierung und eigenem Wartungsbedarf ein und verschiebt die Abbildung der Gerätedaten lediglich in ein anderes System. Ein solches Zwischensystem entspricht dem in der Gebäudeautomation verbreiteten Muster der vermittelnden Schicht @src:perumal2010, deren Gewinn im Zusammenführen mehrerer ungleichartiger Quellen liegt. Genau diese Bedingung fehlt hier, da eine einzige Quelle anzubinden ist, die mit Modbus #acro("TCP") bereits ein von der Zielplattform unterstütztes Protokoll spricht. Auf den Fall mehrerer Stränge kommt @sec:weiterentwicklung zurück.

Die drei verbleibenden Wege sind sämtlich gangbar, weshalb die Kriterien auf zwei Ebenen wirken. Die beiden Ausschlusskriterien, das Vorhandensein der Schnittstelle und die Eignung für den Dauerbetrieb, haben bereits W1, W2 und W5 ausgeschieden und werden von W3, W4 und W6 erfüllt. Die Entscheidung fällt deshalb über die drei Abwägungskriterien, die keine Gewichtung tragen, sondern den Preis des jeweiligen Wegs benennen. Die Informationssicherheit wird dabei nicht als gleichrangiges Kriterium geführt, sondern im Anschluss gesondert betrachtet, da sie sich im Gegensatz zu den übrigen durch Maßnahmen außerhalb des Protokolls beeinflussen lässt.

#figure(
  {
    // Die Spaltenbreiten sind bewusst als Anteile gesetzt. Mit `auto` bemassen
    // sich die drei Wegspalten an der laengsten Zelle, also an der Schlusszeile,
    // wodurch die Tabelle breiter als der Satzspiegel wurde: Die erste Spalte
    // fiel auf ein Wort je Zeile zusammen und die Schlusszeile lief in die
    // Nachbarspalte. Die Trennung erlaubt den langen Woertern der Schlusszeile
    // den Umbruch innerhalb ihrer Zelle.
    set text(hyphenate: true)
    table(
      columns: (1.4fr, 1fr, 1fr, 1fr),
      inset: 6pt,
      align: (left + horizon, center + horizon, center + horizon, center + horizon),
      table.header(
        [*Kriterium*], [*W3*], [*W4*], [*W6*],
      ),

      table.cell(colspan: 4)[_Ausschlusskriterien_],
      [Schnittstelle am Powercenter vorhanden], [ja], [ja], [ja],
      [Für zyklischen Dauerbetrieb geeignet], [ja], [ja], [ja],

      table.cell(colspan: 4)[_Abwägungskriterien_],
      [Anbindung mit der vorgesehenen Werkzeugkette], [ja], [nein], [ja],
      [Voller Datenumfang mit Schreibzugriff], [ja], [ja], [eingeschränkt],
      [Ohne zusätzliches System], [ja], [ja], [nein],

      [*Ausschlaggebender Nachteil*],
      [keine Verschlüsselung im Protokoll],
      [Eigenentwicklung statt Werkzeugkette],
      [zweites Leitsystem für eine Quelle],
    )
  },
  caption: [Abwägung zwischen den gangbaren Integrationswegen. W3 Modbus #acro("TCP"), W4 REST-Schnittstelle, W6 vorgelagerter Powermanager. W1, W2 und W5 sind zuvor an den Ausschlusskriterien gescheitert]
)<tab:integrationswege>

Modbus #acro("TCP") über das Powercenter ist damit der einzige Weg, der ohne Eigenentwicklung und ohne zusätzliches System auskommt. Diese Feststellung ist weniger eine Auswahl unter gleichwertigen Alternativen als vielmehr die Bestätigung, dass die Schnittstellenlage von Quell- und Zielsystem nur einen der Wege zulässt. Bemerkenswert ist dabei, dass ausgerechnet der sicherheitstechnisch schwächste Weg der einzige durchgängig unterstützte ist.

Die sicherheitstechnische Schwäche ist die zentrale Einschränkung des gewählten Wegs. Da das Protokoll selbst weder Verschlüsselung noch Authentifizierung kennt (siehe @sec:modbus) und die rollenbasierte Zugriffskontrolle des Powercenters ausschließlich auf die #acro("HTTPS")-Kommunikation wirkt @src:sentronsystemhandbuch, kann ein Schutz nur außerhalb des Protokolls auf Netzebene entstehen. Daraus folgen drei Voraussetzungen, die als Randbedingungen in die Anforderungen einfließen. Die Modbus-Schnittstelle wird nur dort aktiviert, wo sie benötigt wird, was am Powercenter 1100 separat möglich ist @src:sentronsystemhandbuch. Die Kommunikation verbleibt in einem eigenen Netzsegment. Ein Zugriff über das lokale Netz hinaus erfolgt ausschließlich über #acro("VPN"). 

Diese drei Punkte sind explizit kein Sicherheitskonzept, sondern als Mindestvoraussetzungen des Betriebs zu verstehen. Wie Segmentierung, Fernzugriff und Überwachung im Einzelnen umgesetzt werden, richtet sich nach den Vorgaben des jeweiligen Kunden und ist, wie in @sec:stakeholder abgegrenzt, kein Gegenstand dieser Arbeit.

/* Claude: Drei Punkte aus der Durchsicht sind hier abgearbeitet.
   1. Der Hinweis, die Eingrenzung des Integrationswegs greife der
      Anforderungsanalyse vor, ist im Einleitungsabsatz aufgenommen: Der
      Abschnitt trifft ausdruecklich keine Entwurfsentscheidung, sondern grenzt
      den Loesungsraum ab, damit die Anforderungen realistisch formuliert werden
      koennen.
   2. Die fetten Zwischenueberschriften W1 bis W6 sind durch Ueberschriften der
      vierten Ebene ersetzt. Sie erscheinen wegen `outline(depth: 2)` nicht im
      Inhaltsverzeichnis.
   3. W6 ist mit @src:sentronsoftwareguide belegt und sprachlich getrennt.
      Wesentliche Korrektur gegenueber der vorherigen Fassung: Nur der
      Powermanager stellt nach oben OPC bereit, das Powercenter 3000
      ausschliesslich MQTT. Der Satz, man koenne "dieses System ueber OPC an
      Desigo CC koppeln", galt also nicht fuer beide Produkte. */


=== Integrationsmechanismus in Desigo CC<sec:desigoccmechanik>

Mit der Festlegung auf Modbus #acro("TCP") ist noch nicht bestimmt, in welcher Form das Datenmodell auf der Zielseite überhaupt vorliegen kann. Da die von Desigo CC vorgegebenen Mechanismen die Gestalt der Lösung unmittelbar begrenzen, werden sie hier gesondert untersucht. Grundlage ist die Engineering-Dokumentation der Plattform @src:desigoccenghelp, deren hier herangezogene Aussagen über die Plattformstände hinweg unverändert gelten (siehe @sec:quellenlage).

/* Claude: Die Angaben dieses Abschnitts stammen aus der Engineering Help. Geprueft wurden
   die Plattformstaende V5.1 und V7; die verwendeten Aussagen sind in beiden identisch und
   nach Auskunft des Autors auch gegenueber dem eingesetzten Stand unveraendert (Stand
   27.08.2026). Der Vorbehalt zu NFA-04 in @sec:anforderungsvorbehalte betrifft seither
   allein den Import der konkreten Typbeschreibung, nicht mehr die Dokumentationslage.

   Der zuvor hier vermerkte offene Punkt, die JSON-Objektmodellbeschreibung trage keine
   Modbus-Adressen, ist erledigt. Er war auf den allgemeinen Importweg der Engineering
   Help bezogen, nicht auf den hier gewaehlten Weg ueber den PDE. Die vom PDE erzeugte
   Typbeschreibung fuehrt Registeradresse, Funktionscode, Datentyp und Skalierung je
   Eigenschaft mit (siehe @tab:pde_schritte), sodass nur ein Artefakt zu entwickeln ist.
   Der folgende Absatz ist entsprechend umgeschrieben. */

Von den Mitteln, die die Plattform für eine Modbus-Anbindung bereithält, ist für diese Arbeit im Wesentlichen eines maßgeblich. Ein Gerätetyp wird in Desigo CC als Objektmodell beschrieben, und dieses Objektmodell lässt sich als #acro("JSON")-Datei importieren @src:desigoccenghelp. Damit besteht eine unmittelbare Entsprechung zu dem Format, das der #acro("PDE") erzeugt (siehe @sec:pde), und genau an dieser Stelle setzt das Datenmodell dieser Arbeit an. Die Dokumentation des #acro("PDE") führt Desigo CC allerdings nicht als Zielapplikation (siehe @sec:pde_ziel), weshalb diese Entsprechung nicht dokumentiert ist, sondern am Testaufbau zu bestätigen war.
// Claude: wie sinnvoll ist der folgende Abschnitt? Das ergibt sich doch eigentlich im Verlauf der Arbeit, muss das hier nochmal erwähnt
Für den Zuschnitt der Lösung ist dabei entscheidend, dass die Typbeschreibung des #acro("PDE") die Adressierung bereits enthält. Zu jeder Eigenschaft werden dort Registeradresse, Funktionscode, Datentyp, Subindex und Skalierungsfaktor hinterlegt (siehe @tab:pde_schritte), sodass Objektmodell und Adressbelegung in derselben Datei liegen. Die Lösung dieser Arbeit besteht folglich aus einem einzigen zu entwickelnden Artefakt. Daneben beschreibt die Engineering-Dokumentation einen allgemeinen Weg, auf dem ein Objektmodell ohne Adressangaben eingelesen und die Zuordnung von Registeradressen und Funktionscodes in eigenen Regelwerken danebengelegt wird @src:desigoccenghelp. Dieser Weg kommt ohne den #acro("PDE") aus, gibt dessen Werkzeugkette damit aber auch auf und wird hier nicht beschritten.

Nicht Gegenstand der Entwicklung sind zwei weitere Bestandteile einer vollständigen Integration. Das sind zum einen Grafiken, Symbole und Textgruppen für die Darstellung in der Bedienoberfläche, zum anderen die Liste der tatsächlich anzulegenden Geräteinstanzen @src:desigoccenghelp. Beides ist projektspezifisch, es ist somit von der Anlage und nichgt vom Gerätetyp abhängig.

Die Kommunikation selbst trägt ein Treiber, der im Projekt eigens angelegt, einem Netzwerk zugeordnet und gestartet wird @src:desigoccenghelp. Er ist eine Voraussetzung dafür, dass überhaupt Werte fließen, hat auf die Gestalt des Datenmodells jedoch keinen Einfluss und wird deshalb hier nicht weiter betrachtet.

Bedeutsam ist dagegen die Trennung von Typ und Instanz auf der Zielseite. Das importierte Objektmodell beschreibt einen Gerätetyp und ist damit zunächst nur eine Vorlage. Für jedes physisch vorhandene Gerät ist in Desigo CC eine eigene Instanz anzulegen, die ihre Kommunikationsparameter mitbringt, also die #acro("IP")-Adresse und den Unit Identifier des Geräts @src:desigoccenghelp. Eine Kommunikationsschnittstelle besteht dabei aus der Kombination von Adresse und Slave-Kennung und trägt genau ein Gerät.

==== Randbedingungen des Treibers

Aus der Dokumentation lassen sich darüber hinaus mehrere Eigenschaften des Modbus-Treibers entnehmen, die für die Modellierung unmittelbar bedeutsam sind.

#figure(
  table(
    columns: (8em, 1fr),
    inset: 7pt,
    align: (left + horizon, left),
    table.header(
      [*Eigenschaft*], [*Bedeutung für das Datenmodell*],
    ),
    [Funktionscodes],
    [Unterstützt werden die Codes 1, 2, 3, 4, 5, 6, 7, 15, 16 und 24. Die vom Powercenter verwendeten Codes 0x03, 0x04, 0x06 und 0x10 sind damit vollständig abgedeckt.],

    [Datentypen],
    [Ganzzahlen mit 16, 32 und 64 Bit mit und ohne Vorzeichen, Gleitkommazahlen einfacher und doppelter Genauigkeit, Wahrheitswerte, Bytes, Zeichenketten und #acro("BLOB"). Die Formate der Registerkarte lassen sich abbilden.],

    [Wortreihenfolge],
    [Wird global oder je Treiberinstanz über einen Konfigurationseintrag gesetzt; für Geräte mit Big-Endian-Anordnung ist er auf 0 zu setzen. Für die mitgelieferten Energiemessgeräte schreibt die Dokumentation dies ausdrücklich vor.],

    [Abfrageintervall],
    [Das Intervall, in dem der Treiber die Geräte abfragt, wird an der Treiberkonfiguration eingestellt und gilt für sämtliche Datenpunkte aller Geräte dieses Treibers. Eine nach Geräten oder nach Datenpunktgruppen abgestufte Abfrage steht am eingesetzten Stand nicht zur Verfügung, was von der Dokumentation abweicht und deshalb nach @sec:quellenlage der Beobachtung folgt. Die Abfragelast lässt sich damit allein über die Zahl der abgebildeten Datenpunkte und über dieses eine Intervall steuern.], //Claude: hier bitte nochmal Dokumentation prüfen und ggf mir sagen was da drin steht, damit man das hier in dem Punkt richtig sagt


    [Blockbildung],
    [Register, deren Adressabstand einen einstellbaren Grenzwert unterschreitet, werden zu einem gemeinsamen Leseblock zusammengefasst. Eine dichte Belegung des Adressraums verringert damit unmittelbar die Zahl der Telegramme.],

    [Schreibrichtung],
    [Ein Datenpunkt kennt entweder die Lese- oder die Schreibrichtung, nicht beide. Für Werte, die geschrieben und zurückgelesen werden sollen, sieht die Plattform Objektmodelle mit getrennten Eigenschaften für Soll- und Istwert vor.],
  ),
  caption: [Eigenschaften des Modbus-Treibers von Desigo CC und ihre Bedeutung für die Modellierung, nach @src:desigoccenghelp]
)<tab:modbustreiber>

/* Anmerkung des Autors, erledigt: "Abfrageintervall ist noch offen, das muss ich
   nochmal im Detail prüfen wie das ist"
   Claude: Der Autor hat den Punkt am eingesetzten Stand geprueft. Das Intervall
   ist nicht je Geraet, sondern ausschliesslich am Modbus-Treiber einstellbar und
   gilt dort fuer alle angebundenen Geraete. Die Tabellenzeile ist entsprechend
   gefasst. Die davon beruehrten Stellen sind @sec:konzept, FA-02 in @sec:fa,
   T-03 in @sec:testuebersicht, @sec:kommunikationsstrecke sowie K-07 in
   @sec:auswahlkriterien und die Bilanz in @sec:datenpunkte. Die auskommentierte
   Notiz darunter ist damit ebenfalls beantwortet. */


// #kommentar[Prüfung offen: Die Zeile zum Abfrageintervall stützt sich auf die Beobachtung am eingesetzten Stand, dass sich die Abfragegeschwindigkeit nur je Gerät und nicht je Datenpunktgruppe einstellen lässt. Die Engineering-Dokumentation beschreibt dagegen benannte Abfragegruppen mit eigenem Intervall. Vor Abgabe ist zu klären, ob die Gruppen an der installierten Version tatsächlich nicht nutzbar sind oder ob sie lediglich nicht projektiert waren. Von der Antwort hängt ab, ob die abgestufte Abfrage eine Möglichkeit der Weiterentwicklung bleibt oder bereits in dieser Arbeit umgesetzt werden kann.]

Die letzte Zeile der Tabelle verdient besondere Beachtung. Sie bedeutet, dass ein Schaltbefehl und die zugehörige Rückmeldung im Modell zwingend zwei Eigenschaften belegen, selbst wenn beide auf dasselbe Register verweisen. Die Einschränkung trifft damit unmittelbar auf die Kommandoregister des #acro("ECPD"). Ebenso bemerkenswert ist das Mengengerüst. Bei rund 3.900 Einträgen für einen vollständig abgebildeten Strang, dessen Herleitung in @sec:registerraum folgt, ließen sich überschlägig nur etwa acht Stränge über eine einzige Treiberinstanz betreiben. Auch von dieser Seite her ist eine Reduktion des Datenumfangs vonnöten.

/* Claude: Der Auftrag "hier bitte noch ausformulieren und mit Quellen belegen"
   ist abgearbeitet; die drei Stichpunkte sind zu drei Absaetzen geworden
   (JSON-Objektmodell als tragendes Artefakt und die uebrigen Artefakte nur
   benannt, separat anzulegender Treiber, Trennung von Typ und Instanz mit
   IP-Adresse und Unit Identifier).

   Die fette Zwischenueberschrift "Randbedingungen des Treibers" ist durch eine
   Ueberschrift der vierten Ebene ersetzt.

   Die Zeile "Abfragegruppen" der Tabelle ist nach dem Hinweis des Autors zu
   "Abfrageintervall" geworden. Der Widerspruch zur Engineering-Dokumentation ist
   nicht aufloesbar, ohne an der installierten Version nachzusehen, und steht
   deshalb als offener Punkt im #kommentar darueber. */


=== Erstes Lösungskonzept<sec:konzept>

Aus der Festlegung auf Modbus #acro("TCP"), den Eigenschaften des Powercenters und den in @sec:desigoccmechanik dargestellten Mitteln der Zielplattform lässt sich ein erster Entwurf der Lösung ableiten, der die Struktur der weiteren Arbeit vorgibt. Er ist als Ausgangspunkt zu verstehen und wird im Entwicklungsteil konkretisiert. @img:konzept stellt seine Bestandteile im Zusammenhang dar.

Den Kern des Entwurfs bildet die Trennung von Gerätetyp und Geräteinstanz. Die Registeradressen sind bei allen Geräten desselben Typs identisch; unterschieden werden die Geräte allein über den Unit Identifier @src:sentronsystemhandbuch. Eine einzige Typbeschreibung genügt daher, um beliebig viele physische Geräte abzubilden, und genau darin liegt die Wiederverwendbarkeit des Modells über Projektgrenzen hinweg. 

Powercenter und #acro("ECPD") werden als getrennte Objekttypen modelliert. Ein erheblicher Teil der Register stimmt zwar überein, es handelt sich jedoch um verschiedene Geräte mit unterschiedlichen Aufgaben und unterschiedlicher Adressierung. Auf der Zielseite entspricht ein Strang damit bis zu 25 Kommunikationsschnittstellen mit gemeinsamer #acro("IP")-Adresse und unterschiedlicher Slave-Adresse, unter denen jeweils genau ein Geräteobjekt liegt @src:desigoccenghelp. Der Schwerpunkt liegt dabei auf dem Objektmodell des #acro("ECPD"), da dieses Gerät die Messwerte, die Zählerstände und die Schaltfunktion trägt. Für das Powercenter entsteht eine eigene Typbeschreibung geringeren Umfangs, da es weder misst noch schaltet und im Wesentlichen Zustands- und Diagnoseangaben des Strangs führt.

#figure(
  abb_konzept,
  caption: [Erstes Lösungskonzept, Werkzeugkette vom #acro("PDE") über die #acro("JSON")-Typbeschreibung zum Objektmodell in Desigo CC sowie die Instanziierung je physischem Gerät über den Unit Identifier],
)<img:konzept>

Für die Abfrage gibt das Systemhandbuch drei Empfehlungen, nämlich jedes Gerät höchstens einmal pro Sekunde abzufragen, die Endgeräte sequenziell abzuarbeiten und Register blockweise zu lesen @src:sentronsystemhandbuch. Desigo CC setzt diese Methodik bereits um, da der Treiber einen einstellbaren Abstand zwischen den Anfragen kennt und benachbarte Register selbsttätig zu Leseblöcken zusammenfasst @src:desigoccenghelp. Eine schnellere Abfrage brächte ohnehin keinen Gewinn, weil die Messwerte frühestens alle $2space.thin"s"$ aktualisiert werden @src:sentronsystemhandbuch. Das Intervall gilt nach @tab:modbustreiber jedoch für sämtliche Datenpunkte aller Geräte eines Treibers, sodass der am schnellsten benötigte Wert den Takt aller übrigen bestimmt. Die Abfragelast hängt damit unmittelbar an der Zahl der abgebildeten Datenpunkte, und eine nach Verwendungszweck abgestufte Abfrage bleibt ein Ansatzpunkt für eine Weiterentwicklung.

Ungültige Messwerte kennzeichnet das Powercenter als _Not a Number_, und zusätzlich zeigt ein Statusdatenpunkt an, ob die Verbindung zum Endgerät besteht @src:sentronsystemhandbuch. Beides ist im Modell auszuwerten, damit ein ausgefallenes Gerät nicht als Gerät mit dem Messwert null erscheint. //Claude: Not a number ist eine Dopplung von vorhin, weiß ich nicht ob ich das drinnen lassen würde oder nicht, gib mir deine Meinung

Schließlich sieht der Entwurf eine feste Arbeitsteilung zwischen den beiden Werkzeugen vor. Die Parametrierung der Geräte, also Grenzwerte, Hysteresen und Schutzeinstellungen, verbleibt bei SENTRON Powerconfig. Desigo CC übernimmt den laufenden Betrieb mit Anzeige, Archivierung, Alarmierung und Bedienung. SENTRON Powerconfig lässt sich damit nicht ablösen und wird von der errichtenden Fachkraft weiterhin benötigt, denn sobald in den elektrotechnischen Aufbau oder in die Wirkungsweise eines Geräts eingegriffen wird, hat dies über Powerconfig zu geschehen. Diese Aufteilung ist nicht nur eine Frage des Aufwands, sondern auch eine der Zuständigkeit. Änderungen an der Schutzwirkung setzen eine Elektrofachkraft voraus, während Desigo CC vom Personal der Gebäudeverwaltung bedient wird. Bleibt die Parametrierung außerhalb des Datenmodells, so ist ausgeschlossen, dass sie aus der Leitwarte heraus unbeabsichtigt verändert wird. Die Aufteilung hält das Datenmodell zugleich frei von Inbetriebnahmedaten und begründet, dass ein großer Teil des Registerraums unberücksichtigt bleiben kann. Die Auswirkung auf den Anforderungskatalog wird bei FA-06 und FA-09 in @sec:fa aufgegriffen.

/* Claude: Drei Hinweise aus der Durchsicht sind hier abgearbeitet.
   1. Die zuvor beschriebenen vier Abfragegruppen sind entfallen. Der Autor hat
      am eingesetzten Stand nachgesehen: Das Abfrageintervall ist weder je
      Geraet noch je Datenpunktgruppe, sondern ausschliesslich am Modbus-Treiber
      einstellbar und gilt dort fuer alle angebundenen Geraete. Der Absatz nennt
      die abgestufte Abfrage stattdessen als Ansatzpunkt fuer eine
      Weiterentwicklung, wie vorgeschlagen.
   2. Die fehlende Quelle zu "Diese Abfragemethodik ist von Desigo CC bereits
      implementiert" ist ergaenzt (@src:desigoccenghelp, Anfrageabstand und
      automatische Blockbildung); der Satz war zuvor auch grammatisch unvollstaendig.
   3. Der Hinweis, dass die Trennung ueber Powerconfig zugleich verhindert, dass
      die Gebaeudeverwaltung die Geraetekonfiguration aendert, ist in den letzten
      Absatz aufgenommen.

   Der Absatz zur Trennung von Geraetetyp und Geraeteinstanz sowie der Absatz zu
   den zwei Objekttypen sind zudem gekuerzt, wie in den Notizen zur Durchsicht
   vermerkt.

   Der Platzhalter am Ende des Abschnitts ist durch das mit fletcher gezeichnete
   Diagramm `abb_konzept` aus config/diagrams.typ ersetzt und an die Stelle
   gerueckt, an der von Typ, Instanz und Unit Identifier die Rede ist. Die
   Abbildung wird jetzt auch im Text referenziert, was zuvor fehlte.

   Nachtrag: Die Abbildung fuehrte urspruenglich eine eigene "Adressbelegung" als
   zweites Artefakt neben der Typbeschreibung. Das war auf den allgemeinen
   Importweg von Desigo CC bezogen und trifft auf den hier gewaehlten Weg nicht
   zu, weil der PDE die Registeradressen in dieselbe JSON-Datei schreibt. Der
   Knoten ist aus `abb_konzept` entfernt und die Bildunterschrift angepasst.
   Die Instanzliste bleibt, da die anzulegenden Geraete je Anlage feststehen
   muessen. Siehe auch den Kommentar in @sec:desigoccmechanik. */


=== Analyse des Modbus-Registerraums<sec:registerraum>

Der gewählte Integrationsweg bestimmt, welche Daten überhaupt zur Verfügung stehen. Der folgende Überblick charakterisiert diesen Datenbestand; die begründete Auswahl der tatsächlich abzubildenden Datenpunkte erfolgt im Entwicklungsteil der Arbeit.

Grundlage ist die Übersicht der Datenpunkte und Modbus-Register der Gerätefamilie @src:sentronregistermap. Sie weist für das Powercenter 211 und für das #acro("ECPD") 152 Einträge aus. Da einem Powercenter bis zu 24 Endgeräte zugeordnet sein können, ergäbe eine vollständige Abbildung eines voll bestückten Strangs rund 3.900 Einträge. Bereits diese Größenordnung zeigt, dass eine unbesehene Übernahme des Registerraums weder gegenüber der Kommunikationslast noch gegenüber der Bedienbarkeit in der Leitwarte zu vertreten wäre.

Inhaltlich lassen sich die Register des #acro("ECPD") in sieben Gruppen einteilen. Diese Einteilung folgt nicht der Gliederung der Registerkarte, sondern dem Nutzungszweck aus Sicht des Betriebs und wurde im Rahmen dieser Arbeit vorgenommen.

#figure(
  table(
    columns: (7em, 1fr),
    inset: 7pt,
    align: (left + horizon, left),
    table.header(
      [*Gruppe*], [*Inhalt und Bedeutung für den Betrieb*],
    ),
    [Live-Zustand],
    [Schalterstellung, Rückmeldung von Schaltbefehlen, Funkverbindung und Signalstärke sowie das Sammelregister der Alarme. Beantwortet die Kernfrage, ob ein Abgang in Betrieb ist.],

    [Messwerte],
    [Strom, Spannung, Wirkleistung, Leistungsfaktor, Temperatur und Differenzstrom, jeweils als Momentanwert sowie teilweise als vom Gerät gespeicherter Extremwert.],

    [Zähler und Wartung],
    [Betriebsstunden, mechanische Schaltspiele, nach Ursache getrennte Auslösezähler sowie ein Zähler für Änderungen an geschützten Parametern. Grundlage der Instandhaltungsplanung.],

    [Prüfung und Betriebsart],
    [Anstoß und Ergebnis von Geräte- und #acro("RCD")-Test sowie der Zustand des automatischen Wiedereinschaltens (#acro("ARD")).],

    [Kommandos],
    [Schreibende Datenpunkte für elektronisches Schalten, Quittieren, Rücksetzen von #acro("RCM")-Alarmen, Anstoßen des Gerätetests, Lokalisierung durch Blinken und mechanisches Trennen.],

    [Stammdaten],
    [Anlagenkennzeichen, Einbauort, Seriennummer, Artikelnummer, Firmwarestand, Phasenzuordnung und eingestellter Nennstrom. Ändern sich im Betrieb nicht.],

    [Konfiguration und Grenzwerte],
    [Ein- und Ausschalter, Grenzwerte und Hysteresen je Alarm, Mittelungszeiträume sowie geschützte Schutzeinstellungen. Mit Abstand die größte Gruppe.],
  ),
  caption: [Eigene Gliederung des Registerraums des #acro("ECPD") nach Nutzungszweck, auf Grundlage der Registerkarte @src:sentronregistermap]
)<tab:registergruppen>

Für die Gestaltung des Datenmodells sind über diese Gliederung hinaus sechs Eigenschaften des Registerraums bedeutsam, die sich aus der Registerkarte und aus der praktischen Arbeit mit den Geräten ergeben.

Erstens dominieren Konfigurationsdaten den Registerraum. Der größte Teil der Register des #acro("ECPD") entfällt auf die Alarm- und Grenzwertkonfiguration sowie auf geschützte Schutzeinstellungen. Diese Werte werden einmalig bei der Inbetriebnahme gesetzt und verbleiben nach dem Konzept aus @sec:konzept bei SENTRON Powerconfig. Für den Betrieb ist nicht die Schwelle relevant, sondern deren Überschreitung, und diese wird über das Alarmregister gemeldet.

Zweitens ist die Informationsdichte sehr ungleich verteilt. Ein einziges Register trägt als Bitfeld sämtliche Alarme des Geräts, während umgekehrt einzelne Werte wie mehrwortige Zeichenketten oder Gleitkommazahlen doppelter Genauigkeit mehrere Register belegen. Die Spalte „Länge" der Registerkarte gibt dabei die Anzahl der zu lesenden Register an; wird ein Mehrwortregister mit abweichender Länge gelesen, liefert das Gerät keine verwertbaren Daten.

Drittens liegen Werte teilweise doppelt vor. Der Schalterzustand jedes Endgeräts ist sowohl am Endgerät selbst als auch in einem Feld über alle 24 Endgeräte am Powercenter verfügbar; Gleiches gilt für Verbindungs- und Pairing-Zustände sowie für die Zähler von Parameteränderungen. Eine Abbildung beider Quellen wäre redundant und würde die Datenpunktzahl am Gateway vervielfachen.

Viertens sind nicht alle dokumentierten Register nutzbar. Ein Teil ist geräteweit konstant und damit ohne Informationsgewinn, ein weiterer Teil antwortet auf dem #acro("ECPD") mit einer Ausnahmemeldung oder liefert konstant null. Die Registerkarte allein ist folglich keine hinreichende Grundlage. Alle Angaben sind am Gerät zu prüfen, wie es der Umgang mit der Herstellerdokumentation nach @sec:quellenlage vorsieht.

Fünftens sind Alarme nicht ohne Weiteres wirksam. Von den für das #acro("ECPD") belegten Alarmbits ist nur ein kleinerer Teil ab Werk aktiv; die übrigen müssen zunächst in SENTRON Powerconfig eingeschaltet werden und liefern andernfalls dauerhaft den Wert null. Betroffen sind unter anderem die beiden #acro("RCM")-Alarme, die zu den aussagekräftigsten Meldungen des Geräts zählen. Ein Datenmodell allein genügt daher nicht; es ist um eine Aussage zur erforderlichen Geräteparametrierung zu ergänzen.

Sechstens fehlt ein Energiezähler. Der Registersatz des #acro("ECPD") enthält die momentane Wirkleistung, jedoch besitzt er keine Zählfunktion. Eine Auswertung des Energieverbrauchs setzt daher voraus, dass Desigo CC die Leistung über die Zeit integriert oder in der Anwendung ein weiteres Gerät eingebaut wird. 

Aus dieser Charakterisierung folgt die zentrale Erkenntnis des Abschnitts: Der Registerraum ist nicht vollständig, sondern begründet reduziert abzubilden. Die Auswahl hat sich am tatsächlichen Nutzen für den Betrieb zu orientieren, Konfigurationsdaten auszuklammern, Redundanzen aufzulösen und die Abfragelast durch abgestufte Zyklen zu begrenzen. Die Durchführung dieser Auswahl ist Gegenstand des Entwicklungsteils.


=== Anwendungsfälle<sec:usecases>

Die vorangegangenen Abschnitte beschreiben, was technisch möglich ist. Welche dieser Möglichkeiten tatsächlich benötigt werden, ergibt sich aus den Tätigkeiten der in @sec:stakeholder eingeordneten Gruppen. Die folgenden Anwendungsfälle beschreiben diese Tätigkeiten und bilden die Brücke zu den Anforderungen. Sie sind bewusst frei von technischen Festlegungen formuliert: Was daraus für die Lösung folgt, wird erst im Anforderungskatalog bestimmt, der jeder Anforderung die tragenden Anwendungsfälle zuordnet.

#figure(
  table(
    columns: (4em, 1fr, 8em),
    inset: 6pt,
    align: (left + horizon, left, left + horizon),
    table.header(
      [*ID*], [*Anwendungsfall*], [*Akteur*],
    ),
    [UC-01],
    [Geräte eines Verteilers in Desigo CC einbinden: Typbeschreibung importieren, je physischem Gerät eine Instanz anlegen und die Adressierung festlegen.],
    [Systemintegrator],

    [UC-02],
    [Betriebszustand der Abgänge in der Leitwarte überwachen und dabei planmäßiges Ausschalten von störungsbedingtem Auslösen unterscheiden.],
    [Betreiber],

    [UC-03],
    [Eine Störung erkennen, nach Dringlichkeit einordnen, den betroffenen Stromkreis lokalisieren und die Meldung nach Behebung quittieren.],
    [Betreiber, Instandhaltung],

    [UC-04],
    [Ausfall der Datenverbindung zu einem Endgerät oder zum Powercenter erkennen und von einem tatsächlichen Anlagenereignis unterscheiden.],
    [Betreiber, IT-Betrieb],

    [UC-05],
    [Einen Stromkreis aus der Leitwarte schalten und anhand der Rückmeldung prüfen, ob der Befehl ausgeführt wurde.],
    [Betreiber, Instandhaltung],

    [UC-06],
    [Wiederkehrende Prüfung anstoßen, das Ergebnis auswerten und den Nachweis in Desigo CC dokumentieren.],
    [Elektrofachkraft],

    [UC-07],
    [Wartungsbedarf aus Zählerständen und Alarmen ableiten und einen Einsatz vorbereiten, ohne zuvor vor Ort zu prüfen.],
    [Instandhaltung],

    [UC-08],
    [Ein bestimmtes Gerät unter baugleichen Geräten im Verteiler auffinden.],
    [Servicetechniker],

    [UC-09],
    [Anlagendokumentation aus den Stammdaten der Geräte führen und Datenpunkte eindeutig beschriften.],
    [Betreiber, Integrator],

    [UC-10],
    [Einzelne Datenpunkte des Datenmodells ergänzen, entfernen oder anpassen, ohne das Modell neu zu erstellen.],
    [Siemens-Entwicklung],
  ),
  caption: [Anwendungsfälle der Lösung und die Gruppen, aus deren Tätigkeit sie hervorgehen]
)<tab:usecases>

Der Abgleich dieser Anwendungsfälle mit dem zu Beginn der Arbeit aufgestellten Anforderungskatalog hat mehrere Punkte offengelegt, die vor der Modellierung zu klären waren. Sie betreffen sowohl den Zuschnitt einzelner Anforderungen als auch zwei Fragen, die sich nur durch eine Messung am Testaufbau beantworten lassen. Beides ist Gegenstand von @sec:anforderungen und dort in @sec:anforderungsvorbehalte zusammengefasst.

/* Claude: Die zuvor hier stehenden fuenf Abschnitte (Konflikt Fernsteuerung/Parametrierung,
   Belastbarkeit des Fernschaltens, Visualisierung und Energieauswertung, Nachvollziehbarkeit
   von Parameteraenderungen, Dokumentationsstand und Systemversion) sind nach der Durchsicht
   entfallen, weil sie den Anforderungen vorgriffen. Der Inhalt wird in 320_Anforderungen.typ
   bei den betroffenen Anforderungen und in @sec:anforderungsvorbehalte aufgegriffen.

   Die Aenderungen am Katalog sind in Requirements.xlsx eingetragen: FA-06 geaendert,
   FA-07 gestrichen, FA-10 ergaenzt, FA-11 nicht aufgenommen; hinzu kommen NFA-06 und
   RB-05 bis RB-07. Die betroffenen Zeilen tragen in der Spalte "Kommentar" einen
   datierten Vermerk, der urspruengliche Stand liegt als
   Requirements_BACKUP_2026-08-06.xlsx im Projektverzeichnis. Die Aenderungen sind mit dem
   Betreuer abzustimmen; die ausfuehrliche Aenderungstabelle liegt in
   @sec:anforderungsvorbehalte auskommentiert im Quelltext.

   Hinweis: Der Kommentar in Requirements.xlsx zu FA-11 verweist auf einen UC-12, den es
   in obiger Tabelle nicht gibt. In der Arbeit wird der Verweis daher nicht gefuehrt;
   die Zelle in der Arbeitsmappe waere bei Gelegenheit zu bereinigen. */

/* Claude: @tab:integrationswege nach der Anmerkung des Betreuers umgebaut
   (Ausschluss und Abwaegung vermischt) und am 31.08.2026 nach einem
   Speicherkonflikt wiederhergestellt.

   W2 ist aus der Tabelle entfernt. Der Absatz darueber sagt "Drei Wege
   scheiden ohne naehere Bewertung aus" und nennt W1, W2 und W5, danach stand
   W2 aber als bewertete Spalte in der Tabelle. Das war ein Widerspruch im
   Abschnitt selbst, und die Bildunterschrift nannte nur W1 und W5.

   Die Kriterien sind jetzt in zwei Gruppen gefuehrt. Ausschlusskriterien sind
   die, an denen W1, W2 und W5 gescheitert sind; die drei verbleibenden Wege
   erfuellen sie alle. Darunter stehen die Abwaegungskriterien, die keine
   Gewichtung tragen. Statt eines Ergebnisworts nennt die Schlusszeile den
   ausschlaggebenden Nachteil, weil "ungeeignet" zuvor sowohl fuer das
   technisch Unmoegliche (W2) als auch fuer das nur Aufwendige (W4) stand,
   obwohl der Text zu W4 die Eigenentwicklung ueber das SDK ausdruecklich als
   gangbar beschreibt. Der Schlusssatz sagt nicht mehr "der alle Kriterien
   erfuellt", da das alle fuenf Kriterien als Gates gelesen haette und W6 dann
   schlicht durchgefallen waere.

   Zahlenbasis in @sec:registerraum und im Absatz zum Mengengeruest auf die
   Registerkarte umgestellt: ECPD 152, POC 1100 211, voll bestueckter Strang
   rund 3900 Eintraege. Herleitung siehe Kommentar in @sec:datenpunkte.

   VORBEHALT: Die Zahl der Straenge je Treiberinstanz ist nur proportional von
   sechs auf acht mitgezogen. Die zugrunde liegende Obergrenze von Desigo CC
   steht nirgends in der Arbeit. Entweder Quelle ergaenzen oder die Aussage
   qualitativ fassen. */

/* Claude: UC-05 (Last- und Energieverlauf je Abgang auswerten) am 31.08.2026
   gestrichen, weil dem ECPD die Zaehlfunktion fuer die elektrische Arbeit fehlt
   (siehe @sec:befunde). Der Anwendungsfall haette eine Faehigkeit vorausgesetzt,
   die das Geraet nicht hat.

   Die nachfolgenden Anwendungsfaelle sind aufgerueckt: alt UC-06 bis UC-11
   heissen jetzt UC-05 bis UC-10. Umgestellt wurden alle Verweise in neun
   Dateien (310, 320, 420, 530, 540, 560, 640, 720, 730). Die Tabelle laeuft
   lueckenlos von UC-01 bis UC-10.

   Verweise auf das gestrichene UC-05 sind an drei Stellen entfallen: FA-02 in
   @sec:fa fuehrt jetzt nur noch UC-02, die Zeile "Messwerte" in
   @tab:datenpunkte_ecpd nur noch UC-02 und UC-07, und die Aufzaehlung in
   @sec:praxistauglichkeit ist entsprechend gekuerzt. Der fehlende Energiezaehler
   bleibt als Befund in @sec:befunde und @sec:praxistauglichkeit erhalten, dort
   aber als Eigenschaft des Geraets und nicht als unerfuellter Anwendungsfall.

   ACHTUNG: Requirements.xlsx fuehrt weiterhin die alte Nummerierung. Die
   Zuordnungen dort sind vor der Abgabe nachzuziehen, sonst zeigen die Zellen
   auf die falschen Anwendungsfaelle. Der dort zu FA-11 vermerkte UC-12 existiert
   ohnehin nicht und ist bei der Gelegenheit mit zu bereinigen. */

/* Claude: Am 02.09.2026 gekuerzt. Der Absatz zum IT- und Netzwerkbetrieb
   verweist fuer die sicherheitsrelevanten Eigenschaften jetzt auf
   @sec:integrationswege, statt die Abgrenzung ein zweites Mal auszufuehren.
   Der Absatz zu den einflussreichsten Gruppen ist auf einen Satz
   zusammengezogen. */
