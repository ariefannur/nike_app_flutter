import 'dart:math';

import 'package:flutter/material.dart';

class Utils{

  static int randomRange(int min, int max){
    final _random = new Random();
    return min + _random.nextInt(max - min);
  }

  static Color getRamdomColor(int random){
    return (random == 0) ? Color(0xffe5ffe2) : (random == 1) ? Color(0xffe2f4ff) : Color(0xffffe2ea);
  }

  static Color getRamdomColorText(int random){
    return (random == 0) ? Color(0xffd3fccf) : (random == 1) ? Color(0xffd3eeff) : Color(0xffffd6e1);
  }

}