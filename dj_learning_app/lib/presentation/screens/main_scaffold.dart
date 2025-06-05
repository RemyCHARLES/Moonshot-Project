import 'package:flutter/material.dart';
import 'package:dj_learning_app/presentation/screens/home/home_screen.dart';
import 'package:dj_learning_app/presentation/screens/practice/practice_screen.dart';
import 'package:dj_learning_app/presentation/screens/progress/progress_screen.dart';
import 'package:dj_learning_app/presentation/screens/rewards/rewards_screen.dart';
import 'package:dj_learning_app/presentation/screens/settings/settings_screen.dart';
import '../../core/constants/colors.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final PageStorageBucket _bucket = PageStorageBucket();

  final List<Widget> _screens = const [
    KeyedSubtree(key: PageStorageKey('HomeScreen'), child: HomeScreen()),
    KeyedSubtree(key: PageStorageKey('PracticeScreen'), child: PracticeScreen()),
    KeyedSubtree(key: PageStorageKey('ProgressScreen'), child: ProgressScreen()),
    KeyedSubtree(key: PageStorageKey('RewardsScreen'), child: RewardsScreen()),
    KeyedSubtree(key: PageStorageKey('SettingsScreen'), child: SettingsScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 247, 246, 246),
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.headphones),
              label: 'Practice',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Rewards',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}