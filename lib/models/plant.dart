/*
Hier geht es hauptsächlich um die "Plant" Klasse die unsere Pflanzen mit all ihren
eigenschaften modeliert.
Im Konstruktor mit dem Keyword "required" versehene Eigenschaft müssen immer angegeben
werden.
*/

/*
Fürs Düngen (Fertilising) habe ich eine eigene Klasse erstellt.
Pflanzen müssen nicht gedüngt werden, also kann "fertilising" (in der Klasse Plant)
auch null sein. Es muss sicher gestellt werden dass "fertiliserInterval" und
"lastFertilising" beide null sind oder beide einen Wert haben. Daher die eigen Klasse
und die Überprüfung dass in der settern nicht null Werte zugewiesen
*/
import 'package:cloud_firestore/cloud_firestore.dart';

class Fertilising {
  //Die eigenschaften sind private uns starten deshalb mit _
  //Eigenschaften:
  int _fertiliserInterval;
  DateTime _lastFertilising;

  //Konstruktor:
  Fertilising({
    required fertiliserInterval,
    required lastFertilising,
  })  : _fertiliserInterval = fertiliserInterval,
        _lastFertilising = lastFertilising;

  //Setters und Getters:
  get fertiliserInterval => _fertiliserInterval;
  get lastFertilising => _lastFertilising;

  set setFertiliserInterval(fertiliserInterval) {
    if (fertiliserInterval != null && fertiliserInterval is int) {
      _fertiliserInterval = fertiliserInterval;
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
      _lastFertilising = lastFertilising;
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
  //Eigenschaften:
  late String id;
  String name;
  String species;
  String roomName;
  DateTime lastWatering;
  int waterInterval;
  Fertilising? fertilising; //Kann null sein
  String notes;
  String imagePath;

  //Konstruktor:
  Plant(
      {required this.name,
      required this.species,
      required this.waterInterval,
      required this.lastWatering,
      this.fertilising,
      this.roomName = "",
      this.notes = "",
      this.imagePath = ""});

  //Methoden:
  //Berechnet wann die Pflanze das nächste mal gegossen werden muss
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

  //Berechnet wann die Pflanze das nächste mal gedüngt werden muss
  String fertiliseInDays() {
    //TODO falls die App released wird brauchen wir hier iwas was Fehler sammelt, checken wie genau sich assert verhält
    assert(fertilising != null);
    int inDays = fertilising!._fertiliserInterval +
        fertilising!._lastFertilising.difference(DateTime.now()).inDays;
    if (inDays > 0) {
      return "In $inDays Tagen";
    } else if (inDays <= -fertilising!._fertiliserInterval) {
      //Wenn düngen dringen ist, also schon mehr als ein Interwall her ist.
      return "Dringend Düngen!";
    } else if (inDays <= 0) {
      return "Heute";
    }
    throw Exception('fertiliseInDays konnte nicht berechnet werden');
  }

  //Konstruktor für Daten aus der DB
  Plant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        species = json['species'],
        roomName = json['roomName'],
        lastWatering = (json['lastWatering'] as Timestamp).toDate(),
        waterInterval = json['waterInterval'],
        fertilising = Fertilising(
          fertiliserInterval: json['fertiliserInterval'],
          lastFertilising: (json['lastFertilising'] as Timestamp).toDate(),
        ),
        notes = json['notes'],
        imagePath = json['imagePath'];

  //Formatiert die Klasse für das Hochladen in die DB
  Map<String, dynamic> toJson() => {
        'name': name,
        'species': species,
        'roomName': roomName,
        'lastWatering': lastWatering,
        'waterInterval': waterInterval,
        'lastFertilising': fertilising!._lastFertilising,
        'fertiliserInterval': fertilising!.fertiliserInterval,
        'notes': notes,
        'imagePath': imagePath,
      };


  set setName(String name) => this.name = name;

  set setSpecies(String species) => this.species = species;

  set setRoomName(String roomName) => this.roomName = roomName;

  set setWaterInterval(int waterInterval) => this.waterInterval = waterInterval;

  set setNotes(String notes) => this.notes = notes;

  set setLastWatering(DateTime lastWatering) =>
      this.lastWatering = lastWatering;

  set setFertilising(Fertilising? fertilising) =>
      this.fertilising = fertilising;

  set setImagePath(imagePath) => this.imagePath = imagePath;
}
