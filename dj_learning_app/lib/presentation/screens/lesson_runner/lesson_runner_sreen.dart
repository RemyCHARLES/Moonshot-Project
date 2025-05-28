import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'lesson_header.dart';
import 'lesson_content_page.dart';
import 'lesson_navigation_controls.dart';
import 'lesson_state_controller.dart';

class LessonRunnerScreen extends StatefulWidget {
  final String lessonId;

  const LessonRunnerScreen({super.key, required this.lessonId});

  static LessonRunnerScreen fromState(GoRouterState state) {
    final id = state.pathParameters['id'] ?? '';
    return LessonRunnerScreen(lessonId: id);
  }

  @override
  State<LessonRunnerScreen> createState() => _LessonRunnerScreenState();
}

class _LessonRunnerScreenState extends State<LessonRunnerScreen>
    with LessonStateController<LessonRunnerScreen> {
  @override
  void initState() {
    super.initState();
    loadPage(widget.lessonId);
  }

  void _onAnswerSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _onValidateAnswer() {
    if (selectedIndex == null) return;

    setState(() {
      hasValidated = true;
      if (page != null && selectedIndex == page!.correctIndex) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    });
  }

  void _goToNextPage() {
    setState(() {
      currentIndex++;
    });
    loadPage(widget.lessonId);
  }

  void _goToPreviousPage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      loadPage(widget.lessonId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leçon'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  LessonHeader(
                    title: lessonTitle,
                    currentIndex: currentIndex,
                    totalPages: totalPages,
                  ),
                  Expanded(
                    child: LessonContentPage(
                      page: page,
                      selectedIndex: selectedIndex,
                      hasValidated: hasValidated,
                      onAnswerSelected: _onAnswerSelected,
                      correctAnswers: correctAnswers,
                      incorrectAnswers: incorrectAnswers,
                    )
                  ),
                  const SizedBox(height: 16),
                  if (page?.type == 'quiz' && !hasValidated)
                    ElevatedButton(
                      onPressed: selectedIndex != null ? _onValidateAnswer : null,
                      child: const Text('Valider'),
                    ),
                  const SizedBox(height: 16),
                  LessonNavigationControls(
                    onPrevious: _goToPreviousPage,
                    onNext: _goToNextPage,
                    hasMore: hasMore,
                    hasValidated: hasValidated,
                    quizPage: page?.type == 'quiz',
                    hasSelection: selectedIndex != null,
                  ),
                ],
              ),
            ),
    );
  }
}