// lib/presentation/screens/register/register_screen.dart
// ------------------------------------------------------------
// Beatquest – Register Screen
// ------------------------------------------------------------
// This screen allows users to create a new account in the Beatquest app.
// It captures username, email, and password, then registers the user
// through the AuthService. Upon success, credentials are securely stored.
//
// Features:
// - Secure account creation
// - JWT and user ID saved using flutter_secure_storage
// - Navigation to home after registration
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dj_learning_app/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController(); // Controller for username field
  final TextEditingController _emailController = TextEditingController();    // Controller for email field
  final TextEditingController _passwordController = TextEditingController(); // Controller for password field
  final _storage = const FlutterSecureStorage(); // For secure local credential storage

  void _register() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Validate input fields are not empty
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    // Try to register user with backend
    final userData = await AuthService.registerUser(username, email, password);

    if (userData != null) {
      // Save secure session information
      await _storage.write(key: 'jwt_token', value: userData['token']);
      await _storage.write(key: 'user_id', value: userData['user_id'].toString());
      await _storage.write(key: 'username', value: userData['username']);

      // Go to home if success
      if (!mounted) return;
      context.go('/home');
    } else {
      // Show error message on failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')), // App bar with title
      body: Padding(
        padding: const EdgeInsets.all(24.0), // Padding around form fields
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            // Username input field
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16), // Spacing between fields

            // Email input field
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16), // Spacing between fields

            // Password input field
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true, // Hide password text
            ),
            const SizedBox(height: 32), // Spacing before buttons

            // Button to trigger registration
            ElevatedButton(
              onPressed: _register,
              child: const Text('Create Account'),
            ),
            const SizedBox(height: 16), // Spacing before login link

            // Button to navigate to login screen
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}