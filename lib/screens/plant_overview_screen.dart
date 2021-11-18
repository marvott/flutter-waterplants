import 'dart:io';
import 'package:fluttericon/entypo_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'plant_screen.dart';
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
  callback() {
    setState(() {});
  }

  int _counter = 2;

  void _incrementCounter() {
    _counter++;
  }

// TODO: Wo speicher ich diese Liste am Besten damit sie beim Routenwechsel erhalten bleibt?
// statische Variable in einer Klasse?
// Als Atribut dieser Klasse? -> dann muss das immer üpbergeben werden -> anstrengend
// Provider Package da empfohlen!
  List<PlantProperties> plantList = [
    PlantProperties(
        name: "Zierlicher Peter",
        species: "Zierpfeffer",
        roomName: "Schlafzimmer",
        waterInterval: 7,
        lastWatering: DateTime.utc(2021, 11, 18),
        notes:
            "Muss regelmäßig von Staub befreit und alle paar Tage gedreht werden"),
    PlantProperties(
        name: "Gedüngter Peter",
        species: "Zierpfeffer",
        roomName: "Schlafzimmer",
        waterInterval: 7,
        lastWatering: DateTime.utc(2021, 11, 10),
        fertilising: Fertilising(
            fertiliserInterval: 14,
            lastFertilising: DateTime.utc(2021, 11, 18))),
  ];

  @override
  Widget build(BuildContext context) {
    // map mit name, imag und onPressedFunction

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
            itemCount: plantList.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlantScreen(
                                callback: callback,
                                plantProperties: plantList[index],
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
                              image: plantList[index].imagePath.isEmpty
                                  ? GeneralArguments.defaultPlantImg
                                  : FileImage(File(plantList[index].imagePath)),
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
                            plantList[index].name,
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
                            onPressed: () {},
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
                          onPressed: () {},
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
            plantList.add(PlantProperties(
                name: "Zierlicher Peter " + _counter.toString(),
                species: "Zierpfeffer",
                waterInterval: 7,
                lastWatering: DateTime.utc(2021, 11, 16)));
            _incrementCounter();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
