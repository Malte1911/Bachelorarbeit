#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Abgleich mit dem Anforderungskatalog<sec:anforderungsabgleich>

/* Anmerkung des Autors, erledigt: "Hier schliesst sich der aufsteigende Ast des
   V-Modells. Eine Tabelle fuehrt jede Anforderung aus @tab:fa und @tab:nfa mit
   dem zugehoerigen Testfall und dem Ergebnis, also erfuellt, teilweise erfuellt
   oder nicht erfuellt, jeweils mit Verweis auf den Abschnitt der Durchfuehrung.
   Teilweise erfuellte Anforderungen sind zu begruenden." */

Mit diesem Abschnitt schließt sich der aufsteigende Ast des in @sec:vorgehensmodell_auswahl gewählten Vorgehens. @tab:anforderungsabgleich stellt jeder Anforderung aus @tab:fa und @tab:nfa die Testfälle gegenüber, die sie abdecken, und hält das Ergebnis fest. Die Beobachtungen selbst stehen in @sec:testdurchfuehrung und werden hier nicht wiederholt. Um dieselbe Kette auch in ihrer vollen Länge nachvollziehbar zu halten, führt @tab:apx_rueckverfolgung im Anhang die über @sec:usecases, @sec:fa, @sec:testfaelle und diesen Abschnitt verteilten Zuordnungen zusammen und ergänzt sie um den Anwendungsfall und das jeweils tragende Element des Datenmodells.

#figure(
  table(
    columns: (4.5em, 6em, 8em, 1fr),
    inset: 6pt,
    align: (left + horizon, left + horizon, left + horizon, left),
    table.header(
      [*ID*], [*Testfälle*], [*Ergebnis*], [*Bemerkung*],
    ),
    [FA-01], [T-01, T-02], [erfüllt],
    [Import und Instanziierung für beide Typbeschreibungen bestätigt],

    [FA-02], [T-03], [erfüllt],
    [zyklische Übertragung im eingestellten Intervall bestätigt],

    [FA-03], [T-04, T-05], [erfüllt],
    [Messwerte vollständig, plausibel und richtig beschriftet],

    [FA-04], [T-06, T-07], [nicht erfüllt],
    [Zustände nur als Sammelregister, keine auswertbare Meldung],

    [FA-05], [T-07], [nicht erfüllt],
    [Zuordnung zu Alarmkategorien ohne einzelne Zustände nicht möglich],

    [FA-06], [T-08], [erfüllt],
    [nach der Freischaltung des Fernschaltens, siehe @sec:befunde],

    [FA-08], [T-09], [erfüllt],
    [Anstoß und Auslesen beider Tests bestätigt, Beurteilung bleibt bei der befähigten Person],

    [FA-09], [T-10], [erfüllt],
    [Parametrierung neben der laufenden Abfrage möglich],

    [FA-10], [T-11], [teilweise erfüllt],
    [gestörte Werte gekennzeichnet, Ausfall eines Endgeräts jedoch ohne Alarm],

    [NFA-01], [T-13], [erfüllt],
    [Integrationsprozess dokumentiert, D-01, D-04 und D-05 am Artefakt bestätigt],

    [NFA-02], [T-13], [teilweise erfüllt],
    [Anleitung für beide Adressatenkreise vorhanden, ihre Eignung mangels unabhängiger Durchsicht nicht belegt],

    [NFA-03], [T-12], [erfüllt],
    [Änderung im #acro("PDE") möglich, Vorbehalt gegen das Werkzeug],

    [NFA-04], [T-01], [erfüllt],
    [Verträglichkeit mit dem eingesetzten Plattformstand belegt],

    [NFA-05], [T-02], [teilweise erfüllt],
    [Wiederverwendbarkeit belegt, Betrieb eines vollen Strangs nicht],

    [NFA-06], [T-14], [erfüllt],
    [vorausgesetzte Parametrierung ist Bestandteil der Unterlage],
  ),
  caption: [Abgleich der Anforderungen aus @tab:fa und @tab:nfa mit den Ergebnissen aus @sec:testdurchfuehrung]
)<tab:anforderungsabgleich>

