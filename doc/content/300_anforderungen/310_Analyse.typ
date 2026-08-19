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

Die in @sec:ecpd bis @sec:desigocc beschriebenen Komponenten stehen im Betrieb nicht nebeneinander, sondern in einer festen Kette. Die #acro("ECPD") vom Typ 5TY1 COM sitzen als Endstromkreisschutz im Installationsverteiler, erreichen über die Funkstrecke ausschließlich das SENTRON Powercenter, und erst dieses stellt die Daten über das Gebäudenetz bereit, wo Desigo CC sie abfragen kann. @img:systemaufbau zeigt diese Kette zusammen mit den beiden Werkzeugen, die nicht Teil des laufenden Datenpfads sind, für den Lebenszyklus der Lösung aber maßgeblich bleiben. SENTRON Powerconfig dient der Inbetriebnahme und Parametrierung der Geräte vor Ort und greift dazu über #acro("BLE") oder über die REST-#acro("API") des Powercenters zu @src:sentronsystemhandbuch, während der #acro("PDE") die Gerätetypbeschreibung als #acro("JSON")-Datei erzeugt (siehe @sec:pde).

#figure(
  abb_systemaufbau,
  caption: [Datenpfad vom #acro("ECPD") über die Funkstrecke zum Powercenter, von dort über Modbus #acro("TCP") im Gebäudenetz zu Desigo CC, seitlich angetragen die Werkzeuge SENTRON Powerconfig und #acro("PDE") mit ihren jeweiligen Zugriffspunkten],
)<img:systemaufbau>

Eine Einheit aus einem Powercenter und den ihm zugeordneten Endgeräten wird im Folgenden als _Strang_ bezeichnet. Eine Liegenschaft kann mehrere solcher Stränge enthalten. Der konkrete Laboraufbau, an dem die Lösung erprobt wird, ist von dieser allgemeinen Betrachtung zu unterscheiden und wird im Kapitel zur Systemumgebung beschrieben.

Aus der Kette ergibt sich die Systemgrenze der Arbeit. Gegenstand ist die Abbildung zwischen dem Modbus-Registerraum, den das Powercenter bereitstellt, und dem Objektmodell in Desigo CC. Nicht Gegenstand sind die Schutzfunktion der Geräte selbst, die Funkstrecke zwischen Endgerät und Powercenter, die elektrotechnische Installation sowie die Systemarchitektur von Desigo CC einschließlich ihrer Redundanz- und Betriebskonzepte. Welche Gestalt die Lösung innerhalb dieser Grenze annimmt, ist an dieser Stelle noch offen und wird erst in @sec:konzept aus den Ergebnissen der folgenden Abschnitte abgeleitet.

Für die Ausgangslage ist dabei bedeutsam, dass die betrachtete Gerätereihe in Desigo CC bislang nicht zur Verfügung steht. Das Erweiterungsmodul „Modbus TCP Power Devices" bringt eine Bibliothek vorgefertigter Objektmodelle für diverse Siemens-Niederspannungsgeräten für Gebäude mit, jedoch weder das #acro("ECPD") noch das Powercenter sind darin enthalten @src:desigoccenghelp. Rückwärtskompatibilität zu einer Vorgängerlösung ist folglich keine Anforderung.

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

Zwischen diesen Gruppen bestehen zwei Spannungsfelder, die die Gestaltung des Modells unmittelbar betreffen. Das erste verläuft zwischen dem Endkunden ohne eigene Entwicklung und dem selbst entwickelnden Endkunden: Ersterer verlangt eine Lösung, die fertig und ohne Erklärung funktioniert, letzterer eine, die offen und veränderbar ist. Beides ist nur vereinbar, wenn das Modell zwar unmittelbar einsetzbar, in seiner Struktur aber modular und dokumentiert ist. Das zweite Spannungsfeld verläuft zwischen dem Betreiber, der möglichst viele Informationen in der Leitwarte sehen möchte, und dem Instandhaltungspersonal sowie dem Systemintegrator, für die jeder zusätzliche Datenpunkt Projektierungs- und Kommunikationsaufwand bedeutet. Es ist der eigentliche Grund dafür, dass die Auswahl der Datenpunkte einen eigenen Arbeitsschritt darstellt und nicht nebenbei erledigt werden kann.

