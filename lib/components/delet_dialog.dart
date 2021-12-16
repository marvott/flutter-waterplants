import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/plant_list.dart';

class Dialogs {
  static void showSimpleDialog(BuildContext context, PlantList plantList,
          int index, Function callback) =>
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
                  Navigator.pop(context);
                },
                child: const Text('Pflanze begraben'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  callback();
                  plantList.remove(index);
                  Navigator.pop(context);
                },
                child: const Text('Pflanze löschen'),
              ),
            ],
          );
        },
      );
}
