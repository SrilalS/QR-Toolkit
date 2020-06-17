import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MakeQR extends StatefulWidget {
  @override
  _MakeQRState createState() => _MakeQRState();
}

class _MakeQRState extends State<MakeQR> {
  String groupVal = '1';
  String qrData = '';
TextEditingController qrText = TextEditingController();
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
                  });
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  depth: -5
                ),
                child: TextField(
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
                child: QrImage(data: 'sss')),
            )
          ],
        ),
      ),
    );
  }
}
