// ignore_for_file: prefer_const_constructors
import 'package:intl/intl.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class SprossenRoute extends StatefulWidget {
  const SprossenRoute({Key? key}) : super(key: key);

  @override
  State<SprossenRoute> createState() => _SprossenRouteState();
}

class _SprossenRouteState extends State<SprossenRoute> {
  //Variables
  double fontsize = 16;

  @override
  Widget build(BuildContext context) {
    CollectionReference itemsRef =
        FirebaseFirestore.instance.collection('sprossen');
    Query query = itemsRef.orderBy('name');
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
                    return Center(child: CircularProgressIndicator());
                  }
                  List<Item> items = snapshot.data!.docs
                      .map((doc) => Item.fromJson(
                          (doc.data() as Map<String, dynamic>)
                            ..['id'] = doc.id))
                      .toList();
                  return ListView(children: _listTiles(itemsRef, items));
                }),
          )),
          ElevatedButton(
              onPressed: () => _addItem(itemsRef), child: Icon(Icons.add)),

          //
        ],
      )),
    );
  }
}

//Versuch einzelne Werte zu bekommen -> Noch behalten und ausprobieren. Am Ende löschen
Future<Object?> getFirestoreValues() async {
  CollectionReference collRef = firestore.collection('sprossen');
  //DocumentReference docRef = collRef.doc('Alfalfa');
  var docSnapshot = await collRef.doc('Alfalfa').get();
  var test = await collRef.doc('Alfalfa').snapshots();
  print(test);

  Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
  // You can then retrieve the value from the Map like this:
  var value = data?['Keimdauer'];
  print("value: " + value);

  QuerySnapshot query = await collRef.get();
  List sprossenlist = [];
  query.docs.forEach((document) => sprossenlist.add(document.data()));
  //print("Liste " + sprossenlist[0].toString());
  print(sprossenlist);

  return sprossenlist;
}

List<Widget>? itemsStreamBuilder() {
  CollectionReference itemsRef =
      FirebaseFirestore.instance.collection('sprossen');
  Query query = itemsRef.orderBy('name');
  StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (BuildContext context, var snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        List<Item> items = snapshot.data!.docs
            .map((doc) => Item.fromJson(
                (doc.data() as Map<String, dynamic>)..['id'] = doc.id))
            .toList();
        return ListView(children: _listTiles(itemsRef, items));
      });
}

_addItem(CollectionReference itemsRef) {
  final name = "test";
  final keimdauer = '4';

  final item = Item(name, keimdauer);
  itemsRef
      .add(item.toJson())
      .then((doc) => print('Added a new item with id = ${doc.id}'));
}

_deleteItem(CollectionReference itemsRef, String id) {
  itemsRef.doc(id).delete().then((_) => print('Deleted item with id = $id'));
}

_listTiles(CollectionReference itemsRef, List<Item> items) {
  return items
      .map((i) => ListTile(
          title: Text(i.name,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
          subtitle: Text("Keimdauer (Tage):" + i.keimdauer),
          leading: Container(width: 40, height: 40, color: Colors.blue),
          trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteItem(itemsRef, i.id))))
      .toList();
}

class Item {
  late String id;
  String name;
  String keimdauer;
  //Color color;
  //DateTime created = DateTime.now();

  Item(this.name, this.keimdauer);

  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        keimdauer = json['Keimdauer (Tage)'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'Keimdauer (Tage)': keimdauer};
}












/*
* ALTE IDEEN ABER ERSTMAL NOCH ALS BACKUP UND REFERENZ
*
//First Row from Table = Header
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text.rich(TextSpan(
                      text: 'Saaten',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
                  Text.rich(TextSpan(
                      text: 'Menge',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
                  Text.rich(TextSpan(
                      text: 'Keimdauer',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)))
                ],
              )),
ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigate back to first route when tapped.
                },
                child: Text('Go back!'),
              ),*//*
              Expanded(
                  child: CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          
                          child: const Text(
                              "1. Schritt: Sprossen 4-12h einweichen"),
                          color: Colors.green[10],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('3-4 Tage dunkel lagern'),
                          color: Colors.green[100],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Jeden Tag 1-2x mit Wasser spülen'),
                          color: Colors.green[300],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                              'Danach 3 Tage in indirektes Licht stellen'),
                          color: Colors.green[500],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                              'Dann sind die Sprossen 3-4cm lang. Guten!'),
                          color: Colors.green[700],
                        ),
                      ],
                    ),
                  ),
                ],
              ))*/