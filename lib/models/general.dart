import 'package:flutter/widgets.dart';

/*
Die Klasse hat mal "globale" Variablen zur Verfügung gestellt
Bis zur Fertigstellung muss diese Klasse gelöscht werden können.
*/

//TODO: diese Klasse wenn möglich löschen
class GeneralArguments {
  static String cameraName = "";
  static String imagePath = "";
  static String defaultImagePath = "assets/images/plant.jpeg";
  static ImageProvider defaultPlantImg =
      const AssetImage("assets/images/plant.jpeg");
}
