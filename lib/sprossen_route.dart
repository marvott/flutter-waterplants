import 'package:flutter/material.dart';

class SprossenRoute extends StatefulWidget {
  const SprossenRoute({Key? key}) : super(key: key);

  @override
  State<SprossenRoute> createState() => _SprossenRouteState();
}

class _SprossenRouteState extends State<SprossenRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Life of Sprossen"),
          backgroundColor: const Color.fromRGBO(18, 185, 24, 0.8),
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
                          child: const Text("1. Schritt: Sprossen einweichen"),
                          color: Colors.green[10],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Wie lange? 4-12h'),
                          color: Colors.green[50],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Dann dunkel lagern'),
                          color: Colors.green[100],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Wie lange? 3-4 Tage'),
                          color: Colors.green[200],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Jeden Tag...'),
                          color: Colors.green[300],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('...1-2x mit Wasser spülen'),
                          color: Colors.green[400],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Dann in indirektes Licht stellen'),
                          color: Colors.green[500],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Wie lange? 3 Tage '),
                          color: Colors.green[600],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child:
                              const Text('Dann sind die Sprossen 3-4cm lang'),
                          color: Colors.green[700],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Guten!'),
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
