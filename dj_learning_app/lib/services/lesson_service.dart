// ------------------------------------------------------------
// Beatquest – LessonService
// ------------------------------------------------------------
// This service provides a function to fetch all available lessons
// from the backend REST API. It decodes the JSON response and
// converts each lesson into a `Lesson` model object.
//
// Features:
// - Sends a GET request to /lessons
// - Handles UTF-8 encoded responses (supports accents)
// - Parses JSON into a list of Lesson objects
// ------------------------------------------------------------

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/models/lesson.dart';

class LessonService {
  /// Loads all lessons from the backend API.
  /// Returns a list of Lesson objects on success, or throws an error on failure.
  static Future<List<Lesson>> loadLessons() async {
    final response = await http.get(Uri.parse('http://localhost:18080/lessons')); // API GET call

    if (response.statusCode == 200) {
      // 🟡 Use utf8.decode to handle accented characters properly
      final body = utf8.decode(response.bodyBytes);
      final List<dynamic> data = json.decode(body); // Parse JSON array
      return data.map((e) => Lesson.fromJson(e)).toList(); // Map to List<Lesson>
    } else {
      throw Exception("Erreur lors du chargement des leçons depuis l’API"); // Throw on error
    }
  }
}