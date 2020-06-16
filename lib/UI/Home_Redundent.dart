import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:qrtools/Styles/Theme.dart';
import 'package:qrtools/UI/Home.dart';



class HomeRedundent extends StatefulWidget {
  @override
  _HomeRedundentState createState() => _HomeRedundentState();
}

class _HomeRedundentState extends State<HomeRedundent> {
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
            Neumorphic(
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
                  child: Pulse(
                    duration: Duration(milliseconds: 2500),
                    infinite: true,
                    child: NeumorphicIcon(
                      Icons.blur_on,
                      size: w * 0.5,
                      style: NeumorphicStyle(depth: 2),
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
              child: Hero(
                tag: 'hometag',
                child: NeumorphicButton(
                  provideHapticFeedback: false,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
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
