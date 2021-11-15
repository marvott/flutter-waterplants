import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'general_arguments.dart';

class PlantOverview extends StatefulWidget {
  const PlantOverview({
    Key? key,
  }) : super(key: key);

  @override
  State<PlantOverview> createState() => _PlantOverviewState();
}

class _PlantOverviewState extends State<PlantOverview> {
  @override
  Widget build(BuildContext context) {
    // map mit name, imag und onPressedFunction
    List<Map> plantList = [
      {
        'name': 'Zierlicher Peter',
        'image': GeneralArguments.defaultPlantImg,
        'plantRoute': '/plant'
      },
      {
        'name': 'Zierlicher Peter',
        'image': GeneralArguments.defaultPlantImg,
        'plantRoute': '/plant'
      },
      {
        'name': 'Zierlicher Peter',
        'image': GeneralArguments.defaultPlantImg,
        'plantRoute': '/plant'
      },
      // Image(
      //   // image: FileImage(File(GeneralArguments.imagePath)),
      //   image: GeneralArguments.imagePath.isEmpty
      //       ? GeneralArguments.defaultPlantImg
      //       : FileImage(File(GeneralArguments.imagePath)),
      //   fit: BoxFit.cover,
      // )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pflanzen'),
      ),

      // Inhalt der Pflanzen-Seite
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemCount: plantList.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/plant');
                },
                splashColor: Colors.green,
                child: Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          child: Image(
                            image: GeneralArguments.imagePath.isEmpty
                                ? GeneralArguments.defaultPlantImg
                                : FileImage(File(GeneralArguments.imagePath)),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.green.shade800,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            )),
                        child: Text(
                          plantList[index]['name'],
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

//Navigator.pushNamed(context, '/plant')
