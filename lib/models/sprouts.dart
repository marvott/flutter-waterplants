import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Class of Sprouts
class SproutItems {
  late String id;
  String name;
  int keimdauer;

  SproutItems(this.name, this.keimdauer);

  SproutItems.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        keimdauer = json['Keimdauer (Tage)'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'Keimdauer (Tage)': keimdauer,
      };

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
}

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

//Adds a new Item to the Collection

