import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:firebase_core/firebase_core.dart';
import 'language_selection_screen.dart';
import 'phone_login_screen.dart';
import 'otp_verification_screen.dart'; // If needed
import 'home_screen.dart'; // Optional

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized(); // ⬅️ important
  await Firebase.initializeApp(); // Initialize Firebase

  // Check the login state and language preference
  bool isLoggedIn = await checkLoginState();
  String languageCode = await getLanguagePreference();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('mr'),
      ],
      path: 'assets/lang', // ⬅️ path to your JSON files
      fallbackLocale: const Locale('en'),
      startLocale: Locale(languageCode), // Set the initial locale
      child: MyApp(isLoggedIn: isLoggedIn, languageCode: languageCode),
    ),
  );
}

// Function to check login state from SharedPreferences
Future<bool> checkLoginState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;  // Defaults to false if not set
}

// Function to get the language preference from SharedPreferences
Future<String> getLanguagePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('language') ?? 'en';  // Defaults to 'en' if not set
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String languageCode;

  MyApp({required this.isLoggedIn, required this.languageCode, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kosac Delivery App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale, // Use context.locale instead of creating a new Locale
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => isLoggedIn ? const HomeScreen() : const SplashScreen(),
        '/language': (context) => const LanguageSelectionScreen(),
        '/login': (context) => const PhoneLoginScreen(),
        '/home': (context) => isLoggedIn ? const HomeScreen() : const PhoneLoginScreen(),
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
    Future.delayed(const Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool hasLanguage = prefs.getBool('hasLanguage') ?? false;
      
      if (hasLanguage) {
        // Navigate to login or home based on login state
        bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      } else {
        // Navigate to language selection screen
        Navigator.pushReplacementNamed(context, '/language');
      }
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