Eine Gruppe ist dabei gesondert einzuordnen. Der IT- und Netzwerkbetrieb ist zwar von der Lösung berührt, seine Erwartung lässt sich jedoch nicht allgemeingültig erfüllen: Netzarchitektur, Zonenmodell, Zugriffsregeln und Betriebskonzepte folgen bei jedem Kunden eigenen Vorgaben, sodass ein Sicherheitskonzept für die Anbindung nur im jeweiligen Projekt und nicht in einer generischen Integrationsvorlage festgelegt werden kann. Diese Arbeit benennt daher die sicherheitsrelevanten Eigenschaften des gewählten Übertragungswegs und die Voraussetzungen, unter denen er vertretbar betrieben werden kann; die Bewertung und Ausgestaltung der Netzsicherheit selbst ist ausdrücklich nicht Gegenstand der Arbeit.

Eine Erwartung des Instandhaltungspersonals verdient dabei eine Einordnung, weil sie leicht überdehnt wird. Das #acro("ECPD") führt einen zyklischen Selbsttest durch und kann dessen Ergebnis melden (siehe @sec:ecpd_geraet). Damit lassen sich Gerätefehler früh sichtbar machen, die andernfalls erst bei einer wiederkehrenden Prüfung nach #acro("DGUV") Vorschrift 3 auffielen und dann Austausch und erneute Prüfung nach sich zögen. Die wiederkehrende Prüfung selbst lässt sich dadurch jedoch nicht ersetzen, da sie die Beurteilung durch eine befähigte Person voraussetzt. Die Erwartung richtet sich folglich auf die Unterstützung und die Dokumentation der Prüfung, nicht auf deren Automatisierung.

Auffällig ist außerdem, dass die Gruppen mit dem höchsten Einfluss, also Betreiber, Instandhaltung, Systemintegrator und Produktmanagement, ihre Erwartungen an vergleichsweise wenige Eigenschaften knüpfen. Es sind die Verlässlichkeit der Zustandsanzeige, die Aussagekraft der Alarme, die Wiederverwendbarkeit des Modells und die Nachvollziehbarkeit seiner Struktur. Diese vier Eigenschaften bilden den Maßstab, an dem die Lösung in der Validierung zu messen ist.

/* Claude: Der offene Punkt aus der Durchsicht (Selbsttest des ECPD, Verhaeltnis
   zur DGUV-Pruefung) ist eingearbeitet: als Erwartung in der Tabellenzeile zur
   Instandhaltung und als eigener Absatz mit der Abgrenzung, dass die
   wiederkehrende Pruefung nicht ersetzbar ist. Die Auswirkung auf FA-08 und die
   Frage, welche Test- und Selbsttestregister dafuer tatsaechlich abgebildet
   werden, bleibt dem Anforderungskatalog und dem Entwicklungsteil vorbehalten. */


=== Analyse der Integrationswege<sec:integrationswege>

Die Frage, über welchen Weg die Daten in Desigo CC gelangen, ist der Ausgangspunkt jeder weiteren Festlegung, denn sie entscheidet über den verfügbaren Datenumfang, über die Möglichkeit schreibender Zugriffe und über die einzusetzende Werkzeugkette. Der folgende Abschnitt trifft dabei keine Entwurfsentscheidung, sondern grenzt den Lösungsraum ab. Er stellt fest, welche Wege technisch überhaupt bestehen, und bildet damit die Voraussetzung dafür, dass die Anforderungen im folgenden Abschnitt realistisch formuliert werden können. Ein Weg ist nur dann gangbar, wenn er auf beiden Seiten unterstützt wird, also sowohl vom Powercenter als Datenquelle als auch von Desigo CC als Zielsystem. Desigo CC bindet Fremdsysteme über Erweiterungsmodule für offene Protokolle ein, für die die Engineering-Dokumentation eigene Kapitel zu BACnet, Modbus #acro("TCP"), OPC DA, #acro("SNMP") und IEC 61850 führt @src:desigoccenghelp.

Aus dem Schnittstellenangebot des Powercenters (siehe @sec:powercenter_schnittstellen) und den Gegebenheiten der Feldebene ergeben sich sechs denkbare Wege. Die Bezeichner W1 bis W6 dienen allein der Verweisbarkeit innerhalb dieses Abschnitts.

==== W1 Direkter Zugriff auf das Endgerät

