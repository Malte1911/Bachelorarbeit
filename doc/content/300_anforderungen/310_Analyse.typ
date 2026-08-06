#import "../../config/acronyms.typ": *
#include "../../config/config.typ"

== Analyse<sec:analyse>

Bevor Anforderungen an das Datenmodell formuliert werden können, ist zu klären, in welcher Umgebung die Lösung entstehen soll, wer sie später nutzt, über welchen Weg die Daten der Schutzschaltgeräte überhaupt in Desigo CC gelangen können, mit welchen Mitteln das Zielsystem sie abbildet und welcher Datenbestand auf diesem Weg zur Verfügung steht. Der vorliegende Abschnitt untersucht diese Fragen nacheinander und leitet aus den Ergebnissen Anwendungsfälle ab, die den Übergang zu den Anforderungen bilden.


=== Systemaufbau und Systemgrenzen<sec:systemanalyse>

Die Daten der Schutzschaltgeräte legen bis zur Managementstation einen festen Weg zurück, und dieser Weg bestimmt den Lösungsraum bereits weitgehend. Die #acro("ECPD") vom Typ 5TY1 COM sitzen als Endstromkreisschutz im Installationsverteiler und erfassen dort neben ihrer Schutzaufgabe Messgrößen wie Strom, Spannung, Wirkleistung, Differenzstrom und Temperatur (siehe @sec:ecpd). Eine eigene Ethernet- oder Modbus-Schnittstelle besitzen sie nicht; sie kommunizieren ausschließlich über ein proprietäres Funkprotokoll und sind für übergeordnete Systeme nicht direkt erreichbar @src:sentronsystemhandbuch. Erst das SENTRON Powercenter (siehe @sec:powercenter), das bis zu 24 Endgeräte ankoppelt, stellt deren Daten über Ethernet bereit. Es ist damit die einzige Stelle, an der die Gerätedaten das Funknetz verlassen, und zugleich der Punkt, an dem das in dieser Arbeit entwickelte Datenmodell ansetzt. Über das Gebäudenetz erreichen die Daten schließlich Desigo CC, wo sie als Objekte abgebildet, archiviert, alarmiert und visualisiert werden. Eine Einheit aus einem Powercenter und den ihm zugeordneten Endgeräten wird im Folgenden als _Strang_ bezeichnet; eine Liegenschaft kann mehrere solcher Stränge enthalten. Der konkrete Laboraufbau, an dem die Lösung erprobt wird, ist von dieser allgemeinen Betrachtung zu unterscheiden und wird im Kapitel zur Systemumgebung beschrieben.

Nicht Teil des laufenden Datenpfads, für den Lebenszyklus der Lösung aber maßgeblich, sind zwei Werkzeuge: SENTRON Powerconfig dient der Inbetriebnahme und Parametrierung der Geräte vor Ort und greift dazu über #acro("BLE") oder über die REST-#acro("API") des Powercenters zu @src:sentronsystemhandbuch, während der #acro("PDE") die Gerätetypbeschreibung als #acro("JSON")-Datei erzeugt und damit jenes Werkzeug ist, mit dem das Datenmodell dieser Arbeit entsteht (siehe @sec:pde).

#figure(
  image("../../resources/img/placeholder.png", width: 90%, format: "png"),
  caption: [PLATZHALTER: Datenpfad vom #acro("ECPD") über die Funkstrecke zum Powercenter, von dort über Modbus #acro("TCP") im Gebäudenetz zu Desigo CC; seitlich angetragen die Werkzeuge SENTRON Powerconfig und #acro("PDE") mit ihren jeweiligen Zugriffspunkten]
)<img:systemaufbau>

/* Claude: Die Abbildung traegt nach Absprache die Struktur, die zuvor als vier Ebenen
   ausformuliert war. Beim Zeichnen darauf achten, dass die Systemgrenze (Powercenter
   bis Desigo CC) und die beiden Werkzeuge erkennbar abgesetzt sind. */

