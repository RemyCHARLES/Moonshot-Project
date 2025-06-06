import 'package:flutter/material.dart';
import 'package:dj_learning_app/core/models/lesson.dart';

class TextPage extends StatelessWidget {
  final LessonPageModel page;

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
              page.question,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (page.explanation != null) ...[
              const SizedBox(height: 24),
              Text(
                page.explanation!,
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
