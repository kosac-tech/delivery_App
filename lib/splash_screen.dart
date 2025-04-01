import 'package:flutter/material.dart';
import 'dart:async';
import 'phone_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after 2 seconds
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PhoneLoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0051BA), // Kosac blue
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/kosac_delivery_app_splash_screen_logo.png',
              width: 280,
            ),
            const SizedBox(height: 60), // space between logo & loader
            const CircularProgressIndicator(
              color: Color(0xFF82D5C7), // Minty loader
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