Der naheliegendste Weg, das Endgerät unmittelbar anzusprechen, ist technisch versperrt. Die Schutzschaltgeräte besitzen keine Modbus-Schnittstelle und kommunizieren ausschließlich über die Funkstrecke mit dem Powercenter. Sie sind für übergeordnete Systeme nicht direkt erreichbar @src:sentronsystemhandbuch. Der Weg scheidet ohne weitere Bewertung aus.

==== W2 Bluetooth am Powercenter

Die #acro("BLE")-Schnittstelle ist als lokaler Zugang vor Ort ausgelegt. Sie unterstützt nur eine aktive Verbindung, schaltet sich nach $180space.thin"s"$ ohne Nutzung ab und ist über eine sechsstellige PIN abgesichert @src:sentronsystemhandbuch. Für eine dauerhafte, zyklische Anbindung eines Leitsystems ist sie damit weder vorgesehen noch geeignet.

==== W3 Modbus TCP über das Powercenter

Das Powercenter tritt als Modbus-#acro("TCP")-Server auf und stellt die Daten aller unterlagerten Endgeräte über eine einzige #acro("IP")-Adresse bereit, wobei die Unterscheidung der Geräte über den Unit Identifier erfolgt @src:sentronsystemhandbuch. Lesende wie schreibende Zugriffe sind möglich, das Protokoll ist offen spezifiziert und lizenzfrei (siehe @sec:modbus). Auf der Gegenseite steht mit dem Erweiterungsmodul „Modbus TCP" ein vollständiger Treiber bereit, in dem Desigo CC als Client auftritt @src:desigoccenghelp. Die Ausgestaltung dieses Wegs wird in @sec:desigoccmechanik gesondert untersucht.

==== W4 REST-Schnittstelle über HTTPS

Diese Schnittstelle ist der Modbus-Variante sicherheitstechnisch deutlich überlegen, da sie über #acro("TLS") verschlüsselt ist und der rollenbasierten Zugriffskontrolle des Powercenters unterliegt @src:sentronsystemhandbuch. Sie ist jedoch herstellerspezifisch und damit kein Protokoll, für das in Desigo CC ein generisches Erweiterungsmodul bereitsteht @src:desigoccenghelp. Eine Anbindung erforderte eine Eigenentwicklung über das Software Development Kit. Ebenso wenig ließe sich der #acro("PDE") nutzen, dessen Ergebnis ausdrücklich eine Beschreibung der Modbus-Kommunikation ist @src:pdemanual. Die vorgesehene Werkzeugkette entfiele damit vollständig.

==== W5 MQTT

Die native Cloud-Anbindung steht ausschließlich am Powercenter 2000 zur Verfügung @src:sentronsystemhandbuch, während für den Testaufbau ein Powercenter 1100 vorgesehen ist. Unabhängig davon ist #acro("MQTT") ein publikationsgetriebenes Protokoll zur Anbindung externer Dienste. Es passt weder zum lokalen Charakter einer Gebäudemanagementplattform noch zählt es zu den von Desigo CC unterstützten Feldprotokollen @src:desigoccenghelp.

==== W6 Vorgelagertes Fremdsystem

Die vom #acro("PDE") ausdrücklich unterstützten Zielapplikationen sind der SENTRON Powermanager und das SENTRON Powercenter 3000 @src:pdemanual. Die Geräte ließen sich zunächst in einer dieser Applikationen einbinden und diese anschließend an Desigo CC koppeln. Beide Produkte verfolgen dasselbe Ziel, unterscheiden sich aber sowohl in ihrer Bauform als auch in ihren Schnittstellen, weshalb sie hier getrennt zu betrachten sind.

Der SENTRON Powermanager ist ein Energiemanagementsystem, das unter Windows auf einem gewöhnlichen Rechner installiert wird, über eine Lizenz erworben wird und bis zu 700 unterlagerte Geräte je Server führt. Zur Feldebene hin unterstützt er neben Modbus #acro("TCP") auch OPC UA und OPC DA, IEC 61850 sowie BACnet, und nach oben stellt er OPC UA und OPC DA bereit @src:sentronsoftwareguide. Da Desigo CC OPC DA als Feldprotokoll unterstützt @src:desigoccdatasheet, ist eine Kopplung über diesen Weg tatsächlich möglich.

Das SENTRON Powercenter 3000 ist demgegenüber kein Softwarepaket, sondern ein Industrierechner mit vorinstallierter Monitoring-Software, der als Gerät beschafft und über optionale Lizenzen erweitert wird und bis zu 212 unterlagerte Geräte führt. Zur Feldebene hin unterstützt er ausschließlich Modbus #acro("TCP"), und nach oben stellt er allein eine #acro("MQTT")-Schnittstelle zu Cloud-Diensten bereit @src:sentronsoftwareguide. Eine Kopplung an Desigo CC scheidet damit aus demselben Grund aus wie in W5.

