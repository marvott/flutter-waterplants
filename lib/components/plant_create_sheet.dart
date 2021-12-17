import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

import 'package:flutter_application_1/models/plant_list.dart';
import '../models/plant.dart';

class PlantCreateSheet {
  Function? callback;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  String name = "Mein Name";
  String species = "Meine Spezies";
  String roomName = "Schlafzimmer";
  DateTime lastWatering = DateTime.now();
  int waterInterval = 7;
  int fertiliserInterval = 14;
  DateTime lastFertilising = DateTime.now();
  String notes = "";

  showBottomSheetPlantCreate(
    BuildContext context,
    Function callback,
    PlantList plantList,
    CollectionReference itemsRef,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Hinzufügen:",
                            style: TextStyle(fontSize: 18),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final isValid = formKey.currentState!.validate();
                              if (isValid) {
                                formKey.currentState!.save();
                                Plant newPlant = Plant(
                                    name: name,
                                    species: species,
                                    waterInterval: waterInterval,
                                    lastWatering: lastWatering,
                                    roomName: roomName,
                                    fertilising: Fertilising(
                                        fertiliserInterval: fertiliserInterval,
                                        lastFertilising: lastFertilising),
                                    notes: notes);
                                //  Neue Pflanze wird beim Klick auf Speichern der Pflanzenliste und der Datenbank hinzugefügt
                                plantList.add(newPlant);
                                itemsRef.add(newPlant.toJson()).then((doc) =>
                                    print(
                                        'Added a new plant with id = ${doc.id}'));
                                // callback();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              "Speichern",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                          initialValue: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Name",
                            icon: Icon(RpgAwesome.wooden_sign),
                          ),
                          onSaved: (String? value) => name = value!,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            return (value == null || value.isEmpty)
                                ? 'Darf nicht leer sein'
                                : null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                          initialValue: species,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Spezies",
                            icon: Icon(RpgAwesome.flowers),
                          ),
                          onSaved: (String? value) => species = value!,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            return (value == null || value.isEmpty)
                                ? 'Darf nicht leer sein'
                                : null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                          initialValue: roomName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Zimmer",
                            icon: Icon(FontAwesome5.house_user),
                          ),
                          onSaved: (String? value) => roomName = value!,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            return (value == null || value.isEmpty)
                                ? 'Darf nicht leer sein'
                                : null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          initialValue: waterInterval.toString(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Gieß-Interwall in Tagen",
                            icon: Icon(Entypo.droplet),
                          ),
                          onSaved: (String? value) {
                            waterInterval = int.parse(value!);
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            return (value == null || value.isEmpty)
                                ? 'Darf nicht leer sein'
                                : null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          pickDate(context, lastWatering, true);
                        },
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            enabled: false,
                            controller: _dateController
                              ..text =
                                  "${lastWatering.day}.${lastWatering.month}.${lastWatering.year}",
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Zuletzt gegossen",
                              icon: Icon(Entypo.back_in_time),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              return (value == null || value.isEmpty)
                                  ? 'Darf nicht leer sein'
                                  : null;
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          initialValue: fertiliserInterval.toString(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Düngen-Interwall in Tagen",
                            icon: Icon(Entypo.leaf),
                          ),
                          onSaved: (String? value) {
                            fertiliserInterval = int.parse(value!);
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            return (value == null || value.isEmpty)
                                ? 'Darf nicht leer sein'
                                : null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          pickDate(context, lastWatering, false);
                        },
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            enabled: false,
                            controller: _dateController
                              ..text =
                                  "${lastFertilising.day}.${lastFertilising.month}.${lastFertilising.year}",
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Zuletzt gedüngt",
                              icon: Icon(Entypo.back_in_time),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              return (value == null || value.isEmpty)
                                  ? 'Darf nicht leer sein'
                                  : null;
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future pickDate(BuildContext context, DateTime initialDate,
      bool waterOrFertilisie) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );

    if (newDate == null) return;
    //Todo Dateformater verwenden
    _dateController.text = "${newDate.day}.${newDate.month}.${newDate.year}";
    waterOrFertilisie ? lastWatering = newDate : lastWatering = newDate;
  }
}
