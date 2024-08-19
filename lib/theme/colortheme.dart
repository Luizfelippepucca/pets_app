import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeColor {
  static final ColorScheme lightTheme =
      ColorScheme.fromSeed(primary: Colors.blue[100], seedColor: Colors.blue);

  static final TextTheme fontsTheme = TextTheme(
    titleLarge: GoogleFonts.kanit(
      textStyle: const TextStyle(fontSize: 22, letterSpacing: .5),
    ),
    headlineLarge: GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 20,
        letterSpacing: .5,
      ),
    ),
    headlineMedium: GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 18,
        letterSpacing: .5,
      ),
    ),
    displayMedium: GoogleFonts.kanit(
      textStyle:
          const TextStyle(fontSize: 18, letterSpacing: .5, color: Colors.white),
    ),
    bodyMedium: GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 16,
        letterSpacing: .5,
      ),
    ),
  );

  static final buttonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        elevation: 4,
        backgroundColor: ThemeColor.lightTheme.primary,
        foregroundColor: Colors.black),
  );

  static const bottomNavigateThemeBar = BottomNavigationBarThemeData(
      selectedItemColor: Colors.black, unselectedItemColor: Colors.white);
}
