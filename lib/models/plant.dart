/*
Fürs Düngen (Fertilising) habe ich eine eigene Klasse erstellt.
Pflanzen müssen nicht gedüngt werden, also kann "fertilising" (in der Klasse Plant)
auch null sein. Es muss sicher gestellt werden dass "fertiliserInterval" und
"lastFertilising" beide null sind oder beide einen Wert haben. Daher die eigen Klasse
und die Überprüfung dass in der settern nicht null Werte zugewiesen
*/
class Fertilising {
  int fertiliserInterval;
  DateTime lastFertilising;

  Fertilising({
    required this.fertiliserInterval,
    required this.lastFertilising,
  });

  set setFertiliserInterval(fertiliserInterval) {
    if (fertiliserInterval != null && fertiliserInterval is int) {
      this.fertiliserInterval = fertiliserInterval;
    } else if (fertiliserInterval == null) {
      throw Exception('fertiliserInterval darf nicht Null sein');
    } else if (fertiliserInterval is! int) {
      throw Exception('fertiliserInterval muss ein Integer sein');
    } else {
      throw Exception('fertiliserInterval wert ist ungültig');
    }
  }

  set setLastFertilising(lastFertilising) {
    if (lastFertilising != null && lastFertilising is DateTime) {
      this.lastFertilising = lastFertilising;
    } else if (lastFertilising == null) {
      throw Exception('fertiliserInterval darf nicht Null sein');
    } else if (lastFertilising is! DateTime) {
      throw Exception('fertiliserInterval muss ein DateTime sein');
    } else {
      throw Exception('lastFertilising Intervall wert ist ungültig');
    }
  }
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
    throw Exception('waterInDays konnte nicht berechnet werden');
  }

  String fertiliseInDays() {
    //TODO falls die App released wird brauchen wir hier iwas was Fehler sammelt, checken wie genau sich assert verhält
    assert(fertilising != null);
    int inDays = fertilising!.fertiliserInterval +
        fertilising!.lastFertilising.difference(DateTime.now()).inDays;
    if (inDays > 0) {
      return "In $inDays Tagen";
    } else if (inDays <= -fertilising!.fertiliserInterval) {
      //Wenn düngen dringen ist, also schon mehr als ein Interwall her ist.
      return "Dringend Düngen!";
    } else if (inDays <= 0) {
      return "Heute";
    }
    throw Exception('fertiliseInDays konnte nicht berechnet werden');
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

  get getImagePath => imagePath;

  set setImagePath(imagePath) => this.imagePath = imagePath;
}
