import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

import '../models/plant.dart';

//waterOrFertilize == true bedeutet Water, false ist Düngen
//TODO: icons je nach wasser oder dünger anpassen, siehe Ende des Files
class WaterFertilizeSheet {
  BuildContext? context;
  Plant? plant;
  bool? waterOrFertilize;
  Function? callback;
  Function? plantOverviewCallback;
  DateTime? pickedDate;
  String? initialIntervalValue;
  String? intervalLabel;

  final formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  void showBottomSheetWaterOrFertilize(
    BuildContext context,
    Plant plant,
    bool waterOrFertilize,
    Function callback,
    Function plantOverviewCallback,
  ) {
    DateTime initialLastDate;
    String initialLastDateFormatted;
    String lastLabel;
    Icon intervalIcon;

    if (waterOrFertilize) {
      initialIntervalValue = "${plant.waterInterval}";
      intervalLabel = "Gieß-Interwall in Tagen";
      initialLastDate = plant.lastWatering;
      initialLastDateFormatted =
          "${plant.lastWatering.day}.${plant.lastWatering.month}.${plant.lastWatering.year}";
      lastLabel = "Zuletzt gegossen";
      intervalIcon = const Icon(Entypo.droplet);
    } else {
      initialIntervalValue = "${plant.fertilising!.fertiliserInterval}";
      intervalLabel = "Düngen-Interwall in Tagen";
      initialLastDate = plant.fertilising!.lastFertilising;
      initialLastDateFormatted =
          "${plant.fertilising!.lastFertilising.day}.${plant.fertilising!.lastFertilising.month}.${plant.fertilising!.lastFertilising.year}";
      lastLabel = "Zuletzt gedüngt";
      //TODO: passendes Icon für Düngen finden
      intervalIcon = const Icon(Entypo.leaf);
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Form(
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
                          "Bearbeiten:",
                          style: TextStyle(fontSize: 18),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final isValid = formKey.currentState!.validate();
                            if (isValid) {
                              formKey.currentState!.save();
                              callback();
                              plantOverviewCallback();
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
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        initialValue: initialIntervalValue,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: intervalLabel,
                          icon: intervalIcon,
                        ),
                        onSaved: (String? value) {
                          if (waterOrFertilize) {
                            plant.setWaterInterval = int.parse(value!);
                          } else {
                            plant.fertilising!.setFertiliserInterval =
                                int.parse(value!);
                          }
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
                        pickDate(context, initialLastDate, callback);
                      },
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          enabled: false,
                          controller: _dateController
                            ..text = initialLastDateFormatted,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: lastLabel,
                            icon: const Icon(Entypo.back_in_time),
                          ),
                          onSaved: (String? value) {
                            if (pickedDate != null) {
                              if (waterOrFertilize) {
                                plant.setLastWatering = pickedDate!;
                              } else {
                                plant.fertilising!.setLastFertilising =
                                    pickedDate!;
                              }
                              pickedDate = null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            return (value == null || value.isEmpty)
                                ? 'Darf nicht leer sein'
                                : null;
                          }),
                    ),
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future pickDate(
      BuildContext context, DateTime initialDate, Function callback) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );

    if (newDate == null) return;
    //Todo Dateformater verwenden
    _dateController.text = "${newDate.day}.${newDate.month}.${newDate.year}";
    pickedDate = newDate;
    callback();
  }
}
