import 'package:flutter/material.dart';

Column settingslist(context) {
  var settings = Column(
    children: <Widget>[
      const Text('Deliver features faster'),
      const Text('Craft beautiful UIs'),
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
