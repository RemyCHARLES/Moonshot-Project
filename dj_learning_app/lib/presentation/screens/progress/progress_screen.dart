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
  final storage = FlutterSecureStorage();
  List<Map<String, dynamic>> progress = [];

  @override
  void initState() {
    super.initState();
    fetchProgress();
  }

  Future<void> fetchProgress() async {
    String? userId = await storage.read(key: 'user_id');

    if (userId == null) {
      print('❌ No user ID found in secure storage');
      return;
    }

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
              itemCount: progress.length,
              itemBuilder: (context, index) {
                final item = progress[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item['completed'] == 't' ? Colors.green : Colors.grey,
                    child: Text(item['lesson_id'].toString()),
                  ),
                  title: Text('Lesson ${item['lesson_id']}'),
                  subtitle: Text('Completed: ${item['completed']}'),
                  trailing: Text(
                    item['updated_at'],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                );
              },
            ),
    );
  }
}