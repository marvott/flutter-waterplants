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
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Pflanzen',
      style: optionStyle,
    ),
    Text(
      'Index 1: Sprossen',
      style: optionStyle,
    ),
    Text(
      'Index 2: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlantRoute(
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
            _widgetOptions.elementAt(_selectedIndex),
            ElevatedButton(
                child: const Text('Foto machen oder ändern'),
                onPressed: () {
                  if (widget.cameraName == "fake") {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PlantRoute(
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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_vintage_rounded),
            label: 'Pflanzen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass_rounded),
            label: 'Sprossen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Einstellungen',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
