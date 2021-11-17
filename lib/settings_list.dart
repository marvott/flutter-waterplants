import 'package:flutter/material.dart';
import 'main_screen.dart';

Column settingslist(context) {
  var settings = Column(
    children: <Widget>[
      const Text('Alle Privaten Infos an den Entwickler "spenden": Akzeptiert'),
      const Text('Daten dürfen an die NSA weitergegeben werden: Akzeptiert'),
      ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        child: const Text('Akzeptieren und zurück!'),
      ),
    ],
  );

  return settings;
}
