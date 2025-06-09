// lib/presentation/screens/welcome/welcome_screen.dart
// ------------------------------------------------------------
// Beatquest – Welcome Screen
// ------------------------------------------------------------
// This screen is the first entry point of the Beatquest app.
// It presents branding and two primary navigation buttons for
// new and returning users.
//
// Features:
// - "Get Started" button navigates to registration screen
// - "Already have an account" goes to login screen
// - Styled with primary brand colors and centralized layout
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dj_learning_app/core/constants/colors.dart';
import 'package:dj_learning_app/core/theme/app_text_styles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Use global background color
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between title and buttons
          children: [
            const SizedBox(height: 40), // Top padding
            const Text(
              'BeatQuest',
              style: AppTextStyles.heading, // App title styling
            ),
            const SizedBox(), // Spacer to center content vertically
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Primary action: Register new account
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      context.go('/register'); // Navigate to register screen
                    },
                    child: const Text(
                      'GET STARTED',
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Secondary action: Existing user login
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.textSecondary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      context.go('/login'); // Navigate to login screen
                    },
                    child: const Text(
                      'I ALREADY HAVE AN ACCOUNT',
                      style: AppTextStyles.linkText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}