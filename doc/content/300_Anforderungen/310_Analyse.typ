#import "../../config/acronyms.typ": *
#include "../../config/config.typ"

= Analyse des DVPCs des Vorjahres <analyse>
// sachlicher umformulieren
Da das System insgesamt erst zu einem späten Zeitpunkt in der Saison entwickelt wurde, mussten an vielen Stellen Kompromisse im Design und der Implementierung eingegangen werden, um eine rechtzeitige Fertigstellung zu garantieren und die Integrationskomplexität gering zu halten @TimonMaxi25.

Der #acro("DVPC") wurde auf mehreren Wettbewerben verwendet und bietet weiterhin eine Plattform für Tests und ist voll funktionstüchtig zum Verfassungszeitpunkt @TimonMaxi25. 

Der jetzige #acro("DVPC") wiegt insgesamt circa $2.6 space.thin"kg"$.
/*- Entwicklung von zwei Personen neben anderen Verantwortlichkeiten als Teamleiter, das heißt es wurden an vielen Stellen Kompromisse eingegangen, um die Komplexität gering zu halten 
- Integration der beiden Systeme ineinander auch nicht perfekt, an vielen Stellen wurde improvisiert*/

== Recheneinheit
Als Recheneinheit für die Driverless Software im eSleek25 wird ein Kompakt-#acro("PC") der Firma ZOTAC verwendet, der MAGNUS EN474070C (Barebone) (siehe @zotacwebistebild). In dieser Arbeit wird die Recheneinheit Zotac genannt. Hierbei handelt es sich um einen x86-basierten #acro("PC") mit dedizierter NVIDIA Grafikkarte und einer Intel #acro("CPU"). Der Zotac bietet Konnektivität via USB-C mit Thunderbolt, USB-A, LAN, HDMI, Displayport, WiFi und Bluetooth @zotacWebsite.
#figure(
    image("../../resources/img/zotac_minipc.png", width: 50%, format: "png"),
    caption: [ZOTAC MAGNUS EN474070C @zotacWebsite]
)<zotacwebistebild>
/*
Hier Bild einfügen von DVPC von Innen.
Die Rechenleistung, die der ZOTAC mit sich bringt ist ausreichend um die Software wie gewünscht auszuführen.@Sinan26
https://www.zotac.com/us/product/mini_pcs/magnus-en474070c-barebone#spec
- Zotac ZBox der aus seinem Casing ausgebaut wurde
- Kühlkörper etc komplett erhalten*/

== Grundlegender Aufbau und Gehäuse

Der #acro("DVPC") gliedert sich in zwei räumlich getrennte Kammern: eine Hauptkammer und eine Nebenkammer. Die Hauptkammer beinhaltet die am Gehäuse angebrachte Recheneinheit, während die Nebenkammer den DCDC-Konverter sowie die Lidarplatine mit der dazugehörigen Verkabelung aufnimmt. Beide Kammern sind an einer gemeinsamen Zwischenplatte befestigt, durch die die Kabelverbindungen zwischen den Kammern geführt werden. In @aufbaudvpc25 kann der grundlegende Aufbau des #acro("DVPC") gesehen werden.

#figure(
    image("../../resources/img/aufbaudvpc25.png", width: 60%, format: "png"),
    caption: [Blick in die Nebenkammer des 25er #acro("DVPC") mit DCDC-Konverter und Lidarplatine; durch den Schlitz zur Hauptkammer ist der Zotac sichtbar]
)<aufbaudvpc25>

Das Gehäuse, auch Casing genannt, ist ein in Handlaminat aus zwei Lagen Köper-Carbon gefertigtes Bauteil. Zum Schutz vor elektromagnetischen Einstreuungen und zur Gewährleistung der #acro("EMV") ist das Casing mit Kupferfolie umwickelt. Da ungeschützte Kupferfolie bei versehentlichem Kontakt mit leitenden Oberflächen Kurzschlüsse verursachen kann, ist diese vollflächig mit Kaptontape abgedeckt. Die Schnittkanten des Casings sind mit Gewebeband umwickelt, um scharfe Kanten abzudecken und den sicheren Umgang zu gewährleisten. Auch die im System integrierten Lüfter sind im Sinne der #acro("EMV")-Abschirmung zusätzlich mit Hasendraht versehen. In @dvpc25innen kann diese Abschirmung gesehen werden.

#figure(
    image("../../resources/img/dvpc25innen.jpeg", width: 60%, format: "jpg"),
    caption: [Innenansicht der Hauptkammer des #acro("DVPC") der 2025er Saison mit #acro("EMV")-Schirmung aus Kupferfolie, Kaptontape und Hasendraht an den Lüftern]
)<dvpc25innen>

Zum Schutz vor Feuchtigkeit und Spritzwasser wurde das Casing mehrfach mit Klarlack versiegelt. An der Trennebene ist Dichtungsband eingelegt, das die Wasserdichtigkeit des Verschlusses sicherstellt. Die Gehäuseteile werden an Flanschen mit Schrauben fixiert, für die in der Zwischenplatte Blindnieten als Einschraubelemente eingebracht sind.


