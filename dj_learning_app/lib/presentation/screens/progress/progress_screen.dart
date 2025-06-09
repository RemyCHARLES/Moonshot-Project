// lib/presentation/screens/progress/progress_screen.dart
// ------------------------------------------------------------
// Beatquest – Progress Screen
// ------------------------------------------------------------
// This screen displays the user's lesson progression history.
// It fetches data from the backend using the user ID stored
// in secure storage, then displays a visual list of all completed
// and in-progress lessons.
//
// Features:
// - Reads JWT-secure user ID
// - Makes HTTP call to /progress endpoint
// - Renders progress using icons and timestamps
// ------------------------------------------------------------
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/constants/colors.dart';


class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final storage = FlutterSecureStorage(); // Used to securely retrieve the logged-in user's ID
  List<Map<String, dynamic>> progress = [];

  @override
  void initState() {
    super.initState();
    fetchProgress();
  }

  Future<void> fetchProgress() async {
    String? userId = await storage.read(key: 'user_id'); // Read user ID

    if (userId == null) {
      print('❌ No user ID found in secure storage');
      return;
    }

    // Make GET request to fetch user's lesson progress
    try {
      final res = await http.get(Uri.parse('http://localhost:18080/users/$userId/progress'));
      print('📦 Progress API response: ${res.body}');
      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body);
        setState(() {
          progress = data.map((item) => item as Map<String, dynamic>).toList();
        });
      }
    } catch (e) {
      print('❌ Error fetching progress: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Progress'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: progress.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              // Render each lesson progress as a list tile
              itemCount: progress.length,
              itemBuilder: (context, index) {
                final item = progress[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item['completed'] == 't' ? Colors.green : Colors.grey, // Green if completed
                    child: Text(item['lesson_id'].toString()),
                  ),
                  title: Text('Lesson ${item['lesson_id']}'), // Display lesson number
                  subtitle: Text('Completed: ${item['completed']}'), // Boolean status
                  trailing: Text(
                    item['updated_at'], // Last update timestamp
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                );
              },
            ),
    );
  }
}