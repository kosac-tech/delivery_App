import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay 2 seconds then go to language selection
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/language');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0051BA),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              'assets/kosac_delivery_app_splash_screen_logo.png',
              width: 240,
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(bottom: 100),
            child: CircularProgressIndicator(
              color: Color(0xFF82D5C7),
              strokeWidth: 3,
            ),
          ),
        ],
      ),
    );
  }
}
