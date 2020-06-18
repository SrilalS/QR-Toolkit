import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrtools/Styles/Theme.dart';
import 'package:qrtools/UI/MakeQR.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = '';
  QRViewController qrViewController;

  Color flash = Colors.grey.shade800;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade100,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.grey.shade100,
        systemNavigationBarIconBrightness: Brightness.dark));
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: NeumorphicAppBar(
        title: Text(
          'QR Toolkit',
          style: mainTextTheme(24),
        ),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: w * 0.9,
              height: w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.white,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                NeumorphicButton(
                  provideHapticFeedback: true,
                  onPressed: () async {
                    if (qrViewController != null) {
                      qrViewController.toggleFlash();
                      setState(() {
                        (flash == Colors.blue)
                            ? flash = Colors.grey.shade800
                            : flash = Colors.blue;
                      });
                    }
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.flash_on,
                    color: flash,
                  ),
                ),
                NeumorphicButton(
                  provideHapticFeedback: true,
                  onPressed: () async {
                    if (qrViewController != null) {
                      qrViewController.flipCamera();
                    }
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.switch_camera,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              height: h * 0.1,
              width: w * 0.6,
              child: NeumorphicButton(
                duration: Duration(milliseconds: 500),
                provideHapticFeedback: false,
                onPressed: () {
                  //showResult('qrResult');
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeQR()));
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                ),
                child: Center(
                    child: Text(
                  'Create QR Code',
                  style: mainTextTheme(16.0),
                )),
              ),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.qrViewController = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      showResult(scanData.toString());
      //setState(() {
      //  qrText = scanData;
      // });
    });
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  void showResult(String qrResult) {


    showDialog(
        context: context,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          actions: <Widget>[
            NeumorphicButton(
              duration: Duration(milliseconds: 250),
              provideHapticFeedback: true,
              onPressed: () {
                ClipboardManager.copyToClipBoard(qrResult);
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.content_copy,
              ),
            ),
            NeumorphicButton(
              provideHapticFeedback: false,
              onPressed: () {
                Navigator.pop(context);
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.done,
              ),
            ),
          ],
          title: Text('QR Result (Hold to Select)'),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: SelectableLinkify(
                text: qrResult,
                style: mainTextTheme(16),
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
              ),
            ),
          ),
        )).then((value) => qrViewController.resumeCamera());
  }
}
