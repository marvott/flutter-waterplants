import '/models/plant.dart';

class PlantList {
  List<Plant> _myPlants = [];

  add(Plant plant) {
    _myPlants.add(plant);
  }

  remove(Plant plant) {
    _myPlants.remove(plant);
  }

  lenght() => _myPlants.length;

  //ist eigentlich ein setter, aber sollte nur 1x verwendet werden
  construct(List<Plant> newPlantlist) {
    _myPlants = newPlantlist;
  }

  getElemtByIndex(int index) => _myPlants[index];

  get getMyPlants => _myPlants;
}
