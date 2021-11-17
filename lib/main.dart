//to open xcode run this in terminal:
//open ios/Runner.xcworkspace

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera.dart';
import 'package:flutter/services.dart';

import 'general_arguments.dart';
import 'main_screen.dart';

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
        theme: ThemeData(
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
                foregroundColor: Colors.white)),
        initialRoute: '/',
        onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text('Not found')),
                )),
        routes: {
          // Routen
          '/': (context) => const MainScreen(),
          '/camera': (context) => TakePictureScreen(camera: camera),
        });
  }
}
