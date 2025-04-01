import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('home_title')),
        backgroundColor: const Color(0xFF0051BA),
      ),
      body: Center(
        child: Text(
          tr('welcome_message'),
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
