// ------------------------------------------------------------
// Beatquest – ProgressService
// ------------------------------------------------------------
// This service handles the retrieval of a user's current progression
// in the Beatquest learning path. It communicates with the backend
// API to fetch the last unlocked lesson for a given user ID.
//
// Features:
// - Sends GET request to /users/:id/progression
// - Parses the 'lastUnlockedLesson' value from the API response
// - Throws exception on failure
// ------------------------------------------------------------

// lib/services/progress_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service for retrieving user progression from the backend API.
class ProgressService {
  /// Fetches the last unlocked lesson for the given user ID.
  /// This determines which lessons are accessible in the UI.
  static Future<int> getLastUnlockedLesson(int userId) async {
    // Send GET request to backend API endpoint for user progression
    final res = await http.get(Uri.parse('http://localhost:18080/users/$userId/progression')); // API request

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body); // Parse JSON response
      return json['lastUnlockedLesson'];  // Return unlocked lesson number
    } else {
      throw Exception("Failed to fetch progression"); // Handle failure
    }
  }
}