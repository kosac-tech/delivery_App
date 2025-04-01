import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phoneNumber;

  // Remove `const` from the constructor of the widget
  OtpVerificationScreen({super.key, required this.phoneNumber});

  // Non-const TextEditingController for OTP input field
  final TextEditingController _otpController = TextEditingController();

  // Save the login state after OTP verification
  Future<void> saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true); // Mark the user as logged in
  }

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
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // OTP Info Text
            Text(
              tr('enter_otp', namedArgs: {'phone': phoneNumber}),
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // OTP Input Field
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: tr('otp'),
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // Verify Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  // Simulate OTP verification success
                  // You would add actual verification logic here (e.g., using Firebase)

                  // Save login state on successful OTP verification
                  await saveLoginState();

                  // Show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(tr('login_success'))),
                  );

                  // Navigate to Home Screen after successful login
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0051BA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  tr('verify'),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
