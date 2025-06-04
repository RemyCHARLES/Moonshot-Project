import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int lastUnlockedLesson = 1;

  @override
  void initState() {
    super.initState();
    fetchProgression();
  }

final storage = FlutterSecureStorage();

void fetchProgression() async {
  String? userId = await storage.read(key: 'user_id'); // récupération sécurisée

  if (userId == null) {
    print('❌ No user ID found in secure storage');
    return;
  }

  try {
    final res = await http.get(Uri.parse('http://localhost:18080/users/$userId/progression'));
    print('📦 API progression: ${res.body}');
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final int nextLesson = json['nextLesson'] ?? 1;
      setState(() {
        lastUnlockedLesson = nextLesson;
      });
      print('🔓 Leçon débloquée: $lastUnlockedLesson');
    }
  } catch (e) {
    print('❌ Erreur fetch progression: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_fire_department, color: Colors.orange),
                const SizedBox(width: 4),
                Text('1', style: TextStyle(color: AppColors.textPrimary)),
                const SizedBox(width: 16),
                const Icon(Icons.diamond, color: Colors.blue),
                const SizedBox(width: 4),
                Text('500', style: TextStyle(color: AppColors.textPrimary)),
                const SizedBox(width: 16),
                const Icon(Icons.favorite, color: Colors.red),
                const SizedBox(width: 4),
                Text('5', style: TextStyle(color: AppColors.textPrimary)),
              ],
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Unit 1  ',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary),
                children: const [
                  TextSpan(
                    text: 'Intro to DJing',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 40),
              itemCount: 12,
              itemBuilder: (context, index) {
                final lessonId = index + 1;
                final isUnlocked = lessonId <= lastUnlockedLesson;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: GestureDetector(
                    onTap: isUnlocked
                        ? () {
                            context.push('/lesson-runner/$lessonId');
                          }
                        : null,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          isUnlocked ? AppColors.primary : Colors.grey.shade300,
                      child: Icon(
                        isUnlocked ? Icons.play_arrow : Icons.lock,
                        color: isUnlocked ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.black,
        currentIndex: 0,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.headphones),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: '',
          ),
        ],
      ),
    );
  }
}