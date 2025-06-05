// 📁 lib/core/models/lesson.dart
class Lesson {
  final int id;
  final String title;
  final List<LessonPageModel> pages;

  Lesson({required this.id, required this.title, required this.pages});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      pages: (json['pages'] as List)
          .map((e) => LessonPageModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'pages': pages.map((e) => e.toJson()).toList(),
      };
}

class LessonPageModel {
  final String type; 
  final String question;
  final List<String>? options;
  final int? correctIndex;
  final String? explanation;
  final String? fileA;
  final String? fileB;
  final int? initialOffsetMs;
  final int? toleranceMs;
  final int? successDurationMs;

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
  String get prompt => question;
  List<String> get choices => options ?? [];
}