#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Kritische Würdigung<sec:wuerdigung>


Zielsetzung der Arbeit war es, eine Vorlage zu liefern, mit der sich die Gerätereihe ohne erneute Grundlagenarbeit an Desigo CC anbinden lässt. Der folgende Abschnitt misst das Ergebnis an dieser Zielsetzung und benennt seine Grenzen.

Die Ergebnisse wurden durch drei zentrale Faktoren beeinflusst: erstens die fehlende Zerlegung des Alarmsammelregisters in einzelne Meldungen, zweitens das geräteübergreifend geltende Abfrageintervall und drittens die fehlende Zählfunktion für die elektrische Arbeit. Keiner dieser Faktoren lag im Ermessen des Verfassers. Alle drei liegen an den beiden Enden der Übertragungsstrecke, am Gerät und an der Zielplattform, und nicht in der Auswahl der Datenpunkte oder in ihrer Abbildung, in dem Teil, den diese Arbeit gestaltet hat. Sie begrenzten die Ergebnisse und den Gestaltungsspielraum der Arbeit gleichwohl in nicht unerheblichem Maße. Für denjenigen, der die Vorlage einsetzt, ändert diese Zuordnung nichts, denn er erhält das Ergebnis und nicht dessen Begründung.


=== Zerlegung der Alarme

Am schwersten wiegt, dass die Alarme nicht als einzelne Meldungen in der Leitwarte ankommen. Die Übertragung leistet das Modell, denn das Sammelregister erreicht Desigo CC vollständig und ist über @tab:apx_ecpd_alarme bitweise zu deuten. Nicht zu leisten ist seine Zerlegung in einzeln auswertbare Zustände. Beide dafür vorgesehenen Wege des #acro("PDE") scheitern nach der Umsetzung im Power Device Engineer (@sec:umsetzung) an der Übernahme, und der Ausweg über die Alarmbedingungen von Desigo CC führt ebenso wenig zum Ziel, weil ohne die Maskierung eines einzelnen Bits jede Bedingung den Inhalt des gesamten Registers prüft und die Meldung gerade dann ausbleibt, wenn mehrere Zustände zugleich anstehen. Die Lücke ist damit nicht durch zusätzlichen Aufwand je Anlage zu schließen, denn auch die Projektierung kann die Zerlegung nicht nachholen. Ob ihre Ursache am Gerät oder an der Bruchstelle zwischen den beiden Werkzeugen liegt, ist offen und für das Ergebnis ohne Belang. Die Vorlage erfüllt in diesem Punkt folglich nicht ihren Zweck, denn der aufwendigste Teil der Einrichtung fehlt und lässt sich auch nachträglich nicht ergänzen.

=== Abfrageintervall

Der zweite Faktor betrifft das Abfrageintervall, das nach den Befunden außerhalb des Datenmodells (@sec:befunde) geräteübergreifend gilt. Die Auswahl unterscheidet die Datenpunkte nach der erforderlichen Aktualität, das Modell kann diese Unterscheidung jedoch nicht ausdrücken. FA-02 bleibt davon unberührt, da die Anforderung allein das am Modbus-Treiber einstellbare Intervall verlangt und dieses nach dem Anforderungsabgleich (@sec:anforderungsabgleich) erfüllt ist. Die abgestufte Abfrage ist eine Eigenschaft der Plattform und in @sec:weiterentwicklung als Ansatzpunkt aufgenommen. Spürbar wird die Grenze erst mit der Größe der Anlage, da der am schnellsten benötigte Wert die Last aller übrigen bestimmt.

=== Fehlende Zählfunktion für die elektrische Arbeit

Der dritte Faktor ist keine Grenze, die unmittelbar die Arbeit und ihre Ergebnisse betrifft. Dem #acro("ECPD") fehlt eine Zählfunktion für die elektrische Arbeit, weshalb sie auch in Desigo CC fehlt, denn ein Datenmodell kann nur abbilden, was das Gerät führt. Die Feststellung gehört gleichwohl hierher. Ein Schutzgerät, das Strom, Spannung und Wirkleistung je Abgang misst, weckt die Erwartung einer Verbrauchsauswertung, und an dieser Erwartung wird die Anbindung gemessen und nicht an der Frage, welche Komponente die Lücke zu verantworten hat. Adressat dieser Feststellung ist die Produktentwicklung.

=== Sonstige Einschränkungen

Daneben stehen zwei kleinere Einschränkungen, die in der Anwendung dennoch auffallen. Zeichenketten sind nicht beschreibbar, weshalb Anlagenkennzeichen und Einbauort in der Leitwarte sichtbar, aber nur über SENTRON Powerconfig zu ändern sind, was UC-09 begrenzt. Und die beiden schaltenden Kommandos sind als schreibende Werte ausgeführt, da eine Schaltfläche den anstehenden Zustand nicht anzeigt und nur in eine Richtung wirkt (siehe Übernahme in Desigo CC, @sec:uebernahme). Beides ist hinnehmbar, gehört aber in die Unterlage und sollte nicht erst im Betrieb auffallen.

