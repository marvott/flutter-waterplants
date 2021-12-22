# PlantUs
Doku zur Pflanzen-App von Marvin u David

## Teamarbeit
Die Arbeit im Team hat bei uns gut funktioniert und die Arbeit mit GitLab hat die Zusammenarbeit nochmal deutlich erleichtert.
David hat alles Rund um die Pflanzen und den "components" geschrieben, diese konnte dann Marvin an mehreren stellen nutzen.
Marvin hat die Sprossenseite und die Anmeldung geschrieben, sich dabei mit Firebase auseinandergesetzt und implementiert. David hat Teile von Firebase übernommen und für die Pflanzen angewendet.
## Benutzung der App / Screens

### Account - Anmeldung
Um die App zu benutzen muss der User sich erst registrieren oder mit einem bestehenden Account anmelden.
Bei erfolgreicher Anmeldung kann der User auf die Seiten für Pflanzen und Sprossen zugreifen.
Meldet sich der User ab werden die anderen Sreens wieder ausgeblendet.
### Sprossen
Auf diesem Screen findet man eine Liste von Sprossen, deren Keimdauer und wie häufig sie gegossen werden müssen.
Mit den Plus-Button kann der User aus einer Liste Sprossen auswählen und hinzufügen.
Über den das blaue Icon kann man die Sprossen gießen.
Mit einem Long-Press kann der User Sprossen wieder löschen.
### Pflanzen
Hier wird eine Liste von Pflanzen mit deren Bild und Name angezeigt, diese sind nach dem letzen Gießdatum sortiert.
Bei jeder Pflanze werden 2 Icons angezeigt über die der User die Pflanze gießen (blau) und düngen (orange) kann.
Über den Plus-Button kann man neue Pflanzen hinzufügen, dabei legt der User verschiedene Eigenschaften der Pflanze fest.
Mit einem Long-Press können Pflanzen wieder gelöscht/begraben werden.
Bei einem einfachen Klick öffnet sich ein neuer Screen mit einer Übersicht der Pflanze.
Hier kann der User noch das Standart-Bild durch ein eigenes Bild ersetzen, Notizen hinzufügen und durch Klicken der Icon die Pflanze Gießen/Düngen.
Um weitere Änderungen vorzunehmen reicht ein einfacher Klick auf das jeweilige Feld.

## Technische Umsetzung
Unser Code ist nach folgender Doku organisiert:
https://medium.com/flutter-community/flutter-code-organization-revised-b09ad5cef7f6

In der Main werden Firebase und andere Sache initialisiert und Routen festgelegt.
In screens/main_screen.dart wird die Bottom-Bar aufgebaut und die 3 Screens in einem IndexedStack angezeit, der sorgt dafür dass der Status der Widgets erhalten bleibt.

Wir haben versucht mit dem Flutter-Package "provider" die in Flutter umständlicher "States" zu managen, das war für unsere Anwendung mit den veränderbaren Instanzen der Pflanzen leider nicht passend und wurde wieder verworfen, siehe unseren Branch "plant_state_provider". Firebase hat uns mit dem Listener diese Arbeit abgenommen und zwischenzeitlich umständlich implementierte callbacks ersetzt. Der Listener von Firebase reagiert auf jede Änderung in der Datenbank, dabei ändern sich auch unsere Screens und werden neu gerendert, so werden auf verschiedenen Geräten allen Nutzern die mit dem selben Account angemeldet sind Änderungen sofort angezeigt.
Nur die Bilder werden noch lokal auf dem Gerät gespeichert, andere User sehen dann das Standart-Bild.

## Roadmap
### Notifications
Auf Android können wir bereits über Firebase Custom-Benachrichtigungen senden. Ziel ist es dass alle User Benachrichtigungen zum Gießen und Düngen und eine der Essreife von Sprossen erhalten.‚

### Sprossen
Es soll noch eine Erklärung zur richtigen Zucht von Sprossen hinzugefügt werden.
Wenn die Sprossen Essreif sind sollen sie automatisch aus der Liste verschwinden.
Die verschiedenen Sorten sollen eigene Bilder erhalten.
Individuelle Anpassung der Eigenschaften der Sprossen soll ermöglicht werden, eigene Sorten sollen hinzugefügt werden können.

### Pflanzen
Die Bilder der Pflanzen sollen in Firebase/Store abgelegt werden,
Passenderes Icons für das Düngen,
Mehrere Zimmer sollen verfügbar sein (akutell kann ein Zimmer festgelegt werden, wird aber nicht angezeigt),
Benutzer sollen Zimmer/Gebäude teilen können, damit zB. in einem Unternehmen mehrere Mitarbeiter sich um Pflanzen kümmern können, wenn der Pflanzenbeauftragte im Urlaub ist.
Die Icons fürs Gießen/Düngen auf der Pflanzenübersicht sollen nur angezeigt wenn die Pflanzen Pflege benötigen.

### Veröffentlichung
Da es tatsächlich noch keine App gibt die das Teilen von Pflanzen über iOS u Android ermöglicht würden wir die App gerne weiterntwickeln, am Design und der Usability arbeiten und vlt in den Appstores veröffentlichen.