Daraus ergibt sich die Systemgrenze der Arbeit. Gegenstand ist die Abbildung zwischen dem Modbus-Registerraum, den das Powercenter bereitstellt, und dem Objektmodell in Desigo CC. Nicht Gegenstand sind die Schutzfunktion der Geräte selbst, die Funkstrecke zwischen Endgerät und Powercenter, die elektrotechnische Installation sowie die Systemarchitektur von Desigo CC einschließlich ihrer Redundanz- und Betriebskonzepte.

Für die Ausgangslage ist dabei bedeutsam, dass die betrachtete Gerätereihe in Desigo CC bislang nicht zur Verfügung steht. Das Erweiterungsmodul „Modbus TCP Power Devices" bringt eine Bibliothek vorgefertigter Objektmodelle für Siemens-Energiemessgeräte mit, unter anderem für die Reihen SENTRON PAC 1500 bis 5200, den Leistungsschalter 3VL und die Auslöseeinheit 3VA ETU8; weder das #acro("ECPD") noch das Powercenter sind darin enthalten @src:desigoccenghelp. Die Arbeit beginnt damit nicht bei der Ablösung einer bestehenden Anbindung, sondern bei deren erstmaliger Schaffung; Rückwärtskompatibilität zu einer Vorgängerlösung ist folglich keine Anforderung.


=== Stakeholderanalyse<sec:stakeholder>

Das Datenmodell wird von unterschiedlichen Personengruppen mit deutlich verschiedenen Erwartungen genutzt. Die folgende Einordnung unterscheidet sie nach ihrer Rolle im Lebenszyklus der Lösung -- von der Entwicklung über die Inbetriebnahme bis zum laufenden Betrieb -- und benennt jeweils die Erwartung, aus der später Anforderungen abgeleitet werden.

