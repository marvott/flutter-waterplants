import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fluttericon/entypo_icons.dart';

import '../components/notes_sheet.dart';
import '../components/plant_edit_sheet.dart';
import '../components/water_fertilize_sheet.dart';
import '../components/snackbar_dialog.dart';
import '../components/get_image.dart';
import '../models/general.dart';
import '../models/plant.dart';

class PlantScreen extends StatefulWidget {
  final Plant plant;
  final CollectionReference itemsRef;
  const PlantScreen({
    Key? key,
    required this.plant,
    required this.itemsRef,
  }) : super(key: key);

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  //Farben der Listview, gehe sicher dass es die RICHTIGE LÄNGE HAT!

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
        itemCount: 4,
        // ListView.separated muss mit dem itemBuilder gebaut werden
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: buildPlantScreenElements(context, index),
            // nur das 2. Element brauch den decorator
            decoration: index == 1
                ? BoxDecoration(
                    color: Colors.grey.shade700,
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
        heroTag: "addPicture",
        onPressed: () {
          // Abfrage für den iOS Simulator, dieser stellt keine Kamerafunktion zur verfügung
          if (IosSimulatorCameraHandler.cameraName != 'fake') {
            Navigator.pushNamed(context, '/camera')
                .then((imagePath) => setState(() {
                      widget.plant.setImagePath = imagePath;
                      widget.itemsRef
                          .doc(widget.plant.id)
                          .update({'imagePath': imagePath});
                    }));
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }

  //Elemente die mit dem Liestview-Builder gebaut werden
  Widget buildPlantScreenElements(BuildContext context, int index) => <Widget>[
        // Pflanzenbild
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Image(
              image: getImage(widget.plant.imagePath),
              height: 400,
              fit: BoxFit.fitWidth,
            )),
        Row(
          // Pflanzenname u -zimmer
          children: [
            Expanded(
              //TODO: Ändern in eine colum mit 2 Text Feldern um maxline anzuwenden
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
            // Button zum änder des Namens/ Zimmer / Spezies
            ElevatedButton(
              onPressed: () {
                showBottomSheetPlantEdit(
                    context, widget.plant, callback, widget.itemsRef);
              },
              child: const Icon(Icons.edit),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),
            )
          ],
        ),
        // Gießen und Düngen
        Row(
          children: <Widget>[
            Expanded(
              //Infos zum Gießen
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
                        // Button zum gießen
                        ElevatedButton(
                            onPressed: () {
                              String message =
                                  "${widget.plant.name} wurde gegossen";
                              Utils.showSnackBar(context,
                                  message: message, color: Colors.blue);
                              widget.plant.setLastWatering = DateTime.now();
                              widget.itemsRef
                                  .doc(widget.plant.id)
                                  .update({'lastWatering': DateTime.now()});
                              setState(() {});
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
              //Infos zum Düngen
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
                        // Button zum gießen
                        ElevatedButton(
                            onPressed: () {
                              String message =
                                  "${widget.plant.name} wurde gedüngt";
                              Utils.showSnackBar(context,
                                  message: message, color: Colors.deepOrange);
                              widget.plant.fertilising!.setLastFertilising =
                                  DateTime.now();
                              widget.itemsRef
                                  .doc(widget.plant.id)
                                  .update({'lastFertilising': DateTime.now()});
                              setState(() {});
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
        // Notizen zur Pflanze
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
