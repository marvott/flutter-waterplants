//to open xcode run this in terminal:
//open ios/Runner.xcworkspace

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_application_1/main_screen.dart';

import 'plant_route.dart';
import 'settings_route.dart';
import 'sprossen_route.dart';
import 'camera.dart';

Future<void> main() async {
  // Kamera initialisieren
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final CameraDescription firstCamera;
  if (cameras.isNotEmpty) {
    firstCamera = cameras.first;
  } else {
    firstCamera = CameraDescription(
        name: "fake",
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 90);
  }

  runApp(MyApp(
    camera: firstCamera,
    cameraName: firstCamera.name,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.camera, required this.cameraName})
      : super(key: key);

  final CameraDescription camera;
  final String cameraName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MainScreen(cameraName: cameraName,),
    );
  }
}
