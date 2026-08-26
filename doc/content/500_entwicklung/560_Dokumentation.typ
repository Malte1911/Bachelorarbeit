#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Begleitende Dokumentation<sec:modelldoku>

Eine Typbeschreibung, die niemand erklärt, ist eine Datei und keine Integrationsvorlage. Wer sie einsetzen will, muss wissen, welche Register sie liest, welche Einstellungen sie am Gerät voraussetzt, was sie bewusst offenlässt und wie sie sich ändern lässt. Nichts davon geht aus der Datei selbst hervor. NFA-01 und NFA-02 erheben die Dokumentation deshalb zur Anforderung, und T-13 macht sie zum Prüfgegenstand. Sie ist damit Bestandteil des Entwicklungsergebnisses und nicht dessen Beiwerk.

Diese Einordnung deckt sich mit dem Stand der Technik. Die Zuordnung von Datenpunkten eines Gebäudeleitsystems zu einer einheitlichen Beschreibung erfolgt überwiegend von Hand und macht einen erheblichen Anteil des Projektierungsaufwands aus @src:wang2018. Der Nutzen einer Vorlage entscheidet sich folglich nicht daran, ob diese Zuordnung einmal getroffen wurde, sondern daran, ob sie in nachvollziehbarer Form mitgeliefert wird. Andernfalls fällt der Aufwand im nächsten Projekt erneut an.


==== Adressatenkreise und die Wahl einer einzigen Unterlage

NFA-02 benennt zwei Adressatenkreise ausdrücklich, nämlich das technische Personal, das die Anlage errichtet, und das administrative Personal, das die Projektierung in Desigo CC vornimmt. Aus UC-11 und NFA-03 tritt ein dritter hinzu, der die Vorlage selbst verändert. Drei Leser also, die zu verschiedenen Zeitpunkten und mit verschiedenen Werkzeugen arbeiten.

Getrennte Unterlagen je Adressatenkreis liegen damit nahe, sind hier jedoch nicht gewählt worden. Der Grund liegt in den Grenzen der Vorlage. Dass die Alarme des Sammelregisters nicht als einzelne Meldungen ankommen, dass Zeichenketten nicht beschreibbar sind und dass das Abfrageintervall für alle Geräte eines Treibers gemeinsam gilt, betrifft jeden der drei Leser. In getrennten Unterlagen stünden diese Aussagen entweder mehrfach oder an einer Stelle, an der ein Teil der Leser sie nicht findet. Die Unterlage ist deshalb ein einziges Dokument, das seine Adressatenkreise über die Gliederung trennt und die gemeinsamen Aussagen voranstellt.

#figure(
  table(
    columns: (13em, 10em, 1fr),
    inset: 6pt,
    align: (left + horizon, left + horizon, left),
    table.header(
      [*Teil der Unterlage*], [*Adressat*], [*Getragene Anforderung*],
    ),
    [Voraussetzungen und Grenzen], [alle drei], [NFA-01, NFA-06, @sec:rb],
    [Inbetriebnahme im Verteiler], [Errichter], [NFA-02, NFA-06],
    [Integration in Desigo CC], [Projektierung], [NFA-01, NFA-02],
    [Vorlage anpassen], [Weiterentwicklung], [NFA-03, UC-11],
    [Referenz der Datenpunkte], [alle drei], [NFA-01, NFA-03],
  ),
  caption: [Aufbau der begleitenden Unterlage mit den Adressatenkreisen und den Anforderungen, die der jeweilige Teil trägt]
)<tab:doku_aufbau>

Der Teil zur Inbetriebnahme fällt dabei bewusst knapp aus. Die Errichtung eines Verteilers und die Kopplung der Endgeräte folgen dem gewohnten Ablauf der Gerätefamilie und sind dem Fachpersonal geläufig. Beschrieben ist deshalb nur, was die spätere Anbindung festlegt oder ohne Hinweis übersehen würde. Umgekehrt ist der Teil zur Weiterentwicklung knapp, weil die Werkzeugkette diese Aufgabe bereits trägt. Eine bestehende Typbeschreibung lässt sich im #acro("PDE") erneut öffnen und bearbeiten, sodass sich Datenpunkte ohne Neuerstellung ergänzen oder entfernen lassen. Zu dokumentieren bleiben allein die Fallstricke, also die Bindung an bestehende Instanzen und das in @sec:umsetzung beschriebene Verhalten der Datei beim Entfernen eines Datentyps.


