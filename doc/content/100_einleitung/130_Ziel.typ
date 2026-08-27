#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Zielsetzung und Abgrenzung<sec:ziel>

/* Anmerkung des Autors, erledigt: "Ziel aus der Anmeldung uebernehmen. Danach
   die Abgrenzungen buendeln, die bisher verstreut in Kapitel 3 stehen:
   Informationssicherheit nicht im Scope (siehe @sec:stakeholder), SENTRON
   Powerconfig wird nicht abgeloest (siehe @sec:konzept), Schutzfunktion der
   Geraete nicht Gegenstand (siehe @sec:systemanalyse), eigenes Objektmodell
   fuer das Powercenter nicht gefordert." */

Ziel der Arbeit ist es, die Daten des SENTRON Powercenters und der mit ihm verbundenen SENTRON #acro("ECPD") über ein im Rahmen der Arbeit entwickeltes Datenmodell in Desigo CC verfügbar zu machen. Das Datenmodell wird an einem Hardwareaufbau erprobt und validiert. Es soll nicht eine einzelne Anlage anbinden, sondern als Vorlage für alle Geräte desselben Typs dienen, sodass die Zuordnung zwischen Registern und benannten Datenpunkten einmalig geleistet ist und in Folgeprojekten nicht erneut zu erbringen bleibt.

Gegenstand ist allein die Abbildung zwischen dem Modbus-Registerraum des Powercenters und dem Objektmodell in Desigo CC. Die Schutzfunktion der Geräte, die Funkstrecke zum Powercenter, die elektrotechnische Installation und die Architektur von Desigo CC bleiben außerhalb der Betrachtung (siehe @sec:systemanalyse), ebenso die Gestaltung von Dashboards und Archivgruppen, die einer konkreten Anlage vorbehalten bleibt (siehe @sec:anforderungsvorbehalte). Auch die Ausgestaltung der Netzsicherheit ist nicht Gegenstand der Arbeit, da sie kundeneigenen Vorgaben folgt. RB-05 bis RB-07 benennen dafür lediglich einen Mindeststandard (siehe @sec:stakeholder).

Hinzu kommen zwei Festlegungen zum Umfang der Lösung. SENTRON Powerconfig wird nicht abgelöst, da die Parametrierung der Geräte dort und damit bei der Elektrofachkraft verbleibt, während der Schwerpunkt der Umsetzung auf dem Objektmodell des #acro("ECPD") liegt und die Typbeschreibung des Powercenters schmal gehalten und allein auf Import und Instanzbildung geprüft ist (siehe @sec:konzept). Der Nachweis erfolgt nach RB-04 an einem Powercenter 1100 mit einem #acro("ECPD"), weshalb sich über das Verhalten eines voll bestückten Strangs unter Betriebsbedingungen keine Aussage belegen lässt (siehe @sec:anforderungsabgleich).

/* Claude: Zielabsatz aus der Anmeldung der Arbeit uebernommen und um den
   Vorlagencharakter ergaenzt, der im Titel steht, in der Anmeldung aber nicht
   ausdruecklich formuliert ist. Der Wortlaut ist gegen
   TES23_Schroeter_Malte_AnmeldungBachelorarbeit_2026-1.pdf zu pruefen, falls
   eine woertliche Uebernahme gewuenscht ist.

   Die Abgrenzung ist auf zwei Absaetze gekuerzt und nennt die Ausschluesse nur
   noch mit dem Verweis auf die Stelle, an der sie begruendet sind
   (@sec:systemanalyse, @sec:stakeholder, @sec:konzept,
   @sec:anforderungsvorbehalte, @sec:anforderungsabgleich). Entfallen sind dabei
   die Begruendungen, die dort ohnehin stehen, darunter die Zustaendigkeitsfrage
   bei der Arbeitsteilung mit SENTRON Powerconfig und der Hinweis, dass die
   Datenpunkte des Powercenters trotz fehlenden Objektmodells ausgewaehlt und
   dokumentiert sind. Letzteres steht in @sec:datenpunkte. */
