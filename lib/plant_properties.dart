import 'package:flutter_application_1/general_arguments.dart';

class PlantProperties {
  String name;
  String species;
  String roomName = "";
  int waterInterval;
  int fertiliserInterval = 0;
  String notes = "";
  DateTime lastWatering;
  DateTime? lastFertilising;
  String imagePath = GeneralArguments.defaultImagePath;

  PlantProperties(
      {required this.name,
      required this.species,
      required this.waterInterval,
      required this.lastWatering});

  get getName => name;

  set setName(name) => this.name = name;

  get getSpecies => species;

  set setSpecies(species) => this.species = species;

  get getRoomName => roomName;

  set setRoomName(roomName) => this.roomName = roomName;

  get getWaterInterval => waterInterval;

  set setWaterInterval(waterInterval) => this.waterInterval = waterInterval;

  get getFertiliserInterval => fertiliserInterval;

  set setFertiliserInterval(fertiliserInterval) =>
      this.fertiliserInterval = fertiliserInterval;

  get getNotes => notes;

  set setNotes(notes) => this.notes = notes;

  get getLastWatering => lastWatering;

  set setLastWatering(lastWatering) => this.lastWatering = lastWatering;

  get getLastFertilising => lastFertilising;

  set setLastFertilising(lastFertilising) =>
      this.lastFertilising = lastFertilising;

  get getImagePath => imagePath;

  set setImagePath(imagePath) => this.imagePath = imagePath;
}
