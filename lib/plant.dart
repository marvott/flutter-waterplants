import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/general_arguments.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({Key? key}) : super(key: key);

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO: entries und myColor noch vor build plazieren,
    // Für Hotreload funktioniert das im build aber besser

    //Elemente die in der Liestview sind
    final List<Widget> plantElements = [
      ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Image(
            // image: FileImage(File(GeneralArguments.imagePath)),
            image: GeneralArguments.imagePath.isEmpty
                ? GeneralArguments.defaultPlantImg
                : FileImage(File(GeneralArguments.imagePath)),
            height: 400,
            fit: BoxFit.fitWidth,
          )),
      Row(
        children: [
          const Expanded(
            child: Text.rich(
              TextSpan(
                  text: 'Zierpfeffer\n',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Zimmer',
                        style: TextStyle(fontSize: 20, color: Colors.white70))
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
              child: const Text.rich(
                TextSpan(
                    text: 'Gießen\n',
                    style: TextStyle(color: Colors.blue),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'In 5 Tagen',
                        style: TextStyle(color: Colors.white),
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
                borderRadius: const BorderRadius.all(Radius.circular(8)),
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
      const Text.rich(
        TextSpan(
            text: 'Notizen\n',
            style: TextStyle(color: Colors.indigo),
            children: <TextSpan>[
              TextSpan(
                text:
                    'Muss regelmäßig von Staub befreit werden und alle paar Tage gedreht werden',
                style: TextStyle(color: Colors.white),
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
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: myColors[index],
                      border: Border.all(
                        width: 8,
                        color: Colors.transparent,
                      ),
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
            Navigator.pushNamed(context, '/camera')
                .then((_) => setState(() {}));
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}