Gangbar ist folglich nur die Variante über den Powermanager. Sie führt jedoch ein zweites Leitsystem mit eigener Datenhaltung, eigener Alarmierung und eigenem Wartungsbedarf ein und verschiebt die eigentliche Aufgabe, nämlich die Abbildung der Gerätedaten in Desigo CC, lediglich in ein anderes System. Der Aufwand der Gesamtlösung steigt durch die zusätzliche Komponente und die zusätzliche Schnittstelle deutlich, ohne dass ein entsprechender Gewinn entstünde.

Zur Bewertung der verbleibenden Wege werden fünf Kriterien herangezogen. Es sind die Verfügbarkeit auf beiden Seiten, die Eignung für den zyklischen Dauerbetrieb, der erreichbare Datenumfang einschließlich schreibender Zugriffe, die Nutzbarkeit der vorgesehenen Werkzeugkette sowie der Bedarf an zusätzlichen Systemkomponenten. Die Informationssicherheit wird bewusst nicht als gleichrangiges Kriterium geführt, sondern im Anschluss gesondert betrachtet, da sie im Gegensatz zu den anderen Kriterien durch Maßnahmen außerhalb des Protokolls beeinflussbar ist.

#figure(
  table(
    columns: (1fr, auto, auto, auto, auto),
    inset: 7pt,
    align: (left, center, center, center, center),
    table.header(
      [*Kriterium*], [*W2*], [*W3*], [*W4*], [*W6*],
    ),
    [Beidseitig verfügbar], [nein], [ja], [nein], [ja],
    [Zyklischer Dauerbetrieb], [nein], [ja], [ja], [ja],
    [Datenumfang und Schreibzugriff], [ja], [ja], [ja], [eingeschränkt],
    [Werkzeugkette nutzbar], [nein], [ja], [nein], [ja],
    [Ohne Zusatzsysteme], [ja], [ja], [ja], [nein],
    [*Ergebnis*], [*ungeeignet*], [*geeignet*], [*ungeeignet*], [*bedingt*],
  ),
  caption: [Bewertung der Integrationswege. W2 #acro("BLE"), W3 Modbus #acro("TCP"), W4 REST-Schnittstelle, W6 vorgelagerter Powermanager. W1 ist bereits technisch ausgeschlossen, W5 steht am eingesetzten Gerät nicht zur Verfügung]
)<tab:integrationswege>

Damit bleibt Modbus #acro("TCP") über das Powercenter als einziger Weg, der alle Kriterien erfüllt. Diese Feststellung ist weniger eine Auswahl unter gleichwertigen Alternativen als vielmehr die Bestätigung, dass die Schnittstellenlage von Quell- und Zielsystem nur eine Schnittmenge zulässt. Bemerkenswert ist dabei, dass ausgerechnet der sicherheitstechnisch schwächste Weg der einzige durchgängig unterstützte ist.

Diese Schwäche ist keine Nebenbedingung, sondern die zentrale Einschränkung des gewählten Wegs. Da das Protokoll selbst weder Verschlüsselung noch Authentifizierung kennt (siehe @sec:modbus) und die rollenbasierte Zugriffskontrolle des Powercenters ausschließlich auf die #acro("HTTPS")-Kommunikation wirkt @src:sentronsystemhandbuch, kann ein Schutz nur außerhalb des Protokolls auf Netzebene entstehen. Daraus folgen drei Voraussetzungen, die als Randbedingungen in die Anforderungen einfließen. Die Modbus-Schnittstelle wird nur dort aktiviert, wo sie benötigt wird, was am Powercenter 1100 separat möglich ist @src:sentronsystemhandbuch. Die Kommunikation verbleibt in einem eigenen Netzsegment. Ein Zugriff über das lokale Netz hinaus erfolgt ausschließlich über #acro("VPN").

Diese drei Punkte sind als Mindestvoraussetzungen des Betriebs zu verstehen, nicht als Sicherheitskonzept. Wie Segmentierung, Fernzugriff und Überwachung im Einzelnen umgesetzt werden, richtet sich nach den Vorgaben des jeweiligen Kunden und ist, wie in @sec:stakeholder abgegrenzt, nicht Gegenstand dieser Arbeit.

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

