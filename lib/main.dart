import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route Demo',
      initialRoute: '/',
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => Scaffold(
                body: Center(child: Text('Not found')),
              )),
      routes: {
        '/': (context) => const FirstRoute(),
        '/second': (context) => const SecondRoute(),
        '/third': (context) => const ThirdRoute(),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

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
              child: Text('Open second route'),
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
            ),
            ElevatedButton(
              child: Text('Sprossen'),
              onPressed: () {
                Navigator.pushNamed(context, '/third');
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
              title: const Text('First Route'),
              leading: Icon(Icons.filter_vintage_rounded),
              onTap: () {
                //Update the state of the app
                Navigator.popAndPushNamed(context, '/');
                //then close the drawer
              },
            ),
            ListTile(
              title: const Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {
                //Update the state of the app
                Navigator.popAndPushNamed(context, '/second');
                //then close the drawer
              },
            ),
            ListTile(
              title: const Text('Sprossen'),
              leading: Icon(Icons.grass_rounded),
              onTap: () {
                //Update the state of the app
                Navigator.popAndPushNamed(context, '/third');
                //then close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class ThirdRoute extends StatefulWidget {
  const ThirdRoute({Key? key}) : super(key: key);

  @override
  State<ThirdRoute> createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sprossen"),
          backgroundColor: Color.fromRGBO(18, 185, 24, 0.8),
        ),
        body: Center(
          child: Column(
            children: [
              /*ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigate back to first route when tapped.
                },
                child: Text('Go back!'),
              ),*/
              Expanded(
                  child: CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text("He'd have you all unravel at the"),
                          color: Colors.green[100],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Heed not the rabble'),
                          color: Colors.green[200],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Sound of screams but the'),
                          color: Colors.green[300],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Who scream'),
                          color: Colors.green[400],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Revolution is coming...'),
                          color: Colors.green[500],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Revolution, they...'),
                          color: Colors.green[600],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Rsdasda'),
                          color: Colors.green[40],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('sadsady...'),
                          color: Colors.green[800],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('test'),
                          color: Colors.green[100],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('sadsasdasdasd..'),
                          color: Colors.green[800],
                        ),
                      ],
                    ),
                  ),
                ],
              ) /*GridView.count(
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text("He'd have you all unravel at the"),
                      color: Colors.green[100],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text("text 2"),
                      color: Colors.green[300],
                    ),
                  ]
                      List.generate(20, (index) {
                      return Center(
                      child: Text(
                        'Item $index',
                        style: Theme.of(context).textTheme.headline5,
                    ),
                  );
                }),
                */
                  )
            ],
          ),
        ));
  }
}
