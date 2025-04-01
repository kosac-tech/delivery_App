import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  Locale? _selectedLocale;

  final Map<String, Locale> languageMap = {
    'English': const Locale('en'),
    'हिंदी': const Locale('hi'),
    'मराठी': const Locale('mr'),
  };

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
              Center(
                child: Image.asset(
                  'assets/delivery_partner_logo.png',
                  width: 180,
                ),
              ),
              const Spacer(),

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

              DropdownButtonFormField<Locale>(
                value: _selectedLocale,
                decoration: InputDecoration(
                  labelText: tr('language'),
                  border: const OutlineInputBorder(),
                ),
                items: languageMap.entries.map((entry) {
                  return DropdownMenuItem(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
                onChanged: (locale) {
                  setState(() {
                    _selectedLocale = locale;
                    context.setLocale(locale!);
                  });
                },
              ),

              const Spacer(),

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
                  onPressed: () {
                    if (_selectedLocale != null) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
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
