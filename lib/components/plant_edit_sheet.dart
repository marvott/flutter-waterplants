import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

import '../models/plant.dart';

showBottomSheetPlantEdit(
  BuildContext context,
  Plant plant,
  Function callback,
  Function plantOverviewCallback,
) {
  final formKeyPlantedit = GlobalKey<FormState>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: formKeyPlantedit,
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
                            final isValid =
                                formKeyPlantedit.currentState!.validate();
                            if (isValid) {
                              formKeyPlantedit.currentState!.save();
                              callback();
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
                        initialValue: plant.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name",
                          icon: Icon(RpgAwesome.wooden_sign),
                        ),
                        onSaved: (String? value) => plant.setName = value!,
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
                        initialValue: plant.species,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Spezies",
                          icon: Icon(RpgAwesome.flowers),
                        ),
                        onSaved: (String? value) => plant.setSpecies = value!,
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
                        initialValue: plant.roomName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Zimmer",
                          icon: Icon(FontAwesome5.house_user),
                        ),
                        onSaved: (String? value) => plant.setRoomName = value!,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'Darf nicht leer sein'
                              : null;
                        }),
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
