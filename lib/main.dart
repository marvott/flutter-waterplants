//to open xcode run this in terminal:
//open ios/Runner.xcworkspace

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_application_1/camera.dart';

import 'main_screen.dart';
import 'plant_route.dart';
import 'settings_route.dart';
import 'sprossen_route.dart';

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
  const MyApp({Key? key, required this.camera, required this.cameraName})
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
        initialRoute: '/',
        onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text('Not found')),
                )),
        routes: {
          // Routen
          '/': (context) => MainScreen(cameraName: cameraName),
          //TODO: die routen fliegen evtl. raus weil sie im main screen drinne sind
          '/plants': (context) => PlantRoute(
                cameraName: cameraName,
              ),
          '/sprossen': (context) => const SprossenRoute(),
          '/settings': (context) => const SettingsRoute(),
          '/camera': (context) => TakePictureScreen(camera: camera),
        });
  }
}