==== Dokumentation im Artefakt selbst

Vor der Unterlage steht eine Ebene, die häufig übersehen wird. Der #acro("PDE") führt zu jeder Eigenschaft ein Beschreibungsfeld in deutscher und englischer Sprache @src:pdemanual. Was dort abgelegt ist, wandert mit der #acro("JSON")-Datei, übersteht den Import und geht nicht verloren, während eine danebenliegende Unterlage nach wenigen Projekten nicht mehr auffindbar ist. Zusammen mit den in @sec:umsetzung festgelegten sprechenden Bezeichnern und der Gruppenzuordnung trägt diese Ebene die Dokumentation dort, wo sie am haltbarsten ist.

Der Anspruch dahinter ist derselbe, den @src:balaji2018 an eine über Anlagengrenzen hinweg gültige Beschreibung stellt. Erst eine einheitliche und aus sich heraus verständliche Benennung erlaubt es, Anwendungen auf der Beschreibung aufzusetzen, statt sie für jede Anlage neu zuzuschneiden. Die äußere Unterlage trägt folglich nur noch das, was sich im Artefakt nicht unterbringen lässt, also Voraussetzungen, Grenzen, Arbeitsschritte und Begründungen.


==== Vorausgesetzte Geräteparametrierung

Eine Aussage der Unterlage verdient hier eine eigene Erwähnung, weil das Datenmodell ohne sie unvollständig bleibt. Nach @sec:registerraum sind 13 der 27 Alarmbits des #acro("ECPD") ab Werk abgeschaltet und liefern ohne vorherige Einstellung in SENTRON Powerconfig dauerhaft den Wert null, darunter beide #acro("RCM")-Alarme. Ein Modell, das diese Bits abbildet, ist formal vollständig und in der Sache wirkungslos, solange die Parametrierung fehlt. Genau hierauf zielt NFA-06.

Die Unterlage benennt diese Voraussetzung deshalb an hervorgehobener Stelle und weist über @tab:apx_ecpd_alarme aus, welche Alarme betroffen sind. Zwei weitere Voraussetzungen stehen daneben. Das Fernschalten über Modbus ist ab Werk gesperrt und lässt sich nach @sec:geraetekonfiguration ausschließlich über SENTRON Powerconfig freigeben, ein Umstand, der sich aus der zugänglichen Produktdokumentation nicht ergibt und in @sec:befunde ausgewertet wird. Anlagenkennzeichen und Einbauort sind nach @sec:umsetzung im Modell nur lesend geführt und ebenfalls am Gerät zu vergeben. Alle drei Punkte eint, dass ihr Fehlen keine Fehlermeldung erzeugt, sondern einen Datenpunkt ohne Aussage. Sie sind damit genau die Art von Wissen, die eine Unterlage tragen muss.

Hinzu treten die Randbedingungen aus @tab:rb, die nach @sec:testabdeckung keine geprüfte Eigenschaft der Lösung beschreiben, sondern die Voraussetzungen ihres Betriebs, und deren Einhaltung folglich zu dokumentieren ist. Betroffen sind vor allem die Begrenzung der Modbus-Schnittstelle auf Netzebene, die angesichts der fehlenden Authentifizierung des Protokolls unmittelbar sicherheitsrelevant ist.


==== Kriterien für die Durchsicht

T-13 ist nach @sec:testanmerkungen der einzige Testfall ohne objektives Kriterium, und seine Aussagekraft hängt daran, dass die Kriterien vor der Durchsicht feststehen und die Durchsicht von einer an der Entwicklung unbeteiligten Person vorgenommen wird. Festgelegt werden die Kriterien deshalb an dieser Stelle und nicht erst im Validierungsteil, der sie in @sec:pruefablauf lediglich anwendet.

