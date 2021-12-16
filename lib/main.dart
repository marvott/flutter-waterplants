/* 
# open xcode:
open ios/Runner.xcworkspace

# after changing branch, when imports fail:
flutter pub get

# after flutter upgrade:
flutter clean
flutter pub get
flutter pub upgrade

# fix ios build errors:
cd ios
rm Podfile.lock
rm Podfile
pod init
pod install
*/

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_application_1/theme/style.dart';
import 'screens/camera.dart';
import 'package:flutter/services.dart';

import 'models/general.dart';
import 'screens/main_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; //TODO

Future<void> main() async {
  // Kamera initialisieren
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
    FirebaseMessaging.instance
        .getToken()
        .then((token) => print('Device token = $token'));
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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Received a background message.');
  // You can't update the app UI here!
}
