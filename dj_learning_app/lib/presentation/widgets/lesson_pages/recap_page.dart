// lib/presentation/widgets/lesson_pages/recap_page.dart
// ------------------------------------------------------------
// Beatquest – Recap Page Widget
// ------------------------------------------------------------
// This widget is shown at the end of a lesson. It displays a summary
// of correct and incorrect answers, shows a custom explanation message,
// and allows the user to mark the lesson as completed.
//
// Features:
// - Recap of lesson performance
// - Explanation text (if any)
// - Completion logic calling backend
// - Navigation back to home screen
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Recap screen with score summary and finish button
class RecapPage extends StatelessWidget {
  final String? explanation; // Optional message or summary
  final int correctAnswers;  // Total correct answers in the lesson
  final int incorrectAnswers; // Total incorrect answers
  final Future<int?> Function() getUserId; // Function to retrieve user ID
  final Future<void> Function(int userId) markLessonAsCompleted; // Completion handler

  const RecapPage({
    super.key,
    required this.explanation,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.getUserId,
    required this.markLessonAsCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Recap title
            const Text(
              "Lesson Recap",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (explanation != null)
              // Explanation message shown if provided
              Text(
                explanation!,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 32),
            // Score boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildResultBox("Correct answers", correctAnswers, Colors.orange),
                _buildResultBox("Incorrect answers", incorrectAnswers, Colors.purple),
              ],
            ),
            const SizedBox(height: 40),
            // Button to mark lesson as complete and return to home
            ElevatedButton(
              onPressed: () async {
                final userId = await getUserId();
                print("👤 ID récupéré dans recap: $userId");
                if (userId != null) {
                  await markLessonAsCompleted(userId);
                }
                GoRouter.of(context).go('/home'); // Navigate back to home
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("CONTINUE"),
            ),
          ],
        ),
      ),
    );
  }

  // Builds a box widget showing a label and a numerical value with color accent
  Widget _buildResultBox(String label, int value, Color color) {
    return Container(
      width: 120,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          "$value\n$label",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
