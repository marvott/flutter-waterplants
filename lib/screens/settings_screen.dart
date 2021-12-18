import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  String? cloudMsgToken;

  //Init firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Example for Input-Fields
  final _emailInput = TextEditingController(text: 'bob@example.com');
  final _passInput = TextEditingController(text: 'passwort');

  @override
  void initState() {
    super.initState();

    //Listener if other User logs in: Updates Token in Firestore and reloads Build
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _updateTokenForUser(firestore, cloudMsgToken);
      setState(() => this.user = user);
    });
  }

  @override
  Widget build(BuildContext context) {
    //Gets Device Token for Cloud Messaging
    FirebaseMessaging.instance.getToken().then((token) {
      cloudMsgToken = token;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(child: userInfo()), //Message if user is signed in
            inputTextFields(), //Input for Email and Password
            mySignInButtons(context), //Sign-In, Sign-Up and Sign-Out Buttons
          ])),
    );
  }

  //Status Message if User is logged in
  Widget userInfo() {
    if (user == null) return const Text('Nicht angemeldet.');
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      if (user!.photoURL != null) Image.network(user!.photoURL!, width: 50),
      Text(
          'Angemeldet als: ${user!.displayName != null ? user!.displayName! + ', ' : ''}${user!.email}.')
    ]);
  }

  //Buttons
  Widget mySignInButtons(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SignInButtonBuilder(
          key: Key('signInBtn'),
          icon: Icons.email_rounded,
          backgroundColor: Colors.green.shade400,
          text: "Mit Email anmelden",
          onPressed: () =>
              loginWithEmail(_emailInput.text, _passInput.text, context)),
      SignInButtonBuilder(
          key: Key('SignUpBtn'),
          text: 'Registrieren',
          icon: Icons.account_circle,
          onPressed: () => createUserWithEmailAndPassword(
              _emailInput.text, _passInput.text, context),
          backgroundColor: Colors.blueGrey),
      SignInButtonBuilder(
          key: Key('SignOutBtn'),
          text: 'Abmelden',
          icon: Icons.logout_rounded,
          onPressed: () => user != null ? logout() : null,
          backgroundColor: Colors.redAccent),
    ]);
  }

  //Email and Password Input for User
  Widget inputTextFields() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      SizedBox(
          key: Key("emailInput"),
          width: 150,
          child: TextField(
              controller: _emailInput,
              decoration: const InputDecoration(hintText: 'Email'))),
      SizedBox(
          key: Key("pwInput"),
          width: 150,
          child: TextField(
              controller: _passInput,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Passwort'))),
    ]);
  }

  //Communication with Firebase when user logs in
  //Error-Handling and Message in Snackbar if user was not found or wrong pw
  Future<UserCredential?> loginWithEmail(
      String email, String pass, BuildContext context) async {
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
      String email, String pass, BuildContext context) async {
    DateTime currentTime = DateTime.now();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);

      //Adding the users email to the firestore collection 'users' with corresponding timestamp
      var _currentUser = firestore.collection('users').doc(email);

      _currentUser.set({'usercreated': currentTime});

      _currentUser.collection('sprossen').doc().set({
        'name': '',
        'Keimdauer (Tage)': '',
        'Wasser gewechselt': currentTime
      });

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

//Adds the Device Token for Cloud Messaging to Firestore
_updateTokenForUser(FirebaseFirestore firestore, String? cloudMsgToken) {
  try {
    DocumentReference? currentUserRef = firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email);
    currentUserRef.update({'cloudMsgToken': cloudMsgToken}).catchError(
        (error) => print("Could not update cloudMsgToken"));
  } catch (e) {
    String message = "Melde dich erst an";
    print(message);
    // Snackbar an der Stelle nicht benutzbar da kein BuildContext in initState vorhanden ist
    //Utils.showSnackBar(context, message: message, color: Colors.blueGrey);
  }
}
