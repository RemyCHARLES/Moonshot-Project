// lib/presentation/widgets/lesson_pages/mcq_page.dart
// ------------------------------------------------------------
// Beatquest – MCQ Page Widget
// ------------------------------------------------------------
// This widget displays a multiple choice question (MCQ) as part of
// a lesson page. It allows the user to select one option and submit
// their answer. Once submitted, feedback is shown with optional
// explanation text and a "Next" button if provided.
//
// Features:
// - Supports selection of one answer from a list
// - Validates selection against the correct index
// - Shows success/failure and explanation
// - Optional callback to navigate to next page
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:dj_learning_app/core/models/lesson.dart';

class McqPage extends StatefulWidget {
  final LessonPageModel page; // The lesson content for this MCQ
  final void Function(bool isCorrect) onValidated; // Callback triggered after user submits
  final VoidCallback? onNext; // Optional callback to go to next page

  const McqPage({Key? key, required this.page, required this.onValidated, this.onNext}) : super(key: key);

  @override
  State<McqPage> createState() => _McqPageState();
}

class _McqPageState extends State<McqPage> {
  int? _selectedIndex; // Stores the index of selected answer
  bool _hasValidated = false; // True once user has submitted answer

  @override
  Widget build(BuildContext context) {
    final page = widget.page;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Display the question
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            page.question,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),

        // Render each option with styling based on selection
        ...?page.options?.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isSelected = index == _selectedIndex;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.blueAccent.withOpacity(0.3) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.blueAccent : Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(option, textAlign: TextAlign.center),
                onTap: _hasValidated
                    ? null
                    : () {
                        setState(() {
                          _selectedIndex = index; // Update selected option
                        });
                      },
              ),
            ),
          );
        }),

        // Show submit button once an option is selected
        if (_selectedIndex != null && !_hasValidated)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _hasValidated = true; // Mark as validated
                });
                final isCorrect = _selectedIndex == page.correctIndex;
                widget.onValidated(isCorrect); // Send result back
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: const Text("Submit"),
            ),
          ),

        // Display feedback after submission
        if (_hasValidated)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                Text(
                  _selectedIndex == page.correctIndex ? "Correct answer ✅" : "Incorrect answer ❌",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _selectedIndex == page.correctIndex ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                if (page.explanation != null)
                  Text(
                    page.explanation!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
              ],
            ),
          ),

        // Show next button if onNext is provided
        if (_hasValidated && widget.onNext != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: _hasValidated ? widget.onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
              ),
              child: const Text("Next"),
            ),
          ),
      ],
    );
  }
}
