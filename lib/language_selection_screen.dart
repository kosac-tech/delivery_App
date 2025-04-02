import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'phone_login_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguage;

  final Map<String, Locale> languageMap = {
    'English': const Locale('en'),
    'हिंदी': const Locale('hi'),
    'मराठी': const Locale('mr'),
  };

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
  }

  // Load the saved language preference from SharedPreferences
  _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('language');
    if (savedLanguage != null) {
      setState(() {
        _selectedLanguage = savedLanguage == 'en'
            ? 'English'
            : savedLanguage == 'hi'
                ? 'हिंदी'
                : 'मराठी';
      });
    }
  }

  Future<void> _saveLanguageAndProceed(BuildContext context) async {
    if (_selectedLanguage != null) {
      final locale = languageMap[_selectedLanguage!]!;
      
      // Save preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasLanguage', true);
      await prefs.setString('language', locale.languageCode);

      // Set the locale
      if (mounted) {
        await context.setLocale(locale);
        
        // Force a rebuild of the entire app
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const PhoneLoginScreen()),
            (route) => false,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Kosac logo
              Center(
                child: Image.asset(
                  'assets/delivery_partner_logo.png',
                  width: 180,
                ),
              ),
              const Spacer(),

              // Title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tr('select_language'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Dropdown
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                decoration: InputDecoration(
                  labelText: tr('language'),
                  border: const OutlineInputBorder(),
                ),
                items: languageMap.keys.map((lang) {
                  return DropdownMenuItem(
                    value: lang,
                    child: Text(lang),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),

              const Spacer(),

              // Next Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0051BA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  onPressed: () => _saveLanguageAndProceed(context),
                  child: Text(
                    tr('next'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
