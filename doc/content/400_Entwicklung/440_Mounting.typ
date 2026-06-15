#import "../../config/acronyms.typ": *
#include "../../config/config.typ"


== Entwicklung des Mountings <mounting>
Nachdem in den vorangegangenen Abschnitten sowohl das Casing als auch der Kühlkörper konstruktiv festgelegt wurden, wird im Folgenden die mechanische Anbindung des #acro("DVPC") an das Fahrzeug beschrieben. Das Mounting hat die Aufgabe, das Casing im Hinterwagen sicher zu fixieren und einen einfachen Ein- und Ausbau zu ermöglichen.

=== Auswahl der Mountingmethodik
/* - Mounting über Carbonrod seitlich am Mono, Mounting wie Syselbox mit Alubiegeteilen
- seitliches Mounting schwierig, da da das Sideboard ist und somit keine Möglichkeit besteht da sauber anzubinden
- Mounting oben an oberer Firewall im Hinterwagen möglich
- Aus Erfahrungswerten kann geschlossen werden, dass die Alubiegeteile eine sehr gute Lösung darstellen, da sie einfach zu fertigen sind, eine hohe Steifigkeit bieten und trotzdem relativ leicht sind
- Anbindung oben am besten da überhaupt möglich und recht einfach zu realisieren und robust mit Alubiegeteilen
 */
Für die Anbindung des Casings an die Fahrzeugstruktur werden zwei grundsätzliche Ansätze gegenübergestellt. Der erste Ansatz sieht eine seitliche Anbindung über Carbonrods am Mono vor. Der zweite Ansatz orientiert sich an der Syselbox und setzt auf Alubiegeteile als tragende Mountingstruktur.

Eine seitliche Anbindung am Mono erweist sich im Bauraum des Hinterwagens als nicht praktikabel, da an den in Frage kommenden Positionen das Sideboard verläuft. Eine saubere Anbindung an das Mono ist dadurch nicht möglich, ohne die bestehende Struktur wesentlich anzupassen. Als alternativer Anbindungspunkt steht die obere Firewall im Hinterwagen zur Verfügung, über die das Casing von oben in die Fahrzeugstruktur eingehängt werden kann.

Aus Erfahrungswerten der vorangegangenen Saisons lässt sich ableiten, dass Alubiegeteile für eine solche Anbindung eine sehr gute Lösung darstellen. Sie sind einfach zu fertigen, bieten bei geringem Gewicht eine hohe Steifigkeit und lassen sich nachträglich durch Biegen an Toleranzen anpassen. In Kombination mit der oberen Firewall als einzig sinnvoll verfügbarem Anbindungspunkt wird daher das Konzept eines Alubiegeteil-Mountings an der oberen Firewall des Hinterwagens gewählt.

=== Entwicklung des Mountings
/* - Orientierung am Syselbox Mounting der 25er Saison, das hat gut funktioniert, war leicht und gut in der Verwendung
- Fertigungspartner übernimmt die Fertigung der Alubiegeteile
- Konstruktion im CAD, die y- und x-Achsen werden durch Pressung der Alubiegeteile auf das Casing sichergestellt, die Z-Achse wird durch die Flansche des Casings sichergestellt, hier werden spezifische Slots eingebaut, die die Flansche von oben und unten drücken
- Ganzes Casing liegt auf der seitlichen Flansche auf einer Schiene auf dem Alublech auf
- vorne wird ein Aluteil angeschraubt an das Mounting, damit wird dann auf die Flansche des Casings gedrückt
- in den Aluteilen die von oben kommen sollen Blindnieten eingebaut werden damit man es da verschrauben kann
- eventuelle Fertigungstoleranzen des Casings könne durch Biegen per Hand ausgeglichen werden
- wird an Fertigungspartner gegeben und dort produziert
- placeholderbild für aluteile im CAD
 */
Als Referenz für die Konstruktion dient das Mounting der Syselbox aus der Saison 2025, das sich dort als leicht, robust und in der Handhabung praktikabel erwiesen hat, siehe @syselboxmounting. Die grundlegende Idee, das Casing über umgreifende Alubiegeteile formschlüssig zu fixieren, wird auf die Geometrie des #acro("DVPC")-Casings übertragen. Die Fertigung der Alubiegeteile selbst wird an einen externen Fertigungspartner ausgelagert, der über die entsprechenden Biege- und Schneidprozesse verfügt.

#figure(
  image("../../resources/img/syselboxmounting.png", width: 60%, format: "png"),
  caption: [Mounting der Syselbox aus der 25er Saison]
)<syselboxmounting>

