import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:qrtools/WelcomeScreen.dart';

void main() {
  runApp(QRTools());
}

class QRTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Toolkit',
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      home: Welcome(),
    );
  }
}