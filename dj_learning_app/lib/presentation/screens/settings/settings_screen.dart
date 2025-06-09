// lib/presentation/screens/settings/settings_screen.dart
// ------------------------------------------------------------
// Beatquest – Settings Screen
// ------------------------------------------------------------
// This screen serves as a placeholder for user account or app settings.
// It currently displays a centered message but may include future options
// like:
// - Theme switching
// - Audio preferences
// - Account management
// - Logout functionality
//
// This uses standard Scaffold layout with custom app bar styling.
// ------------------------------------------------------------
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Use global background color
      appBar: AppBar(
        backgroundColor: Colors.white,       // Header styling: white background
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(color: AppColors.textPrimary), // Dark title text
        ),
        centerTitle: true, // Center the app bar title
      ),
      body: const Center(
        // Placeholder text for future settings implementation
        child: Text(
          'Settings content goes here...',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}