import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/plant_list.dart';

// Dialog zum löschen von Pflanzen
// Begraben und löschen haben die selbe Funktion
class Dialogs {
  static void showSimpleDialog(
    BuildContext context,
    PlantList plantList,
    int index,
    CollectionReference itemsRef,
  ) {
    String id = plantList.getElemtByIndex(index).id;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(plantList.getElemtByIndex(index).name),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                plantList.remove(index);
                itemsRef.doc(id).delete();
                Navigator.pop(context);
              },
              child: const Text('Pflanze begraben'),
            ),
            SimpleDialogOption(
              onPressed: () {
                plantList.remove(index);
                itemsRef.doc(id).delete();
                Navigator.pop(context);
              },
              child: const Text('Pflanze löschen'),
            ),
          ],
        );
      },
    );
  }
}
