/*
//Sinnloser Screen, kann weg
class SettingsRoute extends StatefulWidget {
  const SettingsRoute({Key? key}) : super(key: key);

  @override
  State<SettingsRoute> createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(child: settingslist(context)),
    );
  }
}
*/
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_application_1/components/snackbar_dialog.dart';

//FirebaseFirestore.instance.settings = Settings(host: '10.0.2.2:8080', sslEnabled: false); // use emulatorvoid main() async {

class SettingsRoute extends StatefulWidget {
  const SettingsRoute({Key? key}) : super(key: key);

  @override
  _MySettingsState createState() => _MySettingsState();
}

class _MySettingsState extends State<SettingsRoute> {
  User? user;

  final _emailInput = TextEditingController(text: 'bob@example.com');
  final _passInput = TextEditingController(text: 'passwort');

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() => this.user = user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(child: userInfo()),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              SizedBox(
                  width: 150,
                  child: TextField(
                      controller: _emailInput,
                      decoration: const InputDecoration(hintText: 'Email'))),
              SizedBox(
                  width: 150,
                  child: TextField(
                      controller: _passInput,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'Passwort'))),
            ]),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SignInButton(Buttons.Email,
                      text: "Mit Email anmelden",
                      onPressed: () => loginWithEmail(
                            _emailInput.text,
                            _passInput
                                .text, /*(e) => _showErrorDialog(context, 'Failed to sign in', e)*/
                          )),
                  SignInButtonBuilder(
                      text: 'Registrieren',
                      icon: Icons.account_circle,
                      onPressed: () => createUserWithEmailAndPassword(
                          _emailInput.text, _passInput.text),
                      backgroundColor: Colors.blueGrey),
                  SignInButtonBuilder(
                      text: 'Abmelden',
                      icon: Icons.logout_rounded,
                      onPressed: () => user != null ? logout() : null,
                      backgroundColor: Colors.redAccent),
                ]),
          ])),
    );
  }

  Widget userInfo() {
    if (user == null) return const Text('Nicht angemeldet.');
    if (user!.isAnonymous) return Text('Anonym angemeldet: ${user!.uid}.');
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      if (user!.photoURL != null) Image.network(user!.photoURL!, width: 50),
      Text(
          'Angemeldet als: ${user!.displayName != null ? user!.displayName! + ', ' : ''}${user!.email}.')
    ]);
  }

  Future<UserCredential?> loginWithEmail(
    String email,
    String pass,
    /*void Function(FirebaseAuthException e) errorCallback,*/
  ) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        String message = "Nutzer muss erst registriert werden.";
        Utils.showSnackBar(context, message: message, color: Colors.blueGrey);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        String message = "Falsches Passwort.";
        Utils.showSnackBar(context, message: message, color: Colors.blueGrey);
      }
    } catch (e) {
      print(e);
    }
    return Future.value(null);
  }

  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.${e.code}');
        String message = "Passwort zu schwach. Versuch es nochmal.";
        Utils.showSnackBar(context, message: message, color: Colors.blueGrey);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.${e.code}');
        String message = "Die Email ist bereits registriert.";
        Utils.showSnackBar(context, message: message, color: Colors.blueGrey);
      }
    } catch (e) {
      print(e);
    }

    return Future.value(null);
  }

/*
  Future<UserCredential> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await (GoogleSignIn().signIn());
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
*/
  logout() => FirebaseAuth.instance.signOut();
}

void _showErrorDialog(BuildContext context, String title, Exception e) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                '${(e as dynamic).message}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.deepPurple),
            ),
          ),
        ],
      );
    },
  );
}
