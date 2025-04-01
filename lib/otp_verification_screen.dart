import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          tr('verify_otp'),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              tr('enter_otp', args: [phoneNumber]),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: tr('otp'),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(tr('login_success')),
                      backgroundColor: const Color(0xFF0051BA),
                    ),
                  );
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pushReplacementNamed(context, '/home');
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0051BA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  tr('verify'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