Zehn der fünfzehn Anforderungen sind erfüllt, drei teilweise und zwei nicht. Erfüllt ist durchweg, was die Abbildung zwischen Registerraum und Objektmodell betrifft, also der Kern des entwickelten Artefakts. Nicht erfüllt ist, was über diese Abbildung hinausgeht und in der Zielplattform oder außerhalb der Technik liegt.

Auf die Anwendungsfälle übertragen ergibt sich ein etwas anderes Bild, das @tab:apx_rueckverfolgung Zeile für Zeile ausweist. Acht der zehn Anwendungsfälle aus @tab:usecases sind getragen, zwei davon mit einem Vorbehalt. UC-01 ist es nur in dem Umfang, den der Aufbau nach RB-04 nachzuweisen erlaubt, und bei UC-10 bleibt offen, ob die Unterlage einem fremden Leser genügt. Nicht getragen ist UC-03, das Erkennen, Einordnen und Quittieren einer Störung, da beide ihn tragenden Anforderungen nicht erfüllt sind. UC-04 ist zur Hälfte getragen. Beide Lücken haben dieselbe Ursache, denn auch das Erkennen eines ausgefallenen Endgeräts setzt die Alarmkonfiguration voraus, die FA-04 fehlt. Gemessen an den Anwendungsfällen wiegt das Ergebnis damit schwerer als die Zählung der Anforderungen vermuten lässt, weil sich die beiden nicht erfüllten Anforderungen auf denselben Anwendungsfall bündeln, während sich die erfüllten über mehrere verteilen.

Am schwersten wiegt das Nichterfüllen von FA-04 und FA-05. Beide Anforderungen tragen UC-03 und damit den Anwendungsfall, der den Nutzen einer Leitwartenanbindung im Wesentlichen ausmacht. Ihre Erfüllung scheitert nicht an der Auswahl der Datenpunkte, sondern daran, dass sich das Sammelregister mit der eingesetzten Werkzeugkette nicht in einzelne Zustände zerlegen lässt (siehe @sec:umsetzung). Solange das so bleibt, steht in Desigo CC eine Zahl, deren Bedeutung nur über @tab:apx_ecpd_alarme zu erschließen ist, und keine Meldung, die sich bearbeiten und quittieren ließe. Die in @sec:fa getroffene Feststellung, dass beide Anforderungen erst im Zusammenwirken von Modell und Projektierung erfüllbar sind, gilt damit verschärft, denn das Modell schafft die Voraussetzung dieser Projektierung derzeit nicht.

FA-08 ist erfüllt, jedoch in einem Umfang, der zu benennen ist. Der Gerätetest und der #acro("RCD")-Test lassen sich aus Desigo CC anstoßen und ihre Ergebnisse dort auslesen. Die wiederkehrende Prüfung nach #acro("DGUV") Vorschrift 3 selbst setzt dagegen die Beurteilung durch eine befähigte Person voraus und ist kein Vorgang, den eine Leitwarte auslösen und abschließen kann. Die Anforderung war in ihrer ursprünglichen Fassung insoweit zu weit gefasst und ist auf das beschränkt worden, was das Modell tatsächlich leisten kann. Es unterstützt die Prüfung und ersetzt sie nicht.

Die drei teilweise erfüllten Anforderungen sind aus verschiedenen Gründen begrenzt. Bei FA-10 liegt die Grenze in der Zielplattform. Von ihr ist die Kennzeichnung gestörter Werte erfüllt, da Desigo CC betroffene Datenpunkte als kommunikationsgestört ausgibt und nicht als gültig, während der Ausfall eines einzelnen Endgeräts ohne Meldung bleibt und allein am Verbindungszustand ablesbar ist, dessen Auswertung dieselbe Alarmierung voraussetzt, die schon FA-04 fehlt. Bei NFA-05 liegt die Grenze dagegen im Testaufbau. Nachgewiesen ist, dass sich aus einer Typbeschreibung beliebig viele Instanzen anlegen lassen, nicht aber, dass ein voll bestückter Strang im Betrieb trägt, was mit einem einzelnen #acro("ECPD") nach RB-04 auch nicht zu leisten war. Bei NFA-02 liegt sie schließlich in der Form des Nachweises. Die Anleitung ist vorhanden und trennt beide Adressatenkreise, doch verlangt NFA-02 ihre Eignung für diese Kreise, und darüber entscheidet nach @tab:doku_kriterien D-02, das eine an der Erstellung unbeteiligte Person voraussetzt. Die Durchsicht hat nach @sec:pruefablauf der Verfasser selbst vorgenommen, weshalb die Anforderung im Nachweis und nicht in der Sache offenbleibt.

