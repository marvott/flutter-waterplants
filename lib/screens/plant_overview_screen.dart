import 'dart:io';
import 'package:flutter_application_1/components/snackbar_dialog.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'plant_screen.dart';
import '../models/plant_list.dart';
import '../models/plant.dart';
import '../models/general.dart';

class PlantOverview extends StatefulWidget {
  const PlantOverview({
    Key? key,
  }) : super(key: key);

  @override
  State<PlantOverview> createState() => _PlantOverviewState();
}

class _PlantOverviewState extends State<PlantOverview> {
  int _counter = 1;

  callback() {
    setState(() {});
  }

  void _incrementCounter() {
    _counter++;
  }

//Liste wird hier gespeichert
// Als Atribut dieser Klasse? -> dann muss das immer üpbergeben werden -> Ja passt, wir haben wenige screens -> geringster aufwand
// Indexed Stack mit Bottom-Bar!
//kann später auch von der DB direkt was reinkriegen
  PlantList plantList = PlantList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pflanzen'),
      ),

      // Inhalt der Pflanzen-Seite
      body: Padding(
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
                              )));
                },
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
                              plantList.getElemtByIndex(index).setLastWatering =
                                  DateTime.now();
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
                            if (plantList.getElemtByIndex(index) != null) {
                              String message =
                                  "${plantList.getElemtByIndex(index).name} wurde gedüngt";
                              Utils.showSnackBar(context,
                                  message: message, color: Colors.deepOrange);
                              plantList
                                  .getElemtByIndex(index)
                                  .fertilising!
                                  .setLastFertilising = DateTime.now();
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            //TODO: ändern, Dialog zum Hinzufügen öffnen
            plantList.add(Plant(
                name: "Zierlicher Peter " + _counter.toString(),
                species: "Zierpfeffer",
                roomName: "Schlafzimmer",
                waterInterval: 7,
                fertilising: Fertilising(
                    fertiliserInterval: 14,
                    lastFertilising: DateTime.utc(2021, 11, 16)),
                lastWatering: DateTime.utc(2021, 11, 16)));
            _incrementCounter();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
