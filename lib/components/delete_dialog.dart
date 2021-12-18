import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_application_1/models/plant_list.dart';

//TODO: Beheben: "Exception caught by widgets library Incorrect use of ParentDataWidget. "
class Dialogs {
  static void showSimpleDialog(
    BuildContext context,
    PlantList plantList,
    int index,
    Function callback,
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
                callback();
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
                callback();
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
