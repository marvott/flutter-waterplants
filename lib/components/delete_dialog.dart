import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_application_1/models/plant_list.dart';

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
                itemsRef
                    .doc(id)
                    .delete()
                    .then((_) => print('Deleted plant with id = $id'));
                Navigator.pop(context);
              },
              child: const Text('Pflanze begraben'),
            ),
            SimpleDialogOption(
              onPressed: () {
                plantList.remove(index);
                itemsRef
                    .doc(id)
                    .delete()
                    .then((_) => print('Deleted plant with id = $id'));
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
