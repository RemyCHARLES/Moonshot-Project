// core/constants/colors.dart
// ------------------------------------------------------------
// Beatquest – App Color Constants
// ------------------------------------------------------------
// This file defines all the main color constants used across the
// Beatquest Flutter application. Centralizing these colors ensures
// consistent theming, easier updates, and cleaner styling throughout
// the UI components.
//
// These constants are referenced in widgets, buttons, backgrounds,
// text styles, and general theme configuration.
// ------------------------------------------------------------

import 'package:flutter/material.dart';

/// Centralized class for app-wide color definitions
class AppColors {
  static const Color primary = Color(0xFF9C27B0);        // Main brand color (Purple)
  static const Color background = Color(0xFFF5F5F5);     // Default screen background (Light Grey)
  static const Color accent = Color(0xFFE1BEE7);         // Secondary accent color (Light Purple)
  static const Color textPrimary = Color(0xFF212121);    // Primary text color (Dark Grey)
  static const Color textSecondary = Color(0xFF757575);  // Secondary text color (Muted Grey)
  static const Color button = Color(0xFF8E24AA);         // Button color (Dark Purple)
}
