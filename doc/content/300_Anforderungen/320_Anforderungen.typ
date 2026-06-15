#import "../../config/acronyms.typ": *
#include "../../config/config.typ"


= Ableitung von Anforderungen an den DVPC <anforderungen>

Die folgenden Anforderungen werden aus der Analyse des Vorjahres-#acro("DVPC") sowie aus den allgemeinen Entwicklungszielen des Teams abgeleitet. Ein übergeordnetes Ziel, das alle Anforderungsbereiche durchzieht, ist die Gewichtsoptimierung. Jede Komponente sowie das Gesamtsystem sind auf minimales Gewicht auszulegen, da jegliche Masse am Fahrzeug das #acro("CoG") beeinflusst und sich damit unmittelbar auf das fahrdynamische Verhalten auswirkt. Die Gewichtsminimierung stellt somit den zentralen Aspekt der gesamten Entwicklung dar.

== Mechanische Anforderungen

Der #acro("DVPC") muss als kompaktes und mechanisch stabiles System ausgeführt werden, das den im Renneinsatz auftretenden Vibrationen und Erschütterungen dauerhaft standhält. Das System ist für eine einjährige Verwendung ausgelegt und darf durch bestimmungsgemäßen Gebrauch nicht beschädigt werden.

Da das Fahrzeug im Außeneinsatz Witterungsbedingungen ausgesetzt ist, muss das System gegen Spritzwasser und direkten Regenfall geschützt sein. Eine vollständige Wasserdichtigkeit gemäß einer spezifischen Schutzklasse ist nicht erforderlich; eine ausreichende Schutzwirkung, die den Betrieb unter typischen Rennbedingungen sicherstellt, ist jedoch einzuhalten. Dieser Schutz vor Witterungsbedingungen ist nur vonnöten, sollte durch die Positionierung des Systems nicht bereits andere Komponenten (zum Beispiel das Chassis) die witterungsfestigkeit sichergestellt sein. 

Die Positionierung des #acro("DVPC") am Fahrzeug soll einen möglichst geringen Einfluss auf das #acro("CoG") des Fahrzeugs haben. Da ein niedriges #acro("CoG") generell mit verbesserter fahrdynamischer Performance korreliert, ist eine möglichst niedrige Einbaulage zu bevorzugen @CoGRobertKaufhold. Die Montagemethodik muss den schnellen Ein- und Ausbau des Systems ermöglichen, ohne dass dafür weitere Fahrzeugkomponenten demontiert oder verändert werden müssen.

== Thermische Anforderungen

Die Kühlung des #acro("DVPC") und der im Casing integrierten Peripheriekomponenten ist so auszulegen, dass keine Komponente im bestimmungsgemäßen Betrieb in ihrer Leistungsfähigkeit eingeschränkt wird. Insbesondere muss die Recheneinheit in der Lage sein, die gesamte Driverless-Software über die vollständige Dauer eines Trackdrives ohne thermisch bedingtes Leistungsdrosseln auszuführen. Ein sogenanntes Thermal Throttling, also eine automatische Reduzierung der Rechenleistung infolge von Überhitzung, ist solange zulässig, bis es die Funktionsfähigkeit zeitkritischer Fahralgorithmen beeinträchtigen würde. Dieselbe Anforderung gilt für den DCDC-Wandler und alle weiteren im Casing untergebrachten Systeme.

Da die endgültige Hardwareauswahl zum Zeitpunkt der Anforderungsdefinition noch nicht feststeht, werden keine absoluten Temperaturobergrenzen als Anforderung definiert. Als Maßstab gilt die vom jeweiligen Komponentenhersteller spezifizierte maximale Betriebstemperatur, die unter allen Betriebsbedingungen einzuhalten ist und die Temperatur, auf der noch kein Thermal Throttling stattfindet oder dieses sich in einem akzeptablen Rahmen befindet.

== Elektronische Anforderungen

Die Spannungsversorgung des #acro("DVPC") sowie aller im Casing integrierten Peripheriekomponenten muss jederzeit stabil und zuverlässig gewährleistet sein. Spannungseinbrüche oder -schwankungen, die zu einem unerwarteten Systemausfall führen können, sind zu vermeiden.

Das System muss über einen elektrischen Mechanismus ferngesteuert ein- und ausgeschaltet werden können. Die Steuerung dieses Mechanismus erfolgt über die #acro("RCU"), die als zentrales Steuergerät für die rückwärtigen Fahrzeugsysteme fungiert.

Das elektronische System muss eine ausreichende Konnektivität bereitstellen, um sowohl die peripheren Komponenten innerhalb des Casings als auch die relevanten Subsysteme des Fahrzeugs zuverlässig anzubinden. Die Wahl der Kommunikationsschnittstellen richtet sich nach den Anforderungen der eingesetzten Komponenten. Hierbei ist sich nach den Anforderungen des #acro("AS")-Subteams im Verein zu richten, abhängig von der zu verwendenden Recheneinheit.

== Nutzbarkeit und Wartbarkeit

Alle Komponenten des #acro("DVPC") sollen in einem einzigen, geschlossenen Package zusammengefasst sein. Da das System im Entwicklungs- und Testbetrieb regelmäßig ausgebaut wird, um Hardware-Tests an einem stationären Arbeitsplatz durchzuführen, reduziert ein als Einheit handhabbares System den hierfür erforderlichen Aufwand erheblich.

Der Ein- und Ausbau des Systems muss ohne umfangreiche Kenntnisse der Fahrzeugtechnik möglich sein, sodass auch Teammitglieder aus nicht-technischen Bereichen den Vorgang selbstständig durchführen können. In diesem Zusammenhang ist die elektrische Anbindung des Systems an das Fahrzeug so einfach und eindeutig wie möglich zu gestalten, beispielsweise durch klar gekennzeichnete Steckverbindungen.

Das System muss für Wartungs- und Reparaturzwecke zerstörungsfrei zerlegbar sein, um den Austausch einzelner Komponenten zu ermöglichen, ohne das Gesamtsystem unbrauchbar zu machen.
