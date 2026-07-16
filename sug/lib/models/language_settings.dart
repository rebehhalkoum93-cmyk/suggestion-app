import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  static TextStyle font({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Paint? foreground,
  }) {
    final base = isArabic ? GoogleFonts.cairo : GoogleFonts.montserrat;
    return base(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      decorationStyle: decorationStyle,
      foreground: foreground,
    );
  }
}
