import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrtools/Styles/Theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = '';
  QRViewController qrViewController;

  Color flash = Colors.grey.shade800;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Hero(
      tag: 'hometag',
          child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: NeumorphicAppBar(
          title: Text('Scan QR', style: mainTextTheme(24),),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
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
                  height: 16,
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
                  height: 16,
                ),
                Visibility(
                  visible: (qrText == '') ? false:true,
                                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Neumorphic(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableLinkify(
                          text: qrText,
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.qrViewController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }
}