#figure(
  table(
    columns: (7.5em, 1fr, 4.5em),
    inset: 7pt,
    align: (left + horizon, left, center + horizon),
    table.header(
      [*Interessengruppe*], [*Erwartung an die Lösung*], [*Einfluss*],
    ),
    [Betreiber und Facility Management],
    [Möchte auf einen Blick erkennen, ob ein Abgang in Betrieb ist, und im Störungsfall wissen, welcher Stromkreis an welchem Ort betroffen ist. Erwartet, dass sich die neuen Geräte in der Bedienung nicht von den übrigen Gewerken unterscheiden.],
    [hoch],

    [Instandhaltungspersonal und Elektrofachkraft],
    [Benötigt belastbare Diagnoseinformationen, um einen Einsatz vorzubereiten, und will unnötige Fahrten vermeiden. Erwartet zudem Unterstützung bei der wiederkehrenden Prüfung und deren Dokumentation.],
    [hoch],

    /* Claude: Offener Punkt aus der Durchsicht -- das ECPD fuehrt eigene Selbsttests durch,
       die einen Alarm ausloesen koennen und Probleme frueh sichtbar machen, die sonst erst
       bei einer DGUV-Pruefung auffielen. Ob und wo das aufgegriffen wird (hier, bei FA-08
       oder erst im Entwicklungsteil), ist nach Absprache noch offen und bewusst noch nicht
       eingearbeitet. Eine automatisierte DGUV-Pruefung ueber Desigo CC duerfte an der
       erforderlichen Abnahme durch eine befaehigte Person scheitern. */


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
    [Hat kein Interesse an der Integrationsvorlage als solcher und soll idealerweise nicht bemerken, dass sie existiert -- die Geräte sollen in Desigo CC einfach vorhanden sein.],
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

Auffällig ist ferner, dass die Gruppen mit dem höchsten Einfluss -- Betreiber, Instandhaltung, Systemintegrator und Produktmanagement -- ihre Erwartungen an vergleichsweise wenige Eigenschaften knüpfen: Verlässlichkeit der Zustandsanzeige, Aussagekraft der Alarme, Wiederverwendbarkeit des Modells und Nachvollziehbarkeit seiner Struktur. Diese vier Eigenschaften bilden den Maßstab, an dem die Lösung in der Validierung zu messen ist.


=== Analyse der Integrationswege<sec:integrationswege>

Die Frage, über welchen Weg die Daten in Desigo CC gelangen, ist der Ausgangspunkt jeder weiteren Festlegung: Sie entscheidet über den verfügbaren Datenumfang, über die Möglichkeit schreibender Zugriffe und über die einzusetzende Werkzeugkette. Ein Weg ist nur dann gangbar, wenn er auf beiden Seiten unterstützt wird -- sowohl vom Powercenter als Datenquelle als auch von Desigo CC als Zielsystem. Desigo CC bindet Fremdsysteme über Erweiterungsmodule für offene Protokolle ein; die Engineering-Dokumentation führt hierfür eigene Kapitel zu BACnet, Modbus #acro("TCP"), OPC DA, #acro("SNMP") und IEC 61850 @src:desigoccenghelp.

Aus dem Schnittstellenangebot des Powercenters (siehe @sec:powercenter) und den Gegebenheiten der Feldebene ergeben sich sechs denkbare Wege.

/* Claude: Die Bezeichner W1--W6 dienen nur der Verweisbarkeit innerhalb dieses Abschnitts. */

*W1 -- Direkter Zugriff auf das #acro("ECPD").* Der naheliegendste Weg, das Endgerät unmittelbar anzusprechen, ist technisch versperrt. Die Schutzschaltgeräte besitzen keine Modbus-Schnittstelle und kommunizieren ausschließlich über ein proprietäres Funkprotokoll mit dem Powercenter; sie sind für übergeordnete Systeme nicht direkt erreichbar @src:sentronsystemhandbuch. Der Weg scheidet ohne weitere Bewertung aus.

*W2 -- #acro("BLE") am Powercenter.* Die Bluetooth-Schnittstelle ist als lokaler Zugang vor Ort ausgelegt. Sie unterstützt nur eine aktive Verbindung, schaltet sich nach 180 Sekunden ohne Nutzung ab und ist über eine sechsstellige PIN abgesichert @src:sentronsystemhandbuch. Für eine dauerhafte, zyklische Anbindung eines Leitsystems ist sie damit weder vorgesehen noch geeignet.

*W3 -- Modbus #acro("TCP") über das Powercenter.* Das Powercenter tritt als Modbus-#acro("TCP")-Server auf und stellt die Daten aller unterlagerten Endgeräte über eine einzige #acro("IP")-Adresse bereit; die Unterscheidung der Geräte erfolgt über den Unit Identifier im Modbus-Header @src:sentronsystemhandbuch. Lesende wie schreibende Zugriffe sind möglich, das Protokoll ist offen spezifiziert und lizenzfrei (siehe @sec:modbus). Auf der Gegenseite steht mit dem Erweiterungsmodul „Modbus TCP" ein vollständiger Treiber bereit, in dem Desigo CC als Client auftritt @src:desigoccenghelp; die Ausgestaltung dieses Wegs wird in @sec:desigoccmechanik gesondert untersucht.

*W4 -- REST-#acro("API") über #acro("HTTPS").* Diese Schnittstelle ist der Modbus-Variante sicherheitstechnisch deutlich überlegen: Sie ist über TLS verschlüsselt und unterliegt der rollenbasierten Zugriffskontrolle des Powercenters @src:sentronsystemhandbuch. Sie ist jedoch herstellerspezifisch und damit kein Protokoll, für das in Desigo CC ein generisches Erweiterungsmodul bereitsteht @src:desigoccenghelp. Eine Anbindung erforderte eine Eigenentwicklung über das Software Development Kit. Ebenso wenig ließe sich der #acro("PDE") nutzen, dessen Ergebnis ausdrücklich eine Beschreibung der Modbus-Kommunikation ist @src:pdemanual -- die Werkzeugkette dieser Arbeit entfiele vollständig.

*W5 -- #acro("MQTT").* Die native Cloud-Anbindung steht ausschließlich am Powercenter 2000 zur Verfügung @src:sentronsystemhandbuch, während für den Testaufbau ein Powercenter 1100 vorgesehen ist. Unabhängig davon ist #acro("MQTT") ein publikationsgetriebenes Protokoll zur Anbindung externer Dienste; es passt weder zum lokalen Charakter einer Gebäudemanagementplattform noch zählt es zu den von Desigo CC unterstützten Feldprotokollen @src:desigoccenghelp.

*W6 -- Vorgelagertes Fremdsystem.* Die vom #acro("PDE") ausdrücklich unterstützten Zielapplikationen sind SENTRON Powermanager und SENTRON Powercenter 3000 @src:pdemanual. Die Geräte ließen sich zunächst dort einbinden und dieses System anschließend über OPC an Desigo CC koppeln. Der Weg ist gangbar, führt aber ein zweites Leitsystem mit eigener Datenhaltung, eigener Alarmierung und eigenem Wartungsbedarf ein. Die eigentliche Aufgabe -- die Abbildung der Gerätedaten auf ein Objektmodell -- wird dadurch nicht gelöst, sondern lediglich in ein anderes System verschoben, und die Alarme erreichten Desigo CC nur noch in der Interpretation des Zwischensystems.

Zur Bewertung der verbleibenden Wege werden fünf Kriterien herangezogen: die Verfügbarkeit auf beiden Seiten, die Eignung für den zyklischen Dauerbetrieb, der erreichbare Datenumfang einschließlich schreibender Zugriffe, die Nutzbarkeit der vorgesehenen Werkzeugkette sowie der Bedarf an zusätzlichen Systemkomponenten. Die Informationssicherheit wird bewusst nicht als gleichrangiges Kriterium geführt, sondern im Anschluss gesondert betrachtet, da sie -- anders als die übrigen Kriterien -- durch Maßnahmen außerhalb des Protokolls beeinflussbar ist.

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
  caption: [Bewertung der Integrationswege -- W2 #acro("BLE"), W3 Modbus #acro("TCP"), W4 REST-#acro("API"), W6 vorgelagertes Fremdsystem. W1 ist bereits technisch ausgeschlossen, W5 steht am eingesetzten Gerät nicht zur Verfügung]
)<tab:integrationswege>

Damit bleibt Modbus #acro("TCP") über das Powercenter als einziger Weg, der alle Kriterien erfüllt. Diese Feststellung ist weniger eine Auswahl unter gleichwertigen Alternativen als vielmehr die Bestätigung, dass die Schnittstellenlage von Quell- und Zielsystem nur eine Schnittmenge zulässt. Bemerkenswert ist dabei, dass ausgerechnet der sicherheitstechnisch schwächste Weg der einzige durchgängig unterstützte ist.

Diese Schwäche ist keine Nebenbedingung, sondern die zentrale Einschränkung des gewählten Wegs. Da das Protokoll selbst weder Verschlüsselung noch Authentifizierung kennt (siehe @sec:modbus) und die rollenbasierte Zugriffskontrolle des Powercenters ausschließlich auf die #acro("HTTPS")-Kommunikation wirkt @src:sentronsystemhandbuch, kann ein Schutz nur außerhalb des Protokolls auf Netzebene entstehen. Daraus folgen drei Voraussetzungen, die als Randbedingungen in die Anforderungen einfließen: Die Modbus-Schnittstelle wird nur dort aktiviert, wo sie benötigt wird -- am Powercenter 1100 ist sie separat zu- und abschaltbar @src:sentronsystemhandbuch --, die Kommunikation verbleibt in einem eigenen Netzsegment, und ein Zugriff über das lokale Netz hinaus erfolgt ausschließlich über #acro("VPN").

Diese drei Punkte sind als Mindestvoraussetzungen des Betriebs zu verstehen, nicht als Sicherheitskonzept. Wie Segmentierung, Fernzugriff und Überwachung im Einzelnen umgesetzt werden, richtet sich nach den Vorgaben des jeweiligen Kunden und ist, wie in @sec:stakeholder abgegrenzt, nicht Gegenstand dieser Arbeit.


=== Integrationsmechanismus in Desigo CC<sec:desigoccmechanik>

Mit der Festlegung auf Modbus #acro("TCP") ist noch nicht bestimmt, in welcher Form das Datenmodell auf der Zielseite überhaupt vorliegen kann. Da die von Desigo CC vorgegebenen Mechanismen die Gestalt der Lösung unmittelbar begrenzen, werden sie hier gesondert untersucht. Grundlage ist die Engineering-Dokumentation der Plattform @src:desigoccenghelp.

/* Claude: Die Angaben dieses Abschnitts stammen aus der Engineering Help. Geprueft wurden
   die Plattformstaende V5.1 und V7; die verwendeten Aussagen sind in beiden identisch.
   NFA-04 fordert jedoch V9.0, wozu keine Dokumentation zugaenglich war. Vor Abgabe gegen
   die installierte Version gegenlesen -- insbesondere die Aussage, dass die JSON-
   Objektmodellbeschreibung keine Modbus-Adressen traegt. Siehe auch den Vorbehalt zu
   NFA-04 in @sec:anforderungsvorbehalte. */

*Rollenverteilung und Objektstruktur.* Desigo CC tritt als Modbus-Client auf und spricht die Feldgeräte als Server an. Ein Gerät wird dabei nicht durch ein, sondern durch zwei Objekte dargestellt: eine Kommunikationsschnittstelle und das eigentliche Gerät. Die Dokumentation begründet diese auf den ersten Blick unintuitive Trennung ausdrücklich damit, dass sich nur so Geräte abbilden lassen, die über ein Gateway angebunden sind und keine eigene #acro("TCP")-Schnittstelle besitzen @src:desigoccenghelp. Eine Schnittstelle ist durch die Kombination aus #acro("IP")-Adresse und Slave-Adresse eindeutig bestimmt, und unter jeder Schnittstelle darf genau ein Gerät liegen. Genau diese Konstellation liegt beim Powercenter vor: Ein Strang wird nicht als ein Objekt mit 24 Untergeräten abgebildet, sondern als 24 Schnittstellen mit identischer #acro("IP")-Adresse und unterschiedlicher Slave-Adresse, zuzüglich einer weiteren für das Powercenter selbst. Ein Gateway-Objekt sieht die Plattform nicht vor; der Zusammenhang der Geräte eines Verteilers muss daher über die logische oder benutzerdefinierte Sicht hergestellt werden, die beim Import als Pfadangabe mitgegeben wird @src:desigoccenghelp.

*Begriffe der Zielseite.* Desigo CC beschreibt Feldgerätedaten objektorientiert. Ein #acro("DPT") legt fest, aus welchen Eigenschaften -- den #acro("DPE") -- ein Datenobjekt besteht und welchen Datentyp jede Eigenschaft hat; die Zuordnung einer Eigenschaft zu einer Registeradresse heißt Adresskonfiguration, und ein konkretes Objekt eines solchen Typs ist eine Instanz @src:desigoccenghelp. Neben den mitgelieferten Standardobjektmodellen, die jeweils ein einzelnes Register abbilden, lassen sich eigene Objektmodelle definieren. Die Dokumentation nennt dafür zwei Anwendungsformen: ein ganzes Gerät als einen Datenpunkt abzubilden, dessen Eigenschaften den einzelnen Registern entsprechen, oder ein einzelnes Register als Datenpunkt abzubilden, dessen Eigenschaften Teilen dieses Registers entsprechen @src:desigoccenghelp. Beide Formen werden für die vorliegende Aufgabe benötigt.

*Drei Artefakte statt eines.* Eine Modbus-Integration entsteht in Desigo CC aus drei getrennten Beschreibungen, die auf unterschiedlichen Ebenen liegen. Auf der *Typebene* steht das Objektmodell; es kann als #acro("CSV")- oder als #acro("JSON")-Datei importiert werden, wobei nur der #acro("JSON")-Import neben den Datenpunkttypen auch deren Konfiguration überträgt. Die #acro("JSON")-Beschreibung umfasst Name und Beschreibung des Typs, die Liste der Eigenschaften mit ihren Datentypen, Anzeigeebenen, Einheiten und Zustandstexte, die Klassifikation nach Gewerk und Typ sowie die Kommando- und Alarmkonfiguration; ein Schema zur Prüfung solcher Dateien liegt der Installation bei @src:desigoccenghelp. Auf der *Adressebene* stehen die Import Rules. Sie legen je Eigenschaft die Richtung, den Funktionscode, den Transformationstyp, den Offset, den Bit- oder Byte-Index, die Abfragegruppe und die Messwertskalierung fest; über sogenannte Adressprofile kann ein Objektmodell mehrere alternative Adressbelegungen tragen @src:desigoccenghelp. Auf der *Instanzebene* steht eine #acro("CSV")-Datei, die Verbindungen, Geräte und Punkte je Projekt anlegt und dabei Slave-Adresse, #acro("IP")-Adresse, Port, Wortreihenfolge sowie die Einordnung in die logische und benutzerdefinierte Sicht enthält @src:desigoccenghelp.

Für die vorliegende Arbeit ist die Aufteilung dieser drei Artefakte der wichtigste Befund des Abschnitts: Die #acro("JSON")-Beschreibung eines Objektmodells trägt selbst keine Modbus-Adressen. Register, Funktionscode und Offset werden ausschließlich in den Import Rules und in der Instanz-#acro("CSV") festgelegt. Die vom #acro("PDE") erzeugte Typbeschreibung und die Typebene von Desigo CC decken sich damit nur teilweise -- die Adressinformation, die den eigentlichen Kern einer Modbus-Anbindung ausmacht, muss beim Übergang gesondert überführt werden. Wie dieser Übergang gestaltet wird, ist eine der zentralen Fragen des Entwicklungsteils.

*Randbedingungen des Treibers.* Aus der Dokumentation lassen sich darüber hinaus mehrere Eigenschaften des Modbus-Treibers entnehmen, die für die Modellierung unmittelbar bedeutsam sind.

#figure(
  table(
    columns: (7em, 1fr),
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

    [Abfragegruppen],
    [Datenpunkte können Abfragegruppen zugeordnet werden, die jeweils aus einem Namen und einem Abfrageintervall bestehen. Der Name einer Gruppe ist nach dem Anlegen nicht mehr änderbar.],

    [Blockbildung],
    [Register, deren Adressabstand einen einstellbaren Grenzwert unterschreitet, werden zu einem gemeinsamen Leseblock zusammengefasst. Eine dichte Belegung des Adressraums verringert damit unmittelbar die Zahl der Telegramme.],

    [Anfrageabstand],
    [Ein Mindestabstand zwischen zwei Anfragen ist einstellbar; die Dokumentation nennt als Anwendungsfall ausdrücklich den Betrieb über ein Gateway.],

    [Mengengerüst],
    [Je Server sind bis zu zehn Treiberinstanzen möglich, je Treiber bis zu 35.000 Datenpunkte. Die Zahl der Systemobjekte wird überwacht und ein Import bei drohender Überschreitung abgewiesen.],

    [Schreibrichtung],
    [Ein Datenpunkt kennt entweder die Lese- oder die Schreibrichtung, nicht beide. Für Werte, die geschrieben und zurückgelesen werden sollen, sieht die Plattform Objektmodelle mit getrennten Eigenschaften für Soll- und Istwert vor.],
  ),
  caption: [Eigenschaften des Modbus-Treibers von Desigo CC und ihre Bedeutung für die Modellierung, nach @src:desigoccenghelp]
)<tab:modbustreiber>

