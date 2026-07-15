import 'package:flutter/material.dart';

enum Language {
  en,
  ar,
}

class LanguageSettings {
  static final ValueNotifier<Language> currentLanguage = ValueNotifier<Language>(Language.en);

  static bool get isArabic => currentLanguage.value == Language.ar;

  static void toggleLanguage() {
    currentLanguage.value = currentLanguage.value == Language.en ? Language.ar : Language.en;
  }
}
