import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class MakeQR extends StatefulWidget {
  @override
  _MakeQRState createState() => _MakeQRState();
}

class _MakeQRState extends State<MakeQR> {
  GlobalKey _globalKey = new GlobalKey();
  GlobalKey scaffkey = new GlobalKey();
  String groupVal = 'Free Text';
  String qrData = '';
  TextEditingController qrText = TextEditingController();

  bool urlVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffkey,
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
                value: 'Free Text',
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
                value: 'URL',
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
                value: 'Phone',
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onSubmitted: (value) {
                        setState(() {
                          qrData = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          qrData = value;
                        });
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        labelText: groupVal,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Neumorphic(
                    style: NeumorphicStyle(depth: -5),
                    child: RepaintBoundary(
                      key: _globalKey,
                      child: Container(
                        color: Colors.white,
                        child: QrImage(
                          data: qrData,
                        ),
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
                    onPressed: () {
                      shareimage();
                    },
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

  Future capturePng() async {
    try {
      await Permission.storage.request().then((value) async {
        RenderRepaintBoundary boundary =
            _globalKey.currentContext.findRenderObject();
        ui.Image image = await boundary.toImage(pixelRatio: 5.0);
        ByteData byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        var pngBytes = byteData.buffer.asUint8List();

        String dtx = DateTime.now().millisecondsSinceEpoch.toString();
        //final file = await new File('${tempDir.path}/QR Tools $dtx.png').create();
        //await file.writeAsBytes(pngBytes);

        new Directory('/sdcard/DCIM/QR Toolkit/').create();
        final file2 =
            await new File('/sdcard/DCIM/QR Toolkit/QR Toolkit $dtx.png')
                .create();
        await file2.writeAsBytes(pngBytes);
        Flushbar(
            message: 'Saved!',
            duration: Duration(
              seconds: 1,
            )).show(context);
      });
    } catch (e) {}
  }

  void shareimage() async {
    try {
      var status = await Permission.camera.status;
      await Permission.storage.request().isGranted;
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 5.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      String dtx = DateTime.now().millisecondsSinceEpoch.toString();
      new Directory('/sdcard/DCIM/QR Toolkit/').create();
      final file2 =
          await new File('/sdcard/DCIM/QR Toolkit/QR Toolkit Temp.png')
              .create();
      await file2.writeAsBytes(pngBytes);
      await WcFlutterShare.share(
          sharePopupTitle: 'QR Toolkit : Share QR',
          fileName: 'QR Toolkit $dtx.png',
          mimeType: 'image/png',
          bytesOfFile: pngBytes);
    } catch (e) {}
  }
}
