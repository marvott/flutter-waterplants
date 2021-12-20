import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  testWidgets("Test Auth Sign-In", (WidgetTester tester) async {
    //Das hier ist der Versuch die Anmeldung zu testen,
    //aber dies gestaltete sich mit Firebase doch schwieriger als gedacht.
    //Error ist, dass er Firebase erwartet.
    //Wir wollten zwar erstmal nur auf vorhandene Widgets testen, aber wir haben in jeder Seite immer Firebase und fürs Mocking fehlte uns die Zeit.
    //Test-Driven-Development wäre angebrachter gewesen, dann wäre wir aber auch nicht soweit gekommen...

    //execute the test
    Firebase.initializeApp();
    await tester.pumpWidget(SettingsRoute());

    //find widgets we need
    final emailField = find.byKey(const ValueKey('emailInput'));
    final pwField = find.byKey(const ValueKey('pwInput'));
    //print(emailField);

    final signOutButton = find.byKey(const ValueKey('signOutBtn'));

    //await tester.enterText(emailField, "bob@exampl.com");
    //await tester.enterText(pwField, "1234567890");
    //await tester.tap(signInButton);
    await tester.pump(); //rebuilds Widget (wie SetState)

    //expect outputs
    //expect(find.text("bob@example.com"), findsOneWidget);
    expect(signOutButton, findsNothing);
  });
}

class TestApp extends StatefulWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  _MyTestApp createState() => _MyTestApp();
}

class _MyTestApp extends State<TestApp> {
  @override
  void initState() {
    super.initState();
  }

  //Buttons
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            SignInButtonBuilder(
                key: const Key('signInBtn'),
                icon: Icons.email_rounded,
                backgroundColor: Colors.green.shade400,
                text: "Mit Email anmelden",
                onPressed: () => print("Angemeldet")),
            SignInButtonBuilder(
                key: const Key('SignUpBtn'),
                text: 'Registrieren',
                icon: Icons.account_circle,
                onPressed: () => print("Registriert"),
                backgroundColor: Colors.blueGrey),
            SignInButtonBuilder(
                key: const Key('SignOutBtn'),
                text: 'Abmelden',
                icon: Icons.logout_rounded,
                onPressed: () => print("User ausgeloggt"),
                backgroundColor: Colors.redAccent),
          ])),
    );
  }
}
