// lib/theme.dart
// -------------------------------------------------------
// APP THEME CONFIGURATION (Simplified - No CardTheme)
// -------------------------------------------------------

import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF036666); // Deep green (Biliran sea)
  static const Color primaryDark = Color(0xFF024E4E);
  static const Color accent = Color(0xFFFFB703); // Warm yellow accent
  static const Color background = Color(0xFFF8FAFB); // Light gray background
  static const Color text = Color(0xFF1F2937); // Dark gray text
  static const Color muted = Color(0xFF6B7280); // For hints/subtle text
  static const Color card = Colors.white;
}

ThemeData buildAppTheme() {
  final base = ThemeData.light(); // Start with the default light theme

  return base.copyWith(
    // Main brand colors
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,

    // Color scheme adjustments
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.primary,
      secondary: AppColors.accent,
    ),

    // AppBar design
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: AppColors.text,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: AppColors.text,
      ),
    ),

    // TextField design
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      hintStyle: const TextStyle(color: AppColors.muted),
    ),

    // Elevated button design
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),

    // Text button design
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
  );
}
