import 'package:flutter/material.dart';
import 'plant_overview_screen.dart';

import '../settings_route.dart';
import '../sprossen_route.dart';

class MainScreen extends StatefulWidget {
  final String imagePath;

  const MainScreen({Key? key, this.imagePath = ""}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> screens = [
    const PlantOverview(),
    const SprossenRoute(),
    const SettingsRoute(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //So bleiben die Screens im Widgettree, ist mit der geringen Anzahl an Screens vertretbar und performant
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,

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
