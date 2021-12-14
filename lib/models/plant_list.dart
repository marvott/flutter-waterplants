import '/models/plant.dart';

//In dieser Klasse geht es um die Liste in der alle Pflanzen abgespeichert werden
class PlantList {
  List<Plant> _myPlants = [];

  //Pflanzen hinzufügen
  add(Plant plant) {
    _myPlants.add(plant);
  }

  //Pflanzen entfernen
  remove(Plant plant) {
    _myPlants.remove(plant);
  }

  lenght() => _myPlants.length; //Länge der Liste

  //ist eigentlich ein setter, aber sollte nur 1x verwendet werden
  construct(List<Plant> newPlantlist) {
    _myPlants = newPlantlist;
  }

  getElemtByIndex(int index) => _myPlants[index];

  get getMyPlants => _myPlants;
}
