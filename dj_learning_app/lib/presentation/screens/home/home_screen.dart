import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Row(
                      children: [
                        const Icon(Icons.local_fire_department, color: Colors.orange),
                        const SizedBox(width: 4),
                        const Text('1'),
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        const Icon(Icons.diamond, color: Colors.blue),
                        const SizedBox(width: 4),
                        const Text('500'),
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.red),
                        const SizedBox(width: 4),
                        const Text('5'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Unit Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text('Unit 1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  const Text('Intro to DJing'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Progression and Start button with custom curved path
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: _buildStartNode(),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: _buildLockedNode(),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.black),
            activeIcon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.headphones_outlined, color: Colors.black),
            activeIcon: Icon(Icons.headphones, color: Colors.black),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_outlined, color: Colors.black),
            activeIcon: Icon(Icons.leaderboard, color: Colors.black),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined, color: Colors.black),
            activeIcon: Icon(Icons.emoji_events, color: Colors.black),
            label: 'Achievements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            activeIcon: Icon(Icons.menu, color: Colors.black),
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget _buildLockedNode() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CircleAvatar(
        radius: 28,
        backgroundColor: const Color.fromARGB(255, 223, 223, 223),
        child: const Icon(Icons.lock, color: Colors.grey),
      ),
    );
  }

  Widget _buildStartNode() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.purple,
        child: Icon(Icons.play_arrow, color: Colors.white, size: 32),
      ),
    );
  }
}
