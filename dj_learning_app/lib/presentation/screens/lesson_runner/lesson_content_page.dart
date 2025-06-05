import 'package:flutter/material.dart';
import 'package:dj_learning_app/core/models/lesson.dart';

class LessonContentPage extends StatelessWidget {
  final LessonPageModel? page;
  final int? selectedIndex;
  final bool hasValidated;
  final ValueChanged<int> onAnswerSelected;
  final int correctAnswers;
  final int incorrectAnswers;
  final VoidCallback onLessonCompleted;

  const LessonContentPage({
    super.key,
    required this.page,
    required this.selectedIndex,
    required this.hasValidated,
    required this.onAnswerSelected,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.onLessonCompleted,
  });

  @override
  Widget build(BuildContext context) {
    if (page == null) {
      return const Center(child: CircularProgressIndicator());
    }

    switch (page!.type) {
      case 'text':
        return Text(page!.question);
      case 'quiz':
        return Column(
          children: List.generate(page!.options?.length ?? 0, (index) {
            final isSelected = selectedIndex == index;
            final isCorrect = page!.correctIndex == index;
            final showFeedback = hasValidated;

            Color color = Colors.grey;
            if (showFeedback) {
              if (isSelected && isCorrect) color = Colors.green;
              else if (isSelected && !isCorrect) color = Colors.red;
              else if (isCorrect) color = Colors.green;
            } else if (isSelected) {
              color = Colors.blue;
            }

            return ElevatedButton(
              onPressed: () => onAnswerSelected(index),
              style: ElevatedButton.styleFrom(backgroundColor: color),
              child: Text(page!.options?[index] ?? ''),
            );
          }),
        );
      case 'recap':
        return Column(
          children: [
            Text('Lesson completed 🎉'),
            Text('Correct answers: $correctAnswers'),
            Text('Incorrect answers: $incorrectAnswers'),
          ],
        );
      default:
        return const Text('Unsupported page type');
    }
  }
}