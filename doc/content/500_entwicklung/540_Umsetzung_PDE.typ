#import "../../config/acronyms.typ": *
#import "../../config/functions.typ": *
#include "../../config/config.typ"

== Umsetzung im Power Device Engineer<sec:umsetzung>

- in PDE werden die Namensvorschläge aus der Tabelle übernommen
- mit produktsupport stellt sich heraus, dass der blob type auf dem powercenter nicht unterstützt wird
- alarme werden aus einem bitfeld ausgelesen, der über den blob quasi die einzelnen alarme beinhaltet, das geht auf dem powercenter nicht --> diese könnten über einen managementstationsalarm dann in die normale alarmliste gebracht werden
- desigo cc bietet keine möglichkeit, maskierungen oder so vorzunehmen, jedenfalls nicht mit den datentypen die von PDE bereitgestellt werden. verändert man das JSON manuell, wird der typ nicht akzeptiert aufgrund der import regeln. Es gibt ein bitfeld type, der genau für so etwas gemacht ist, in der anwendung ist das aber nicht möglich, da eben man nicht die conversion machen kann mit dem objektmodell. 
- workaround wie beispielsweise die bitmuster als zahl zu interpretieren und damit einen alarm auszulösen sind zwar theoretisch möglich, wenn aber mehrere alarme ausgelöst werden oder zu einem alarm noch ein anderer alarm hinzukommt, kann es sein dass die fälle nicht abgedeckt sind wenn man es gegen eine einzelne zahl prüft, die dem bitmuster entspreicht --> für etwas so kritisches sollten keine pfusch lösungen eingesetzt werden, welche funktionalitäten suggerieren die so nicht sicher funktionieren 
- teilweise unerklärliches verhalten vom PDE --> nachdem der blobtype aus dem objektmodell gelöscht wurde, ist die dateigröße des objektmodells von 22 MB (was auch schon sehr groß ist aber gut) auf 150 MB gesprungen, was dazu geführt hat, dass sich die datei in PDE nicht mehr öffnen lässt (crash) und der import in desigo cc sehr lange dauert. keine erklärung warum, durch das löschen hätte die datei ja eigentlich kleiner werden sollen
- man kann auch keinen text als input schreiben, heißt das muss man dann auch in powerconfig machen für die stammdaten
- tranformation type mit float 64 funktioniert, softwareversion geht nicht und ist im grunde auch nicht so ultra relevant, da ein servicemitarbeiter die software updaten muss, das geht nur mit powerconfig und nicht mit desigo. 
- außerhalb davon soweit so gut eigentlich