Mit der Festlegung auf Modbus #acro("TCP") ist noch nicht bestimmt, in welcher Form das Datenmodell auf der Zielseite überhaupt vorliegen kann. Da die von Desigo CC vorgegebenen Mechanismen die Gestalt der Lösung unmittelbar begrenzen, werden sie hier gesondert untersucht. Grundlage ist die Engineering-Dokumentation der Plattform @src:desigoccenghelp, die für die Stände V5.1 und V7 vorlag und in beiden dieselben Aussagen trifft, nicht jedoch für den von NFA-04 geforderten Stand V9.0 (siehe @sec:quellenlage).

/* Claude: Die Angaben dieses Abschnitts stammen aus der Engineering Help. Geprueft wurden
   die Plattformstaende V5.1 und V7; die verwendeten Aussagen sind in beiden identisch.
   NFA-04 fordert jedoch V9.0, wozu keine Dokumentation zugaenglich war. Siehe dazu den
   Vorbehalt zu NFA-04 in @sec:anforderungsvorbehalte.

   Der zuvor hier vermerkte offene Punkt, die JSON-Objektmodellbeschreibung trage keine
   Modbus-Adressen, ist erledigt. Er war auf den allgemeinen Importweg der Engineering
   Help bezogen, nicht auf den hier gewaehlten Weg ueber den PDE. Die vom PDE erzeugte
   Typbeschreibung fuehrt Registeradresse, Funktionscode, Datentyp und Skalierung je
   Eigenschaft mit (siehe @tab:pde_schritte), sodass nur ein Artefakt zu entwickeln ist.
   Der folgende Absatz ist entsprechend umgeschrieben. */

Von den Mitteln, die die Plattform für eine Modbus-Anbindung bereithält, ist für diese Arbeit im Wesentlichen eines maßgeblich. Ein Gerätetyp wird in Desigo CC als Objektmodell beschrieben, und dieses Objektmodell lässt sich als #acro("JSON")-Datei importieren @src:desigoccenghelp. Damit besteht eine unmittelbare Entsprechung zu dem Format, das der #acro("PDE") erzeugt (siehe @sec:pde), und genau an dieser Stelle setzt das Datenmodell dieser Arbeit an. Die Dokumentation des #acro("PDE") führt Desigo CC allerdings nicht als Zielapplikation (siehe @sec:pde_ziel), weshalb diese Entsprechung nicht dokumentiert ist, sondern am Testaufbau zu bestätigen war.

Für den Zuschnitt der Lösung ist dabei entscheidend, dass die Typbeschreibung des #acro("PDE") die Adressierung bereits enthält. Zu jeder Eigenschaft werden dort Registeradresse, Funktionscode, Datentyp, Subindex und Skalierungsfaktor hinterlegt (siehe @tab:pde_schritte), sodass Objektmodell und Adressbelegung in derselben Datei liegen. Die Lösung dieser Arbeit besteht folglich aus einem einzigen zu entwickelnden Artefakt. Daneben beschreibt die Engineering-Dokumentation einen allgemeinen Weg, auf dem ein Objektmodell ohne Adressangaben eingelesen und die Zuordnung von Registeradressen und Funktionscodes in eigenen Regelwerken danebengelegt wird @src:desigoccenghelp. Dieser Weg kommt ohne den #acro("PDE") aus, gibt dessen Werkzeugkette damit aber auch auf und wird hier nicht beschritten.

Nicht Gegenstand der Entwicklung sind zwei weitere Bestandteile einer vollständigen Integration. Das sind zum einen Grafiken, Symbole und Textgruppen für die Darstellung in der Bedienoberfläche, zum anderen die Liste der tatsächlich anzulegenden Geräteinstanzen @src:desigoccenghelp. Beides fällt im jeweiligen Projekt an und hängt an der konkreten Anlage, nicht am Gerätetyp.

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
    [Das Intervall, in dem der Treiber ein Gerät abfragt, ist einstellbar und gilt einheitlich für dessen Datenpunkte. Eine nach Datenpunktgruppen abgestufte Abfrage steht am eingesetzten Stand nicht zur Verfügung, was von der Dokumentation abweicht und deshalb nach @sec:quellenlage der Beobachtung folgt, sodass die Abfragelast allein über die Zahl der abgebildeten Datenpunkte und über das Intervall je Gerät gesteuert werden kann.],

    [Blockbildung],
    [Register, deren Adressabstand einen einstellbaren Grenzwert unterschreitet, werden zu einem gemeinsamen Leseblock zusammengefasst. Eine dichte Belegung des Adressraums verringert damit unmittelbar die Zahl der Telegramme.],

    [Schreibrichtung],
    [Ein Datenpunkt kennt entweder die Lese- oder die Schreibrichtung, nicht beide. Für Werte, die geschrieben und zurückgelesen werden sollen, sieht die Plattform Objektmodelle mit getrennten Eigenschaften für Soll- und Istwert vor.],
  ),
  caption: [Eigenschaften des Modbus-Treibers von Desigo CC und ihre Bedeutung für die Modellierung, nach @src:desigoccenghelp]
)<tab:modbustreiber>

