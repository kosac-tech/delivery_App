import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'phone_login_screen.dart'; // 👈 Make sure this is imported

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhoneLoginScreen(), // 👈 This sets your login screen
    ),
  );
}