Die letzte Zeile der Tabelle verdient besondere Beachtung. Sie bedeutet, dass ein Schaltbefehl und die zugehörige Rückmeldung im Modell zwingend zwei Eigenschaften belegen, selbst wenn beide auf dasselbe Register verweisen. Die Einschränkung trifft damit unmittelbar auf die Kommandoregister des #acro("ECPD"). Ebenso bemerkenswert ist das Mengengerüst: Bei rund 5.200 Datenpunkten für einen vollständig abgebildeten Strang -- die Herleitung dieser Zahl folgt in @sec:registerraum -- ließen sich überschlägig nur etwa sechs Stränge über eine einzige Treiberinstanz betreiben. Auch von dieser Seite her ist eine Reduktion des Datenumfangs geboten.


=== Erstes Lösungskonzept<sec:konzept>

Aus der Festlegung auf Modbus #acro("TCP"), den Eigenschaften des Powercenters und den in @sec:desigoccmechanik dargestellten Mitteln der Zielplattform lässt sich ein erster Entwurf der Lösung ableiten, der die Struktur der weiteren Arbeit vorgibt. Er ist als Ausgangspunkt zu verstehen und wird im Entwicklungsteil konkretisiert.

Den Kern des Entwurfs bildet die Trennung von Gerätetyp und Geräteinstanz. Die Registeradressen sind bei allen Geräten desselben Typs identisch; unterschieden werden die Geräte allein über den Unit Identifier @src:sentronsystemhandbuch. Eine einzige Typbeschreibung genügt daher, um beliebig viele physische Geräte abzubilden, und genau darin liegt die Wiederverwendbarkeit des Modells über Projektgrenzen hinweg. Die Zielplattform trennt Objektmodell, Adresskonfiguration und Instanz ebenfalls voneinander @src:desigoccenghelp; die Lösung besteht folglich nicht aus einer Datei, sondern aus drei zusammengehörigen Artefakten -- der Typbeschreibung, der Adressbelegung und einer projektbezogenen Instanzliste. Die vom #acro("PDE") erzeugte #acro("JSON")-Datei deckt davon die Typbeschreibung ab; wie die Adressbelegung daraus hervorgeht, ist im Entwicklungsteil zu klären.

