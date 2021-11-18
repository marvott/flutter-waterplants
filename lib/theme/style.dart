import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
      brightness: Brightness.dark,
      backgroundColor: Colors.green.shade800,
      appBarTheme: AppBarTheme(
        color: Colors.green.shade800,
      ),
      buttonTheme: ButtonThemeData(buttonColor: Colors.green.shade800),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              // hier einstellen wie breit die Buttons sind?
              backgroundColor:
                  MaterialStateProperty.all(Colors.green.shade800))),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.grey.shade700,
          foregroundColor: Colors.white));
}
