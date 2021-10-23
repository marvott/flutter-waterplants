//to open xcode run this in terminal:
//open ios/Runner.xcworkspace

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'plant_route.dart';
import 'settings_route.dart';
import 'sprossen_route.dart';
import 'camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

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
        '/': (context) => const PlantRoute(),
        '/sprossen': (context) => const SprossenRoute(),
        '/settings': (context) => const SettingsRoute(),
        '/camera': (context) => TakePictureScreen(camera: camera),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
