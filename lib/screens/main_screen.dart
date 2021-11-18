import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/plant.dart';
import 'package:flutter_application_1/models/plant_list.dart';
import 'plant_overview_screen.dart';
import 'package:provider/provider.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlantList()),
      ],
      child: Scaffold(
        body: [
          const PlantOverview(),
          const SprossenRoute(),
          const SettingsRoute(),
        ][_selectedIndex],
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
      ),
    );
  }
}
