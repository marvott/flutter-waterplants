//to open xcode run this in terminal:
//open ios/Runner.xcworkspace

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_application_1/theme/style.dart';
import 'screens/camera.dart';
import 'package:flutter/services.dart';

import 'models/general.dart';
import 'screens/main_screen.dart';

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
    GeneralArguments.cameraName = 'fake';
  }

  runApp(MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        title: 'Route Demo',
        theme: appTheme(),
        initialRoute: '/',
        onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text('Route Not found')),
                )),
        routes: {
          '/': (context) => const MainScreen(),
          '/camera': (context) => TakePictureScreen(camera: camera),
        });
  }
}
