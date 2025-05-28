import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dj_learning_app/core/models/lesson.dart';

mixin LessonStateController<T extends StatefulWidget> on State<T> {
  int currentIndex = 0;
  int totalPages = 0;
  LessonPageModel? page;
  String lessonTitle = '';
  bool isLoading = true;
  bool hasMore = true;
  int? selectedIndex;
  bool hasValidated = false;

  int correctAnswers = 0;
  int incorrectAnswers = 0;

  Future<void> loadPage(String lessonId) async {
    setState(() => isLoading = true);

    final url = 'http://localhost:18080/lessons/$lessonId/page/$currentIndex';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded);

      if (data == null || data.isEmpty) {
        setState(() {
          hasMore = false;
          isLoading = false;
        });
        return;
      }

      setState(() {
        page = LessonPageModel.fromJson(data);
        lessonTitle = data['lessonTitle'] ?? 'Leçon';
        totalPages = data['totalPages'] ?? 0;
        selectedIndex = null;
        hasValidated = false;
        isLoading = false;
        hasMore = data['type'] != 'recap';
      });
    } else {
      setState(() {
        hasMore = false;
        isLoading = false;
      });
    }
  }
}