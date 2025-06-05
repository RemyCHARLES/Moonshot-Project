import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/colors.dart';
import '../../../core/navigation/route_observer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  int lastUnlockedLesson = 1;

  @override
  void initState() {
    super.initState();
    fetchProgression();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when returning to this page
    fetchProgression();
  }

final storage = FlutterSecureStorage();

void fetchProgression() async {
  String? userId = await storage.read(key: 'user_id'); // Secure retrieval

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
      print('🔓 Unlocked lesson: $lastUnlockedLesson');
    }
  } catch (e) {
    print('❌ Error fetching progression: $e');
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
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lessonId < lastUnlockedLesson
                          ? Colors.lightBlueAccent
                          : lessonId == lastUnlockedLesson
                              ? AppColors.primary
                              : Colors.grey.shade300,
                      boxShadow: [
                        if (isUnlocked)
                          BoxShadow(
                            color: lessonId < lastUnlockedLesson
                                ? const Color.fromARGB(255, 0, 113, 166)
                                : const Color.fromARGB(255, 110, 0, 157),
                                
                            offset: const Offset(0, 4),
                            blurRadius: 0,
                            spreadRadius: 0.3,
                          )
                      ],
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: isUnlocked
                          ? () {
                              context.go('/lesson-runner/$lessonId');
                            }
                          : null,
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
    );
  }
}