import 'package:flutter/material.dart';

import 'package:flutter_application_1/main.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  testWidgets("Test Auth Sign-In", (WidgetTester tester) async {
    //Das hier ist der Versuch die Anmeldung zu testen,
    //aber dies gestaltete sich mit Firebase doch schwieriger als gedacht.

    //execute the test
    await tester.pumpWidget(const SettingsRoute());

    //find widgets we need
    final emailField = find.byKey(const ValueKey('emailInput'));
    final pwField = find.byKey(const ValueKey('pwInput'));
    print(emailField);

    final signInButton = find.byKey(const ValueKey('signInBtn'));
    final signUpButton = find.byKey(const ValueKey('signUpBtn'));
    final signOutButton = find.byKey(const ValueKey('signOutBtn'));

    await tester.enterText(emailField, "bob@exampl.com");
    await tester.enterText(pwField, "1234567890");
    await tester.tap(signInButton);
    await tester.pump(); //rebuilds Widget (wie SetState)

    //expect outputs
    expect(find.text("bob@example.com"), findsOneWidget);
  });
}
