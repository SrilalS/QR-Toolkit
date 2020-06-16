import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

TextStyle mainTextTheme(double size) {
  return TextStyle(
      fontSize: size, fontWeight: FontWeight.bold, color: Colors.grey.shade800);
}

NeumorphicStyle mainNStyle() {
  return NeumorphicStyle(
    shape: NeumorphicShape.flat,
    boxShape: NeumorphicBoxShape.circle(),
  );
}
