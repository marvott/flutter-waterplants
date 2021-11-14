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
              return Container(
                child: InkWell(
                  child: Text(
                    plantList[index]['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(backgroundColor: Colors.green.shade800),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/plant');
                  },
                  splashColor: Colors.white,
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: GeneralArguments.defaultPlantImg,
                        fit: BoxFit.cover),
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(8)),
              );
            }),
      ),
    );
  }
}

//Navigator.pushNamed(context, '/plant')
