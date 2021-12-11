import 'package:flutter/material.dart';

import 'package:flutter_application_1/main.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';

void main() {
  testWidgets("Test Auth Sign-In", (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    //find widgets we need
    final emailField = find.byKey(ValueKey('emailInput'));
    final pwField = find.byKey(ValueKey('pwInput'));

    final signInButton = find.byKey(ValueKey('signInBtn'));
    final signUpButton = find.byKey(ValueKey('signUpBtn'));
    final signOutButton = find.byKey(ValueKey('signOutBtn'));

    //execute the test
    await tester.pumpWidget(SettingsRoute());

    await tester.enterText(emailField, "bob@example.com");
    await tester.enterText(pwField, "secret");
    await tester.tap(signInButton);
    await tester.pump(); //rebuilds Widget (wie SetState)

    //expect outputs
    expect(find.text("bob@example.com"), findsOneWidget);
  });
}
