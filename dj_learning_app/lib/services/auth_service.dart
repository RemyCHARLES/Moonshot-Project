// lib/services/auth_service.dart
// ------------------------------------------------------------
// Beatquest – AuthService (Login & Registration)
// ------------------------------------------------------------
// This service handles user authentication by interacting with the
// backend REST API. It provides functions to:
//
// - Log in users by sending username/password
// - Register new users by sending username/email/password
// - Decode the JWT token returned by the API
//
// Both methods return a map containing the token, user ID, and username
// if successful, or null on failure.
// ------------------------------------------------------------

import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static Future<Map<String, dynamic>?> loginUser(String username, String password) async {
    final url = Uri.parse('http://localhost:18080/login'); // API endpoint for login
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}), // Send credentials
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Parse API response
      final token = data['token']; // JWT token returned
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))), // Decode JWT payload
      );

      return {
        'token': token,
        'user_id': payload['user_id'],
        'username': payload['username'],
      };
    }

    return null; // Login failed
  }

  static Future<Map<String, dynamic>?> registerUser(String username, String email, String password) async {
    final url = Uri.parse('http://localhost:18080/register'); // API endpoint for registration
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))), // Decode JWT payload
      );

      return {
        'token': token,
        'user_id': payload['user_id'],
        'username': payload['username'],
      };
    }

    return null; // Registration failed
  }
}