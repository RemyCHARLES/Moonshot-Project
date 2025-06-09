// lib/presentation/screens/lesson_runner/lesson_runner_sreen.dart
// ------------------------------------------------------------
// Beatquest – Lesson Runner Screen
// ------------------------------------------------------------
// This widget is responsible for rendering a complete lesson session,
// page by page. Each page can be a quiz, instructional text, beatmatch,
// or final recap. It fetches lesson content from the backend API
// and tracks user answers and progression.
//
// Features:
// - Loads lesson pages dynamically using REST API
// - Tracks correct/incorrect answers and current step
// - Handles lesson completion and progress persistence
// - Displays a recap screen at the end
//
// Related widgets: McqPage, TextPage, BeatmatchPage, RecapPage
// ------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dj_learning_app/core/models/lesson.dart';
import 'package:go_router/go_router.dart';
import 'package:dj_learning_app/presentation/widgets/lesson_pages/beatmatch_page.dart';
import 'package:dj_learning_app/presentation/widgets/lesson_pages/mcq_page.dart';
import 'package:dj_learning_app/presentation/widgets/lesson_pages/text_page.dart';
import 'package:dj_learning_app/presentation/widgets/lesson_pages/recap_page.dart';

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

class _LessonRunnerScreenState extends State<LessonRunnerScreen> {
  int _currentIndex = 0;
  int _totalPages = 0;
  LessonPageModel? _page;
  String _lessonTitle = '';
  bool _isLoading = true;
  bool _hasMore = true;
  int? _selectedIndex;
  bool _hasValidated = false;

  int _correctAnswers = 0;
  int _incorrectAnswers = 0;
  bool _showNextLessonButton = false;

  // -----------------------------------------
  // LIFECYCLE: Init screen and fetch first page
  // -----------------------------------------
  @override
  void initState() {
    super.initState();
    _loadPage();
  }

  // -----------------------------------------
  // NETWORK: Fetch a lesson page from backend
  // -----------------------------------------
  Future<void> _loadPage() async {
    setState(() {
      _isLoading = true;
    });

    final url = 'http://localhost:18080/lessons/${widget.lessonId}/page/$_currentIndex';
    final response = await http.get(Uri.parse(url));

    print('→ Requesting URL: $url');
    print('← Raw response: ${response.body}');

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded);

      if (data == null || data.isEmpty) {
        setState(() {
          _hasMore = false;
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _page = LessonPageModel.fromJson(data);
        _lessonTitle = data['lessonTitle'] ?? 'Lesson';
        _totalPages = data['totalPages'] ?? 0;
        _selectedIndex = null;
        _hasValidated = false;
        _isLoading = false;
        _showNextLessonButton = false;
        // Set _hasMore to false if this is the recap page
        _hasMore = data['type'] != 'recap';
      });
      _selectedIndex = null;
      _hasValidated = false;
    } else {
      setState(() {
        _hasMore = false;
        _isLoading = false;
      });
    }
  }

  // -----------------------------------------
  // UI LOGIC: Handle navigation to next lesson step
  // -----------------------------------------
  void _nextPage() async {
    if (_currentIndex >= _totalPages - 1) {
      setState(() {
        _page = LessonPageModel(
          type: 'recap',
          question: '',
          explanation: 'Thanks for following this lesson! You can review your results below.',
        );
        _hasMore = false;
        _showNextLessonButton = false;
      });

      final userId = await _getUserIdFromToken();
      if (userId != null) {
        await _markLessonAsCompleted(userId);
      }
      return;
    }

    _currentIndex++;
    print('→ Moving to page index $_currentIndex');

    final url = 'http://localhost:18080/lessons/${widget.lessonId}/page/$_currentIndex';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded);

      setState(() {
        _page = LessonPageModel.fromJson(data);
        _lessonTitle = data['lessonTitle'] ?? 'Lesson';
        _selectedIndex = null;
        _hasValidated = false;
        _isLoading = false;
        _totalPages = data['totalPages'] ?? _totalPages;
        _hasMore = _currentIndex < _totalPages - 1;
        _showNextLessonButton = false;
      });
      _selectedIndex = null;
      _hasValidated = false;
    } else {
      setState(() {
        _page = LessonPageModel(
          type: 'recap',
          question: '',
          explanation: 'Thanks for following this lesson! You can review your results below.',
        );
        _hasMore = false;
        _showNextLessonButton = false;
      });
    }
  }

  // -----------------------------------------
  // RENDER: Build main scaffold and render active lesson page
  // -----------------------------------------
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_page == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No page found')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(_lessonTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Step ${_currentIndex + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: (_totalPages > 0) ? (_currentIndex + 1) / _totalPages : 0.0, // ⚠️ Adapter ce nombre si besoin
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildPageContent(_page!)),
                if (_page?.type != 'recap')
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: (_showNextLessonButton ||
                                  ((_hasMore || _currentIndex >= _totalPages - 1) &&
                                   (_page?.type != 'mcq' || (_hasValidated && _selectedIndex != null))))
                          ? _nextPage
                          : null,
                      child: const Text("Next"),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------
  // WIDGET: Render content widget for current page type
  // -----------------------------------------
  Widget _buildPageContent(LessonPageModel page) {
    switch (page.type) {
      case 'mcq':
        return McqPage(
          key: ValueKey(_currentIndex),
          page: page,
          onValidated: (bool isCorrect) {
            setState(() {
              if (isCorrect) {
                _correctAnswers++;
              } else {
                _incorrectAnswers++;
              }
              _showNextLessonButton = true;
            });
          },
        );
      case 'text':
        return TextPage(
          key: ValueKey(_currentIndex),
          page: page,
        );
      case 'recap':
        return RecapPage(
          key: ValueKey(_currentIndex),
          explanation: page.explanation,
          correctAnswers: _correctAnswers,
          incorrectAnswers: _incorrectAnswers,
          getUserId: _getUserIdFromToken,
          markLessonAsCompleted: _markLessonAsCompleted,
        );
      case 'beatmatch':
        return BeatmatchPage(
          key: ValueKey(_currentIndex),
          data: page.toJson(),
          onValidated: (bool isCorrect) {
            setState(() {
              if (isCorrect) {
                _correctAnswers++;
              } else {
                _incorrectAnswers++;
              }
              _showNextLessonButton = true;
            });
          },
        );
      default:
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

  // -----------------------------------------
  // NETWORK: POST completion to /progress endpoint
  // -----------------------------------------
  Future<void> _markLessonAsCompleted(int userId) async {
    final url = 'http://localhost:18080/users/$userId/progress';
    final payload = {
      "user_id": userId,
      "lesson_id": int.parse(widget.lessonId),
      "completed": true
    };

    print("📤 Sending lesson completion: $payload → $url");
    if (!mounted) return;

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print("✅ Lesson marked as completed successfully");
      setState(() {
        _showNextLessonButton = true;
      });
    } else {
      print("❌ Failed to mark lesson as completed: ${response.statusCode} - ${response.body}");
    }
  }

  // -----------------------------------------
  // AUTH: Extract user ID from JWT token
  // -----------------------------------------
  Future<int?> _getUserIdFromToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'jwt_token');
    if (token == null) return null;

    final decoded = JwtDecoder.decode(token);
    return int.tryParse(decoded['user_id'].toString());
  }
}