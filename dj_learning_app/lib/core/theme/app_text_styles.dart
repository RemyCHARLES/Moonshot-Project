// lib/core/theme/app_text_styles.dart
// ------------------------------------------------------------
// Beatquest – Centralized Text Style Definitions
// ------------------------------------------------------------
// This file defines reusable text styles used throughout the app.
// By centralizing these styles, we ensure a consistent visual identity
// and make it easier to update typography across the UI.
//
// These styles are applied in buttons, headings, links, and body text.
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:dj_learning_app/core/constants/colors.dart';

/// Collection of pre-defined text styles used across the Beatquest app
class AppTextStyles {
  /// Large, bold headline – used for titles and section headers
  static const TextStyle heading = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// White, bold text – used on primary buttons
  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// Medium-weight clickable text – used for hyperlinks or nav links
  static const TextStyle linkText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  /// Standard body copy – used for paragraphs and instructions
  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );
}
