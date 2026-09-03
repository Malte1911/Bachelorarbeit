#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Kriterien der Datenauswahl<sec:auswahlkriterien>

Die Reduktion des Registerraums ist die folgenreichste Festlegung des Entwicklungsteils. Sie bestimmt, welche Information in der Leitwarte überhaupt erscheinen kann, und sie wirkt über die Typbeschreibung auf jede Anlage, in der das Modell eingesetzt wird. Eine Auswahl, die sich allein auf das Urteil des Bearbeiters stützt, wäre weder überprüfbar noch nach NFA-03 fortschreibbar, da sich später nicht mehr feststellen ließe, ob ein Datenpunkt aus einem Grund fehlt oder übersehen wurde. Die Kriterien werden deshalb zuerst benannt und begründet, bevor sie in @sec:datenpunkte angewandt werden.


Sie sind nicht frei gewählt, sondern gehen aus drei bereits vorliegenden Ergebnissen hervor. Die Anwendungsfälle in @tab:usecases und der Anforderungskatalog in @tab:fa und @tab:nfa bestimmen, welche Information im Betrieb gebraucht wird. Die in @sec:registerraum beschriebenen Eigenschaften des Registerraums bestimmen, in welcher Form sie vorliegt und an welchen Stellen eine unbesehene Übernahme in die Irre führt. Die Arbeitsteilung zwischen SENTRON Powerconfig und Desigo CC aus @sec:konzept bestimmt schließlich, welche Register für eine Aufnahme von vornherein ausscheiden.


Dass es eines offengelegten Kriterienkatalogs überhaupt bedarf, folgt aus dem in @sec:stakeholder beschriebenen Spannungsfeld zwischen Erkenntnisgewinn und Projektierungsaufwand, in dem beide Seiten hohen Einfluss haben und keine sich verwerfen lässt. Ein Kriterium entscheidet den Einzelfall daher nicht nach Angemessenheitsempfinden, sondern nach einer vorab bekannten Regel, deren Anwendung der Leser an jedem einzelnen Datenpunkt nachprüfen kann.


#figure(
  table(
    columns: (4em, 1fr, 10em),
    inset: 6pt,
    align: (left + horizon, left, left + horizon),
    table.header(
      [*ID*], [*Kriterium*], [*Herkunft*],
    ),
    [K-01],
    [Aufgenommen wird ein Datenpunkt nur, wenn er mindestens eine Tätigkeit aus den Anwendungsfällen trägt. Die bloße Verfügbarkeit eines Registers ist kein Aufnahmegrund.],
    [@sec:usecases, FA-03],

    [K-02],
    [Abgebildet wird das Ergebnis, nicht die Schwelle. Grenzwerte, Hysteresen, Ein- und Ausschalter der Alarme sowie Mittelungszeiträume bleiben außerhalb des Modells.],
    [FA-09, @sec:konzept],

    [K-03],
    [Register, deren Veränderung Fachkunde voraussetzt oder unumkehrbar wirkt, werden nicht abgebildet. Dazu zählen geschützte Schutzeinstellungen, Werksrückstellung und Zugangsdaten.],
    [FA-06, FA-09, @sec:stakeholder],

    [K-04],
    [Liegt eine Information doppelt vor, wird sie an der Stelle geführt, an der sie entsteht. Gerätebezogene Werte gehören an das Endgerät, nicht an den Datentransceiver.],
    [@sec:registerraum],

    [K-05],
    [Größen, die die Zielplattform aus abgebildeten Werten selbst bilden kann, entfallen. Nicht ableitbar sind vom Gerät gespeicherte Extremwerte.],
    [@sec:desigoccmechanik],

    [K-06],
    [Abgebildet wird nur, was am Gerät einen lesbaren und veränderlichen Wert liefert. Geräteweit konstante, nicht implementierte und nicht dekodierbare Register entfallen.],
    [@sec:quellenlage, @sec:registerraum],

    [K-07],
[Gelesen wird nur, was gebraucht wird. Was ein Datenpunkt kostet, hängt an den Registern hinter ihm und nicht an seiner Erscheinung in der Leitwarte.],
    [FA-02, @tab:modbustreiber],
  ),
  caption: [Kriterien der Datenauswahl und die Ergebnisse, aus denen sie hervorgehen]
)<tab:auswahlkriterien>

