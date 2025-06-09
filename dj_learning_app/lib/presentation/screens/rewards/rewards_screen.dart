// lib/presentation/screens/rewards/rewards_screen.dart
// ------------------------------------------------------------
// Beatquest – Rewards Screen (Placeholder)
// ------------------------------------------------------------
// This screen will display the user's earned rewards such as badges,
// trophies, or level milestones. It is currently a placeholder with a
// message that reward features are under development.
//
// Future functionality may include:
// - Visual list of unlocked badges
// - Reward animations and sounds
// - Integration with progress and performance
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';


class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Use global light background
      appBar: AppBar(
        backgroundColor: Colors.white,       // Header white background
        elevation: 0,
        automaticallyImplyLeading: false,    // Hide default back arrow
        title: const Text(
          'Rewards',
          style: TextStyle(
            color: AppColors.textPrimary,    // Dark title text
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,                   // Center-align the title
      ),
      body: Center(
        // Placeholder text while rewards are in progress
        child: Text(
          '🎉 Coming Soon!\nYou will be able to unlock badges, trophies, and more.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
