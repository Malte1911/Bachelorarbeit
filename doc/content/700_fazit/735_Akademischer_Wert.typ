#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"


Der Beitrag dieser Arbeit liegt weniger in der einzelnen Integrationslösung als in dem Weg, der zu ihr geführt hat. Aus der System- und Stakeholderanalyse gehen die Anwendungsfälle hervor, aus diesen die Anforderungen und die Testfälle, und aus sieben begründeten Kriterien die Auswahl der Datenpunkte. Jede Festlegung des Modells bleibt damit bis zu einer Tätigkeit einer benannten Nutzergruppe zurückführbar, und der Entscheidungsweg von der Anforderung bis zur Abbildung im Objektmodell ist für Dritte nachvollziehbar.

Methodisch verbindet die Arbeit eine anforderungsgetriebene Entwicklung mit der Prüfung an einem Hardwareaufbau, sodass sich die getroffenen Annahmen an Beobachtungen messen lassen. Dieses Vorgehen ist auf die Anbindung weiterer Gerätefamilien über Modbus oder vergleichbare Protokolle übertragbar. Die Übertragbarkeit selbst ist lediglich argumentativ begründet und an einem zweiten Fall bislang unerprobt aufgrund des Fehlens eines zweiten Aufbaus.

Gegenüber dem Stand der Technik ist der Beitrag dieser Arbeit eng begrenzt und beansprucht keine Allgemeingültigkeit. Mit Brick liegt ein herstellerneutrales Schema vor, das Anlagenteile, Messpunkte und deren Beziehungen allgemein beschreibt @src:balaji2018, während diese Arbeit eine Typbeschreibung für eine Gerätefamilie in den Ausdrucksmitteln einer einzelnen Plattform liefert. Ein allgemeines Schema war zu keinem Zeitpunkt das Ziel. Was die Arbeit beisteuert, ist die geschlossene Darstellung einer Strecke aus Gerät, Protokoll und Managementplattform, die sich in der zugänglichen Literatur in dieser Form bislang nicht findet (siehe @sec:standdertechnik).

Die Reichweite dieser Aussagen hängt an der Quellenlage. Die technischen Feststellungen stützen sich auf die Dokumentation der Hersteller und auf eigene Beobachtungen am Testaufbau, während begutachtete Literatur allein die Einordnung des Problems stützt (siehe @sec:quellenlage). Hinzu kommt, dass die Prüfung an einem einzelnen #acro("ECPD") unter kontrollierten Bedingungen erfolgte, weshalb Aussagen zum Verhalten unter Betriebslast offenbleiben. Diese Grenze abzustecken gehört zum Ergebnis, da sie zugleich die Anknüpfungspunkte einer Fortführung benennt (siehe @sec:weiterentwicklung).


/* Claude: Abschnitt auf vier Absaetze gekuerzt, gegenueber der vorherigen
   Fassung rund die Haelfte des Umfangs bei zwei zusaetzlichen Themen. Die
   beiden offenen Anmerkungen sind eingearbeitet, die Abgrenzung gegen Brick in
   den dritten Absatz und die Quellenlage in den vierten, wo sie mit der schon
   vorhandenen Aussage zu den Grenzen des Testaufbaus zusammenfaellt.

   Entfallen sind die Einleitungswendungen der alten Fassung sowie die
   Wiederholung der Herleitung, die in @sec:zusammenfassung bereits steht. Der
   Hinweis auf die Reproduzierbarkeit fuer Dritte ist im ersten Absatz erhalten.
   Zahlen sind nur dort genannt, wo sie eine Aussage tragen. */

/* Claude: Am 07.09.2026 ist der Einstieg des dritten Absatzes umformuliert. Die
   Wendung "ist der Beitrag eng zu fassen" sagte nicht, wer den Beitrag eng
   fasst und woran er gemessen wird; der Satz benennt jetzt beides. */
