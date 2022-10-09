import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:to_do_app/layout/board_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        log(MediaQuery.of(context).size.width.toInt().toString());

        if (MediaQuery.of(context).size.width.toInt() >= 550) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.5),
              child: const BoardScreen());
        } else if (350 < MediaQuery.of(context).size.width.toInt() &&
            MediaQuery.of(context).size.width.toInt() < 410) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: const BoardScreen());
        } else if (MediaQuery.of(context).size.width.toInt() <= 350) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 0.8),
              child: const BoardScreen());
        } else {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.2),
              child: const BoardScreen());
        }
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff04352d),
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/splach.jpg',
            ),
          ),
        ),
      ),
    );
  }
}
