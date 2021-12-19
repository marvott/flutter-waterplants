import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/components/no_user_widget.dart';

import 'plant_overview_screen.dart';
import 'settings_screen.dart';
import 'sprossen_screen.dart';

class MainScreen extends StatefulWidget {
  final String imagePath;

  const MainScreen({Key? key, this.imagePath = ""}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user;

  @override
  void initState() {
    super.initState();

    //Listens for Changes in Authentification State -> Other user logs in
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print("current user: $user");
      setState(() => this.user = user);
    });
  }

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
    return (user == null)
        ? const SettingsRoute()
        : Scaffold(
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
                  icon: Icon(Icons.person_rounded),
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
