import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/general.dart';
import 'package:flutter_application_1/models/plant.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

class PlantScreen extends StatefulWidget {
  final Function callback;
  final Plant plant;
  const PlantScreen({
    Key? key,
    required this.callback,
    required this.plant,
  }) : super(key: key);

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  final formKey = GlobalKey<FormState>();

  //Farben der Listview, gehe sicher dass es die RICHTIGE LÄNGE HAT!
  final List myColors = <Color>[
    Colors.transparent,
    Colors.grey.shade700,
    Colors.grey.shade700,
    Colors.grey.shade700,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plant.name),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: myColors.length,
        // ListView.separated muss mit dem itemBuilder gebaut werden
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: buildPlantScreenElements(context, index),
              // das Bild (Index 0) ist schon in einem abgerundeten Container
              decoration: index == 0 || index == 2
                  ? null
                  : BoxDecoration(
                      color: myColors[index],
                      border: Border.all(
                        width: 8,
                        color: Colors.transparent,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ));
        },
        // Der Abstand zw. den Listenelementen
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.transparent,
          height: 10,
        ),
      ),
      // Foto der Pflanze ändern
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (GeneralArguments.cameraName != 'fake') {
            // damit das Foto direkt angezeigt wird, werden alle betroffenen Widgets neu gerendert
            Navigator.pushNamed(context, '/camera')
                .then((imagePath) => setState(() {
                      widget.plant.setImagePath = imagePath;
                      widget.callback();
                    }));
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }

  void showBottomSheet(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      final isValid = formKey.currentState!.validate();
                      if (isValid) {
                        formKey.currentState!.save();
                        setState(() {
                          widget.callback();
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Fertig")),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                      initialValue: widget.plant.name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Name",
                        icon: Icon(RpgAwesome.wooden_sign),
                      ),
                      onSaved: (String? value) => widget.plant.setName = value!,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        return (value == null || value.isEmpty)
                            ? 'Darf nicht leer sein'
                            : null;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                      initialValue: widget.plant.roomName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Spezies",
                        icon: Icon(RpgAwesome.flowers),
                      ),
                      onSaved: (String? value) =>
                          widget.plant.setRoomName = value!,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        return (value == null || value.isEmpty)
                            ? 'Darf nicht leer sein'
                            : null;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                      initialValue: widget.plant.roomName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Zimmer",
                        icon: Icon(FontAwesome5.house_user),
                      ),
                      onSaved: (String? value) =>
                          widget.plant.setRoomName = value!,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        return (value == null || value.isEmpty)
                            ? 'Darf nicht leer sein'
                            : null;
                      }),
                ),
              ],
            ),
          );
        },
      );

  Widget buildPlantScreenElements(BuildContext context, int index) => <Widget>[
        //Elemente die in der Liestview sind
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Image(
              image: widget.plant.imagePath.isEmpty
                  ? GeneralArguments.defaultPlantImg
                  : FileImage(File(widget.plant.imagePath)),
              height: 400,
              fit: BoxFit.fitWidth,
            )),
        Row(
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                    text: widget.plant.name + '\n',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.plant.roomName,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white70))
                    ]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showBottomSheet(context);
              },
              child: const Icon(Icons.edit),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                          text: 'Gießen\n',
                          style: const TextStyle(color: Colors.blue),
                          children: <TextSpan>[
                            TextSpan(
                              text: widget.plant.waterInDays(),
                              style: const TextStyle(color: Colors.white),
                            )
                          ]),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          widget.plant.setLastWatering = DateTime.now();
                          setState(() {
                            widget.callback;
                          });
                        },
                        child: const Icon(
                          Entypo.droplet,
                          size: 20,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15),
                          primary: Colors.blue,
                          minimumSize: Size.zero,
                        )),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: Colors.grey.shade700,
                  border: Border.all(
                    width: 8,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            //TODO: sehr hässliche Abfrage, das geht schöner!
            widget.plant.fertilising == null
                ? const SizedBox.shrink()
                : Expanded(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                      text: 'Düngen\n',
                                      style: const TextStyle(
                                          color: Colors.deepOrange),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: widget.plant.fertiliseInDays(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ]),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      widget.plant.setLastFerilising =
                                          DateTime.now();
                                      setState(() {
                                        widget.callback;
                                      });
                                    },
                                    child: const Icon(
                                      Entypo.leaf,
                                      size: 20,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(15),
                                      primary: Colors.deepOrange,
                                      minimumSize: Size.zero,
                                    )),
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: Colors.grey.shade700,
                              border: Border.all(
                                width: 8,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
        Text.rich(
          TextSpan(
              text: 'Notizen\n',
              style: const TextStyle(color: Colors.indigo),
              children: <TextSpan>[
                TextSpan(
                  text: widget.plant.notes,
                  style: const TextStyle(color: Colors.white),
                )
              ]),
        ),
      ][index];
}
