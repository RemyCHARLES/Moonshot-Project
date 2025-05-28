import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/models/lesson.dart';

class LessonService {
  static Future<List<Lesson>> loadLessons() async {
    final response = await http.get(Uri.parse('http://localhost:18080/lessons'));

    if (response.statusCode == 200) {
      // 🟡 Utilise utf8.decode pour bien gérer les accents
      final body = utf8.decode(response.bodyBytes); 
      final List<dynamic> data = json.decode(body);
      return data.map((e) => Lesson.fromJson(e)).toList();
    } else {
      throw Exception("Erreur lors du chargement des leçons depuis l’API");
    }
  }
}