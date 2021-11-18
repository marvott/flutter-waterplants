import 'package:flutter/foundation.dart';
import '/models/plant.dart';

class PlantList extends ChangeNotifier {
  List<Plant> myPlants = [];

  add(Plant plant) {
    myPlants.add(plant);
    notifyListeners();
  }

  remove(Plant plant) {
    myPlants.remove(plant);
    notifyListeners();
  }

  lenght() => myPlants.length;

  getElemtWithIndex(int index) => myPlants[index];

  get getMyPlants => myPlants;
}