Die Konstruktion des Mountings erfolgt im #acro("CAD") auf Basis der bereits festgelegten Casinggeometrie. Die Fixierung in Fahrzeug-x- und -y-Richtung wird durch formschlüssige Anlage der Alubiegeteile an den Seitenflächen des Casings sichergestellt. Die Biegeteile greifen dabei so um das Casing, dass eine Verschiebung in der Ebene durch die umgebende Blechstruktur blockiert wird. Die Sicherung in z-Richtung erfolgt über die seitlich am Casing angeformten Flansche. In die Alubiegeteile werden hierfür spezifische Slots eingebracht, die die Flansche sowohl von oben als auch von unten einfassen und damit die Bewegung des Casings senkrecht zur Montageebene begrenzen.

Das Casing liegt im montierten Zustand mit seinen seitlichen Flanschen auf einer im Alublech ausgeformten Schiene auf, die gleichzeitig als Aufnahme und als untere Führung der Flansche dient. Nach vorne hin wird das Casing durch ein zusätzliches, an das Mounting angeschraubtes Aluteil gesichert, welches von vorne auf die Flansche des Casings drückt und damit die Bewegung in Fahrzeug-X-Richtung abschließend fixiert. In die von oben auf das Casing greifenden Biegeteile werden Blindnieten eingebracht, über die die Verschraubung des vorderen Sicherungsteils sowie weiterer Anbindungspunkte erfolgen kann.

Etwaige Fertigungstoleranzen des Casings, die sich aus dem Laminierprozess ergeben, können über ein manuelles Nachbiegen der Alubiegeteile ausgeglichen werden. Diese Toleranzfähigkeit stellt einen wesentlichen Vorteil des Konzepts dar, da Abweichungen der Casinggeometrie nicht zwingend zu einer Neufertigung des Mountings führen. Die fertige #acro("CAD")-Konstruktion wird an den Fertigungspartner übergeben und dort produziert. @mountingcad zeigt das konstruierte Mounting im #acro("CAD").

#figure(
  image("../../resources/img/mountingcad.png", width: 60%, format: "png"),
  caption: [#acro("CAD")-Darstellung der Alubiegeteile des Mountings mit umgreifenden Slots für die Flansche des Casings an der linken Seite der seitlichen Alubiegeteilen]
)<mountingcad>

=== Test des Mountings
/* - da noch kein Mono zum testen werden erste Tests auf einer Holzplatte durchgeführt: aufschrauben des Mountings
- Casing wird eingesetzt --> passt, ist fixiert
- vordere Mountingschiene passt wegen entformungsschräge im Casing nicht --> geht zu weit nach vorne
- vordere mountingschiene kann umgedreht werden, Z-Sicherung ist ausreichend
- placeholder bild für das Ganze auf der holzplatte
- später dann auch test im auto --> gleiches Ergebnis wie Holzplatte
- placeholder bild dafür auch einfügen
 */
Da zum Zeitpunkt der Erprobung des Mountings das Mono des Fahrzeugs noch nicht zur Montage zur Verfügung stand, wird der erste Funktionstest auf einer Holzplatte durchgeführt. Das Mounting wird hierfür auf die Holzplatte aufgeschraubt und bildet so die Anbindungsfläche der späteren oberen Firewall im Hinterwagen nach. Anschließend wird das Casing in die Alubiegeteile eingesetzt. Die formschlüssige Aufnahme funktioniert wie ausgelegt, das Casing ist in x-, y- und z-Richtung sicher fixiert.

Als Abweichung zeigt sich beim Einsetzen, dass die vordere Mountingschiene in der ursprünglich vorgesehenen Orientierung nicht sauber an die Flansche des Casings anliegt. Ursache ist die Entformungsschräge des Casings, die aus dem Designprozess des zweiten Toolings resultiert und dazu führt, dass die Schiene in der geplanten Einbaulage zu weit nach vorne auf die Flansche trifft. Durch Umdrehen der vorderen Mountingschiene wird diese Abweichung kompensiert. Die Sicherung des Casings in Z-Richtung bleibt in der umgedrehten Anordnung in vollem Umfang erhalten, da der Eingriff der Schiene in die Flansche durch die Symmetrie der Geometrie nicht beeinträchtigt wird. @mountingholzplatte zeigt das Gesamtsetup auf der Holzplatte.

#figure(
  image("../../resources/img/mountingholzplatte.png", width: 60%, format: "png"),
  caption: [Testaufbau des Mountings mit eingesetztem Casing auf einer Holzplatte zur Überprüfung der Passung vor Verfügbarkeit des Monos]
)<mountingholzplatte>

Zu einem späteren Zeitpunkt, nach Bereitstellung des Monos, wird das Mounting im Fahrzeug selbst montiert und mit eingesetztem Casing erprobt. Der Einbau im Fahrzeug zeigt dasselbe Verhalten wie der Aufbau auf der Holzplatte. Mit umgedrehter vorderer Mountingschiene ist das Casing in allen drei Raumrichtungen sicher fixiert und das Mounting wird für den weiteren Einsatz freigegeben.

Das Mounting wiegt $35 space.thin g$.