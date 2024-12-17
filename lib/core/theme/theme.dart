import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors for Light Theme
const Color primaryColor = Colors.deepPurple;
const Color onPrimaryColor = Colors.white;
const Color cardColor = Colors.white;
const Color onCardColor = Colors.black87;
const Color backgroundColor = Colors.white;
const Color errorColor = Color(0xffff3969);
const Color onErrorColor = Colors.white;

// Colors for Dark Theme
const Color darkPrimaryColor = Colors.deepPurpleAccent;
const Color darkOnPrimaryColor = Colors.white;
const Color darkCardColor = Color(0xFF1E1E1E);
const Color darkBackgroundColor = Colors.black;
const Color darkErrorColor = Color(0xffff6767);
const Color darkOnErrorColor = Colors.black;

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: const AppBarTheme(
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
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    background: backgroundColor,
    error: errorColor,
    onError: onErrorColor,
  ),
  textTheme: GoogleFonts.robotoTextTheme(),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: darkBackgroundColor,
  appBarTheme: const AppBarTheme(
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
  colorScheme: const ColorScheme.dark(
    primary: darkPrimaryColor,
    onPrimary: darkOnPrimaryColor,
    background: darkBackgroundColor,
    error: darkErrorColor,
    onError: darkOnErrorColor,
  ),
  textTheme: GoogleFonts.robotoTextTheme(
    const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
  ),
);
