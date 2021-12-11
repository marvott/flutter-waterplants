// ignore_for_file: prefer_const_constructors

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
    //UI
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sprossen"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
          //Line to set Header apart from other Text
          const Divider(
            height: 5,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          //Second Row
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(TextSpan(
                      text: 'Saaten', style: TextStyle(fontSize: fontsize))),
                  Text.rich(TextSpan(
                      text: 'Menge', style: TextStyle(fontSize: fontsize))),
                  Text.rich(TextSpan(
                      text: 'Keimdauer', style: TextStyle(fontSize: fontsize)))
                ],
              )),
          FloatingActionButton(
              child: Text('Klick'), onPressed: () => getFirestoreValues()),
        ],
      )),
    );
  }
}

Future<Object> getFirestoreValues() async {
  CollectionReference collRef = firestore.collection('sprossen');
  //DocumentReference docRef = collRef.doc('Alfalfa');
  var docSnapshot = await collRef.doc('Alfalfa').get();
  var test = await collRef.doc('Alfalfa').snapshots();
  print(test);

  print("Teiler\n");
  Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
  // You can then retrieve the value from the Map like this:
  var value = data?['Keimdauer'];
  print(value);

  QuerySnapshot query = await collRef.get();
  List sprossenlist = [];
  query.docs.forEach((doc) => sprossenlist.add(doc.data()));

  //print("Liste " + sprossenlist[0].toString());
  //print(sprossenlist);
  streamding();
  return sprossenlist;
}

Widget streamding() {
  return StreamBuilder(
      stream: firestore.collection('sprossen').doc('Alfalfa').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        print(userDocument);
        return Text(userDocument.toString());
      });
}


/*ElevatedButton(
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