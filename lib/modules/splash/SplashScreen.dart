import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/Utils/authutilities.dart';
import 'package:tempalteflutter/modules/home/views/screens/tabScreen.dart';
import 'package:tempalteflutter/modules/phoneauth/PhoneValidationScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    _loadNextScreen();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    animationController.forward();
    super.initState();
  }

  void _loadNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Authutilities.isuserlogin != ''
              ? TabScreen()
              : PhoneValidationScreen(),
          // ?  PhoneValidationScreen() :  PhoneValidationScreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: AllCoustomTheme.getThemeData().primaryColor,
              // color: Colors.white
            ),
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
                minWidth: MediaQuery.of(context).size.width),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/appicon.png",
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20,),
                  // new Text(
                  //   "CRICZAT",
                  //   style: new TextStyle(
                  //     fontFamily: 'Poppins',
                  //     fontSize: 40.0,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