Zwei der erfüllten Anforderungen tragen ihre Aussage schwächer als die übrigen. Bei FA-02 ist das Intervall nach @sec:befunde nur einheitlich einstellbar, sodass eine nach Verwendungszweck abgestufte Abfrage der in @sec:konzept benannte Ansatzpunkt einer Weiterentwicklung bleibt. NFA-01 stützt sich allein auf die Begutachtung, wenn auch auf deren am Artefakt entscheidbaren Teil. Ob die Anleitung darüber hinaus im Projektgeschäft trägt, erweist sich erst an einer Integration durch Dritte.

/* Claude: Abschnitt kompakt gehalten, eine Tabelle und fuenf kurze Absaetze.
   Die Ergebnisse folgen unmittelbar @sec:testdurchfuehrung, es ist kein
   Testfallergebnis guenstiger gewertet als dort.

   Bewusst ehrlich gefuehrt sind FA-04 und FA-05 als nicht erfuellt sowie die
   schwaechere Beweiskraft von NFA-01 und NFA-02. FA-08 ist nach der Anpassung
   des Testfalls in @sec:testuebersicht erfuellt, aber im Umfang beschraenkt;
   der Absatz dazu benennt das. Die Bilanz elf zu zwei zu zwei ist am
   31.08.2026 gegen @tab:anforderungsabgleich und @tab:testergebnisse
   nachgezaehlt und bei einer Aenderung der Testergebnisse mitzufuehren, ebenso
   in @sec:zusammenfassung, in der Kurzfassung und im Abstract, wo zuvor noch
   die ueberholte Bilanz neun zu drei zu drei stand.

   Die Kennzeichnung gestoerter Werte ueber das Kuerzel #COM in Desigo CC ist
   nach Auskunft des Autors ergaenzt. FA-10 bleibt teilweise erfuellt, da der
   Alarm beim Ausfall eines einzelnen Endgeraets weiterhin fehlt. In
   @sec:testdurchfuehrung ist zu T-11 offen, ob die Kennzeichnung auch bei
   unterbrochener Funkstrecke auftritt. */

/* Claude: Am 31.08.2026 nach dem Hinweis des Autors, dass die Durchsicht der
   Unterlage eine Selbstpruefung war, umgestellt. T-13 ist in
   @sec:testdurchfuehrung von "erfuellt" auf "eingeschraenkt nachweisbar"
   gesetzt und je Kriterium aufgeloest. D-01, D-04 und D-05 entscheiden sich am
   Artefakt und bleiben davon unberuehrt, D-02 und D-03 nicht.

   Daraus folgt NFA-02 als teilweise erfuellt. NFA-01 bleibt erfuellt, weil die
   Vollstaendigkeit der Dokumentation ueber D-01, D-04 und D-05 nachweisbar ist,
   waehrend allein die Eignung der Anleitung fuer fremde Leser an D-02 haengt.
   Wer beide Anforderungen gleich behandeln will, setzt auch NFA-01 auf
   teilweise erfuellt; die Bilanz lautete dann neun zu vier zu zwei.

   Die Bilanz ist damit zehn zu drei zu zwei, nachgezaehlt gegen
   @tab:anforderungsabgleich und @tab:testergebnisse. Mitgefuehrt sind
   @sec:zusammenfassung, die Kurzfassung, der Abstract und
   @tab:apx_rueckverfolgung. */

/* Claude: Am 02.09.2026 gekuerzt. Die Erlaeuterung zu FA-02 gab die
   Eigenschaft des Treibers erneut vollstaendig wieder und verweist jetzt auf
   @sec:befunde, wo sie als Befund belegt ist. */
