import 'package:flutter/material.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/snackbar_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _MySettingsState createState() => _MySettingsState();
}

class _MySettingsState extends State<SettingsScreen> {
  User? user;
  String? cloudMsgToken;

  //Init firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Example for Input-Fields
  final _emailInput = TextEditingController();
  final _passInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateTokenForUser(firestore, cloudMsgToken);

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
        title: const Text("Account"),
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
    return (user == null)
        ? Column(
            children: const [
              Text('Nicht angemeldet'),
              Text('Bitte anmelden oder registrieren'),
            ],
          )
        : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            if (user!.photoURL != null)
              Image.network(user!.photoURL!, width: 50),
            Text(
                'Angemeldet als: ${user!.displayName != null ? user!.displayName! + ', ' : ''}${user!.email}')
          ]);
  }

  //Buttons
  Widget mySignInButtons(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SignInButtonBuilder(
          key: const Key('signInBtn'),
          icon: Icons.email_rounded,
          backgroundColor: Colors.green.shade400,
          text: "Mit Email anmelden",
          onPressed: () =>
              loginWithEmail(_emailInput.text, _passInput.text, context)),
      SignInButtonBuilder(
          key: const Key('SignUpBtn'),
          text: 'Registrieren',
          icon: Icons.account_circle,
          onPressed: () => createUserWithEmailAndPassword(
              _emailInput.text, _passInput.text, context),
          backgroundColor: Colors.blueGrey),
      SignInButtonBuilder(
          key: const Key('SignOutBtn'),
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
          key: const Key("emailInput"),
          width: 150,
          child: TextField(
              controller: _emailInput,
              decoration: const InputDecoration(hintText: 'Email'))),
      SizedBox(
          key: const Key("pwInput"),
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
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        String message = "Anmeldung erfolgreich";
        Utils.showSnackBar(context, message: message, color: Colors.green);
      });
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
        (error) => ("Could not update cloudMsgToken"));
  } catch (e) {
    //String message = "Melde dich erst an";
    // print(message);
  }
}
