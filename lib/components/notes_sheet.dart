import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

import '../models/plant.dart';

//waterOrFertilize == true bedeutet Water, false ist Düngen
//TODO: icons je nach wasser oder dünger anpassen, siehe Ende des Files
class NotesSheet {
  BuildContext? context;
  Plant? plant;
  String? notesText;
  Function? callback;

  final formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  void showBottomSheet(
    BuildContext context,
    Plant plant,
    Function callback,
  ) {
    String initialnotesText = plant.notes;

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
                      minLines: 3,
                      maxLines: 10,
                      // keyboardType: TextInputType.text,
                      initialValue: initialnotesText,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Notizen:",
                      ),
                      onSaved: (String? value) {
                        if (value != null) {
                          value = value.trim();
                        }
                        plant.setNotes = value!;
                      },
                      autovalidateMode: AutovalidateMode.disabled,
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
}
