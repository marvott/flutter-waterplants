import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Class of Sprouts
class SproutItems {
  late String id;
  String name;
  late int keimdauer;
  int wieoftgegossen = 2;

  SproutItems(this.name, this.keimdauer);

  SproutItems.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        keimdauer = json['Keimdauer'],
        wieoftgegossen = json['wie oft gegossen'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'Keimdauer': keimdauer,
        'wie oft gegossen': wieoftgegossen,
      };

  //Add Items
  static _addItem(CollectionReference itemsRef, String name, int keimdauer) {
    final item = SproutItems(name, keimdauer);
    itemsRef
        .add(item.toJson())
        .then((doc) => print('Added a new item with id = ${doc.id}'));
  }

  //Deletes Item
  static deleteItem(CollectionReference itemsRef, String id) {
    itemsRef.doc(id).delete().then((_) => print('Deleted item with id = $id'));
  }

  static updateGegossen(
      CollectionReference itemsRef, String id, int anzahlgegossen) {
    if (anzahlgegossen > 0) {
      anzahlgegossen--;
      itemsRef.doc(id).update({'wie oft gegossen': anzahlgegossen});
    }
  }
}

//User can choose which Sprout he/she wants
class SproutDialog {
  static void showSimpleDialog(
      BuildContext context, CollectionReference itemsRef, Function callback) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleDialog(
                title: Text("Wähle deine Sprosse:"),
                children: <Widget>[
                  SimpleDialogOption(
                      child: const Text("Alfalfa"),
                      onPressed: () {
                        SproutItems._addItem(itemsRef, 'Alfalfa', 7);
                        callback();
                        Navigator.pop(context);
                      }),
                  SimpleDialogOption(
                      child: const Text("Brokkoli"),
                      onPressed: () {
                        SproutItems._addItem(itemsRef, 'Brokkoli', 4);
                        callback();
                        Navigator.pop(context);
                      }),
                  SimpleDialogOption(
                      child: const Text("Linsen"),
                      onPressed: () {
                        SproutItems._addItem(itemsRef, 'Linsen', 4);
                        callback();
                        Navigator.pop(context);
                      }),
                  SimpleDialogOption(
                      child: const Text("Mungobohne"),
                      onPressed: () {
                        SproutItems._addItem(itemsRef, 'Mungobohne', 4);
                        callback();
                        Navigator.pop(context);
                      }),
                ],
              ),
            ],
          );
        });
  }
}
