import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrtools/UI/Home.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  
  bool visible = true;
  void perchecher() async{
    if ( await Permission.camera.isGranted == true && await Permission.storage.isGranted == true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
    } else {
      setState(() {
        visible = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    perchecher();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade100,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.grey.shade100,
        systemNavigationBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                Text('QR Toolkit', style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold , color: Colors.grey.shade800)),
                SizedBox(height:32),
                Text('Welcome!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                SizedBox(height:16),
                Text('Before We get Started we need your Permissions!', textAlign: TextAlign.center, style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                SizedBox(height:16),
                Text('Camera : To Read The QR Code', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                
                Text('Storage : To Save the QR Codes', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                SizedBox(height:16),
                Container(
                  height: 64,
                  width: 128,
                  child: NeumorphicButton(

                    child: Center(child: Text('Grant')
                    
                    ),

                    onPressed:() async{
                      await Permission.camera.request();
                      await Permission.storage.request();
                      perchecher();
                    },
                  ),
                ),
              ],
            ),

          ),
        
          Visibility(
            visible: visible,
                      child: Container(
              color: Colors.grey.shade100,
              child: Center(child:Text('QR Toolkit', style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold , color: Colors.grey.shade800)),
                  ),
            ),
          ),
        ],
      ),
      
    );
  }
}