import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_application_1/main_screen.dart';

class PlantRoute extends StatefulWidget {
  final String imagePath;
  final String cameraName;

  const PlantRoute({Key? key, this.imagePath = "", required this.cameraName})
      : super(key: key);

  @override
  State<PlantRoute> createState() => _PlantRouteState();
}

class _PlantRouteState extends State<PlantRoute> {
  @override
  Widget build(BuildContext context) {
    // Button an dessen Stelle das aufgenommene Foto angezeigt wird
    StatefulWidget picOrButton;

    if (widget.imagePath.isNotEmpty && widget.cameraName != "fake") {
      picOrButton = Image.file(File(widget.imagePath));
    } else if (widget.imagePath.isNotEmpty && widget.cameraName == "fake") {
      picOrButton = const Image(image: AssetImage("assets/images/plant.jpeg"));
    } else {
      picOrButton = ElevatedButton(
          child: const Text('Foto machen'),
          onPressed: () {
            if (widget.cameraName == "fake") {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MainScreen(
                    imagePath: "assets/images/plant.jpeg",
                    cameraName: widget.cameraName,
                  ),
                ),
              );
            } else {
              Navigator.pushNamed(context, '/camera');
            }
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pflanzen'),
      ),

      // Inhalt der Pflanzen-Seite
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                child: const Text('Foto machen oder ändern'),
                onPressed: () {
                  if (widget.cameraName == "fake") {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MainScreen(
                          imagePath: "assets/images/plant.jpeg",
                          cameraName: widget.cameraName,
                        ),
                      ),
                    );
                  } else {
                    Navigator.pushNamed(context, '/camera');
                  }
                }),
            picOrButton, // Zeigt einen Knopf oder das Foto
            const Image(image: AssetImage("assets/images/plant.jpeg"))
          ],
        ),
      ),
    );
  }
}
