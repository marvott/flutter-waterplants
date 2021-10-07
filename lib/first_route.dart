import 'package:flutter/material.dart';

class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Open settings route'),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ElevatedButton(
              child: const Text('Sprossen'),
              onPressed: () {
                Navigator.pushNamed(context, '/sprossen');
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Pflanzen'),
              leading: const Icon(Icons.filter_vintage_rounded),
              onTap: () {
                //Update the state of the app
                Navigator.popAndPushNamed(context, '/');
                //then close the drawer
              },
            ),
            ListTile(
              title: const Text('Sprossen'),
              leading: const Icon(Icons.grass_rounded),
              onTap: () {
                //Update the state of the app
                Navigator.popAndPushNamed(context, '/sprossen');
                //then close the drawer
              },
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings),
              onTap: () {
                //Update the state of the app
                Navigator.popAndPushNamed(context, '/settings');
                //then close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}
