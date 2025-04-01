import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash_screen.dart'; // 💡 Make sure this file exists and is imported

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // 🔥 Initializes Firebase

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // 🚀 Starts with the Splash screen
    ),
  );
}
