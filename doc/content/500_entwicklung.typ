#import "../config/acronyms.typ": *
#import "../config/functions.typ" : *

= Entwicklung des Datenmodells

Das erste Lösungskonzept in @sec:konzept legt das Gerüst der Lösung fest. Eine einzige Typbeschreibung bildet alle Geräte desselben Typs ab und wird über den Unit Identifier je physischem Gerät instanziiert, Powercenter und #acro("ECPD") erhalten getrennte Objekttypen, und die Parametrierung der Geräte verbleibt bei SENTRON Powerconfig. Womit dieses Gerüst gefüllt wird, bleibt darin offen. Die Analyse des Registerraums in @sec:registerraum weist rund 3.900 Einträge je voll bestücktem Strang aus, von denen nur ein Teil in das Modell gehört. Welcher Teil dies ist, aus welchem Grund und in welcher Form er in der Typbeschreibung erscheint, ist Gegenstand dieses Kapitels.

@sec:auswahlkriterien benennt die Kriterien der Auswahl und führt sie auf die Anwendungsfälle und die Eigenschaften des Registerraums zurück, bevor sie angewandt werden. @sec:datenpunkte wendet sie auf beide Gerätetypen an und stellt die getroffene Auswahl der vollständigen Abbildung gegenüber. Aus dem Ergebnis entstehen in @sec:umsetzung die Typbeschreibungen im #acro("PDE") mit der Zuordnung zu Datentypen, Transformationen und Registeradressen. @sec:uebernahme beschreibt den Import in Desigo CC und das Anlegen der Geräteinstanzen, @sec:modelldoku die begleitende Dokumentation, ohne die das Entwicklungsergebnis nach NFA-01 und NFA-02 unvollständig bliebe. Der Schwerpunkt liegt durchgehend auf dem Objektmodell des #acro("ECPD"). Für das Powercenter entsteht eine eigene Typbeschreibung geringeren Umfangs, deren Prüfung sich auf Import und Instanzbildung beschränkt.

// #kommentar[Zu prüfen, ob eine Abbildung den Ablauf des Entwicklungsteils trägt, also den Weg von der Registerkarte über Kriterien und Auswahl zur Typbeschreibung und zurück aus der Prüfung. @img:konzept zeigt die Werkzeugkette, nicht den Arbeitsablauf, und wäre dadurch nicht doppelt belegt. Diese Abbildung gehörte an diese Stelle.]

#include "../content/500_entwicklung/520_Auswahlkriterien.typ"
#include "../content/500_entwicklung/530_Auswahl_Datenpunkte.typ"
#include "../content/500_entwicklung/540_Umsetzung_PDE.typ"
#include "../content/500_entwicklung/550_Übernahme_DesigoCC.typ"
#include "../content/500_entwicklung/560_Dokumentation.typ"

/* Claude: Der Abschnitt "Aufbau des Datenmodells" (510_Aufbau_des_Modells.typ,
   Label sec:modellaufbau) ist nach dem Hinweis des Autors aufgeloest worden.
   Grund: Seine drei tragenden Punkte, also die Trennung von Gerätetyp und
   Instanz, die zwei getrennten Objekttypen und die Arbeitsteilung, stehen
   bereits ausformuliert in @sec:konzept, sodass ein eigener Abschnitt sie nur
   wiederholt haette. Verbleib der Notizen:
   - Die Rahmung des Kapitels ist zum Vorspann oben ausformuliert, ohne eigene
     Überschrift. Die Frage nach einer Ablaufabbildung steht als Kommentar dort.
   - Gruppenstruktur des PDE, Namenskonvention der Eigenschaften und die
     Praefixfrage sind nach @sec:umsetzung gewandert, da es Festlegungen am
     Werkzeug sind und dort Datentyp, Transformationstyp und Byte-Reihenfolge
     ohnehin behandelt werden. Ebenso der Beleg @src:balaji2018, der eine
     Anforderung an die Eigenschaften der Typbeschreibung formuliert.
   - Der Beleg @src:wang2018 zur Wiederverwendbarkeit steht jetzt in
     @sec:auswahlkriterien; die Notiz hatte diese Alternative selbst genannt.
   Das Label sec:modellaufbau war an keiner anderen Stelle referenziert.

   Der Import von acronyms.typ ist ergaenzt, weil der Vorspann #acro verwendet.
   Die uebrigen Kapitel-Integrationsdateien kommen ohne diesen Import aus, da sie
   nur #include-Zeilen enthalten. */
