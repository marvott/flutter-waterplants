import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_application_1/components/snackbar_dialog.dart';

class SettingsRoute extends StatefulWidget {
  const SettingsRoute({Key? key}) : super(key: key);

  @override
  _MySettingsState createState() => _MySettingsState();
}

class _MySettingsState extends State<SettingsRoute> {
  User? user;

  //Example for Input-Fields
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

            //Input for Email and Password
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

            //Sign-In, Sign-Up and Sign-Out Buttons
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SignInButton(Buttons.Email,
                      text: "Mit Email anmelden",
                      onPressed: () => loginWithEmail(
                            _emailInput.text,
                            _passInput.text,
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

  //Status Message if User is logged in
  Widget userInfo() {
    if (user == null) return const Text('Nicht angemeldet.');
    if (user!.isAnonymous) return Text('Anonym angemeldet: ${user!.uid}.');
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      if (user!.photoURL != null) Image.network(user!.photoURL!, width: 50),
      Text(
          'Angemeldet als: ${user!.displayName != null ? user!.displayName! + ', ' : ''}${user!.email}.')
    ]);
  }

  //Communication with Firebase when user logs in
  //Error-Handling and Message in Snackbar if user was not found or wrong pw
  Future<UserCredential?> loginWithEmail(String email, String pass) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        String message = "Nutzer muss erst registriert werden.";
        Utils.showSnackBar(context, message: message, color: Colors.blueGrey);
      } else if (e.code == 'wrong-password') {
        String message = "Falsches Passwort.";
        Utils.showSnackBar(context, message: message, color: Colors.blueGrey);
      }
    } catch (e) {
      String message = "Es ist ein Fehler aufgetreten.";
      Utils.showSnackBar(context, message: message, color: Colors.blueGrey);
    }
    return Future.value(null);
  }

  //Communication with Firebase when user is created
  //Error-Handling when the email is being used or weak pw
  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        String message = "Passwort zu schwach. Versuch es nochmal.";
        Utils.showSnackBar(context, message: message, color: Colors.blueGrey);
      } else if (e.code == 'email-already-in-use') {
        String message = "Die Email ist bereits registriert.";
        Utils.showSnackBar(context, message: message, color: Colors.blueGrey);
      }
    } catch (e) {
      String message = "Es ist ein Fehler aufgetreten.";
      Utils.showSnackBar(context, message: message, color: Colors.blueGrey);
    }

    return Future.value(null);
  }

  logout() => FirebaseAuth.instance.signOut();
}