== Mounting
Der #acro("DVPC") ist am Auto der 2025er Saison am Main Hoop, dem größeren der beiden Überrollbügel, angebracht. Hier ist er mit vier Schrauben befestigt. Diese Schrauben werden direkt an dafür vorgesehene Gewinde an angeschweißten Metallzungen am Main Hoop eingeschraubt. Diese Mountingmethode ist sehr stabil und hat mechanisch keine Probleme oder Ermüdungserscheinungen gezeigt. Einer der wichtigsten Aspekte, die bei der Auslegung des Mountings beachtet werden müssen, ist die Nutzerfreundlichkeit. Diese ist im Falle des Mountings nicht zum gewünschten Maß gegeben. Für den Ausbau des #acro("DVPC") müssen Teile des Heckflügels und dessen Anbindung (vertikale Streben in @dvpc25mounting) an den Main Hoop und an das Chassis teilweise ausgebaut oder umgebaut werden. 

#figure(
    image("../../resources/img/dvpc25mounting.png", width: 50%, format: "png"),
    caption: [Der am Überrollbügel des Fahrzeugs installierte 2025er #acro("DVPC")]
)<dvpc25mounting>

Ein weiterer Aspekt des Mountings und der Positionierung generell des #acro("DVPC") ist die fahrdynamische Betrachtung. Grundsätzlich gilt, dass je höher Komponenten (und damit Gewicht) am Fahrzeug angebracht sind, desto schlechter die Performance des gesamten Fahrzeugs. Jegliches Gewicht am Auto verändert das #acro("CoG") und somit das fahrdynamische Verhalten. Ein niedriges #acro("CoG") ist generell bevorzugt @CoGRobertKaufhold. Der #acro("DVPC") ist mit seiner Positionierung am 2025er Fahrzeug sehr hoch angebracht und hat somit negative Effekte auf das fahrdynamische Verhalten auf das Gesamtfahrzeug.
/*
- Mounting am Main Hoop des Fahrzeugs --> sehr weit oben über dem gewünschten COG, dadurch schlechtere Fahrdynamik
- Mounting zwischen den Mountings des Rearwings --> mussten immer entfernt werden um an den DVPC zu kommen */
== Kühlung
Der Zotac besteht in seiner Ausführung vom Hersteller aus in einem Plastikgehäuse welches nach oben, hinten, rechts und links aus der Sicht zum Einschaltknopf Öffnungen zur Lüftung besitzt. Richtung Boden des Gehäuses an den Kanten sind auch Schlitze für die Lüftung vorhanden. Um Gewicht zu sparen, wurde dieses Gehäuse vollständig entfernt und der Kühlkörper und die dazugehörigen Lüfter im Inneren wurden freigelegt. Da der Zotac durch seine Positionierung am Wagen Witterungsbedingungen ausgesetzt ist, muss das Kühlsystem gegen Spritzwasser geschützt sein, weswegen die Luft auf einem anderen Weg als im vom Hersteller gelieferten Gehäuse bereitgestellt werden muss. Hierfür wurden zwei Öffnungen auf der Ober- und Unterseite des Casings verwendet, um die Luft an den Zotac im Inneren zu bringen. Auf der Unterseite wird mit zwei Lüftern die Luft durch dünne Drahtmaschen eingesogen. Diese Drahtmaschen sind zu klein, um das Eindringen von Wasser zu ermöglichen. Auf der Oberseite des Casings ist eine einfache Art einer Labyrinthdichtung aus #acro("SLS")-Druck angebracht (siehe @dvpc25mounting auf der Oberseite, mit Kupferfolie überdeckt), die ein direktes Hineinregnen von oben verhindert. Dadurch ist der Zotac im Inneren vor Wasser geschützt. 

Der DCDC-Wandler ist nicht extra gekühlt und ist mit der Hauptkammer, welcher den Zotac enthält, nur über eine Aussparung in der Zwischenwand verbunden, durch die auch die Verkabelung  geführt wird.

== Elektrische Anbindung
Der #acro("PC") wird mit einem $330 space.thin W$ Netzteil ausgeliefert, was auch die relevante Leistung ist, auf die der DCDC-Konverter zur Versorgung ausgelegt wurde. Bei dem DCDC-Konverter handelt es sich um den RECOM RPMGH12-40 der auf einer selbstentwickelten Platine aufgebracht ist. Die nominale Eingangsspannung ist $24 space.thin V$ und wird von der #acro("LV")-Batterie bereitgestellt. Die Ausgangsspannung des DCDC-Konverters ist $19,5 space.thin V$ und entspricht somit direkt der Eingangsspannung des Zotacs. Die maximale Leistung des Konverters liegt bei etwa $500 space.thin W$ @RecomDCDC.

Auf der eigens entwickelten Platine ist ein weiterer DCDC-Konverter der eine Ausgangsspannung von $12 space.thin V$ liefert. Hierbei handelt es sich um den TRACO TSR 2-24120, der die Energieversorgung für die LidarPCB darstellt.

Die Kommunikation mit dem Rest des Fahrzeugs findet über Ethernet statt. Es gibt eine Verbindung über einen Stecker am Chassis, der in den Hinterwagen führt. Von dort aus führt ein Ethernet-Kabel zum zentralen Fahrregler.