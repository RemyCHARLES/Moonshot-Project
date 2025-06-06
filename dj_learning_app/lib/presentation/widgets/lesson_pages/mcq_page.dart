import 'package:flutter/material.dart';
import 'package:dj_learning_app/core/models/lesson.dart';

class McqPage extends StatefulWidget {
  final LessonPageModel page;
  final void Function(bool isCorrect) onValidated;
  final VoidCallback? onNext;

  const McqPage({Key? key, required this.page, required this.onValidated, this.onNext}) : super(key: key);

  @override
  State<McqPage> createState() => _McqPageState();
}

class _McqPageState extends State<McqPage> {
  int? _selectedIndex;
  bool _hasValidated = false;

  @override
  Widget build(BuildContext context) {
    final page = widget.page;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            page.question,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
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
                          _selectedIndex = index;
                        });
                      },
              ),
            ),
          );
        }),
        if (_selectedIndex != null && !_hasValidated)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _hasValidated = true;
                });
                final isCorrect = _selectedIndex == page.correctIndex;
                widget.onValidated(isCorrect);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: const Text("Submit"),
            ),
          ),
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
