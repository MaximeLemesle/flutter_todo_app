import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  colorScheme: const ColorScheme.light(
    background: Color(0xFFF6F8FF),
    primary: Color(0xFF00C48C),
    secondary: Color(0xFFB2F0E3),
    surface: Colors.white,
    onBackground: Colors.black,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
  ),

  // Text
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
  ),

  // Button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF00C48C),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  ),

  // Input
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF7F7F7),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    hintStyle: const TextStyle(color: Colors.black38),
  ),
);