Powercenter und #acro("ECPD") werden als getrennte Objekttypen modelliert. Ein erheblicher Teil der Register stimmt zwar überein, es handelt sich jedoch um verschiedene Geräte mit unterschiedlicher Aufgabe und unterschiedlicher Adressierung: Die Geräteadresse 255 adressiert das Powercenter selbst, die Adressen darunter die Endgeräte @src:sentronsystemhandbuch. Auf der Zielseite entspricht ein Strang damit bis zu 25 Kommunikationsschnittstellen mit gemeinsamer #acro("IP")-Adresse und unterschiedlicher Slave-Adresse, unter denen jeweils genau ein Geräteobjekt liegt; jedes #acro("ECPD") wird einzeln mit seinem Unit Identifier angelegt, ein Gateway-Objekt kennt die Plattform nicht @src:desigoccenghelp. Der Schwerpunkt liegt dabei auf dem Objektmodell des #acro("ECPD"); ein eigenes Objektmodell für das Powercenter ist von den Beteiligten nicht gefordert worden und wäre eine sinnvolle Ergänzung, aber keine Voraussetzung für den Nutzen der Lösung.

Das Systemhandbuch empfiehlt, jedes Gerät höchstens einmal pro Sekunde abzufragen, die Endgeräte sequenziell abzuarbeiten und Register blockweise zu lesen; die Messwerte werden ohnehin frühestens alle zwei Sekunden aktualisiert @src:sentronsystemhandbuch. Bei bis zu 24 Endgeräten je Strang ist eine einheitliche Abtastung deshalb weder möglich noch sinnvoll. Das Konzept sieht vier Gruppen vor: Zustands- und Alarmwerte im schnellen Zyklus, Messwerte im mittleren, Zähler- und Wartungswerte im langsamen sowie Stammdaten einmalig beim Systemstart. Diese Staffelung lässt sich unmittelbar auf die Abfragegruppen der Zielplattform abbilden, die je Eigenschaft in der Adressbelegung hinterlegt werden @src:desigoccenghelp. Die Empfehlung, sequenziell und blockweise zu lesen, findet ihre Entsprechung im einstellbaren Anfrageabstand und in der automatischen Blockbildung des Treibers.

