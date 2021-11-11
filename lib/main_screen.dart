import 'package:flutter/material.dart';
import 'package:flutter_application_1/plant_route.dart';

import 'settings_route.dart';
import 'sprossen_route.dart';

class MainScreen extends StatefulWidget {
  final String imagePath;
  final String cameraName;

  const MainScreen({Key? key, this.imagePath = "", required this.cameraName})
      : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> pageList = <Widget>[
    PlantRoute(
      cameraName: widget.cameraName,
    ),
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
      body: pageList[_selectedIndex],
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
