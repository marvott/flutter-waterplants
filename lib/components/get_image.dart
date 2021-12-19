import 'dart:io';

import 'package:flutter/material.dart';

ImageProvider getImage(String imgPath) {
  if (File("imgPath").existsSync()) {
    return FileImage(File(imgPath));
  } else {
    return const AssetImage("assets/images/plant.jpeg");
  }
}
