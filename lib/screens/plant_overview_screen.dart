import 'dart:io';
import 'dart:core';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fluttericon/entypo_icons.dart';

import 'package:flutter_application_1/components/delete_dialog.dart';
import 'package:flutter_application_1/components/plant_create_sheet.dart';
import 'package:flutter_application_1/components/snackbar_dialog.dart';
import '../models/plant_list.dart';
import '../models/plant.dart';
import '../models/general.dart';
import 'plant_screen.dart';

class PlantOverview extends StatefulWidget {
  const PlantOverview({
    Key? key,
  }) : super(key: key);

  @override
  State<PlantOverview> createState() => _PlantOverviewState();
}

class _PlantOverviewState extends State<PlantOverview> {
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

  PlantList plantList = PlantList();

  @override
  Widget build(BuildContext context) {
    //Gets the 'users' and the email that is logged in and their list of 'Sprossen'
    CollectionReference itemsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email.toString())
        .collection('pflanzen');

    //Orders items by Name
    Query query = itemsRef.orderBy('lastWatering');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pflanzen'),
      ),

      // Inhalt der Pflanzen-Seite
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: StreamBuilder<QuerySnapshot>(
          stream: query.snapshots(),
          builder: (BuildContext context, var snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            }
            List<Plant> items = snapshot.data!.docs
                .map((doc) => Plant.fromJson(
                    (doc.data() as Map<String, dynamic>)..['id'] = doc.id))
                .toList();
            plantList.construct(items);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemCount: plantList.lenght(),
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlantScreen(
                                      plantOverviewCallback: callback,
                                      plant: plantList.getElemtByIndex(index),
                                      itemsRef: itemsRef,
                                    )));
                      },
                      onLongPress: () => Dialogs.showSimpleDialog(
                          context, plantList, index, itemsRef),
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8)),
                                  child: Image(
                                    image: plantList
                                            .getElemtByIndex(index)
                                            .imagePath
                                            .isEmpty
                                        ? GeneralArguments.defaultPlantImg
                                        : FileImage(File(plantList
                                            .getElemtByIndex(index)
                                            .imagePath)),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade700,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    )),
                                child: Text(
                                  plantList.getElemtByIndex(index).name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    String message =
                                        "${plantList.getElemtByIndex(index).name} wurde gegossen";
                                    Utils.showSnackBar(context,
                                        message: message, color: Colors.blue);
                                    plantList
                                        .getElemtByIndex(index)
                                        .setLastWatering = DateTime.now();
                                    itemsRef
                                        .doc(
                                            plantList.getElemtByIndex(index).id)
                                        .update({
                                      'lastWatering': DateTime.now()
                                    }).then((doc) =>
                                            print('updated lastWatering'));
                                    //setState könnte später nötig werden
                                  },
                                  child: const Icon(
                                    Entypo.droplet,
                                    size: 20,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(10),
                                    primary: Colors.blue,
                                    minimumSize: Size.zero,
                                  )),
                              ElevatedButton(
                                onPressed: () {
                                  if (plantList.getElemtByIndex(index) !=
                                      null) {
                                    String message =
                                        "${plantList.getElemtByIndex(index).name} wurde gedüngt";
                                    Utils.showSnackBar(context,
                                        message: message,
                                        color: Colors.deepOrange);
                                    plantList
                                        .getElemtByIndex(index)
                                        .fertilising!
                                        .setLastFertilising = DateTime.now();
                                    itemsRef
                                        .doc(
                                            plantList.getElemtByIndex(index).id)
                                        .update({
                                      'lastFertilising': DateTime.now()
                                    }).then((doc) =>
                                            print('updated lastFertilising'));
                                    //setState könnte später vlt nötig werden
                                  }
                                },
                                child: const Icon(
                                  Entypo.leaf,
                                  size: 20,
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(10),
                                  primary: Colors.deepOrange,
                                  minimumSize: Size.zero,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "addPlants",
        onPressed: () {
          PlantCreateSheet().showBottomSheetPlantCreate(
              context, callback, plantList, itemsRef);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
