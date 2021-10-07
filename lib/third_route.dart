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
          title: const Text("Sprossen"),
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
