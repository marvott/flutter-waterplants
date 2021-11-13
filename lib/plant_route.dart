import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_application_1/main_screen.dart';
import 'general_arguments.dart';

class PlantRoute extends StatefulWidget {
  const PlantRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<PlantRoute> createState() => _PlantRouteState();
}

class _PlantRouteState extends State<PlantRoute> {
  @override
  Widget build(BuildContext context) {
    // Button an dessen Stelle das aufgenommene Foto angezeigt wird
    StatefulWidget picOrButton;

    if (GeneralArguments.imagePath.isNotEmpty &&
        GeneralArguments.cameraName != "fake") {
      picOrButton = Image.file(File(GeneralArguments.imagePath));
    } else if (GeneralArguments.imagePath.isNotEmpty &&
        GeneralArguments.cameraName == "fake") {
      picOrButton = const Image(image: AssetImage("assets/images/plant.jpeg"));
    } else {
      picOrButton = ElevatedButton(
          child: const Text('Foto machen'),
          onPressed: () {
            if (GeneralArguments.cameraName == "fake") {
              GeneralArguments.imagePath = "assets/images/plant.jpeg";
              setState(() {});
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const MainScreen(),
              //   ),
              // );
            } else {
              Navigator.pushNamed(context, '/camera')
                  .then((_) => setState(() {}));
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
                  if (GeneralArguments.cameraName == "fake") {
                    GeneralArguments.imagePath = "assets/images/plant.jpeg";
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
                  } else {
                    Navigator.pushNamed(context, '/camera')
                        .then((_) => setState(() {}));
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
