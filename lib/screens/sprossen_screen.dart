import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/sprouts.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/sprouts.dart';

class SprossenRoute extends StatefulWidget {
  const SprossenRoute({Key? key}) : super(key: key);

  @override
  State<SprossenRoute> createState() => _SprossenRouteState();
}

class _SprossenRouteState extends State<SprossenRoute> {
  //Variables
  double fontsize = 16;

  //Init firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    //Listens for Changes in Authentification State -> Other user logs in
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {});
    });
  }

  callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //Gets the 'users' and the email that is logged in and their list of 'Sprossen'
    CollectionReference itemsRef = firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email.toString())
        .collection('sprossen');

    //Orders items by Name
    Query query = itemsRef.orderBy('name');

/*
TODO1
showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(

1. hardgecodete liste von sprossen mit keimdauer
2. showDialog wenn man auf + button klickt (von david abschauen)

Der nutzer kann mit + seine eigenen sprossen aus der fixen sprossenliste hinzufügen

TODO2:

Der nutzer bekommt erinnerungen wenn gegossen und wasser gewechselt werden muss -> video ehlers

TODO3:
Teste -> video von ehlers

*/

    //UI
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sprossen"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: SizedBox(
            child: StreamBuilder<QuerySnapshot>(
              stream: query.snapshots(),
              builder: (BuildContext context, var snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<SproutItems> items = snapshot.data!.docs
                    .map((doc) => SproutItems.fromJson(
                        (doc.data() as Map<String, dynamic>)..['id'] = doc.id))
                    .toList();
                return ListView(children: _listTiles(itemsRef, items));
              },
            ),
          )),
          FloatingActionButton(
              onPressed: () =>
                  SproutDialog.showSimpleDialog(context, itemsRef, callback),
              child: const Icon(Icons.add)),
        ],
      )),
    );
  }
}

//Lists the items of 'Sprouts' as a Listview
_listTiles(CollectionReference itemsRef, List<SproutItems> items) {
  return items
      .map((i) => ListTile(
          title: Text(i.name,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
          subtitle: Text("Keimdauer (Tage):" + i.keimdauer.toString()),
          leading: Container(width: 40, height: 40, color: Colors.blue),
          trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteItem(itemsRef, i.id))))
      .toList();
}

//Adds a new Item to the Collection
_addItem(CollectionReference itemsRef, String name, int keimdauer) {
  final item = SproutItems(name, keimdauer);
  itemsRef
      .add(item.toJson())
      .then((doc) => print('Added a new item with id = ${doc.id}'));
}

//Deletes Item
_deleteItem(CollectionReference itemsRef, String id) {
  itemsRef.doc(id).delete().then((_) => print('Deleted item with id = $id'));
}

class SproutDialog {
  static void showSimpleDialog(
      BuildContext context, CollectionReference itemsRef, Function callback) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Which Sprouts do you want to grow?"),
            children: <Widget>[
              SimpleDialogOption(
                  child: const Text("Alfalfa"),
                  onPressed: () {
                    _addItem(itemsRef, 'Alfalfa', 7);
                    callback();
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                  child: const Text("Brokkoli"),
                  onPressed: () {
                    _addItem(itemsRef, 'Brokkoli', 4);
                    callback();
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
}
