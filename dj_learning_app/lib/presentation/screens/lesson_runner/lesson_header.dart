import 'package:flutter/material.dart';

class LessonHeader extends StatelessWidget {
  final String title;
  final int currentIndex;
  final int totalPages;

  const LessonHeader({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 4),
        Text(
          'Page ${currentIndex + 1} sur $totalPages',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        const Divider(),
      ],
    );
  }
}