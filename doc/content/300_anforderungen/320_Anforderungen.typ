#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Anforderungskatalog<sec:anforderungen>

Die Analyse in @sec:analyse hat den Lösungsraum eingegrenzt: Sie hat den Integrationsweg bestimmt, die Mittel der Zielplattform beschrieben, den verfügbaren Datenbestand charakterisiert und aus den Tätigkeiten der Beteiligten Anwendungsfälle abgeleitet. Der vorliegende Abschnitt führt diese Ergebnisse in einem verbindlichen Anforderungskatalog zusammen. Er gibt damit den Maßstab vor, an dem das entwickelte Datenmodell in @sec:testfaelle und im Validierungsteil zu messen ist.

Der Katalog ist zu Beginn der Arbeit gemeinsam mit dem betreuenden Fachbereich aufgestellt und seither in einer Arbeitsmappe fortgeschrieben worden. Die in @sec:analyse gewonnenen Erkenntnisse haben ihn an mehreren Stellen präzisiert und ergänzt; welche Anforderungen davon betroffen sind, ist in @sec:anforderungsvorbehalte zusammengefasst. Die im Folgenden wiedergegebenen Formulierungen entsprechen inhaltlich dem Katalog und wurden leicht der Lesbarkeit wegen modifiziert.

/* Autorennotiz aus dem urspruenglichen Entwurf dieses Abschnitts, in den Text zu
   FA-09 eingearbeitet:
   - Powerconfig kann nicht komplett abgelöst werden, für manche konfigurationen wird
     es weiterhin gebraucht werden. errichter wird es brauchen, fokus in desigo CC soll
     wirklich auf monitoring und einfachen funktionen sein. sobald änderungen an dem
     elektrotechnischen aufbau und der funktionsweise ist dann muss das durch eine
     person mit powerconfig geschehen. */


=== Aufbau und Verbindlichkeit<sec:anforderungskatalog>

Der Katalog unterscheidet drei Kategorien, wie es im Requirements Engineering üblich ist @src:sommerville2016. Funktionale Anforderungen (FA) beschreiben, was die Lösung leisten muss, und sind am beobachtbaren Verhalten des Gesamtsystems überprüfbar. Nichtfunktionale Anforderungen (NFA) beschreiben Eigenschaften der Lösung und ihres Entstehungsprozesses, etwa ihre Modularität oder ihre Dokumentation. Randbedingungen (RB) sind nicht Gegenstand der Gestaltung, sondern von außen gesetzt. Sie beschreiben die Voraussetzungen, unter denen die Lösung entsteht und betrieben wird.

Die Verbindlichkeit ergibt sich aus der Wortwahl: Eine mit "muss" formulierte Anforderung ist zwingend zu erfüllen und ihr Nachweis ist Teil der Validierung, während eine mit "soll" formulierte Anforderung angestrebt wird und eine Abweichung zu begründen ist.

Für die spätere Prüfung ist eine weitere Unterscheidung wesentlich, die der Katalog selbst nicht trifft: Die Anforderungen richten sich nicht sämtlich an dasselbe Artefakt. Ein Teil betrifft unmittelbar das Datenmodell, also die Typbeschreibung und die Adressbelegung -- etwa die Vollständigkeit und Beschriftung der Datenpunkte. Ein zweiter Teil wird erst durch die Projektierung in Desigo CC erfüllt, beispielsweise die Zuordnung zu Alarmkategorien oder der Aufbau von Dashboards. Ein dritter Teil betrifft die Geräteseite und ist nur über SENTRON Powerconfig zu erfüllen, etwa die Aktivierung einzelner Alarme. Ein Datenmodell allein kann folglich nicht alle Anforderungen erfüllen; es kann sie nur ermöglichen. Wo diese Grenze verläuft, wird bei den betroffenen Anforderungen jeweils benannt, denn sie bestimmt, wo der Nachweis zu führen ist und was die Lösung an Begleitmaterial umfassen muss.


=== Funktionale Anforderungen<sec:fa>

