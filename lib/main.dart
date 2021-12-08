import 'package:crypto_xe/screens/crypto_list.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.black,
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
          fontFamily: 'Poppins'),
      home: SplashScreen(
          seconds: 3,
          navigateAfterSeconds: CryptoXE(),
          backgroundColor: Colors.white,
          loadingText: Text('Crypto XR'),
          title: Text(
            'CXr',
            style: TextStyle(
                color: Colors.black, fontSize: 58, fontWeight: FontWeight.bold),
          ),
          photoSize: 100,
          loaderColor: Colors.black),
    ));

class CryptoXE extends StatefulWidget {
  @override
  _CryptoXEState createState() => _CryptoXEState();
}

class _CryptoXEState extends State<CryptoXE> {
  @override
  Widget build(BuildContext context) {
    return CryptoList();
  }
}
