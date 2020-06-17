import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MakeQR extends StatefulWidget {
  @override
  _MakeQRState createState() => _MakeQRState();
}

class _MakeQRState extends State<MakeQR> {
  GlobalKey _globalKey = new GlobalKey();
  String groupVal = '1';
  String qrData = '';
  TextEditingController qrText = TextEditingController();

  bool urlVisibility = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 64,
              width: 72,
              child: NeumorphicRadio(
                style: NeumorphicRadioStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                      topLeft: Radius.circular(32.0))),
                ),
                groupValue: groupVal,
                value: '1',
                child: Center(child: Text('Free Text')),
                onChanged: (value) {
                  setState(() {
                    groupVal = value;
                    urlVisibility = false;
                  });
                },
              ),
            ),
            Container(
              height: 64,
              width: 72,
              child: NeumorphicRadio(
                style: NeumorphicRadioStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.rect()),
                groupValue: groupVal,
                value: '2',
                child: Center(child: Text('URL')),
                onChanged: (value) {
                  setState(() {
                    groupVal = value;
                    urlVisibility = true;
                  });
                },
              ),
            ),
            Container(
              height: 64,
              width: 72,
              child: NeumorphicRadio(
                style: NeumorphicRadioStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
                      bottomRight: Radius.circular(32.0),
                      topRight: Radius.circular(32.0))),
                ),
                groupValue: groupVal,
                value: '3',
                child: Center(child: Text('Phone')),
                onChanged: (value) {
                  setState(() {
                    groupVal = value;
                    urlVisibility = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Visibility(
                  visible: urlVisibility,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text('Usage of "Https://" is Highly Recommended!'),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Neumorphic(
                  style:
                      NeumorphicStyle(shape: NeumorphicShape.flat, depth: -5),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        qrData = value;
                      });
                    },
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Neumorphic(
                    style: NeumorphicStyle(depth: -5),
                    child: RepaintBoundary(
                      key: _globalKey,
                      child: QrImage(
                        data: qrData,
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  NeumorphicButton(
                    onPressed: () {
                      capturePng();
                    },
                    child: Row(
                      children: <Widget>[Icon(Icons.save), Text('Save')],
                    ),
                  ),
                  NeumorphicButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[Icon(Icons.share), Text('Share')],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List> capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 5.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      //print(pngBytes);
      //print(bs64);
      print(image.height);
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }
}
