import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/general.dart';
import 'package:flutter_application_1/models/plant.dart';

class PlantScreen extends StatefulWidget {
  final Function callback;
  final PlantProperties plantProperties;
  const PlantScreen({
    Key? key,
    required this.callback,
    required this.plantProperties,
  }) : super(key: key);

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  @override
  Widget build(BuildContext context) {
    //Elemente die in der Liestview sind
    final List<Widget> plantElements = [
      ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Image(
            image: widget.plantProperties.imagePath.isEmpty
                ? GeneralArguments.defaultPlantImg
                : FileImage(File(widget.plantProperties.imagePath)),
            height: 400,
            fit: BoxFit.fitWidth,
          )),
      Row(
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                  text: widget.plantProperties.name + '\n',
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                  children: <TextSpan>[
                    TextSpan(
                        text: widget.plantProperties.roomName,
                        style: const TextStyle(
                            fontSize: 20, color: Colors.white70))
                  ]),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
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
            child: Container(
              child: Text.rich(
                TextSpan(
                    text: 'Gießen\n',
                    style: const TextStyle(color: Colors.blue),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.plantProperties.waterInDays(),
                        style: const TextStyle(color: Colors.white),
                      )
                    ]),
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Colors.grey.shade700,
                border: Border.all(
                  width: 8,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          //TODO: sehr hässliche Abfrage, das geht schöner!
          widget.plantProperties.fertilising == null
              ? const SizedBox.shrink()
              : Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: const Text.rich(
                            TextSpan(
                                text: 'Düngen\n',
                                style: TextStyle(color: Colors.deepOrange),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'In 14 Tagen',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            color: Colors.grey.shade700,
                            border: Border.all(
                              width: 8,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
      Text.rich(
        TextSpan(
            text: 'Notizen\n',
            style: const TextStyle(color: Colors.indigo),
            children: <TextSpan>[
              TextSpan(
                text: widget.plantProperties.notes,
                style: const TextStyle(color: Colors.white),
              )
            ]),
      ),
    ];
    //Farben der Listview
    final List myColors = <Color>[
      Colors.transparent,
      Colors.grey.shade700,
      Colors.grey.shade700,
      Colors.grey.shade700,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Zierlicher Peter'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: plantElements.length,
        // ListView.separated muss mit dem itemBuilder gebaut werden
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: plantElements[index],
              // das Bild (Index 0) ist schon in einem abgerundeten Container
              decoration: index == 0 || index == 2
                  ? null
                  : BoxDecoration(
                      color: myColors[index],
                      border: Border.all(
                        width: 8,
                        color: Colors.transparent,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ));
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
                      widget.plantProperties.setImagePath = imagePath;
                      //TODO: Diese Zeile löschen, Fotografieren soll nicht den Namen ändern
                      widget.plantProperties.setName = "Fotografierter Peter";
                      widget.callback();
                    }));
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}