#figure(
  table(
    columns: (4em, 1fr, 7em),
    inset: 6pt,
    align: (left + horizon, left, left + horizon),
    table.header(
      [*ID*], [*Anforderung*], [*Anwendungsfall*],
    ),
    [FA-01],
    [#acro("ECPD") und Powercenter müssen über ein geeignetes Protokoll mit Desigo CC verbunden werden können. Dies setzt einen Import und eine Instanziierung in Desigo CC voraus.],
    [UC-01],

    [FA-02],
    [Die Kommunikation muss zyklisch erfolgen und Datenpunkte zyklisch übermitteln. Die Frequenz soll konfigurierbar sein.],
    [UC-02, UC-05],

    [FA-03],
    [Alle Messwerte des #acro("ECPD") müssen als Datenpunkte in Desigo CC sichtbar sein. Diese Messwerte müssen eine korrekte Beschriftung haben.],
    [UC-02, UC-08, UC-10],

    [FA-04],
    [Es muss möglich sein, Statusmeldungen und Alarme in Desigo CC zu empfangen, anzeigen zu lassen, zu bearbeiten und zu quittieren. Das Verhalten soll hierbei gleich zu anderen Alarmen sein.],
    [UC-03],

    [FA-05],
    [Die Alarme sollen den verschiedenen in Desigo CC vorhandenen Alarmkategorien passend zugeordnet werden.],
    [UC-03],

    [FA-06],
    [Es muss möglich sein, über die gewählte Schnittstelle Fernsteuerbefehle für den laufenden Betrieb zu senden. Dazu zählen das elektronische Schalten, das Quittieren von Meldungen, das Anstoßen der Geräte- und #acro("RCD")-Prüfung sowie das Lokalisieren eines Geräts. Die Parametrierung geschützter Schutzeinstellungen ist hiervon ausgenommen und verbleibt bei SENTRON Powerconfig.],
    [UC-06, UC-09],

    [FA-08],
    [Eine automatische Prüfung nach #acro("DGUV") muss über Desigo CC möglich sein; diese Prüfung muss in Desigo CC dokumentiert werden.],
    [UC-07],

    [FA-09],
    [Die initiale Konfiguration soll weiterhin über SENTRON Powerconfig möglich sein.],
    [UC-01],

    [FA-10],
    [Bei Kommunikationsunterbrechung muss ein Alarm ausgelöst werden. Ebenso müssen als ungültig gekennzeichnete Messwerte und ein fehlender Verbindungsstatus zu einem Endgerät als solche erkennbar sein und dürfen nicht als gültiger Messwert dargestellt werden.],
    [UC-04],
  ),
  caption: [Funktionale Anforderungen an das Datenmodell und ihre Zuordnung zu den Anwendungsfällen aus @tab:usecases]
)<tab:fa>

/* Claude: FA-07 und FA-11 sind aus dem Katalog genommen worden, ihre IDs bleiben
   reserviert. Deshalb springt die Nummerierung von FA-06 auf FA-08 und endet bei FA-10.
   Begruendung siehe @sec:anforderungsvorbehalte. */

Die funktionalen Anforderungen lassen sich vier Wirkbereichen zuordnen, die sich aus dem Datenpfad selbst ergeben.

*Anbindung und Übertragung.* FA-01 und FA-02 betreffen die Verbindung als solche. FA-01 ist mit der Entscheidung für Modbus #acro("TCP") über das Powercenter (siehe @sec:integrationswege) dem Grunde nach beantwortet, verlangt darüber hinaus aber ausdrücklich Import und Instanziierung. Die Anforderung ist damit nicht erfüllt, wenn die Daten lediglich lesbar sind, sondern erst, wenn ein Gerät in Desigo CC als Objekt vorliegt. FA-02 verlangt eine konfigurierbare Abtastfrequenz. Sie lässt sich am eingesetzten Stand ausschließlich am Modbus-Treiber einstellen und gilt dort für sämtliche angebundenen Geräte (siehe @tab:modbustreiber). Der zwingende Teil der Anforderung ist damit erfüllt, die als _soll_ formulierte Konfigurierbarkeit jedoch nur eingeschränkt, da eine nach Geräten oder Datenpunkten abgestufte Abfrage nicht zur Verfügung steht. Aus dieser Einschränkung folgt zugleich, dass der am schnellsten benötigte Wert den Takt aller übrigen bestimmt, was die in @sec:registerraum begründete Reduktion des Datenumfangs zusätzlich trägt. Die Empfehlung des Systemhandbuchs, jedes Gerät höchstens einmal pro Sekunde abzufragen @src:sentronsystemhandbuch, bildet dabei die Grenze, an der sich das eingestellte Intervall zu orientieren hat.


*Abbildung der Daten.* FA-03 bestimmt, welche Werte in welcher Form erscheinen. Die Anforderung ist bewusst auf die Messwerte begrenzt und nicht auf den gesamten Registerraum; die in @sec:registerraum begründete Reduktion steht ihr damit nicht entgegen, solange kein Messwert entfällt. Die geforderte korrekte Beschriftung ist keine Formalie: Sie umfasst Einheit, Skalierung und Vorzeichen und ist der Punkt, an dem sich Fehler in der Registerkarte unmittelbar auf die Anzeige durchschlagen. Nicht Gegenstand von FA-03 ist die Frage, wie diese Werte in der Leitwarte dargestellt und historisiert werden; Archivierung und Visualisierung sind Projektierungsleistungen in Desigo CC und lassen sich im Objektmodell nicht festlegen (siehe @sec:anforderungsvorbehalte).

*Meldungen und Überwachung.* FA-04, FA-05 und FA-10 betreffen die Frage, wie sich das System im Störungsfall verhält. FA-04 verlangt ausdrücklich, dass sich die Alarme der Schutzschaltgeräte nicht anders verhalten als die übriger Gewerke; das Datenmodell hat sich insoweit in die vorhandene Alarmstruktur einzufügen und keine eigene zu schaffen. FA-05 verlangt darüber hinaus eine Einordnung nach Dringlichkeit, die das Gerät selbst nicht liefert: Der #acro("ECPD") meldet seine Zustände als Bitfeld ohne Wertung, sodass die Zuordnung zu Alarmkategorien anderweitig stattfinden muss.

Genau an dieser Stelle liegt die deutlichste Grenze des Datenmodells, die sich erst im Verlauf der Entwicklung in vollem Umfang zeigt: Die Auswertung der Alarme findet in Desigo CC statt und nicht im Objektmodell. Das Modell kann die Zustände des Geräts einzeln, richtig benannt und in der geforderten Aktualität bereitstellen und damit die Voraussetzung dafür schaffen, dass Desigo CC sie überhaupt auswerten kann; welche Meldung daraus wird, welcher Kategorie sie zugeordnet ist und wie sie behandelt wird, ist dagegen Teil der Alarmkonfiguration der jeweiligen Anlage. Diese lässt sich nicht allgemeingültig in der Integrationsvorlage vorwegnehmen, sondern muss für den einzelnen Kunden in Desigo CC angelegt werden. FA-04 und FA-05 sind daher durch das Datenmodell allein nicht erfüllbar; sie werden erst im Zusammenwirken von Modell und Projektierung erfüllt.

/* Claude: Diese Feststellung stammt aus der Durchsicht und ist bislang nur hier
   formuliert. Sie steht in einem gewissen Spannungsverhaeltnis zur Engineering Help,
   nach der die JSON-Objektmodellbeschreibung auch eine Alarmkonfiguration tragen kann
   (siehe @sec:desigoccmechanik). Vor Abgabe klaeren, wie weit diese Konfiguration
   tatsaechlich traegt, und die Aussage hier sowie im Entwicklungs- und Validierungsteil
   entsprechend schaerfen. */

FA-10 schließlich grenzt zwei Fälle voneinander ab, die in der Leitwarte leicht verwechselt werden -- ein tatsächliches Anlagenereignis und ein Ausfall der Datenverbindung -- und verlangt zusätzlich, dass ungültige Werte nicht als gültige erscheinen.

*Eingriff und Arbeitsteilung.* FA-06, FA-08 und FA-09 bestimmen, wie weit die Bedienung über Desigo CC reichen soll. FA-06 beschränkt sich nach der in @sec:anforderungsvorbehalte genannten Änderung auf Befehle des laufenden Betriebs. FA-08 verlangt, die wiederkehrende Prüfung über Desigo CC anzustoßen und ihr Ergebnis dort zu dokumentieren; die Anforderung setzt damit sowohl einen schreibenden Datenpunkt als auch eine Archivierung des Ergebnisses voraus. FA-09 hält die initiale Konfiguration bei SENTRON Powerconfig und bildet gemeinsam mit FA-06 die in @sec:konzept eingeführte Arbeitsteilung zwischen beiden Werkzeugen ab.

Diese Arbeitsteilung ist keine vorläufige Einschränkung, sondern beabsichtigt, und sie bestimmt den Zuschnitt beider Anforderungen. SENTRON Powerconfig lässt sich nicht ablösen: Die errichtende Fachkraft benötigt es für die Inbetriebnahme und für jeden Eingriff in die Funktionsweise der Geräte. Der Schwerpunkt in Desigo CC liegt demgegenüber auf der Überwachung und auf einfachen Bedienhandlungen; sobald der elektrotechnische Aufbau oder die Wirkungsweise eines Geräts verändert wird, hat dies durch eine fachkundige Person über SENTRON Powerconfig zu geschehen. FA-06 und FA-09 schreiben damit fest, was die Geräte ohnehin erzwingen: Ein Teil der Schutzparameter ist nur nach einer Freigabe am Gerät selbst veränderbar @src:sentronsystemhandbuch. Die Grenze verläuft folglich nicht entlang dessen, was über Modbus technisch schreibbar wäre, sondern entlang der Verantwortung für den sicheren Zustand der Anlage.

/* Claude: FA-08 ist nach Absprache unveraendert geblieben. Offen bleibt die Frage, ob eine
   Pruefung nach DGUV ueber Desigo CC ueberhaupt darstellbar ist -- sie duerfte an der
   erforderlichen Abnahme durch eine befaehigte Person scheitern. Als tragfaehiger Ersatz
   kaeme der Selbsttest des Geraets in Betracht, dessen Alarm Probleme frueh sichtbar macht,
   die sonst erst bei einer Pruefung auffielen. Bewusst noch nicht eingearbeitet; siehe auch
   den Kommentar in 310_Analyse.typ bei der Stakeholdertabelle. */


=== Nichtfunktionale Anforderungen<sec:nfa>

#figure(
  table(
    columns: (4em, 1fr, 8.5em),
    inset: 6pt,
    align: (left + horizon, left, left + horizon),
    table.header(
      [*ID*], [*Anforderung*], [*Anwendungsfall*],
    ),
    [NFA-01],
    [Der gesamte Integrationsprozess muss vollständig dokumentiert sein.],
    [UC-11],

    [NFA-02],
    [Es muss eine Anleitung zur Integration des entwickelten Modells für Desigo CC geben. Diese Anleitung soll sowohl für technisches Personal, welches die Anlagen installiert, als auch für administratives Personal, welches die Konfiguration in Desigo CC vornimmt, geeignet sein.],
    [UC-11],

    [NFA-03],
    [Das Modell muss modular aufgebaut sein, sodass einzelne Datenpunkte oder Funktionen ohne vollständige Neuerstellung angepasst werden können.],
    [UC-11],

    [NFA-04],
    [Das Objektmodell muss mit Desigo CC in der Version 9.0 kompatibel sein.],
    [UC-11],

    [NFA-05],
    [Das Modell muss für den Einsatz mit mehreren #acro("ECPD")-Instanzen erweiterbar sein.],
    [UC-01],

    [NFA-06],
    [Zur Lösung muss angegeben werden, welche Geräteparametrierung in SENTRON Powerconfig vorausgesetzt wird, damit die abgebildeten Datenpunkte gültige Werte liefern.],
    [--],
  ),
  caption: [Nichtfunktionale Anforderungen an das Datenmodell]
)<tab:nfa>

NFA-01 und NFA-02 richten sich nicht an das Modell, sondern an sein Umfeld. Sie sind die Anforderungen, die aus dem in @sec:stakeholder beschriebenen Spannungsfeld zwischen dem Endkunden ohne eigene Entwicklung und dem selbst entwickelnden Endkunden folgen: Eine Vorlage, die nicht erklärt ist, lässt sich zwar einsetzen, aber nicht anpassen. NFA-02 verlangt dabei ausdrücklich eine Anleitung für zwei unterschiedliche Adressatenkreise und damit eine Trennung zwischen der Inbetriebnahme im Verteiler und der Projektierung im Leitsystem.

NFA-03 und NFA-05 beschreiben zwei verschiedene Formen der Erweiterbarkeit, die im Katalog leicht zu verwechseln sind. NFA-05 verlangt die Vervielfältigung eines bestehenden Typs auf viele physische Geräte. Sie ist durch die Trennung von Gerätetyp und Geräteinstanz (siehe @sec:konzept) unmittelbar erfüllt, da die Registernummern über alle Geräte eines Typs identisch sind und die Unterscheidung ausschließlich über den Unit Identifier erfolgt @src:sentronsystemhandbuch. NFA-03 verlangt dagegen die Veränderbarkeit des Typs selbst -- das Hinzufügen, Entfernen oder Ändern einzelner Datenpunkte, ohne das Modell von Grund auf neu erstellen zu müssen. Sie richtet sich damit weniger an die Gestaltung des Modells als an die Werkzeugkette und ist durch diese bereits weitgehend erfüllt: Eine bestehende Typbeschreibung lässt sich im #acro("PDE") erneut öffnen und bearbeiten (siehe @sec:pde), sodass sich eine Änderung ohne besondere Vorkehrungen im Modell selbst durchführen lässt. Zu leisten bleibt daher vor allem die Dokumentation -- welche Stelle im Modell welchen Datenpunkt trägt und wie eine Änderung anschließend in Desigo CC nachgeführt wird. Insofern greift NFA-03 unmittelbar in NFA-01 und NFA-02 über.

NFA-04 ist die einzige Anforderung des Katalogs, deren Erfüllung sich aus der Dokumentation allein nicht ableiten lässt. Die für @sec:desigoccmechanik herangezogene Engineering-Dokumentation beschreibt die Mechanismen der Plattform @src:desigoccenghelp, während die Verträglichkeit einer konkreten Typbeschreibung mit einem konkreten Systemstand eine Eigenschaft des Betriebs bleibt. Der Nachweis ist daher am Testaufbau zu führen und selbst ein Ergebnis der Arbeit.

NFA-06 ist die einzige nichtfunktionale Anforderung, die keinem Anwendungsfall entspringt, sondern einer Eigenschaft der Geräte. Ein Teil der Alarmbits des #acro("ECPD") ist ab Werk deaktiviert und liefert andernfalls dauerhaft den Wert null (siehe @sec:registerraum). Ein Datenmodell, das diese Bits abbildet, ist damit formal vollständig, in der Sache aber wirkungslos, solange die zugehörige Parametrierung nicht vorgenommen wurde. Die Anforderung stellt sicher, dass die Lösung diese Voraussetzung benennt, statt sie stillschweigend vorauszusetzen.


=== Randbedingungen<sec:rb>

#figure(
  table(
    columns: (4em, 1fr),
    inset: 6pt,
    align: (left + horizon, left),
    table.header(
      [*ID*], [*Randbedingung*],
    ),
    [RB-01],
    [Zur Einrichtung sind die Software SENTRON Powerconfig in der Desktop-Variante sowie ein Zugang zu Desigo CC mit Konfigurationsrechten erforderlich.],

    [RB-02],
    [Es muss ein Powercenter 1100 oder 2000 mit einem #acro("ECPD") verfügbar sein, wobei vorausgesetzt wird, dass die Funktionsweise des Powercenters 2000 der des Powercenters 1100 entspricht.],

    [RB-03],
    [Es muss eine Netzwerkverbindung zum Powercenter über das gewählte Protokoll bestehen; die Kopplung zwischen #acro("ECPD") und Powercenter erfolgt wie in der Installationsanleitung beschrieben.],

    [RB-04],
    [Für die Testumgebung stehen ein Powercenter 1100 und eine #acro("ECPD")-Anlage zur Verfügung, auf deren Grundlage das Objektmodell entwickelt wird.],

    [RB-05],
    [Die Modbus-#acro("TCP")-Schnittstelle des Powercenters wird nur dort aktiviert, wo sie für die Anbindung benötigt wird.],

    [RB-06],
    [Die Modbus-Kommunikation zwischen Powercenter und Desigo CC verbleibt in einem eigenen, vom übrigen Gebäudenetz getrennten Netzsegment.],

    [RB-07],
    [Ein Zugriff auf das Powercenter über das lokale Netz hinaus erfolgt ausschließlich über eine #acro("VPN")-Verbindung oder ein vorgelagertes Gateway.],
  ),
  caption: [Randbedingungen der Entwicklung und des Betriebs]
)<tab:rb>

RB-01 bis RB-04 beschreiben die Ausstattung, unter der die Arbeit entsteht. Bemerkenswert ist RB-02, weil die Randbedingung eine Annahme enthält: Die Gleichwertigkeit von Powercenter 1100 und 2000 wird vorausgesetzt, aber nicht geprüft. Für die Aussagekraft der Ergebnisse ist das insofern von Bedeutung, als die Validierung ausschließlich an einem Powercenter 1100 erfolgt (RB-04); eine Übertragung auf das Powercenter 2000 ist damit begründet, aber nicht nachgewiesen. Das Powercenter 1000 scheidet als Grundlage aus, da es das #acro("ECPD") erst ab Firmware-Version 3.0 und ohne die per Firmware-Update nachgelieferten Gerätefunktionen unterstützt @src:sentronsystemhandbuch.

RB-01 nennt SENTRON Powerconfig in der Desktop-Variante, und diese Einschränkung ist begründungsbedürftig. Das Werkzeug steht daneben als mobile Anwendung zur Verfügung, die den Zugang über #acro("BLE") vor Ort eröffnet und für die Inbetriebnahme im Feld naheliegt. In eigenen Vorversuchen an den Geräten vor Beginn der Bearbeitung erwies sie sich jedoch als nicht verlässlich. Das Hinzufügen des Powercenters schlug wiederholt fehl, und ein bereits hinzugefügtes #acro("ECPD") wurde anschließend häufig nicht mehr angezeigt. Auch die fachliche Betreuung riet von ihrem Einsatz ab, gestützt auf die Erfahrungen des Inbetriebnahmepersonals @src:ulmer2026. Für das Datenmodell bleibt die Festlegung ohne Folgen, da SENTRON Powerconfig in beiden Ausführungen außerhalb des laufenden Datenpfads steht (siehe @sec:systemanalyse). Sie ist gleichwohl festzuhalten, weil die in @sec:geraetekonfiguration beschriebenen Einstellungen des Testaufbaus auf diesem Weg entstanden sind. #kommentar[Der Tag der Auskunft ist in resources/quellen.bib mit dem 15. Juni 2026 nur angesetzt und vor der Abgabe zu präzisieren. Zu überlegen ist außerdem, ob die beiden Beobachtungen aus den Vorversuchen noch um den Gerätestand ergänzt werden, unter dem sie aufgetreten sind.]

RB-05 bis RB-07 sind das Ergebnis der in @sec:integrationswege getroffenen Feststellung, dass der einzige beidseitig unterstützte Integrationsweg zugleich der sicherheitstechnisch schwächste ist. Da Modbus #acro("TCP") weder Verschlüsselung noch Authentifizierung kennt (siehe @sec:modbus) und die rollenbasierte Zugriffskontrolle des Powercenters ausschließlich auf die #acro("HTTPS")-Kommunikation wirkt @src:sentronsystemhandbuch, muss der Schutz vollständig auf Netzebene erfolgen. Diese drei Randbedingungen sind daher keine Empfehlungen, sondern Voraussetzung dafür, dass die Lösung überhaupt vertretbar betrieben werden kann. Sie beschreiben allerdings nur einen Mindeststandard und ersetzen kein Sicherheitskonzept; dessen Ausgestaltung obliegt dem jeweiligen Kunden und ist, wie in @sec:stakeholder abgegrenzt, nicht Gegenstand dieser Arbeit.


=== Vorbehalte und Abgrenzung<sec:anforderungsvorbehalte>

Der zu Beginn der Arbeit aufgestellte Katalog ist im Zuge der Analyse an einigen Stellen verändert worden. FA-06 ist auf Befehle des laufenden Betriebs beschränkt worden, weil die ursprüngliche Fassung -- über die Schnittstelle „alle verfügbaren Konfigurationen" vorzunehmen -- FA-09 widersprach und der Arbeitsteilung mit SENTRON Powerconfig entgegenstand. FA-10 ist um den Umgang mit ungültig gekennzeichneten Messwerten ergänzt worden, weil das Powercenter diesen Fall eigens kennzeichnet und er sich andernfalls als gültiger Messwert null in der Leitwarte niederschlüge. Zwei Anforderungen sind nicht in den Katalog übernommen worden: die Visualisierung in Dashboards nebst Archivgruppen, da sie eine Projektierungsleistung im Zielsystem und keine Eigenschaft des Objektmodells ist, sowie die Nachvollziehbarkeit von Änderungen an geschützten Geräteparametern, für die sich kein tragender Bedarf ergeben hat. Hinzugekommen sind NFA-06, das aus den ab Werk deaktivierten Alarmbits folgt, sowie die Randbedingungen RB-05 bis RB-07 zur Netzebene. RB-01 ist auf die Desktop-Variante von SENTRON Powerconfig präzisiert worden, weil sich die mobile Anwendung in Vorversuchen als nicht verlässlich erwies (siehe @sec:rb). Die Kennungen entfallener Anforderungen bleiben reserviert und werden nicht neu vergeben, weshalb die Nummerierung in @tab:fa eine Lücke aufweist. Die einzelnen Eingriffe sind im Anforderungskatalog selbst datiert vermerkt; einer weitergehenden Darstellung an dieser Stelle bedarf es nicht, da sie für das Verständnis der Lösung ohne Belang ist.

/* Claude: Die ausfuehrliche Aenderungsuebersicht steht auf Wunsch des Autors nicht in der
   Arbeit, bleibt aber als Kommentar erhalten -- falls der Betreuer sie doch sehen will,
   genuegt es, den folgenden Block wieder auszukommentieren. Die Aenderungen sind in
   Requirements.xlsx eingetragen; die betroffenen Zeilen tragen in der Spalte "Kommentar"
   einen Vermerk mit Datum. Der urspruengliche Stand liegt als
   Requirements_BACKUP_2026-08-06.xlsx im Projektverzeichnis. */

/*

Der Abgleich zwischen den Anwendungsfällen aus @sec:usecases und dem ursprünglichen Katalog hat mehrere Punkte offengelegt. Drei davon führten zu einer Änderung des Katalogs -- eine Präzisierung, eine Streichung und eine nicht aufgenommene Anforderung --, hinzu kommen eine Ergänzung aus der Betrachtung des Registerraums, eine daraus abgeleitete nichtfunktionale Anforderung sowie die drei Randbedingungen zur Netzebene. Zwei weitere Punkte sind als Vorbehalt zu führen und im Validierungsteil aufzulösen. Die folgende Übersicht macht diese Eingriffe nachvollziehbar.

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    align: (left + horizon, left + horizon, left),
    table.header(
      [*ID*], [*Art*], [*Begründung*],
    ),
    [FA-06],
    [geändert],
    [Die ursprüngliche Fassung verlangte, über die Schnittstelle „alle verfügbaren Konfigurationen" vorzunehmen. Das steht im Widerspruch zu FA-09 und zu der in @sec:konzept begründeten Arbeitsteilung. Die Anforderung ist auf Befehle des laufenden Betriebs beschränkt worden; die Parametrierung geschützter Schutzeinstellungen ist ausgenommen.],

    [FA-07],
    [entfallen],
    [Die Anforderung verlangte die Visualisierung in Dashboards und die Einteilung in Archivgruppen. Beides ist keine Eigenschaft des Objektmodells, sondern eine Projektierungsleistung in Desigo CC und daher mit dem Gegenstand dieser Arbeit nicht zu erfüllen. Hinzu kommt, dass der Registersatz des #acro("ECPD") keinen Arbeitszähler enthält (siehe @sec:registerraum), sodass auch die vorausgesetzte Energieauswertung keine unmittelbare Grundlage hat. Die Anforderung ist gestrichen worden.],

    [FA-10],
    [ergänzt],
    [Neben der Kommunikationsunterbrechung sind auch als _Not a Number_ gekennzeichnete Messwerte und ein fehlender Verbindungsstatus des Endgeräts zu behandeln @src:sentronsystemhandbuch, damit ein ausgefallenes Gerät nicht als Gerät mit dem Messwert null erscheint.],

    [FA-11],
    [nicht aufgenommen],
    [Die Nachvollziehbarkeit von Änderungen an geschützten Geräteparametern ließe sich mit den vorhandenen Zählern abbilden, wird aber nicht als Anforderung geführt; die Kennung bleibt reserviert.],

    [NFA-06],
    [neu],
    [Ein Teil der Alarmbits des #acro("ECPD") ist ab Werk deaktiviert (siehe @sec:registerraum). Die erforderliche Geräteparametrierung ist daher Teil des Lieferumfangs der Lösung.],

    [RB-01],
    [präzisiert],
    [Beschränkung auf die Desktop-Variante von SENTRON Powerconfig. Die mobile Anwendung erwies sich in Vorversuchen als nicht verlässlich, zudem wurde von ihrem Einsatz abgeraten @src:ulmer2026.],

    [RB-05 bis RB-07],
    [neu],
    [Aufnahme der drei in @sec:integrationswege hergeleiteten Festlegungen zur Netzebene als Randbedingungen.],
  ),
  caption: [Änderungen am Anforderungskatalog gegenüber dem ursprünglichen Stand]
)<tab:anforderungsaenderungen>

*/

// den folgenden Abschnitt muss ich mir nochmal intensivst anschauen ob das sinnvoll und konsistent ist so da einzufügen
Zwei Punkte sind bewusst nicht durch eine Änderung des Katalogs aufgelöst worden, weil sie sich nicht durch eine Festlegung, sondern nur durch eine Messung klären lassen.

Der erste betrifft die *Belastbarkeit des Fernschaltens*. UC-06 und FA-06 setzen voraus, dass sich das #acro("ECPD") elektronisch fernschalten lässt. Am Testaufbau weist das Gerät den entsprechenden Schreibzugriff zurück, obwohl andere schreibende Zugriffe angenommen werden und die Schaltfunktion als geschützter Parameter freigegeben ist. Die Anforderung bleibt bestehen, wird aber unter Vorbehalt geführt. Die Klärung ist Gegenstand des Validierungsteils.



Der zweite betrifft die *geforderte Systemversion* nach NFA-04. Die Engineering-Dokumentation beschreibt die für diese Arbeit maßgeblichen Mechanismen, ein fehlerfreier Import der konkreten Typbeschreibung unter dem geforderten Stand lässt sich daraus jedoch nicht ableiten. Auch dieser Nachweis ist am Testaufbau zu führen.

Nicht Gegenstand des Katalogs sind schließlich mehrere Punkte, deren Ausschluss sich aus der Analyse ergibt: eine Ablösung von SENTRON Powerconfig (siehe @sec:konzept), eine Rückwärtskompatibilität zu einer bestehenden Anbindung -- eine solche existiert nicht --, Eingriffe in die Schutzfunktion der Geräte sowie Anforderungen an die Architektur von Desigo CC selbst (siehe @sec:systemanalyse). Ebenfalls nicht Gegenstand ist die Ausgestaltung der Netzsicherheit: RB-05 bis RB-07 benennen die Mindestvoraussetzungen des Betriebs, das Sicherheitskonzept selbst richtet sich jedoch nach den Vorgaben des jeweiligen Kunden und lässt sich nicht allgemeingültig festlegen (siehe @sec:stakeholder). Hinzu kommen die beiden oben genannten, nicht in den Katalog übernommenen Punkte: die Gestaltung von Dashboards und Archivgruppen, die der Projektierung im Zielsystem vorbehalten bleibt, sowie die Nachvollziehbarkeit von Änderungen an geschützten Geräteparametern.