#kommentar("Abfrageintervall ist noch offen, das muss ich nochmal im Detail prüfen wie das ist")

// #kommentar[Prüfung offen: Die Zeile zum Abfrageintervall stützt sich auf die Beobachtung am eingesetzten Stand, dass sich die Abfragegeschwindigkeit nur je Gerät und nicht je Datenpunktgruppe einstellen lässt. Die Engineering-Dokumentation beschreibt dagegen benannte Abfragegruppen mit eigenem Intervall. Vor Abgabe ist zu klären, ob die Gruppen an der installierten Version tatsächlich nicht nutzbar sind oder ob sie lediglich nicht projektiert waren. Von der Antwort hängt ab, ob die abgestufte Abfrage eine Möglichkeit der Weiterentwicklung bleibt oder bereits in dieser Arbeit umgesetzt werden kann.]

Die letzte Zeile der Tabelle verdient besondere Beachtung. Sie bedeutet, dass ein Schaltbefehl und die zugehörige Rückmeldung im Modell zwingend zwei Eigenschaften belegen, selbst wenn beide auf dasselbe Register verweisen. Die Einschränkung trifft damit unmittelbar auf die Kommandoregister des #acro("ECPD"). Ebenso bemerkenswert ist das Mengengerüst. Bei rund 5.200 Datenpunkten für einen vollständig abgebildeten Strang, dessen Herleitung in @sec:registerraum folgt, ließen sich überschlägig nur etwa sechs Stränge über eine einzige Treiberinstanz betreiben. Auch von dieser Seite her ist eine Reduktion des Datenumfangs vonnöten.

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

Powercenter und #acro("ECPD") werden als getrennte Objekttypen modelliert. Ein erheblicher Teil der Register stimmt zwar überein, es handelt sich jedoch um verschiedene Geräte mit unterschiedlicher Aufgabe und unterschiedlicher Adressierung. Auf der Zielseite entspricht ein Strang damit bis zu 25 Kommunikationsschnittstellen mit gemeinsamer #acro("IP")-Adresse und unterschiedlicher Slave-Adresse, unter denen jeweils genau ein Geräteobjekt liegt @src:desigoccenghelp. Der Schwerpunkt liegt dabei auf dem Objektmodell des #acro("ECPD"). Ein eigenes Objektmodell für das Powercenter ist von den Beteiligten nicht gefordert worden und wäre eine sinnvolle Ergänzung, aber keine Voraussetzung für den Nutzen der Lösung.

#figure(
  abb_konzept,
  caption: [Erstes Lösungskonzept, Werkzeugkette vom #acro("PDE") über die #acro("JSON")-Typbeschreibung zum Objektmodell in Desigo CC sowie die Instanziierung je physischem Gerät über den Unit Identifier],
)<img:konzept>

Für die Abfrage gibt das Systemhandbuch drei Empfehlungen, nämlich jedes Gerät höchstens einmal pro Sekunde abzufragen, die Endgeräte sequenziell abzuarbeiten und Register blockweise zu lesen @src:sentronsystemhandbuch. Diese Abfragemethodik ist von Desigo CC bereits implementiert, da der Treiber einen einstellbaren Abstand zwischen den Anfragen kennt und benachbarte Register selbsttätig zu Leseblöcken zusammenfasst @src:desigoccenghelp. Eine schnellere Abfrage brächte ohnehin keinen Gewinn, weil die Messwerte frühestens alle $2space.thin"s"$ aktualisiert werden @src:sentronsystemhandbuch. Da sich das Abfrageintervall nach @tab:modbustreiber nur je Gerät und nicht je Datenpunktgruppe einstellen lässt, werden alle Datenpunkte eines Geräts in demselben Takt gelesen. Die Abfragelast eines Strangs hängt damit unmittelbar an der Zahl der abgebildeten Datenpunkte, was die Auswahl der Daten zusätzlich begründet. Eine nach Verwendungszweck abgestufte Abfrage, bei der Zustands- und Alarmwerte häufiger gelesen würden als Zähler- und Stammdaten, wäre technisch wünschenswert und bleibt als Ansatzpunkt für eine Weiterentwicklung festzuhalten.

