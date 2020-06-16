import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:qrtools/Styles/Theme.dart';

import 'ScanScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: NeumorphicAppBar(
        actions: <Widget>[
          NeumorphicButton(
            provideHapticFeedback: false,
            onPressed: () {},
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            

            Hero(
              tag: 'hometag',
                          child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    depth: 5,
                    surfaceIntensity: 0.5,
                    boxShape: NeumorphicBoxShape.circle()),
                child: Container(
                  width: w * 0.75,
                  height: w * 0.75,
                  //color: Colors.grey,
                  child: Center(
                    child: NeumorphicIcon(
                      Icons.blur_on,
                      size: w*0.5,
                      style: NeumorphicStyle(
                        depth: 2
                      ),
                      ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: w / 5,
            ),
            Container(
              height: h * 0.1,
              width: w * 0.6,
              child: NeumorphicButton(
                provideHapticFeedback: false,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScanScreen()));
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                ),
                child: Center(
                    child: Text(
                  'Scan QR Code',
                  style: mainTextTheme(16.0),
                )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: h * 0.1,
              width: w * 0.6,
              child: NeumorphicButton(
                provideHapticFeedback: false,
                onPressed: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanScreen()));
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                ),
                child: Center(
                    child: Text(
                  'Create a QR Code',
                  style: mainTextTheme(16.0),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
