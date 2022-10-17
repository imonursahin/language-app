import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      _navigate();
    });
  }

  void _navigate() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app-icon.png',
              width: 15.w,
              height: 15.w,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'wordStart',
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w200,
                  fontSize: 30.sp),
            ),
            SizedBox(
              height: 4.h,
            ),
            CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    ));
  }
}
