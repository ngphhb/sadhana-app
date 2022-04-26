import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState(){

    Timer(const Duration(milliseconds: 1000), (){
      setState(() async {
        final prefs = await SharedPreferences.getInstance();
        Object userid = prefs.get('userid') ?? "null";
        if (userid.toString().compareTo("null") == 0)
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
        else
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
      });
    });

    Timer(
      Duration(milliseconds: 10),(){
        setState(() {
          _isVisible = true; // Now it is showing fade effect and navigating to Login page
        });
      }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).accentColor, Theme.of(context).primaryColor],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Image.asset("assets/icon/sp.png"),
          // child: Container(
          //   height: 140.0,
          //   width: 140.0,
          //   child: const Center(
          //     // child: Image(
          //     //   image: AssetImage('assets/icon/sp.png'),
          //     // ),
          //     child: ClipOval(
          //       child: Icon(Icons.android_outlined, size: 128,), //put your logo here
          //       // child: Image(
          //       //   image: AssetImage('assets/icon/sp.png'),
          //       // ),
          //     ),
          //   ),
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Colors.white,
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.3),
          //         blurRadius: 2.0,
          //         offset: Offset(5.0, 3.0),
          //         spreadRadius: 2.0,
          //       )
          //     ]
          //   ),
          // ),
        ),
      ),
    );
  }
}