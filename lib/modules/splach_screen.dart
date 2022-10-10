import 'dart:async';
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
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const BoardScreen();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xff04352d),
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/images/splash.jpg',
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 2,
                right: 2,
                child: Column(
                  children: const [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Created By Mohnad Mahamed',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
