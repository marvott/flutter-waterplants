import 'package:flutter/material.dart';

Column settingslist(context) {
  var settings = Column(
    children: <Widget>[
      const Text('Alle Privaten Infos an den Entwickler "spenden": Akzeptiert'),
      const Text('Daten dürfen an die NSA weitergegeben werden: Akzeptiert'),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          // Navigate back to first route when tapped.
        },
        child: const Text('Go back!'),
      ),
    ],
  );

  return settings;
}
