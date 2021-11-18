class PlantProperties {
  String name;
  String species;
  String roomName;
  int waterInterval;
  int fertiliserInterval;
  String notes;
  DateTime lastWatering;
  DateTime? lastFertilising;
  String imagePath;

  PlantProperties(
      {required this.name,
      required this.species,
      required this.waterInterval,
      required this.lastWatering,
      this.roomName = "",
      this.fertiliserInterval = 0,
      this.notes = "",
      this.lastFertilising,
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

  int lastFertilisingInDays() =>
      DateTime.now().difference(lastFertilising!).inDays;

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