Ungültige Messwerte kennzeichnet das Powercenter als _Not a Number_; zusätzlich zeigt ein Statusdatenpunkt an, ob die Verbindung zum Endgerät besteht @src:sentronsystemhandbuch. Beides ist im Modell auszuwerten, damit ein ausgefallenes Gerät nicht als Gerät mit dem Messwert null erscheint.

Schließlich sieht der Entwurf eine feste Arbeitsteilung zwischen den beiden Werkzeugen vor. Die Parametrierung der Geräte -- Grenzwerte, Hysteresen und Schutzeinstellungen -- verbleibt bei SENTRON Powerconfig; Desigo CC übernimmt den laufenden Betrieb mit Anzeige, Archivierung, Alarmierung und Bedienung. SENTRON Powerconfig lässt sich damit nicht ablösen und wird von der errichtenden Fachkraft weiterhin benötigt: Sobald in den elektrotechnischen Aufbau oder in die Wirkungsweise eines Geräts eingegriffen wird, hat dies über Powerconfig zu geschehen. Diese Aufteilung hält das Datenmodell frei von Inbetriebnahmedaten und ist zugleich die Begründung dafür, dass ein großer Teil des Registerraums unberücksichtigt bleiben kann; ihre Auswirkung auf den Anforderungskatalog wird bei FA-06 und FA-09 in @sec:fa aufgegriffen.

