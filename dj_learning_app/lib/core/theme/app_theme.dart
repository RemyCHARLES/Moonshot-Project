// lib/core/theme/app_theme.dart
// ------------------------------------------------------------
// Beatquest – App Theme Configuration
// ------------------------------------------------------------
// This file defines the centralized light and dark themes used by
// the Beatquest Flutter application. It sets the primary color,
// typography, button styles, app bar appearance, and bottom navigation
// bar theming for both brightness modes.
//
// Centralizing themes allows consistent UI styling and simplifies
// customization across the app.
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:dj_learning_app/core/constants/colors.dart';

class AppTheme {
  /// Light mode theme configuration
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background, // Screen background color
    primaryColor: AppColors.primary,               // App accent color

    // AppBar style
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
    ),

    // Default text styles
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
    ),

    // Elevated button style
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Text button (link) style
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: TextStyle(fontWeight: FontWeight.w600),
      ),
    ),

    // Bottom navigation bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textPrimary,
    ),
  );

  /// Dark mode theme configuration
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black, // Dark background for contrast
    primaryColor: AppColors.primary,       // Consistent accent color

    // AppBar style with dark background and white text for visibility
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    // Text styles with lighter colors for readability on dark background
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
    ),

    // Elevated button style remains consistent with light theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Text button style uses primary color for emphasis
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: TextStyle(fontWeight: FontWeight.w600),
      ),
    ),

    // Bottom navigation bar with dark background and contrast colors
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.white70,
    ),
  );
}
