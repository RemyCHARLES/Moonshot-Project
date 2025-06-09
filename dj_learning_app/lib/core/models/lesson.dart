// 📁 lib/core/models/lesson.dart
// ------------------------------------------------------------
// Beatquest – Lesson and LessonPage Model
// ------------------------------------------------------------
// This file defines two core data models used in the Beatquest app:
//
// - `Lesson`: represents a complete DJ learning lesson, which includes
//   an ID, title, and a list of lesson pages.
//
// - `LessonPageModel`: represents a single step (page) of a lesson.
//   It supports different content types such as theoretical questions,
//   audio file comparisons, quizzes, and timing-sensitive prompts.
//
// These models are used for parsing lesson JSON data fetched from the API,
// and for rendering lesson content in the Flutter frontend.
// ------------------------------------------------------------

class Lesson {
  final int id;                     // Unique identifier for the lesson
  final String title;              // Title of the lesson
  final List<LessonPageModel> pages; // List of steps (pages) within the lesson

  Lesson({required this.id, required this.title, required this.pages});

  /// Creates a Lesson object from a decoded JSON map
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      pages: (json['pages'] as List)
          .map((e) => LessonPageModel.fromJson(e))
          .toList(),
    );
  }

  /// Converts the Lesson object back to a JSON map
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'pages': pages.map((e) => e.toJson()).toList(),
      };
}

class LessonPageModel {
  final String type;                // Content type: e.g. "text", "quiz", "audio"
  final String question;            // Prompt or question shown to the user
  final List<String>? options;      // Possible answer choices (for quizzes)
  final int? correctIndex;          // Index of the correct option (if applicable)
  final String? explanation;        // Explanation for the answer (if applicable)
  final String? fileA;              // First audio file path or ID
  final String? fileB;              // Second audio file path or ID
  final int? initialOffsetMs;       // Timing offset used for validation (in ms)
  final int? toleranceMs;           // Accepted timing margin (in ms)
  final int? successDurationMs;     // Duration the user must stay correct (in ms)

  LessonPageModel({
    required this.type,
    required this.question,
    this.options,
    this.correctIndex,
    this.explanation,
    this.fileA,
    this.fileB,
    this.initialOffsetMs,
    this.toleranceMs,
    this.successDurationMs,
  });

  /// Create a LessonPageModel object from JSON map
  factory LessonPageModel.fromJson(Map<String, dynamic> json) {
    return LessonPageModel(
      type: json['type'] ?? '',
      question: json['question'] ?? json['content'] ?? '',
      options: (json['options'] as List?)?.map((e) => e.toString()).toList(),
      correctIndex: json['correctIndex'] is int ? json['correctIndex'] : null,
      explanation: json['explanation']?.toString(),
      fileA: json['fileA']?.toString(),
      fileB: json['fileB']?.toString(),
      initialOffsetMs: json['initialOffsetMs'] is int ? json['initialOffsetMs'] : null,
      toleranceMs: json['toleranceMs'] is int ? json['toleranceMs'] : null,
      successDurationMs: json['successDurationMs'] is int ? json['successDurationMs'] : null,
    );
  }

  /// Convert LessonPageModel object to JSON
  Map<String, dynamic> toJson() => {
        'type': type,
        'question': question,
        'options': options,
        'correctIndex': correctIndex,
        'explanation': explanation,
        'fileA': fileA,
        'fileB': fileB,
        'initialOffsetMs': initialOffsetMs,
        'toleranceMs': toleranceMs,
        'successDurationMs': successDurationMs,
      };

  /// Helper getter: alias for question
  String get prompt => question;

  /// Helper getter: fallback-safe list of options
  List<String> get choices => options ?? [];
}