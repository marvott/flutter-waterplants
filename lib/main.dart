import 'package:flutter/material.dart';
import 'first_route.dart';
import 'second_route.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route Demo',
      initialRoute: '/',
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(child: Text('Not found')),
              )),
      routes: {
        '/': (context) => const FirstRoute(),
        '/second': (context) => const SecondRoute(),
        '/third': (context) => const ThirdRoute(),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
