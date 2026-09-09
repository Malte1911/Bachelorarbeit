#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Befunde außerhalb des Datenmodells<sec:befunde>


Nicht jede Beobachtung der Prüfung sagt etwas über das Datenmodell aus. Der folgende Abschnitt führt jene, die Eigenschaften der Geräte oder der Zielplattform sind und die auch ein anderes Modell nicht beheben könnte. Sie sind hier belegt und werden in @sec:wuerdigung nur noch gewichtet. Beobachtungen, die die Werkzeugkette betreffen, stehen dagegen im Entwicklungsteil, da sie dort Festlegungen des Modells erzwungen haben.


==== Der zurückgewiesene Schaltbefehl

Über längere Zeit der Arbeit wies das #acro("ECPD") jeden Schaltbefehl zurück, obwohl es andere schreibende Zugriffe annahm und die Schaltfunktion als geschützter Parameter freigegeben war. Da damit weder die Adressierung noch die Schreibrichtung als Ursache in Betracht kamen, blieb der Befund als Vorbehalt bestehen, in @sec:anforderungsvorbehalte für FA-06 und den zugehörigen Testfall T-08.

Die Ursache liegt außerhalb des Registerraums. Das Gerät führt für das unauthentifizierte Fernschalten über Modbus einen eigenen Schalter, der ab Werk ausgeschaltet ist und sich nur über SENTRON Powerconfig setzen lässt (siehe @sec:geraetekonfiguration). In der Registerkarte erscheint er ohne Registeradresse und ohne Hinweis auf seine Wirkung, sodass aus ihr nicht hervorgeht, dass ein Schaltbefehl ohne diesen Schritt folgenlos bleibt @src:sentronregistermap. Nach Auskunft des Produktsupports ist die Freischaltung dem Inbetriebnahmepersonal geläufig, in den zugänglichen Unterlagen jedoch nicht als Voraussetzung des Fernschaltens erfasst @src:siemenssupport2026. Nach ihrer Aktivierung wird der Schaltbefehl angenommen und über das Statusregister quittiert, wie @sec:testdurchfuehrung für T-08 festhält.

Damit sind beide Vorbehalte aufgelöst. FA-06 ist erfüllt, was in @sec:anforderungsabgleich ausgewiesen ist, und der Befund bestätigt zugleich die Regel aus @sec:quellenlage, bei einer Abweichung zwischen Dokumentation und Beobachtung die Beobachtung als das Maßgebliche zu behandeln. Für die Lösung folgen daraus zwei Dinge. Der lesend abgebildete Freigabestatus aus Register 5425 erweist sich als der Datenpunkt, der genau diesen Zustand in der Leitwarte sichtbar macht und einen wirkungslosen Schaltbefehl erklärt (siehe @sec:datenpunkte). Und die Freischaltung gehört als Voraussetzung in die Unterlage nach @sec:modelldoku, da eine Integrationsvorlage, die sie verschweigt, beim Errichter denselben Weg noch einmal erzwingt.


==== Eigenschaften der Geräte und der Plattform

Ein Teil der Alarme ist ab Werk abgeschaltet und liefert dauerhaft den Wert null, ohne dass dies von einem nicht anstehenden Alarm zu unterscheiden wäre. T-14 bestätigt dies, soweit es sich am Aufbau zeigen ließ. Der Befund trägt NFA-06 und ist der Grund, weshalb die Lösung nicht aus der Typbeschreibung allein besteht.

Dem #acro("ECPD") fehlt eine Zählfunktion für die elektrische Arbeit. Abgebildet ist die momentane Wirkleistung, sodass eine Verbrauchsauswertung entweder eine Integration über die Zeit in Desigo CC oder ein zusätzliches Messgerät voraussetzt. Für die Anbindung eines Endstromkreises an ein Energiemanagement ist das die spürbarste Lücke des Geräts und in @sec:weiterentwicklung aufgegriffen.

Das Abfrageintervall lässt sich allein am Modbus-Treiber und dort für sämtliche angebundenen Geräte einstellen, was T-03 bestätigt. Die Plattform selbst kennt nach @tab:modbustreiber durchaus benannte Abfragegruppen mit eigenem Intervall, doch werden diese einem einzelnen lesenden Datenpunkt über den tabellarischen Geräteimport zugewiesen und nicht über die Typbeschreibung. Eine nach Verwendungszweck abgestufte Abfrage ist über die Integrationsvorlage damit nicht einrichtbar, obwohl die Auswahl der Datenpunkte sie vorbereitet. Der schnellste benötigte Wert bestimmt den Takt aller übrigen, weshalb die in @sec:datenpunkte begründete Reduktion des Umfangs vor allem der Abfragelast dient und weniger der Übersicht.

/* Claude: Abschnitt aus den drei Notizen ausformuliert und bewusst knapp
   gehalten. Alle vier genannten Befunde sind aufgenommen, der Schaltbefehl als
   eigener Abschnitt, die uebrigen drei knapp, da sie in @sec:registerraum
   bereits beschrieben sind und hier nur bestaetigt werden.

   Die drei Faeden der dritten Notiz sind geschlossen, also Vorbehalt zu FA-06,
   Vorbemerkung zu T-08 und der Absatz in @sec:geraetekonfiguration. Ergaenzt
   ist der Bogen zum Freigabestatus in Register 5425, da @sec:datenpunkte dort
   ausdruecklich auf diesen Abschnitt verweist.

   @src:siemenssupport2026 ist jetzt erstmals zitiert. Der Eintrag in
   quellen.bib ist seit dem 09.09.2026 vollstaendig: Auskunft per E-Mail vom
   18.08.2026 auf direkte Anfrage beim Produktsupport. Eine Vorgangsnummer gibt
   es nicht, da die Anfrage nicht ueber das Ticketsystem lief.

   Nicht aufgenommen ist der Anstieg der Dateigroesse im PDE. Er steht in
   @sec:umsetzung und ist in @sec:testdurchfuehrung bei T-12 aufgegriffen, weil
   er die Werkzeugkette betrifft und keine Eigenschaft der Geraete ist. */
