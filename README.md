# PlantUs
Doku zur Pflanzen-App von Marvin und David

## Benutzung der App / Screens

### Account - Anmeldung
Um die App zu benutzen, muss der User sich erst registrieren oder mit einem bestehenden Account anmelden.
Bei erfolgreicher Anmeldung kann der User auf die Seiten für Pflanzen und Sprossen zugreifen.
Meldet sich der User ab werden die anderen Seiten wieder ausgeblendet.
### Sprossen
Auf diesem Screen findet man eine Liste von Sprossen, deren Keimdauer und wie häufig sie gegossen werden müssen.
Mit den Plus-Button kann der User aus einer Liste Sprossen auswählen und diese hinzufügen.
Über den das blaue Icon kann man die Sprossen gießen.
Mit einem Long-Press kann der User Sprossen wieder löschen.
### Pflanzen
Hier wird eine Liste von Pflanzen mit deren Bild und Name angezeigt. Diese sind nach dem letzen Gießdatum sortiert.
Bei jeder Pflanze werden 2 Icons angezeigt über die der User die Pflanze gießen (blau) und düngen (orange) kann.
Über den Plus-Button kann man neue Pflanzen hinzufügen, dabei legt der User verschiedene Eigenschaften der Pflanze fest.
Mit einem Long-Press können Pflanzen wieder gelöscht/begraben werden.

Bei einem einfachen Klick öffnet sich ein neuer Screen mit einer Übersicht der Pflanze.
Hier kann der User noch das Standart-Bild durch ein eigenes Bild ersetzen, Notizen hinzufügen und durch Klicken der Icons die Pflanze gießen oder düngen.
Um weitere Änderungen vorzunehmen reicht ein einfacher Klick auf das jeweilige Feld.

#

## Technische Umsetzung
Unser Code ist nach folgender Doku organisiert:
https://medium.com/flutter-community/flutter-code-organization-revised-b09ad5cef7f6

### Components
Hier befinden sich die Komponenten, die man überall im Code wiederverwenden möchte. 
Dies können Widgets oder UI-Elemente sein.
Wir haben bspw. die Snackbar öfter an den verschiedensten Orten im Code wiederverwendet, um dem User schnell Feedback zu der ausgeführten Handlung zu geben.

### Models
In dem Models-Ordner befinden sich die selbstgeschriebenen Klassen
### Screens
In diesem Ordner befinden sich alle wichtigen Seiten der App: 
* Der Settings-Screen mit der Authentifizierung
* Der Sprossen-Screen
* Der Plant-Overview-Screen mit der großen Übersicht aller Pflanzen, mit Name und Bild und den zwei Icons zum Gießen/Düngen
* Der Plant-Screen ist die Detail-Ansicht, wenn man auf eine Pflanze draufklickt
* Der Camera-Screen implementiert alles Wichtige für die Nutzung der Kamera im Pflanzen-Screen

### Services
Hier würden normalerweise Services für die Behandlung von APIs und Datenbanken Platz finden. Aus Zeitgründen haben wir es nicht geschafft, aber langfristig kommen hier alle Klassen für Firebase rein.

### Theme
Die App soll überall einen gleichen Style (Corporate Identity mit Schriftart, Farben und Design) besitzen, deswegen wird dieses ausgelagert und kann überall im Code aufgerufen werden.

### Main.dart

In der Main werden Firebase und andere Sache initialisiert und Routen festgelegt.
In screens/main_screen.dart wird die Bottom-Bar aufgebaut und die 3 Screens in einem IndexedStack angezeit, der sorgt dafür dass der Status der Widgets erhalten bleibt.

#


## Learnings
Wir haben versucht mit dem Flutter-Package "provider" die in Flutter umständlicher "States" zu managen, das war für unsere Anwendung mit den veränderbaren Instanzen der Pflanzen leider nicht passend und wurde wieder verworfen (siehe unseren Branch "plant_state_provider"). Firebase hat uns mit dem Listener diese Arbeit abgenommen und zwischenzeitlich umständlich implementierte callbacks ersetzt. Der Listener von Firebase reagiert auf jede Änderung in der Datenbank, dabei ändern sich auch unsere Screens und werden neu gerendert, so werden auf verschiedenen Geräten allen Nutzern die mit dem selben Account angemeldet sind Änderungen sofort angezeigt.
Nur die Bilder werden noch lokal auf dem Gerät gespeichert, andere User sehen dann das Standard-Bild.

## Teamarbeit
Die Arbeit im Team hat bei uns gut funktioniert und die Arbeit mit GitLab hat die Zusammenarbeit nochmal deutlich erleichtert.
David hat alles Rund um die Pflanzen und den "components" geschrieben, diese konnte Marvin an mehreren Stellen nutzen.
Marvin hat die Sprossenseite und die Anmeldung geschrieben, sich dabei mit Firebase auseinandergesetzt und implementiert. David hat Teile von Firebase übernommen und für die Pflanzen angewendet.

#
## Roadmap
### Notifications
Auf Android können wir bereits über Firebase Custom-Benachrichtigungen senden. Ziel ist es dass alle User Benachrichtigungen zum Gießen und Düngen und zum Status der Sprossen erhalten.

### Sprossen
Es soll noch eine Erklärung zur richtigen Zucht von Sprossen hinzugefügt werden.
Langfristig soll man jeden Tag 2x erinnert werden, dass die Sprossen gegossen werden müssen. Dies kann, muss aber nicht bestätigt werden, je nachdem was der User wünscht. Außerdem kann festgelegt werden, wann man erinnert werden möchte.

Wenn die Sprossen essreif sind sollen sie automatisch aus der Liste verschwinden. Davor soll man natürlich eine Notification bekommen, dass man "ernten" kann.

Die verschiedenen Sorten sollen eigene Bilder erhalten.
Individuelle Anpassung der Eigenschaften der Sprossen soll ermöglicht und eigene Sorten sollen hinzugefügt werden können.


### Pflanzen
Die Bilder der Pflanzen sollen in Firebase/Store abgelegt werden,
es soll ein passenderes Icons für das Düngen gefunden werden und
mehrere Zimmer sollen verfügbar sein (akutell kann ein Zimmer festgelegt werden, wird aber nicht angezeigt).

Benutzer sollen Zimmer/Gebäude teilen können, damit z.B. in einem Unternehmen mehrere Mitarbeiter sich um Pflanzen kümmern können, wenn der Pflanzenbeauftragte im Urlaub ist.
Die Icons fürs Gießen/Düngen auf der Pflanzenübersicht sollen nur angezeigt wenn die Pflanzen Pflege benötigen.

### Veröffentlichung
Da es tatsächlich noch keine App gibt die das Teilen von Pflanzen über iOS und Android ermöglicht, sehen wir Potenzial die App weiter zu enttwickeln, am Design und der Usability zu arbeiten und ggf. in den Appstores veröffentlichen.
