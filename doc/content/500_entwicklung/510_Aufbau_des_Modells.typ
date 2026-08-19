#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Aufbau des Datenmodells<sec:modellaufbau>

#kommentar[Eingang ist das erste Loesungskonzept aus @sec:konzept, Ausgang die Festlegung, woraus das Modell besteht, bevor ueber einzelne Datenpunkte entschieden wird. Hierher gehoeren die Trennung von Gerätetyp und Instanz, die zwei getrennten Objekttypen fuer #acro("ECPD") und Powercenter, die Gruppenstruktur des #acro("PDE") sowie die Namenskonvention der Eigenschaften. Zu klaeren ist dabei, ob beide Objekttypen einen gemeinsamen Namensraum teilen und deshalb ein Praefix brauchen.]

#kommentar[Zu pruefen, ob eine Abbildung den Ablauf des Entwicklungsteils traegt, also den Weg von der Registerkarte ueber Kriterien und Auswahl zur Typbeschreibung und zurueck aus der Pruefung. @img:konzept zeigt die Werkzeugkette, nicht den Arbeitsablauf, und wuerde dadurch nicht doppelt belegt.]

#kommentar[Die Struktur des Modells laesst sich am Stand der Technik aufhaengen statt sie zu setzen. Ein Datenpunkt ist erst dann verwertbar, wenn Groesse, Einheit, Zustandsraum und Geraetezugehoerigkeit feststehen @src:balaji2018 (siehe @sec:standdertechnik). Genau diese vier Angaben muessen die Eigenschaften der Typbeschreibung tragen.]

#kommentar[Zweiter Beleg an dieser Stelle, sofern das Argument der Wiederverwendbarkeit hier und nicht erst in @sec:auswahlkriterien gefuehrt wird: Eine einmal geleistete Zuordnung gilt fuer alle Geraete desselben Typs und faellt in Folgeprojekten nicht erneut an, waehrend sie nach dem Stand der Technik sonst je Anlage von Hand zu erbringen ist @src:wang2018.]
