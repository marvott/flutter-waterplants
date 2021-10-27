import 'package:flutter/material.dart';
import 'dart:io';

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

    if (widget.imagePath.isNotEmpty) {
      picOrButton = Image.file(File(widget.imagePath));
    } else {
      picOrButton = ElevatedButton(
          child: const Text('Foto machen'),
          onPressed: () {
            if (widget.cameraName == "fake") {
              PlantRoute(
                  cameraName: widget.cameraName,
                  imagePath: "lib/presetPictures/bild.jpeg");
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
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                child: const Text('Foto machen oder ändern'),
                onPressed: () {
                  if (widget.cameraName == "fake") {
                    PlantRoute(
                        cameraName: widget.cameraName,
                        imagePath: "lib/presetPictures/bild.jpeg");
                  } else {
                    Navigator.pushNamed(context, '/camera');
                  }
                }),
            picOrButton // Zeigt einen Knopf oder das Foto
          ],
        ),
      ),

      // App-Drawer der zu den verschiedenen routen führt
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text('Pflanzen & Sprossen'),
            ),
            ListTile(
              title: const Text('Pflanzen'),
              leading: const Icon(Icons.filter_vintage_rounded),
              onTap: () {
                //Update the state of the app
                Navigator.popAndPushNamed(context, '/');
                //then close the drawer
              },
            ),
            ListTile(
              title: const Text('Sprossen'),
              leading: const Icon(Icons.grass_rounded),
              onTap: () {
                Navigator.popAndPushNamed(context, '/sprossen');
              },
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.popAndPushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
    );
  }
}
