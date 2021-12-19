import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/sprouts.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

    //UI
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sprossen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                          (doc.data() as Map<String, dynamic>)
                            ..['id'] = doc.id))
                      .toList();
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView(
                        children: _listTiles(context, itemsRef, items,callback)),
                  );
                },
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                    onPressed: () => SproutDialog.showSimpleDialog(
                        context, itemsRef, callback),
                    child: const Icon(Icons.add)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//TODO: wasser gießen funktion implementieren -> anzeige wie bei david
// Bilder in firebase hinterlegen
// Bugfix: Exception wenn man neuen User registriert -> sollte gefixt sein
//Was anzeigen, wenn kein user angemeldet und buttons ausblenden ->DAVID
//string is not a subtype of int wenn neuer user hinzugefügt wird
//snackbar beim settingsscreen ->David

//Lists the items of 'Sprouts' as a Listview
_listTiles(BuildContext context, CollectionReference itemsRef,
    List<SproutItems> items, Function callback) {
  return items
      .map((i) => ListTile(
            title: Text(i.name,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 22)),
            isThreeLine: true,
            subtitle: Text("Keimdauer: " +
                i.keimdauer.toString() +
                " Tage\n" +
                "Noch " +
                i.wieoftgegossen.toString() +
                "x gießen!"),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://images.unsplash.com/photo-1587334274328-64186a80aeee?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1762&q=80',
                height: 50.0,
                width: 50.0,
              ),
            ),
            onLongPress: () => _showDeleteDialog(context, itemsRef, i.id),
            trailing: ElevatedButton(
                child: const Icon(Entypo.droplet, size: 20),
                onPressed: () {
                  SproutItems.updateGegossen(itemsRef, i.id, i.wieoftgegossen);
                  callback();
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  primary: Colors.blue,
                  minimumSize: Size.zero,
                )),
          ))
      .toList();
}

//User can delete Sprout after a Long press on the ListTile
_showDeleteDialog(
    BuildContext context, CollectionReference itemsRef, String id) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SimpleDialog(
              children: <Widget>[
                SimpleDialogOption(
                    child: const Text("Sprosse entfernen"),
                    onPressed: () {
                      SproutItems.deleteItem(itemsRef, id);
                      Navigator.pop(context);
                    }),
              ],
            ),
          ],
        );
      });
}
