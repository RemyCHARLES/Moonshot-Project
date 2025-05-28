import 'package:flutter/material.dart';

class LessonNavigationControls extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool hasMore;
  final bool hasValidated;
  final bool quizPage;
  final bool hasSelection;

  const LessonNavigationControls({
    super.key,
    required this.onPrevious,
    required this.onNext,
    required this.hasMore,
    required this.hasValidated,
    required this.quizPage,
    required this.hasSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (quizPage && hasMore)
          ElevatedButton(
            onPressed: hasValidated ? onNext : null,
            child: const Text('Suivant'),
          ),
        if (!quizPage && hasMore)
          ElevatedButton(
            onPressed: onNext,
            child: const Text('Suivant'),
          ),
        if (!hasMore)
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Quitter'),
          ),
      ],
    );
  }
}