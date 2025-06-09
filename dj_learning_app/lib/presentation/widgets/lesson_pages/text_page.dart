// lib/presentation/widgets/lesson_pages/text_page.dart
// ------------------------------------------------------------
// Beatquest – TextPage Widget
// ------------------------------------------------------------
// This widget displays an instructional text page from a lesson.
// It is used to convey theoretical content or explanatory steps
// between interactive questions.
//
// Features:
// - Displays main question or concept text
// - Optionally shows an explanation in italic below
// - Centered layout with padding
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:dj_learning_app/core/models/lesson.dart';

class TextPage extends StatelessWidget {
  final LessonPageModel page; // Lesson content object containing text + optional explanation

  const TextPage({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              page.question, // Main title or instructional text
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            // Conditionally render explanation if it exists
            if (page.explanation != null) ...[
              const SizedBox(height: 24),
              Text(
                page.explanation!, // Optional explanation paragraph
                style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                textAlign: TextAlign.center,
              )
            ]
          ],
        ),
      ),
    );
  }
}
