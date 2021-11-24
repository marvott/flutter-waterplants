import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/components/plant_edit_sheet.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

import 'package:flutter_application_1/components/snackbar_dialog.dart';
import 'package:flutter_application_1/models/general.dart';
import 'package:flutter_application_1/models/plant.dart';

class PlantScreen extends StatefulWidget {
  final Function plantOverviewCallback;
  final Plant plant;
  const PlantScreen({
    Key? key,
    required this.plantOverviewCallback,
    required this.plant,
  }) : super(key: key);

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  final formKeyPlantedit = GlobalKey<FormState>();
  final formKeyWatering = GlobalKey<FormState>();
  final formKeyFertilizing = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();

  //Farben der Listview, gehe sicher dass es die RICHTIGE LÄNGE HAT!
  final List myColors = <Color>[
    Colors.transparent,
    Colors.grey.shade700,
    Colors.grey.shade700,
    Colors.grey.shade700,
  ];

  DateTime? pickedDate;

  callback() {
    setState(() {});
  }

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
                      widget.plantOverviewCallback();
                    }));
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }

  // void showBottomSheetPlantEdit(BuildContext context) => showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true,
  //       builder: (BuildContext context) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //             bottom: MediaQuery.of(context).viewInsets.bottom,
  //           ),
  //           child: Form(
  //             key: formKeyPlantedit,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 ElevatedButton(
  //                     onPressed: () {
  //                       final isValid =
  //                           formKeyPlantedit.currentState!.validate();
  //                       if (isValid) {
  //                         formKeyPlantedit.currentState!.save();
  //                         setState(() {
  //                           widget.plantOverviewCallback();
  //                         });
  //                         Navigator.pop(context);
  //                       }
  //                     },
  //                     child: const Text("Speichern")),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8),
  //                   child: TextFormField(
  //                       initialValue: widget.plant.name,
  //                       decoration: const InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: "Name",
  //                         icon: Icon(RpgAwesome.wooden_sign),
  //                       ),
  //                       onSaved: (String? value) =>
  //                           widget.plant.setName = value!,
  //                       autovalidateMode: AutovalidateMode.onUserInteraction,
  //                       validator: (String? value) {
  //                         return (value == null || value.isEmpty)
  //                             ? 'Darf nicht leer sein'
  //                             : null;
  //                       }),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8),
  //                   child: TextFormField(
  //                       initialValue: widget.plant.species,
  //                       decoration: const InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: "Spezies",
  //                         icon: Icon(RpgAwesome.flowers),
  //                       ),
  //                       onSaved: (String? value) =>
  //                           widget.plant.setSpecies = value!,
  //                       autovalidateMode: AutovalidateMode.onUserInteraction,
  //                       validator: (String? value) {
  //                         return (value == null || value.isEmpty)
  //                             ? 'Darf nicht leer sein'
  //                             : null;
  //                       }),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8),
  //                   child: TextFormField(
  //                       initialValue: widget.plant.roomName,
  //                       decoration: const InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: "Zimmer",
  //                         icon: Icon(FontAwesome5.house_user),
  //                       ),
  //                       onSaved: (String? value) =>
  //                           widget.plant.setRoomName = value!,
  //                       autovalidateMode: AutovalidateMode.onUserInteraction,
  //                       validator: (String? value) {
  //                         return (value == null || value.isEmpty)
  //                             ? 'Darf nicht leer sein'
  //                             : null;
  //                       }),
  //                 ),
  //                 const SizedBox(height: 50)
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );

  void showBottomSheetWatering(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Form(
            key: formKeyWatering,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        final isValid =
                            formKeyWatering.currentState!.validate();
                        if (isValid) {
                          formKeyWatering.currentState!.save();
                          setState(() {
                            widget.plantOverviewCallback();
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Fertig")),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        initialValue: "${widget.plant.waterInterval}",
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Gieß-Interwall in Tagen",
                          icon: Icon(Entypo.droplet),
                        ),
                        onSaved: (String? value) =>
                            widget.plant.setWaterInterval = int.parse(value!),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'Darf nicht leer sein'
                              : null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        pickDate(context, widget.plant.lastWatering);
                      },
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          enabled: false,
                          controller: _dateController
                            ..text =
                                "${widget.plant.lastWatering.day}.${widget.plant.lastWatering.month}.${widget.plant.lastWatering.year}",
                          //initialValue: "${widget.plant.lastWatering}",
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Zuletzt gegossen",
                            icon: Icon(Entypo.back_in_time),
                          ),
                          onSaved: (String? value) {
                            if (pickedDate != null) {
                              widget.plant.lastWatering = pickedDate!;
                              pickedDate = null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            return (value == null || value.isEmpty)
                                ? 'Darf nicht leer sein'
                                : null;
                          }),
                    ),
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
          );
        },
      );

  void showBottomSheetFertilizing(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Form(
            key: formKeyFertilizing,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        final isValid =
                            formKeyFertilizing.currentState!.validate();
                        if (isValid) {
                          formKeyFertilizing.currentState!.save();
                          setState(() {
                            widget.plantOverviewCallback();
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Speichern")),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        initialValue:
                            "${widget.plant.fertilising!.fertiliserInterval}",
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Düngen-Interwall in Tagen",
                          icon: Icon(Entypo.droplet),
                        ),
                        onSaved: (String? value) => widget.plant.fertilising!
                            .setFertiliserInterval = int.parse(value!),
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
                        keyboardType: TextInputType.datetime,
                        // inputFormatters: <TextInputFormatter>[
                        //   FilteringTextInputFormatter.digitsOnly
                        // ],
                        initialValue:
                            "${widget.plant.fertilising!.lastFertilising}",
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Zuletzt gedüngt",
                          icon: Icon(Entypo.back_in_time),
                        ),
                        onSaved: (String? value) => widget.plant.fertilising!
                            .setLastFertilising = DateTime.parse(value!),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'Darf nicht leer sein'
                              : null;
                        }),
                  ),
                  const SizedBox(height: 50)
                ],
              ),
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
              //Ändern in eine colum mit 2 Text Feldern um maxline anzuwenden
              child: Text.rich(
                TextSpan(
                    text: widget.plant.name + '\n',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      overflow: TextOverflow.ellipsis,
                    ),
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
                // showBottomSheetPlantEdit(context);
                showBottomSheetPlantEdit(context, widget.plant, callback,
                    widget.plantOverviewCallback);
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
              child: GestureDetector(
                onTap: () {
                  showBottomSheetWatering(context);
                },
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
                            String message =
                                "${widget.plant.name} wurde gegossen";
                            Utils.showSnackBar(context,
                                message: message, color: Colors.blue);
                            widget.plant.setLastWatering = DateTime.now();
                            setState(() {
                              widget.plantOverviewCallback;
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
                          child: GestureDetector(
                            onTap: () {
                              showBottomSheetFertilizing(context);
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                        text: 'Düngen\n',
                                        style: const TextStyle(
                                            color: Colors.deepOrange),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                widget.plant.fertiliseInDays(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )
                                        ]),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        String message =
                                            "${widget.plant.name} wurde gedüngt";
                                        Utils.showSnackBar(context,
                                            message: message,
                                            color: Colors.deepOrange);
                                        widget.plant.fertilising!
                                                .setLastFertilising =
                                            DateTime.now();
                                        setState(() {
                                          widget.plantOverviewCallback;
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
                        ),
                      ],
                    ),
                  ),
          ],
        ),
        //TODO farbe ändern
        Text.rich(
          TextSpan(
              text: 'Notizen\n',
              style: const TextStyle(
                color: Colors.green,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: widget.plant.notes,
                  style: const TextStyle(color: Colors.white),
                )
              ]),
        ),
      ][index];

  Future pickDate(BuildContext context, DateTime initialDate) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );

    if (newDate == null) return;
    setState(() {
      //Todo Dateformater verwenden
      _dateController.text = "${newDate.day}.${newDate.month}.${newDate.year}";
      pickedDate = newDate;
    });
  }
}