#figure(
  image("../../resources/img/placeholder.png", width: 90%, format: "png"),
  caption: [PLATZHALTER: Erstes Lösungskonzept -- Werkzeugkette vom #acro("PDE") über die #acro("JSON")-Typbeschreibung zum Objektmodell in Desigo CC, ergänzt um Adressbelegung und Instanzliste, sowie die Instanziierung je physischem Gerät über den Unit Identifier]
)<img:konzept>


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

Erstens dominieren Konfigurationsdaten den Registerraum. Der größte Teil der Register des #acro("ECPD") entfällt auf die Alarm- und Grenzwertkonfiguration sowie auf geschützte Schutzeinstellungen. Diese Werte werden einmalig bei der Inbetriebnahme gesetzt und verbleiben nach dem Konzept aus @sec:konzept bei SENTRON Powerconfig. Für den Betrieb ist nicht die Schwelle relevant, sondern deren Überschreitung -- und diese wird über das Alarmregister gemeldet.

Zweitens ist die Informationsdichte sehr ungleich verteilt. Ein einziges Register trägt als Bitfeld sämtliche Alarme des Geräts, während umgekehrt einzelne Werte wie mehrwortige Zeichenketten oder Gleitkommazahlen doppelter Genauigkeit mehrere Register belegen. Die Spalte „Länge" der Registerkarte gibt dabei die Anzahl der zu lesenden Register an; wird ein Mehrwortregister mit abweichender Länge gelesen, liefert das Gerät keine verwertbaren Daten.

Drittens liegen Werte teilweise doppelt vor. Der Schalterzustand jedes Endgeräts ist sowohl am Endgerät selbst als auch in einem Feld über alle 24 Endgeräte am Powercenter verfügbar; Gleiches gilt für Verbindungs- und Pairing-Zustände sowie für die Zähler von Parameteränderungen. Eine Abbildung beider Quellen wäre redundant und würde die Datenpunktzahl am Gateway vervielfachen.

Viertens sind nicht alle dokumentierten Register nutzbar. Ein Teil ist geräteweit konstant und damit ohne Informationsgewinn, ein weiterer Teil antwortet auf dem #acro("ECPD") mit einer Ausnahmemeldung oder liefert konstant null. Die Registerkarte allein ist folglich keine hinreichende Grundlage; ihre Angaben sind am Gerät zu prüfen.

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
