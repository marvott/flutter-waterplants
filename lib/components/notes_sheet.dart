import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/plant.dart';

class NotesSheet {
  BuildContext? context;
  Plant? plant;
  String? notesText;
  Function? callback;

  final formKey = GlobalKey<FormState>();

  void showBottomSheet(
    BuildContext context,
    Plant plant,
    Function callback,
    CollectionReference itemsRef,
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
                        itemsRef.doc(plant.id).update({'notes': value}).then(
                            (doc) => print('updated notes'));
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
