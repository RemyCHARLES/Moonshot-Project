import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              padding: const EdgeInsets.symmetric(horizontal: 120),
              itemCount: 8,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(Icons.lock, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () {
                context.push('/lesson-runner/1');
              },
              child: const Icon(Icons.play_arrow),
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