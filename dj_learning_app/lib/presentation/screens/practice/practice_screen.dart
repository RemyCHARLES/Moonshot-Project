// lib/presentation/screens/practice/practice_screen.dart
// ------------------------------------------------------------
// Beatquest – Practice Screen
// ------------------------------------------------------------
// This screen acts as an entry point for the user's practice space.
// It is intended to present waveform analysis, live performance review,
// or exercise replays (in future versions).
//
// For now, it serves as a placeholder with a welcoming message.
// Future enhancements may include:
//   - Loading waveform visualizations
//   - Interactive practice tools
//   - Feedback from previous sessions
// ------------------------------------------------------------

import 'package:flutter/material.dart';

/// Stateless widget representing the practice area of the app
class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'), // Title in the top app bar
      ),
      body: const Center(
        // Display centered text as placeholder content
        child: Text(
          'Welcome to the practice section!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}