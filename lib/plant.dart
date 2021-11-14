import 'package:flutter/material.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({Key? key}) : super(key: key);

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  final List<Widget> entries = [
    const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Image(
          image: AssetImage("assets/images/plant.jpeg"),
          height: 400,
          fit: BoxFit.fitWidth,
        )),
    const Text.rich(
      TextSpan(
          text: 'Zierpfeffer\n',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
          children: <TextSpan>[
            TextSpan(
                text: 'Zimmer',
                style: TextStyle(fontSize: 20, color: Colors.black))
          ]),
    ),
    Row(
      children: const <Widget>[
        Expanded(
          child: Text.rich(
            TextSpan(
                text: 'Gießen\n',
                style: TextStyle(color: Colors.blue),
                children: <TextSpan>[
                  TextSpan(
                    text: 'In 5 Tagen',
                    style: TextStyle(color: Colors.black),
                  )
                ]),
          ),
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
                text: 'Düngen\n',
                style: TextStyle(color: Colors.deepOrange),
                children: <TextSpan>[
                  TextSpan(
                    text: 'In 14 Tagen',
                    style: TextStyle(color: Colors.black),
                  )
                ]),
          ),
        ),
      ],
    ),
    const Text.rich(
      TextSpan(
          text: 'Notizen\n',
          style: TextStyle(color: Colors.indigo),
          children: <TextSpan>[
            TextSpan(
              text:
                  'Muss regelmäßig von Staub befreit werden und alle paar Tage gedreht werden',
              style: TextStyle(color: Colors.black),
            )
          ]),
    ),
  ];
  final List myColors = <Color>[
    Colors.transparent,
    Colors.grey.shade400,
    Colors.grey.shade300,
    Colors.grey.shade300,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Zierlicher Peter'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              // height: index == 0 ? 500 : Null,

              child: entries[index],
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: myColors[index],
                border: Border.all(
                  width: 8,
                  color: Colors.transparent,
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.transparent height: 10,
          ),
        ));
  }
}