Ungültige Messwerte kennzeichnet das Powercenter als _Not a Number_, und zusätzlich zeigt ein Statusdatenpunkt an, ob die Verbindung zum Endgerät besteht @src:sentronsystemhandbuch. Beides ist im Modell auszuwerten, damit ein ausgefallenes Gerät nicht als Gerät mit dem Messwert null erscheint.

Schließlich sieht der Entwurf eine feste Arbeitsteilung zwischen den beiden Werkzeugen vor. Die Parametrierung der Geräte, also Grenzwerte, Hysteresen und Schutzeinstellungen, verbleibt bei SENTRON Powerconfig. Desigo CC übernimmt den laufenden Betrieb mit Anzeige, Archivierung, Alarmierung und Bedienung. SENTRON Powerconfig lässt sich damit nicht ablösen und wird von der errichtenden Fachkraft weiterhin benötigt, denn sobald in den elektrotechnischen Aufbau oder in die Wirkungsweise eines Geräts eingegriffen wird, hat dies über Powerconfig zu geschehen. Diese Aufteilung ist nicht nur eine Frage des Aufwands, sondern auch eine der Zuständigkeit. Änderungen an der Schutzwirkung setzen eine Elektrofachkraft voraus, während Desigo CC vom Personal der Gebäudeverwaltung bedient wird. Bleibt die Parametrierung außerhalb des Datenmodells, so ist ausgeschlossen, dass sie aus der Leitwarte heraus unbeabsichtigt verändert wird. Die Aufteilung hält das Datenmodell zugleich frei von Inbetriebnahmedaten und begründet, dass ein großer Teil des Registerraums unberücksichtigt bleiben kann. Die Auswirkung auf den Anforderungskatalog wird bei FA-06 und FA-09 in @sec:fa aufgegriffen.

/* Claude: Drei Hinweise aus der Durchsicht sind hier abgearbeitet.
   1. Die zuvor beschriebenen vier Abfragegruppen sind entfallen, weil sich das
      Abfrageintervall am eingesetzten Stand nur je Geraet einstellen laesst. Der
      Absatz nennt die abgestufte Abfrage stattdessen als Ansatzpunkt fuer eine
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

Grundlage ist die Übersicht der Datenpunkte und Modbus-Register der Gerätefamilie @src:sentronregistermap. Sie weist für das Powercenter 177 und für das #acro("ECPD") 208 Datenpunkte aus. Da einem Powercenter bis zu 24 Endgeräte zugeordnet sein können, ergäbe eine vollständige Abbildung rund 5.200 Datenpunkte je Strang. Bereits diese Größenordnung zeigt, dass eine unbesehene Übernahme des Registerraums weder gegenüber der Kommunikationslast noch gegenüber der Bedienbarkeit in der Leitwarte zu vertreten wäre.

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
    [Last- und Energieverlauf je Abgang über die Zeit auswerten und in einem Dashboard darstellen.],
    [Energiemanagement],

    [UC-06],
    [Einen Stromkreis aus der Leitwarte schalten und anhand der Rückmeldung prüfen, ob der Befehl ausgeführt wurde.],
    [Betreiber, Instandhaltung],

    [UC-07],
    [Wiederkehrende Prüfung anstoßen, das Ergebnis auswerten und den Nachweis in Desigo CC dokumentieren.],
    [Elektrofachkraft],

    [UC-08],
    [Wartungsbedarf aus Zählerständen und Alarmen ableiten und einen Einsatz vorbereiten, ohne zuvor vor Ort zu prüfen.],
    [Instandhaltung],

    [UC-09],
    [Ein bestimmtes Gerät unter baugleichen Geräten im Verteiler auffinden.],
    [Servicetechniker],

    [UC-10],
    [Anlagendokumentation aus den Stammdaten der Geräte führen und Datenpunkte eindeutig beschriften.],
    [Betreiber, Integrator],

    [UC-11],
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
