#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Aufbau des Datenmodells<sec:modellaufbau>

#kommentar[Eingang ist das erste Loesungskonzept aus @sec:konzept, Ausgang die Festlegung, woraus das Modell besteht, bevor ueber einzelne Datenpunkte entschieden wird. Hierher gehoeren die Trennung von Gerätetyp und Instanz, die zwei getrennten Objekttypen fuer #acro("ECPD") und Powercenter, die Gruppenstruktur des #acro("PDE") sowie die Namenskonvention der Eigenschaften. Zu klaeren ist dabei, ob beide Objekttypen einen gemeinsamen Namensraum teilen und deshalb ein Praefix brauchen.]

#kommentar[Zu pruefen, ob eine Abbildung den Ablauf des Entwicklungsteils traegt, also den Weg von der Registerkarte ueber Kriterien und Auswahl zur Typbeschreibung und zurueck aus der Pruefung. @img:konzept zeigt die Werkzeugkette, nicht den Arbeitsablauf, und wuerde dadurch nicht doppelt belegt.]
