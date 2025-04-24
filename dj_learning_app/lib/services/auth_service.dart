import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static Future<Map<String, dynamic>?> loginUser(String username, String password) async {
    final url = Uri.parse('http://localhost:18080/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );

      return {
        'token': token,
        'user_id': payload['user_id'],
        'username': payload['username'],
      };
    }

    return null;
  }

  static Future<Map<String, dynamic>?> registerUser(String username, String email, String password) async {
    final url = Uri.parse('http://localhost:18080/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );

      return {
        'token': token,
        'user_id': payload['user_id'],
        'username': payload['username'],
      };
    }

    return null;
  }
}