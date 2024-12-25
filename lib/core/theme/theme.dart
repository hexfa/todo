import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors for Light Theme
Color primaryColor = Colors.deepPurple.shade200;
const Color onPrimaryColor = Colors.white;
const Color cardColor = Colors.white;
const Color onCardColor = Colors.black87;
const Color backgroundColor = Colors.white;
const Color errorColor = Color(0xffff3969);
const Color onErrorColor = Colors.white;

// Colors for Dark Theme
Color darkPrimaryColor = Colors.deepPurple.shade500;
const Color darkOnPrimaryColor = Colors.white;
const Color darkCardColor = Colors.black45;
Color darkBackgroundColor = Colors.grey.shade800;
const Color darkErrorColor = Color(0xffff6767);
const Color darkOnErrorColor = Colors.black;

final List<Color> gradiantColors = [
  Colors.red.shade100,
  Colors.blue.shade100,
  Colors.green.shade100,
  Colors.purple.shade50,
  Colors.orange.shade100,
  Colors.pink.shade100,
  Colors.teal.shade100,
  Colors.amber.shade100,
];

Color getRandomColor(BuildContext context) {
  var random = Random();
  return gradiantColors[random.nextInt(gradiantColors.length)];
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: AppBarTheme(
    color: primaryColor,
    foregroundColor: onPrimaryColor,
  ),
  cardTheme: const CardTheme(
    color: cardColor,
    elevation: 2,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: onPrimaryColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      textStyle: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black87),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10),
    ),
    hintStyle: GoogleFonts.roboto(
      color: Colors.black54,
      fontWeight: FontWeight.w300,
    ),
    contentPadding: const EdgeInsets.all(16),
  ),
  cardColor: cardColor,
  colorScheme: ColorScheme.light(
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    surface: backgroundColor,
    onSurface: Colors.black87,
    error: errorColor,
    onError: onErrorColor,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.roboto(color: Colors.black87),
    displayMedium: GoogleFonts.roboto(color: Colors.black87),
    displaySmall: GoogleFonts.roboto(color: Colors.black87),
    headlineLarge: GoogleFonts.roboto(color: Colors.black87),
    headlineMedium: GoogleFonts.roboto(color: Colors.black87),
    headlineSmall: GoogleFonts.roboto(color: Colors.black87),
    titleLarge: GoogleFonts.roboto(color: Colors.black87),
    titleMedium: GoogleFonts.roboto(color: Colors.black87),
    titleSmall: GoogleFonts.roboto(color: Colors.black87),
    bodyLarge: GoogleFonts.roboto(color: Colors.black87),
    bodyMedium: GoogleFonts.roboto(color: Colors.black87),
    bodySmall: GoogleFonts.roboto(color: Colors.black87),
    labelLarge: GoogleFonts.roboto(color: Colors.black87),
    labelMedium: GoogleFonts.roboto(color: Colors.black87),
    labelSmall: GoogleFonts.roboto(color: Colors.black87),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: darkBackgroundColor,
  appBarTheme: AppBarTheme(
    color: darkPrimaryColor,
    foregroundColor: darkOnPrimaryColor,
  ),
  cardTheme: const CardTheme(
    color: darkCardColor,
    elevation: 2,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkPrimaryColor,
      foregroundColor: darkOnPrimaryColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      textStyle: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkPrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white70),
      borderRadius: BorderRadius.circular(10),
    ),
    hintStyle: GoogleFonts.roboto(
      color: Colors.white54,
      fontWeight: FontWeight.w300,
    ),
    contentPadding: const EdgeInsets.all(16),
  ),
  cardColor: darkCardColor,
  colorScheme: ColorScheme.dark(
    primary: darkPrimaryColor,
    onPrimary: darkOnPrimaryColor,
    surface: darkBackgroundColor,
    onSurface: Colors.white,
    error: darkErrorColor,
    onError: darkOnErrorColor,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.roboto(color: Colors.white),
    displayMedium: GoogleFonts.roboto(color: Colors.white),
    displaySmall: GoogleFonts.roboto(color: Colors.white),
    headlineLarge: GoogleFonts.roboto(color: Colors.white),
    headlineMedium: GoogleFonts.roboto(color: Colors.white),
    headlineSmall: GoogleFonts.roboto(color: Colors.white),
    titleLarge: GoogleFonts.roboto(color: Colors.white),
    titleMedium: GoogleFonts.roboto(color: Colors.white),
    titleSmall: GoogleFonts.roboto(color: Colors.white),
    bodyLarge: GoogleFonts.roboto(color: Colors.white),
    bodyMedium: GoogleFonts.roboto(color: Colors.white),
    bodySmall: GoogleFonts.roboto(color: Colors.white),
    labelLarge: GoogleFonts.roboto(color: Colors.white),
    labelMedium: GoogleFonts.roboto(color: Colors.white),
    labelSmall: GoogleFonts.roboto(color: Colors.white),
  ),
);
