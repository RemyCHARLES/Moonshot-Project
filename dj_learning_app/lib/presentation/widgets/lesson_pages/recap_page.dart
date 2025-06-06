import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecapPage extends StatelessWidget {
  final String? explanation;
  final int correctAnswers;
  final int incorrectAnswers;
  final Future<int?> Function() getUserId;
  final Future<void> Function(int userId) markLessonAsCompleted;

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
            const Text(
              "Lesson Recap",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (explanation != null)
              Text(
                explanation!,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildResultBox("Correct answers", correctAnswers, Colors.orange),
                _buildResultBox("Incorrect answers", incorrectAnswers, Colors.purple),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                final userId = await getUserId();
                print("👤 ID récupéré dans recap: $userId");
                if (userId != null) {
                  await markLessonAsCompleted(userId);
                }
                GoRouter.of(context).go('/home');
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