Eine letzte Einschränkung betrifft nicht die Lösung selbst, sondern den Anforderungskatalog, an dem sie gemessen wird. Die Rückverfolgung in @tab:apx_rueckverfolgung zeigt, dass zwei Anwendungsfälle ohne eigene Anforderung geblieben sind: UC-07 mit den Zähler- und Wartungsdaten und UC-09 mit den Stammdaten des #acro("ECPD"). Beide sind in der Auswahl der Datenpunkte enthalten, weil sie sich unmittelbar aus den Anwendungsfällen ergeben. Verlangt hat sie dagegen keine Anforderung, da FA-03 nach @sec:fa bewusst auf die Messwerte begrenzt ist. Die Auswahl geht an dieser Stelle über den Katalog hinaus. Für das Ergebnis bleibt das folgenlos, denn T-05 erstreckt sich auf jeden abgebildeten Datenpunkt und nicht allein auf die Messwerte. Eine Fortschreibung des Katalogs sollte die beiden Anwendungsfälle dennoch mit eigenen Anforderungen unterlegen. FA-03 nachträglich zu erweitern wäre dagegen der falsche Weg, denn dessen Begrenzung auf die Messwerte stützt die in @sec:registerraum begründete Reduktion des Registerraums.

=== Gesamtbewertung

Das vom Verfasser der Arbeit entwickelte Modell ist tragfähig. Es liefert brauchbare Ergebnisse bei der Datenbereitstellung. Es endet jedoch, bedingt durch die aufgezeigten Grenzen, an der Stelle, wo aus dem analysierten Datenmaterial konkrete Handlungsanweisungen generiert werden sollen. Der Grund dafür liegt in der fehlenden Zerlegung der Alarme: Eine Handlungsanweisung setzt voraus, dass ein einzelner Zustand benannt und einer Ursache zugeordnet werden kann. Das Modell übergibt den Alarmzustand jedoch nur als ungeteiltes Sammelregister, sodass die Leitwarte zwar erkennt, dass etwas ansteht, nicht aber, was ansteht. Ohne diese Unterscheidung lässt sich keine Regel hinterlegen, die von einem bestimmten Zustand auf eine bestimmte Maßnahme schließt, sodass die Bewertung des Alarms beim Betriebspersonal verbleibt.

/* Claude: Abschnitt aus den drei Stichpunkten des Autors ausformuliert. Die
   Befunde selbst sind nicht wiederholt, sondern nur gewichtet und jeweils auf
   @sec:befunde zurueckgefuehrt, wie es die Anmerkung des Autors verlangt.

   Ergaenzt sind zwei kleinere Einschraenkungen aus @sec:umsetzung und
   @sec:uebernahme, die nicht in den Stichpunkten standen, dem Anwender aber
   begegnen. Falls sie hier zu weit fuehren, ist der erste Absatz unter
   "Sonstige Einschraenkungen" ersatzlos zu streichen.

   Die Bewertung des fehlenden Zaehlers ist sachlich gefuehrt und nicht als
   Abwertung des Produkts. Der Adressat ist ausdruecklich die
   Produktentwicklung, womit die Aussage in @sec:weiterentwicklung anschliesst. */

/* Claude: Am 31.08.2026 ergaenzt ist der Absatz zur Deckungsluecke zwischen
   Anwendungsfaellen und Anforderungskatalog. Er ist beim Aufstellen der
   Rueckverfolgungsmatrix @tab:apx_rueckverfolgung aufgefallen: UC-07 und UC-09
   sind in der Auswahl der Datenpunkte getragen, im Katalog aber nur ueber
   FA-03 und damit nur fuer die Messwerte. Bewusst nicht geaendert ist FA-03
   selbst, da eine Erweiterung nach der Validierung den Katalog an das Ergebnis
   anpassen hiesse und die Begrenzung auf die Messwerte in @sec:fa die
   Reduktion des Registerraums traegt. */

/* Claude: Der Alarmabsatz ist am 31.08.2026 nach dem Hinweis des Autors im
   Gesamtkontext geprueft und richtiggestellt. Die vorherige Fassung nannte die
   fehlende Alarmierung eine "von Hand zu leistende Projektierung je Anlage" und
   damit eine Frage des Aufwands. Das widerspricht @sec:umsetzung: Dort scheitern
   beide Zerlegungswege des PDE an der Uebernahme, und der Ausweg ueber die
   Alarmbedingungen von Desigo CC ist mangels Maskierung eines einzelnen Bits
   ausdruecklich als untauglich verworfen, weil die Meldung beim gleichzeitigen
   Anstehen mehrerer Zustaende ausbleibt. Der Absatz sagt jetzt, dass die Luecke
   auch durch Projektierung nicht zu schliessen ist.

   Die Zuschreibung der Ursache bleibt offen gefuehrt, wie es @sec:umsetzung
   und der dortige #kommentar vorgeben. Sobald geklaert ist, ob der Vorgang beim
   Import oder erst am Modbus-Verkehr abbricht, ist der Satz dazu hier
   nachzuziehen.

   Dieselbe Formulierung stand in @sec:praxistauglichkeit, in der Kurzfassung
   und im Abstract und ist dort gleichlautend korrigiert. @sec:anforderungsabgleich
   war bereits richtig gefasst. */

/* Claude: Am 07.09.2026 nach dem Feedback des Betreuers ueberarbeitet.
   Einleitung als Zielsetzung formuliert; die drei Grenzen als "drei zentrale
   Faktoren" eingefuehrt, mit der ausdruecklichen Feststellung, dass keiner von
   ihnen im Ermessen des Verfassers lag; Gliederung in Zwischenueberschriften;
   Querverweise zusaetzlich mit dem Kapitel- bzw. Vorgangsnamen statt nur mit
   der Nummer; der Schlusssatz des Alarmabsatzes vereinfacht ("Die Vorlage
   erfuellt in diesem Punkt folglich nicht ihren Zweck"); der Absatz zur
   Deckungsluecke im Anforderungskatalog neu ausformuliert; die Gesamtbewertung
   um die Begruendung ergaenzt, warum das Modell keine Handlungsanweisungen
   erzeugen kann. */
