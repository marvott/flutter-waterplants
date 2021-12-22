import 'package:flutter/material.dart';

import 'package:fluttericon/entypo_icons.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/sprouts.dart';

class SprossenScreen extends StatefulWidget {
  const SprossenScreen({Key? key}) : super(key: key);

  @override
  State<SprossenScreen> createState() => _SprossenScreenState();
}

class _SprossenScreenState extends State<SprossenScreen> {
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
                        children: _listTiles(context, itemsRef, items)),
                  );
                },
              ),
            )),
          ],
        ),
      ),
      //Button for adding new Sprouts
      floatingActionButton: FloatingActionButton(
          onPressed: () => SproutDialog.showSimpleDialog(context, itemsRef),
          child: const Icon(Icons.add)),
    );
  }
}

//Lists the items of 'Sprouts' as a Listview
_listTiles(BuildContext context, CollectionReference itemsRef,
    List<SproutItems> items) {
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
