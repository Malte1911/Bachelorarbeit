#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Abgleich mit dem Anforderungskatalog<sec:anforderungsabgleich>

/* Anmerkung des Autors, erledigt: "Hier schliesst sich der aufsteigende Ast des
   V-Modells. Eine Tabelle fuehrt jede Anforderung aus @tab:fa und @tab:nfa mit
   dem zugehoerigen Testfall und dem Ergebnis, also erfuellt, teilweise erfuellt
   oder nicht erfuellt, jeweils mit Verweis auf den Abschnitt der Durchfuehrung.
   Teilweise erfuellte Anforderungen sind zu begruenden." */

Mit diesem Abschnitt schließt sich der aufsteigende Ast des in @sec:vorgehensmodell_auswahl gewählten Vorgehens. @tab:anforderungsabgleich stellt jeder Anforderung aus @tab:fa und @tab:nfa die Testfälle gegenüber, die sie abdecken, und hält das Ergebnis fest. Die Beobachtungen selbst stehen in @sec:testdurchfuehrung und werden hier nicht wiederholt.

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

    [FA-02], [T-03], [teilweise erfüllt],
    [zyklische Übertragung gegeben, abgestufte Abfrage nicht einstellbar],

    [FA-03], [T-04, T-05], [erfüllt],
    [Messwerte vollständig, plausibel und richtig beschriftet],

    [FA-04], [T-06, T-07], [nicht erfüllt],
    [Zustände nur als Sammelregister, keine auswertbare Meldung],

    [FA-05], [T-07], [nicht erfüllt],
    [Zuordnung zu Alarmkategorien ohne einzelne Zustände nicht möglich],

    [FA-06], [T-08], [erfüllt],
    [nach der Freischaltung des Fernschaltens, siehe @sec:befunde],

    [FA-08], [T-09], [nicht erfüllt],
    [Prüfung nach #acro("DGUV") nicht aus der Leitwarte abzuwickeln],

    [FA-09], [T-10], [erfüllt],
    [Parametrierung neben der laufenden Abfrage möglich],

    [FA-10], [T-11], [teilweise erfüllt],
    [gestörte Werte gekennzeichnet, Ausfall eines Endgeräts jedoch ohne Alarm],

    [NFA-01], [T-13], [erfüllt],
    [Integrationsprozess in dieser Arbeit und in der Unterlage dokumentiert],

    [NFA-02], [T-13], [erfüllt],
    [Anleitung für beide Adressatenkreise vorhanden, Nachweis begutachtend],

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

Neun der fünfzehn Anforderungen sind erfüllt, drei teilweise und drei nicht. Erfüllt ist durchweg, was die Abbildung zwischen Registerraum und Objektmodell betrifft, also der Kern des entwickelten Artefakts. Nicht erfüllt ist, was über diese Abbildung hinausgeht und in der Zielplattform oder außerhalb der Technik liegt.

Am schwersten wiegt das Nichterfüllen von FA-04 und FA-05. Beide Anforderungen tragen UC-03 und damit den Anwendungsfall, der den Nutzen einer Leitwartenanbindung im Wesentlichen ausmacht. Ihre Erfüllung scheitert nicht an der Auswahl der Datenpunkte, sondern daran, dass sich das Sammelregister mit der eingesetzten Werkzeugkette nicht in einzelne Zustände zerlegen lässt (siehe @sec:umsetzung). Solange das so bleibt, steht in Desigo CC eine Zahl, deren Bedeutung nur über @tab:apx_ecpd_alarme zu erschließen ist, und keine Meldung, die sich bearbeiten und quittieren ließe. Die in @sec:fa getroffene Feststellung, dass beide Anforderungen erst im Zusammenwirken von Modell und Projektierung erfüllbar sind, gilt damit verschärft, denn das Modell schafft die Voraussetzung dieser Projektierung derzeit nicht.

FA-08 ist aus einem anderen Grund nicht erfüllt. Die wiederkehrende Prüfung nach #acro("DGUV") Vorschrift 3 setzt die Beurteilung durch eine befähigte Person voraus und ist deshalb kein Vorgang, den eine Leitwarte auslösen und abschließen kann. Die Anforderung war insoweit von vornherein zu weit gefasst. Was technisch möglich ist, nämlich der Anstoß der Gerätetests und das Auslesen ihrer Ergebnisse, ist im Modell abgebildet und unterstützt die Prüfung, ersetzt sie aber nicht.

Die drei teilweise erfüllten Anforderungen sind aus verschiedenen Gründen begrenzt. Bei FA-02 und FA-10 liegt die Grenze in der Zielplattform. Das Abfrageintervall gilt nur für alle Geräte gemeinsam. Von FA-10 ist die Kennzeichnung gestörter Werte erfüllt, da Desigo CC betroffene Datenpunkte als kommunikationsgestört ausgibt und nicht als gültig, während der Ausfall eines einzelnen Endgeräts ohne Meldung bleibt und allein am Verbindungszustand ablesbar ist, dessen Auswertung dieselbe Alarmierung voraussetzt, die schon FA-04 fehlt. Bei NFA-05 liegt die Grenze dagegen im Testaufbau. Nachgewiesen ist, dass sich aus einer Typbeschreibung beliebig viele Instanzen anlegen lassen, nicht aber, dass ein voll bestückter Strang im Betrieb trägt, was mit einem einzelnen #acro("ECPD") nach RB-04 auch nicht zu leisten war.

Zwei der erfüllten Anforderungen tragen ihre Aussage schwächer als die übrigen. NFA-01 und NFA-02 sind allein durch Begutachtung nachgewiesen, deren Kriterien der Erstellung der Unterlage bereits zugrunde lagen (siehe @sec:testdurchfuehrung). Ob die Anleitung im Projektgeschäft trägt, erweist sich erst an einer Integration durch Dritte.

/* Claude: Abschnitt kompakt gehalten, eine Tabelle und fuenf kurze Absaetze.
   Die Ergebnisse folgen unmittelbar @sec:testdurchfuehrung, es ist kein
   Testfallergebnis guenstiger gewertet als dort.

   Bewusst ehrlich gefuehrt sind FA-04, FA-05 und FA-08 als nicht erfuellt sowie
   die schwaechere Beweiskraft von NFA-01 und NFA-02. Die Bilanz neun zu drei zu
   drei ist nachgezaehlt und bei einer Aenderung der Testergebnisse
   mitzufuehren.

   Die Kennzeichnung gestoerter Werte ueber das Kuerzel #COM in Desigo CC ist
   nach Auskunft des Autors ergaenzt. FA-10 bleibt teilweise erfuellt, da der
   Alarm beim Ausfall eines einzelnen Endgeraets weiterhin fehlt. In
   @sec:testdurchfuehrung ist zu T-11 offen, ob die Kennzeichnung auch bei
   unterbrochener Funkstrecke auftritt. */
