import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dj_learning_app/core/models/lesson.dart';
import 'package:go_router/go_router.dart';

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

  @override
  void initState() {
    super.initState();
    _loadPage();
  }

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
        _lessonTitle = data['lessonTitle'] ?? 'Leçon';
        _totalPages = data['totalPages'] ?? 0;
        _selectedIndex = null;
        _hasValidated = false;
        _isLoading = false;
        // Set _hasMore to false if this is the recap page
        _hasMore = data['type'] != 'recap';
      });
    } else {
      setState(() {
        _hasMore = false;
        _isLoading = false;
      });
    }
  }

  void _nextPage() async {
    if (_currentIndex >= _totalPages - 1) {
      setState(() {
        _page = LessonPageModel(
          type: 'recap',
          question: '',
          explanation: 'Merci d’avoir suivi cette leçon ! Vous pouvez consulter vos résultats ci-dessous.',
        );
        _hasMore = false;
      });
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
        _lessonTitle = data['lessonTitle'] ?? 'Leçon';
        _selectedIndex = null;
        _hasValidated = false;
        _isLoading = false;
        _totalPages = data['totalPages'] ?? _totalPages;
        _hasMore = _currentIndex < _totalPages - 1;
      });
    } else {
      setState(() {
        _page = LessonPageModel(
          type: 'recap',
          question: '',
          explanation: 'Merci d’avoir suivi cette leçon ! Vous pouvez consulter vos résultats ci-dessous.',
        );
        _hasMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_page == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erreur')),
        body: const Center(child: Text('Aucune page trouvée')),
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
                Text('Étape ${_currentIndex + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
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
                      onPressed: ((_hasMore || _currentIndex >= _totalPages - 1) &&
                                   (_page?.type != 'mcq' || (_hasValidated && _selectedIndex != null)))
                          ? _nextPage
                          : null,
                      child: const Text("Suivant"),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(LessonPageModel page) {
    switch (page.type) {
      case 'mcq':
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
                      if (_selectedIndex == page.correctIndex) {
                        _correctAnswers++;
                      } else {
                        _incorrectAnswers++;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Valider"),
                ),
              ),
            if (_hasValidated)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    Text(
                      _selectedIndex == page.correctIndex ? "Bonne réponse ✅" : "Mauvaise réponse ❌",
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
          ],
        );
      case 'text':
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
      case 'recap':
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Récapitulatif de la leçon",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                if (page.explanation != null)
                  Text(
                    page.explanation!,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildResultBox("Bonnes réponses", _correctAnswers, Colors.orange),
                    _buildResultBox("Mauvaises réponses", _incorrectAnswers, Colors.purple),
                  ],
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Retour ou navigation après récapitulatif
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
                  child: const Text("CONTINUER"),
                ),
              ],
            ),
          ),
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