K-01 ist das einzige Einschlusskriterium, die übrigen sechs schließen aus. Der Registerraum wird folglich danach durchsucht, was eine der in @tab:usecases beschriebenen Tätigkeiten trägt. Diese Richtung der Prüfung ist der eigentliche Unterschied zu einer vollständigen Abbildung, denn sie verlangt zu jedem aufgenommenen Datenpunkt eine Angabe darüber, wer ihn wofür benötigt. Ihre Grenze findet sie an FA-03, das die Sichtbarkeit sämtlicher Messwerte des #acro("ECPD") ausdrücklich fordert. Für diese Gruppe ist der Nutzennachweis damit vorweggenommen, und K-01 kann sie nicht weiter beschneiden.


K-02 und K-03 folgen beide aus der Arbeitsteilung, betreffen jedoch verschiedene Register. K-02 zieht die Grenze zwischen Parametrierung und Betrieb. Der größte Teil des Registerraums besteht nach @sec:registerraum aus Alarm- und Grenzwertkonfiguration, die einmalig bei der Inbetriebnahme gesetzt wird und nach FA-09 bei SENTRON Powerconfig verbleibt. Für den Betrieb ist die Schwelle selbst nicht bedeutsam, sondern deren Überschreitung, und diese meldet das Gerät über das Alarmregister. K-03 zieht die Grenze dagegen entlang der Verantwortung. Geschützte Schutzeinstellungen wie die Empfindlichkeit der Fehlerstromauslösung oder das Verhalten nach einer Auslösung sind ausgeschlossen, weil ihre Änderung eine Elektrofachkraft voraussetzt, während Desigo CC vom Personal der Gebäudeverwaltung bedient wird. Dass ein Register über Modbus grundsätzlich beschreibbar wäre, ist für beide Kriterien ohne Bedeutung.


K-04 und K-05 lösen zwei Formen der Doppelung auf. K-04 betrifft Werte, welche die Geräte selbst doppelt bereitstellen. Schalterzustand, Verbindungszustand und die Zähler von Parameteränderungen stehen sowohl am Endgerät als auch in Feldern über alle 24 Endgeräte am Powercenter. Da eine Abbildung beider Quellen jeden Wert doppelt führte und 24 fremde Geräte in ein Objekt mischte, wird der Wert am Endgerät geführt. K-05 betrifft Werte, die sich in der Zielplattform aus bereits abgebildeten Größen bilden lassen. Der Grenzfall dieses Kriteriums sind die vom Gerät gespeicherten Extremwerte. Ein Mittelwert lässt sich aus einer Reihe abgetasteter Werte nachträglich bilden, eine Spitze dagegen nur, wenn sie nicht zwischen zwei Abfragen aufgetreten ist. Extremwerte bleiben deshalb im Modell, obwohl sie auf den ersten Blick als abgeleitete Größen erscheinen.


K-06 überträgt den in @sec:quellenlage festgelegten Umgang mit der Herstellerdokumentation auf die Auswahl. Die Registerkarte weist Register aus, die geräteweit konstant sind, auf dem #acro("ECPD") mit einer Ausnahmemeldung antworten oder wegen gemischter Kodierung nicht dekodierbar sind. Ein solcher Datenpunkt erzeugt in Desigo CC einen Eintrag ohne Aussage und kostet Registerzugriffe. Maßgeblich ist also die Beobachtung des Geräts in Desigo CC.


