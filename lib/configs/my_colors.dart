import 'dart:math';
import 'package:flutter/material.dart';

Random myRandom = Random();
class MyColors {
  static const seed = Colors.deepPurple;
  static const disable = Colors.blueGrey;
  static const dismiss = Colors.red;
  static const amber = Colors.amber;
  static const inputBg = Color.fromARGB(255, 245, 241, 253);

  
  static Color myRandomColor() {
    int r = myRandom.nextInt(255);
    int g = myRandom.nextInt(255);
    int b = myRandom.nextInt(255);

    return Color.fromRGBO(r, g, b, 0.85);
  }
}
