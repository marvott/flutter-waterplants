import 'package:flutter/material.dart';

//Sinnlose Klasse, kann weg
Column settingslist(context) {
  var settings = Column(
    children: <Widget>[
      const Text('Alle Privaten Infos an den Entwickler "spenden": Akzeptiert'),
      const Text('Daten dürfen an die NSA weitergegeben werden: Akzeptiert'),
      ElevatedButton(
        onPressed: () {},
        child: const Text('Akzeptieren'),
      ),
    ],
  );

  return settings;
}
