import 'package:flutter/foundation.dart';
import '/models/plant.dart';

//Helferklasse damit ich die in den Provider packen kann
class PlantModifier extends ChangeNotifier {
  Plant? myPlant;
  set setmyPlant(Plant? myPlant) {
    this.myPlant = myPlant;
  }

  setName(Plant plant, String name) {
    plant.setName = name;
    // notifyListeners();
  }

  setSpecies(Plant plant, String species) {
    plant.species = species;
    notifyListeners();
  }

  setRoomName(Plant plant, roomName) {
    plant.roomName = roomName;
    notifyListeners();
  }

  setWaterInterval(Plant plant, int waterInterval) {
    plant.waterInterval = waterInterval;
    notifyListeners();
  }

  setNotes(Plant plant, String notes) {
    plant.notes = notes;
    notifyListeners();
  }

  setLastWatering(Plant plant, DateTime lastWatering) {
    plant.lastWatering = lastWatering;
    notifyListeners();
  }

  setFertilising(Plant plant, Fertilising? fertilising) {
    plant.fertilising = fertilising;
    notifyListeners();
  }

  setImagePath(Plant plant, imagePath) {
    plant.imagePath = imagePath;
    // notifyListeners();
  }
}
