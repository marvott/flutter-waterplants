class Fertilising {
  int fertiliserInterval;
  DateTime lastFertilising;

  Fertilising({
    required this.fertiliserInterval,
    required this.lastFertilising,
  });
}

class Plant {
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
  //Setter können weg da nix private
  get getName => name;

  set setName(String name) => this.name = name;

  get getSpecies => species;

  set setSpecies(String species) => this.species = species;

  get getRoomName => roomName;

  set setRoomName(String roomName) => this.roomName = roomName;

  get getWaterInterval => waterInterval;

  set setWaterInterval(int waterInterval) => this.waterInterval = waterInterval;

  get getNotes => notes;

  set setNotes(String notes) => this.notes = notes;

  get getLastWatering => lastWatering;

  set setLastWatering(DateTime lastWatering) =>
      this.lastWatering = lastWatering;

  Fertilising? get getFertilising => fertilising;

  set setFertilising(Fertilising? fertilising) =>
      this.fertilising = fertilising;

  set setLastFerilising(DateTime lastFertilising) {
    if (fertilising != null) {
      fertilising = Fertilising(
          fertiliserInterval: fertilising!.fertiliserInterval,
          lastFertilising: lastFertilising);
    } else {
      print("fertilising Problem");
    }
  }

  get getImagePath => imagePath;

  set setImagePath(imagePath) => this.imagePath = imagePath;
}
