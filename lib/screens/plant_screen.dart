import 'dart:io';
import 'dart:core';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fluttericon/entypo_icons.dart';

import 'package:flutter_application_1/components/notes_sheet.dart';
import 'package:flutter_application_1/components/plant_edit_sheet.dart';
import 'package:flutter_application_1/components/water_fertilize_sheet.dart';
import 'package:flutter_application_1/components/snackbar_dialog.dart';
import 'package:flutter_application_1/models/general.dart';
import 'package:flutter_application_1/models/plant.dart';

class PlantScreen extends StatefulWidget {
  final Function plantOverviewCallback;
  final Plant plant;
  final CollectionReference itemsRef;
  const PlantScreen({
    Key? key,
    required this.plantOverviewCallback,
    required this.plant,
    required this.itemsRef,
  }) : super(key: key);

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  //Farben der Listview, gehe sicher dass es die RICHTIGE LÄNGE HAT!
  final List myColors = <Color>[
    Colors.transparent,
    Colors.grey.shade700,
    Colors.grey.shade700,
    Colors.grey.shade700,
  ];

  DateTime? pickedDate;

  callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plant.name),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: myColors.length,
        // ListView.separated muss mit dem itemBuilder gebaut werden
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: buildPlantScreenElements(context, index),
            // das Bild (Index 0) ist schon in einem abgerundeten Container
            decoration: index == 1
                ? BoxDecoration(
                    color: myColors[index],
                    border: Border.all(
                      width: 8,
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  )
                : null,
          );
        },
        // Der Abstand zw. den Listenelementen
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.transparent,
          height: 10,
        ),
      ),
      // Foto der Pflanze ändern
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (GeneralArguments.cameraName != 'fake') {
            // damit das Foto direkt angezeigt wird, werden alle betroffenen Widgets neu gerendert
            Navigator.pushNamed(context, '/camera')
                .then((imagePath) => setState(() {
                      widget.plant.setImagePath = imagePath;
                      widget.plantOverviewCallback();
                    }));
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }

  Widget buildPlantScreenElements(BuildContext context, int index) => <Widget>[
        //Elemente die in der Liestview sind
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Image(
              image: widget.plant.imagePath.isEmpty
                  ? GeneralArguments.defaultPlantImg
                  : FileImage(File(widget.plant.imagePath)),
              height: 400,
              fit: BoxFit.fitWidth,
            )),
        Row(
          children: [
            Expanded(
              //Ändern in eine colum mit 2 Text Feldern um maxline anzuwenden
              child: Text.rich(
                TextSpan(
                    text: widget.plant.name + '\n',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      overflow: TextOverflow.ellipsis,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.plant.roomName,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white70))
                    ]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // showBottomSheetPlantEdit(context);
                showBottomSheetPlantEdit(context, widget.plant, callback,
                    widget.plantOverviewCallback, widget.itemsRef);
              },
              child: const Icon(Icons.edit),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Colors.grey.shade700,
                type: MaterialType.button,
                child: InkWell(
                  onTap: () {
                    WaterFertilizeSheet().showBottomSheetWaterOrFertilize(
                        context, widget.plant, true, callback, widget.itemsRef);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                              text: 'Gießen\n',
                              style: const TextStyle(color: Colors.blue),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.plant.waterInDays(),
                                  style: const TextStyle(color: Colors.white),
                                )
                              ]),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              String message =
                                  "${widget.plant.name} wurde gegossen";
                              Utils.showSnackBar(context,
                                  message: message, color: Colors.blue);
                              widget.plant.setLastWatering = DateTime.now();
                              widget.itemsRef.doc(widget.plant.id).update({
                                'lastWatering': DateTime.now()
                              }).then((doc) => print('updated lastWatering'));
                              setState(() {
                                widget.plantOverviewCallback;
                              });
                            },
                            child: const Icon(
                              Entypo.droplet,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(15),
                              primary: Colors.blue,
                              minimumSize: Size.zero,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Colors.grey.shade700,
                type: MaterialType.button,
                child: InkWell(
                  onTap: () {
                    WaterFertilizeSheet().showBottomSheetWaterOrFertilize(
                      context,
                      widget.plant,
                      false,
                      callback,
                      widget.itemsRef,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                              text: 'Düngen\n',
                              style: const TextStyle(color: Colors.deepOrange),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.plant.fertiliseInDays(),
                                  style: const TextStyle(color: Colors.white),
                                )
                              ]),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              String message =
                                  "${widget.plant.name} wurde gedüngt";
                              Utils.showSnackBar(context,
                                  message: message, color: Colors.deepOrange);
                              widget.plant.fertilising!.setLastFertilising =
                                  DateTime.now();
                              widget.itemsRef.doc(widget.plant.id).update({
                                'lastFertilising': DateTime.now()
                              }).then(
                                  (doc) => print('updated lastFertilising'));
                              setState(() {
                                widget.plantOverviewCallback;
                              });
                            },
                            child: const Icon(
                              Entypo.leaf,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(15),
                              primary: Colors.deepOrange,
                              minimumSize: Size.zero,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        //TODO farbe ändern
        Material(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.grey.shade700,
          type: MaterialType.button,
          child: InkWell(
            onTap: () {
              NotesSheet().showBottomSheet(
                context,
                widget.plant,
                callback,
                widget.itemsRef,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(
                    text: 'Notizen\n',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.plant.notes,
                        style: const TextStyle(color: Colors.white),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ][index];
}
