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

//FirebaseFirestore.instance.settings = Settings(host: '10.0.2.2:8080', sslEnabled: false); // use emulatorvoid main() async {

class SettingsRoute extends StatefulWidget {
  @override
  _MySettingsState createState() => _MySettingsState();
}

class _MySettingsState extends State<SettingsRoute> {
  User? user;

  final _emailInput = TextEditingController(text: 'bob@example.com');
  final _passInput = TextEditingController(text: 'secret');

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() => this.user = user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /*
        SignInButtonBuilder(
            text: 'Sign in anonymously',
            icon: Icons.account_circle,
            onPressed: () => loginAnonymously(),
            backgroundColor: Colors.blueGrey),
            */

        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
              width: 150,
              child: TextField(
                  controller: _emailInput,
                  decoration: InputDecoration(hintText: 'Email'))),
          SizedBox(
              width: 150,
              child: TextField(
                  controller: _passInput,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'))),
        ]),

        SignInButton(Buttons.Email,
            onPressed: () => loginWithEmail(_emailInput.text, _passInput.text,
                (e) => _showErrorDialog(context, 'Failed to sign in', e))),
        SignInButtonBuilder(
            text: 'Sign Up',
            icon: Icons.account_circle,
            onPressed: () => createUserWithEmailAndPassword(
                _emailInput.text, _passInput.text),
            backgroundColor: Colors.blueGrey),

        //SignInButton(Buttons.Google, onPressed: () => loginWithGoogle()),
        //SignInButton(Buttons.FacebookNew, onPressed: () {}),
        //SignInButton(Buttons.Twitter, onPressed: () {}),
        //SignInButton(Buttons.Microsoft, onPressed: () {}),
        //SignInButton(Buttons.AppleDark, onPressed: () {}),
        Container(child: userInfo()),
        ElevatedButton(
            child: const Text('Sign out'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: user != null ? () => logout() : null)
      ],
    )));
  }

  Widget userInfo() {
    if (user == null) return Text('Not signed in.');
    if (user!.isAnonymous) return Text('Anonymous sign in: ${user!.uid}.');
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      if (user!.photoURL != null) Image.network(user!.photoURL!, width: 50),
      Text(
          'Signed in as ${user!.displayName != null ? user!.displayName! + ', ' : ''}${user!.email}.')
    ]);
  }

  /*
  Future<UserCredential> loginAnonymously() {
    return FirebaseAuth.instance.signInAnonymously();
  }
*/
  /*Future<UserCredential> loginWithEmail(
    String email,
    String pass,
    void Function(FirebaseAuthException e) errorCallback,
  ) {
    try {
      print("test");
      return FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      print("this ist shit");
      errorCallback(e);
    }*/

  Future<UserCredential> loginWithEmail(
    String email,
    String pass,
    void Function(FirebaseAuthException e) errorCallback,
  ) {
    try {
      return FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'firebase_auth/user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
    return Future.value(null);
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.${e.code}');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.${e.code}');
      }
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