#figure(
  table(
    columns: (7em, 1fr),
    inset: 6pt,
    align: (left + horizon, left),
    table.header(
      [*Kriterium*], [*Erfüllt, wenn*],
    ),
    [D-01],
    [jeder Datenpunkt des Modells in der Referenz mit Register, Datentyp, Einheit und Bedeutung wiederzufinden ist und umgekehrt kein Eintrag der Referenz ohne Entsprechung im Modell bleibt.],

    [D-02],
    [eine sachkundige Person die Integration in Desigo CC allein anhand der Unterlage und ohne Rückfrage an den Verfasser durchführen kann.],

    [D-03],
    [jeder beschriebene Arbeitsschritt erkennbar einem Adressatenkreis zugeordnet ist und beide Kreise die für sie erforderlichen Schritte an einer Stelle finden.],

    [D-04],
    [die vorausgesetzte Geräteparametrierung vollständig benannt ist, einschließlich der Angabe, welcher Datenpunkt ohne sie ohne Aussage bleibt.],

    [D-05],
    [die bekannten Grenzen der Lösung benannt sind und die Unterlage keine Funktion beschreibt, die sich am Testaufbau nicht bestätigt hat.],
  ),
  caption: [Kriterien für die Durchsicht der begleitenden Unterlage nach T-13]
)<tab:doku_kriterien>

#kommentar[Hier Tabelle Overkill? Ich bin grundsätzlich Fan davon, diese Tabellen zu verwenden, das zeigt Struktur aber ich weiß nicht ob es sich lohnt das so oft zu machen]

D-05 ist dabei das Kriterium, das am ehesten verfehlt wird, denn es verlangt von der Unterlage, gegen das eigene Ergebnis zu sprechen. Eine Vorlage, die ihre Grenzen verschweigt, besteht die Durchsicht dem Wortlaut nach, führt in der Anwendung jedoch zu Erwartungen, die sie nicht einlöst. Der in @sec:uebernahme beschriebene Fall der Alarme ist das deutlichste Beispiel, da die Zerlegung des Sammelregisters in der Auswahl vorgesehen war und erst bei der Übernahme scheiterte.

#kommentar[Zu entscheiden ist, in welcher Form die Unterlage der Arbeit beiliegt. Möglich sind eine Aufnahme in den Anhang oder eine Führung als eigenständige Beilage mit Verweis an dieser Stelle. Für die Beilage spricht, dass die Unterlage außerhalb der Arbeit fortgeschrieben wird und ein eigenes Deckblatt mit Revisionsstand trägt. Die Entscheidung berührt auch @sec:pruefablauf, da die durchsehende Person auf einen benannten Stand verweisen muss.]

/* Claude: Abschnitt nach dem mit dem Autor abgestimmten Konzept ausformuliert.
   Der urspruengliche #kommentar ist damit abgearbeitet, einschliesslich seiner
   Vorgabe, die vorausgesetzte Geraeteparametrierung aufzunehmen.

   Die Entscheidungen des Autors sind eingearbeitet:
   - eine einzige Unterlage statt getrennter Dokumente je Adressatenkreis. Da
     NFA-02 zwei Kreise ausdruecklich nennt, traegt der Abschnitt dafuer eine
     Begruendung, naemlich dass die Grenzen alle drei Leser betreffen.
   - der Teil zur Inbetriebnahme faellt knapp aus, weil der Ablauf dem
     Fachpersonal gelaeufig ist.
   - der Teil zur Weiterentwicklung faellt knapp aus, weil die Werkzeugkette die
     Aufgabe bereits traegt. Die beiden Fallstricke sind dennoch genannt, da
     "im PDE oeffnen und bearbeiten" fuer bestehende Instanzen und nach dem in
     @sec:umsetzung beschriebenen Dateiverhalten nicht uneingeschraenkt gilt.

   Die Kriterien D-01 bis D-05 sind neu eingefuehrt. Sie beantworten die Vorgabe
   aus @sec:testanmerkungen, dass die Kriterien fuer T-13 vor der Durchsicht
   feststehen muessen, und geben @sec:pruefablauf etwas, worauf verwiesen werden
   kann. Die Kennungen folgen dem Muster der uebrigen Kataloge. Falls ein
   anderes Praefix gewuenscht ist, sind nur diese Tabelle und der Verweis in
   @sec:pruefablauf betroffen.

   Die konkrete Unterlage liegt als doc/resources/anwenderdokumentation_ecpd.md
   vor und traegt die hier beschriebene Gliederung. Ob sie in den Anhang oder
   als Beilage geht, ist als #kommentar offen gelassen.

   Der Hinweis auf die Beschreibungsfelder des PDE als erste Dokumentationsebene
   ist belegt ueber @src:pdemanual, siehe doc/resources/pde_referenz.md,
   Abschnitt 4. */
