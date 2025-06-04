// lib/services/progress_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ProgressService {
  static Future<int> getLastUnlockedLesson(int userId) async {
    final res = await http.get(Uri.parse('http://localhost:18080/users/$userId/progression'));
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return json['lastUnlockedLesson'];
    } else {
      throw Exception("Failed to fetch progression");
    }
  }
}