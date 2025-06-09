// lib/presentation/screens/login/login_screen.dart
// ------------------------------------------------------------
// Beatquest – Login Screen
// ------------------------------------------------------------
// This screen allows users to input their username and password
// to log into the Beatquest app. It uses the `AuthService` to
// authenticate via backend API and securely stores credentials
// using `flutter_secure_storage`.
//
// Features:
// - Username & password input
// - JWT token + user data stored securely
// - Navigation to home on success
// - Basic validation and snackbar feedback
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Used to store JWT, user ID securely
import 'package:dj_learning_app/services/auth_service.dart';

/// Main login screen widget
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller for username input field
  final TextEditingController _usernameController = TextEditingController();
  // Controller for password input field
  final TextEditingController _passwordController = TextEditingController();

  // Instance of secure storage to store tokens and user credentials
  final _storage = const FlutterSecureStorage();

  /// Handles the login logic: input validation, API call, secure storage
  void _login() async {
    final username = _usernameController.text.trim(); // Remove trailing spaces
    final password = _passwordController.text.trim();

    // Simple check for empty fields
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password')),
      );
      return;
    }

    // Call the AuthService to authenticate
    final userData = await AuthService.loginUser(username, password);

    if (userData != null) {
      // Save the JWT, user ID and username securely
      await _storage.write(key: 'jwt_token', value: userData['token']);
      await _storage.write(key: 'user_id', value: userData['user_id'].toString());
      await _storage.write(key: 'username', value: userData['username']);

      if (!mounted) return;
      context.go('/home'); // Navigate to home screen on success
    } else {
      // Show error if authentication fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')), // Top bar title

      body: Padding(
        padding: const EdgeInsets.all(24.0), // Add spacing around form
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username input field
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16), // Spacer

            // Password input field
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true, // Hide input for password
            ),
            const SizedBox(height: 32),

            // Login button
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),

            // Navigation to register page
            TextButton(
              onPressed: () => context.go('/register'),
              child: const Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}