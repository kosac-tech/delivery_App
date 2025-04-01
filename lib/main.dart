import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'language_selection_screen.dart';
import 'phone_login_screen.dart';
import 'otp_verification_screen.dart'; // If needed
import 'home_screen.dart'; // Optional

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized(); // ⬅️ important

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('mr'),
      ],
      path: 'assets/lang', // ⬅️ path to your JSON files
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kosac Delivery App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/language': (context) => const LanguageSelectionScreen(),
        '/login': (context) => const PhoneLoginScreen(),
        '/otp': (context) => const OtpVerificationScreen(phoneNumber: '1234567890'), // For testing
        '/home': (context) => const HomeScreen(), // Optional
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
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
