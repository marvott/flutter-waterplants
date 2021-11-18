import 'package:flutter/foundation.dart';

class Fertilising {
  int fertiliserInterval;
  DateTime lastFertilising;

  Fertilising({
    required this.fertiliserInterval,
    required this.lastFertilising,
  });
}

class Plant extends ChangeNotifier {
  String name;
  String species;
  String roomName;
  DateTime lastWatering;
  int waterInterval;
  Fertilising? fertilising;
  String notes;
  String imagePath;

  Plant(
      {required this.name,
      required this.species,
      required this.waterInterval,
      required this.lastWatering,
      this.fertilising,
      this.roomName = "",
      this.notes = "",
      this.imagePath = ""});

  String waterInDays() {
    int inDays = waterInterval + lastWatering.difference(DateTime.now()).inDays;
    if (inDays > 0) {
      return "In $inDays Tagen";
    } else if (inDays <= -waterInterval) {
      //Wenn bewässern dringen ist, also schon mehr als einem Interwall her ist.
      return "Dringend Gießen!";
    } else if (inDays <= 0) {
      return "Heute";
    }
    throw Exception('Gießen in Tagen konnte nicht berechnet werden');
  }

  String fertiliseInDays() {
    //TODO falls die App released wird brauchen wir hier iwas was Fehler sammelt, checken wie genau sich assert verhält
    assert(fertilising != null);
    int inDays = fertilising!.fertiliserInterval +
        fertilising!.lastFertilising.difference(DateTime.now()).inDays;
    if (inDays > 0) {
      return "In $inDays Tagen";
    } else if (inDays <= -fertilising!.fertiliserInterval) {
      //Wenn düngen dringen ist, also schon mehr als einem Interwall her ist.
      return "Dringend Düngen!";
    } else if (inDays <= 0) {
      return "Heute";
    }
    throw Exception('Gießen in Tagen konnte nicht berechnet werden');
  }

  //TODO: nicht benötigten Boilerplatemüll entfernen
  get getName => name;

  set setName(String name) {
    notifyListeners();
    this.name = name;
  }

  get getSpecies => species;

  set setSpecies(String species) {
    notifyListeners();
    this.species = species;
  }

  get getRoomName => roomName;

  set setRoomName(roomName) {
    notifyListeners();
    this.roomName = roomName;
  }

  get getWaterInterval => waterInterval;

  set setWaterInterval(int waterInterval) {
    notifyListeners();
    this.waterInterval = waterInterval;
  }

  get getNotes => notes;

  set setNotes(String notes) {
    notifyListeners();
    this.notes = notes;
  }

  get getLastWatering => lastWatering;

  set setLastWatering(DateTime lastWatering) {
    notifyListeners();
    this.lastWatering = lastWatering;
  }

  Fertilising? get getFertilising => fertilising;

  set setFertilising(Fertilising? fertilising) {
    notifyListeners();
    this.fertilising = fertilising;
  }

  get getImagePath => imagePath;

  set setImagePath(imagePath) {
    notifyListeners();
    this.imagePath = imagePath;
  }
}