K-07 besagt, dass jedes Register Zeit zum Abfragen auf der Strecke kostet, weswegen ein Wert ohne Nutzen nicht abgelesen wird. Wie viel ein Datenpunkt dabei kostet, entscheidet nicht seine Erscheinung in der Leitwarte, sondern das, was das Gerät dafür liefern muss. Der Alarmzustand ist ein einziger Eintrag der Registerkarte und trägt als Bitfeld 27 Meldungen, während das Anlagenkennzeichen ein einziger Wert ist, für den 16 aufeinanderfolgende Register zu lesen sind. Da das Abfrageintervall nach @sec:konzept einheitlich gilt, wird zudem jedes Register gleich häufig gelesen, auch das selten benötigte, und das bei bis zu 24 Endgeräten je Strang. Gespart wird folglich an der Zahl der Register je Gerät und nicht an der Zahl der Datenpunkte.


Die Kriterien stehen in einer Rangfolge, die nur an wenigen Stellen wirksam wird. K-03 und K-06 sind unbedingt, da ein Datenpunkt, der Verantwortungsgrenzen verletzt oder keinen verwertbaren Wert liefert, auch bei hohem Nutzen nicht aufzunehmen ist. K-01 geht K-07 vor, solange die Registerzahl je Gerät im Rahmen bleibt, weshalb ein Register mit belegtem Nutzen nicht allein wegen der Last entfällt. Zwischen K-01 und K-05 entscheidet die Frage, ob die Zielplattform den Wert verlustfrei bilden kann. An dieser Frage entzündet sich die einzige Berührung mit FA-03, die in @sec:datenpunkte bei den Messwerten aufgegriffen wird. // Claude: bitte den satz umformulieren damit da nicht mehr entzündet steht


Zwei Festlegungen trifft dieser Katalog ausdrücklich nicht. Er entscheidet weder über das Abfrageintervall noch über die Archivierung eines Datenpunkts, obwohl die Arbeitsmappe zu jeder Zeile einen Vorschlag dazu führt. Beides ist Projektierungsleistung in Desigo CC und nach @sec:anforderungsvorbehalte nicht Gegenstand des Datenmodells. Ebenso wenig entscheidet er über die Zuordnung der Alarme zu Kategorien nach FA-05, die aus denselben Gründen in der Anlage vorgenommen wird.


Die Kriterien werden von Hand angewandt. Eine selbsttätige Zuordnung setzt uneinheitlich benannte Datenpunkte voraus und ist hier gegenstandslos, da die Registerkarte die Benennung bereits vorgibt (siehe @sec:weiterentwicklung). Die zu leistende Arbeit liegt eine Stufe später und besteht in der Entscheidung, welche Register die Anwendungsfälle tragen und wie sie im Objektmodell zu führen sind. Sie fällt nur einmal an, da sie an den Gerätetyp gebunden ist und in Folgeprojekten erhalten bleibt.

/* Claude: Am 02.09.2026 gekuerzt. Der Absatz stand fast wortgleich als
   Schlussabsatz in @sec:weiterentwicklung, einschliesslich beider Zitate. Er
   bleibt dort, weil er die Frage nach einer Automatisierung als Ausblick
   beantwortet, und ist hier auf die Aussage reduziert, die die Handarbeit an
   dieser Stelle rechtfertigt. @src:zhan2020 steht weiterhin in
   @sec:standdertechnik und @sec:weiterentwicklung, @src:wang2018 in
   @sec:standdertechnik, @sec:stakeholder und @sec:nachhaltigkeit; beide
   fallen also nicht aus dem Literaturverzeichnis.

   Ebenfalls gekuerzt sind der Spannungsfeld-Absatz, dessen erste zwei Saetze
   @sec:stakeholder wiederholten, und die Herleitung des einheitlichen
   Abfrageintervalls in der Erlaeuterung zu K-07, die jetzt auf @sec:konzept
   verweist. */
