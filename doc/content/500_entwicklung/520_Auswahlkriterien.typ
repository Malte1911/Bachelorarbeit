#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Kriterien der Datenauswahl<sec:auswahlkriterien>

#kommentar[Die Kriterien werden hier benannt und begruendet, bevor sie im folgenden Abschnitt angewandt werden. Nur so ist die Auswahl nachvollziehbar und nicht Geschmackssache. Jedes Kriterium bekommt eine Kennung und wird auf die Anwendungsfaelle aus @tab:usecases sowie auf die Eigenschaften des Registerraums aus @sec:registerraum zurueckgefuehrt.]

#kommentar[Tragende Kriterien aus der bisherigen Arbeit: Istwerte statt Schwellwerte, da Grenzwerte nach FA-09 bei SENTRON Powerconfig verbleiben. Redundanzen zwischen den Feldern am Powercenter und den Registern am Endgeraet werden zugunsten des Endgeraets aufgeloest. Maximalwerte statt Mittelwerte, da Desigo CC im Archiv mitteln, eine nie abgetastete Spitze aber nicht rekonstruieren kann. Schutzparameter bleiben ausserhalb des Modells und werden nur ueber den Zaehler der Parameteraenderungen ueberwacht. Die Abfragelast begrenzt die Zahl der Datenpunkte, da sich das Intervall nach @tab:modbustreiber nur je Geraet einstellen laesst.]

#kommentar[Optionaler Beleg dafuer, warum die Kriterien ausdruecklich benannt und von Hand angewandt werden. Verfahren, die eine solche Zuordnung selbsttaetig herleiten, erreichen keine Guete, die eine Pruefung durch den Menschen entbehrlich machte @src:zhan2020.]
