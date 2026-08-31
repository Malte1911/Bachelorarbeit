#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Kritische Würdigung<sec:wuerdigung>

/* Anmerkung des Autors, erledigt: "Die folgenden Punkte sind in @sec:befunde
   erstmals zu belegen und hier nur noch zu gewichten, damit der Leser sie nicht
   erst im Fazit zum ersten Mal erfaehrt." */

Die Arbeit ist an ihrem eigenen Anspruch zu messen, eine Vorlage zu liefern, mit der sich die Gerätereihe ohne erneute Grundlagenarbeit an Desigo CC anbinden lässt. Der folgende Abschnitt benennt die Grenzen dieses Ergebnisses.

Drei Grenzen wiegen schwer, und sie teilen eine Eigenschaft. Keine von ihnen liegt in der Auswahl der Datenpunkte oder in ihrer Abbildung, also in dem Teil, den diese Arbeit gestaltet hat. Sie liegen an den beiden Enden der Strecke, am Gerät und an der Zielplattform. Für denjenigen, der die Vorlage einsetzt, ändert diese Zuordnung nichts, denn er erhält das Ergebnis und nicht dessen Begründung.

/* Anmerkung des Autors, erledigt: "das passt inhaltlich nicht ganz, ich bin mir
   nicht sicher ob die Argumentation so passt oder nicht. Der Schluss ist ja
   eigentlich, dass die Alarme gar nicht übersetzt werden können, weil eine
   Maskierung eben nicht funktioniert." */

Am schwersten wiegt, dass die Alarme nicht als einzelne Meldungen in der Leitwarte ankommen. Die Übertragung leistet das Modell, denn das Sammelregister erreicht Desigo CC vollständig und ist über @tab:apx_ecpd_alarme bitweise zu deuten. Nicht zu leisten ist seine Zerlegung in einzeln auswertbare Zustände. Beide dafür vorgesehenen Wege des #acro("PDE") scheitern nach @sec:umsetzung an der Übernahme, und der Ausweg über die Alarmbedingungen von Desigo CC trägt ebenso wenig, weil ohne die Maskierung eines einzelnen Bits jede Bedingung den Inhalt des gesamten Registers prüft und die Meldung gerade dann ausbleibt, wenn mehrere Zustände zugleich anstehen. Die Lücke ist damit nicht durch zusätzlichen Aufwand je Anlage zu schließen, denn auch die Projektierung kann die Zerlegung nicht nachholen. Ob ihre Ursache am Gerät oder an der Bruchstelle zwischen den beiden Werkzeugen liegt, ist nach @sec:umsetzung offen und für das Ergebnis ohne Belang. Das trifft die Vorlage an ihrem Zweck, denn eine wiederverwendbare Beschreibung, die den aufwendigsten Teil der Einrichtung weder mitbringt noch nachholen lässt, bleibt hinter ihrer Aufgabe zurück.

Die zweite Grenze betrifft das Abfrageintervall, das nach @sec:befunde geräteübergreifend gilt. Die Auswahl unterscheidet die Datenpunkte nach der erforderlichen Aktualität, das Modell kann diese Unterscheidung jedoch nicht ausdrücken, weshalb FA-02 teilweise erfüllt bleibt. Spürbar wird die Grenze erst mit der Größe der Anlage, da der am schnellsten benötigte Wert die Last aller übrigen bestimmt.

Die dritte Grenze ist streng genommen keine der Arbeit. Dem #acro("ECPD") fehlt eine Zählfunktion für die elektrische Arbeit, weshalb sie auch in Desigo CC fehlt, denn ein Datenmodell kann nur abbilden, was das Gerät führt. Die Feststellung gehört gleichwohl hierher. Ein Schutzgerät, das Strom, Spannung und Wirkleistung je Abgang misst, weckt die Erwartung einer Verbrauchsauswertung, und an dieser Erwartung wird die Anbindung gemessen und nicht an der Frage, welche Komponente die Lücke zu verantworten hat. Adressat dieser Feststellung ist die Produktentwicklung.

Daneben stehen zwei kleinere Einschränkungen, die in der Anwendung dennoch auffallen. Zeichenketten sind nicht beschreibbar, weshalb Anlagenkennzeichen und Einbauort in der Leitwarte sichtbar, aber nur über SENTRON Powerconfig zu ändern sind, was UC-09 begrenzt. Und die beiden schaltenden Kommandos sind als schreibende Werte ausgeführt, da eine Schaltfläche den anstehenden Zustand nicht anzeigt und nur in eine Richtung wirkt (siehe @sec:uebernahme). Beides ist hinnehmbar, gehört aber in die Unterlage und sollte nicht erst im Betrieb auffallen.

Eine letzte Einschränkung betrifft nicht die Lösung, sondern den Maßstab, an dem sie gemessen wird. Der Anforderungskatalog deckt die Anwendungsfälle nicht lückenlos ab, wie @tab:apx_rueckverfolgung ausweist. Die Zähler und Wartungsdaten sowie die Stammdaten des #acro("ECPD") sind über UC-07 und UC-09 begründet und in der Auswahl enthalten, doch keine Anforderung verlangt sie, da FA-03 nach @sec:fa bewusst auf die Messwerte begrenzt ist. Die Auswahl folgt an dieser Stelle unmittelbar den Anwendungsfällen und geht damit über den Katalog hinaus. Für das Ergebnis bleibt das folgenlos, denn T-05 erstreckt sich auf jeden abgebildeten Datenpunkt und nicht allein auf die Messwerte. Eine Fortschreibung des Katalogs hätte die beiden Anwendungsfälle gleichwohl mit eigenen Anforderungen zu unterlegen, statt FA-03 nachträglich zu erweitern, denn dessen Begrenzung auf die Messwerte trägt die in @sec:registerraum begründete Reduktion des Registerraums.

In der Summe trägt das Modell dort, wo es Daten bereitstellt, und es endet dort, wo aus diesen Daten eine Handlung werden soll.

/* Claude: Abschnitt aus den drei Stichpunkten des Autors ausformuliert. Die
   Befunde selbst sind nicht wiederholt, sondern nur gewichtet und jeweils auf
   @sec:befunde zurueckgefuehrt, wie es die Anmerkung des Autors verlangt.

   Ergaenzt sind zwei kleinere Einschraenkungen aus @sec:umsetzung und
   @sec:uebernahme, die nicht in den Stichpunkten standen, dem Anwender aber
   begegnen. Falls sie hier zu weit fuehren, ist der vorletzte Absatz
   ersatzlos zu streichen.

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
