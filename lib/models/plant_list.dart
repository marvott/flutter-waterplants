import '/models/plant.dart';

class PlantList {
  final List<Plant> _myPlants = [];

  add(Plant plant) {
    _myPlants.add(plant);
  }

  remove(Plant plant) {
    _myPlants.remove(plant);
  }

  lenght() => _myPlants.length;

  getElemtByIndex(int index) => _myPlants[index];

  get getMyPlants => _myPlants;
}
