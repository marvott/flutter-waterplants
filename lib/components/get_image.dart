import 'dart:io';

import 'package:flutter/material.dart';

/*da wir die Pflanzenbilder nur lokal speichern, deren lokaler Pfad aber in der DB speichern,
kann es sein das der Pfad ungültig ist, ZB auf einem anderen Handy
*/

//checkt ob der gegeben Pfad/Datei existiert
ImageProvider getImage(String imgPath) {
  if (File(imgPath).existsSync()) {
    return FileImage(File(imgPath));
  } else {
    return const AssetImage("assets/images/plant.jpeg");
  }
}
