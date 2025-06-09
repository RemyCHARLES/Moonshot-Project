// lib/presentation/screens/main_scaffold.dart
// ------------------------------------------------------------
// Beatquest – Main Scaffold
// ------------------------------------------------------------
// This widget defines the main navigation structure of the app
// once the user is logged in. It includes a persistent bottom
// navigation bar and maintains the state of each tab.
//
// Tabs included:
// - Home
// - Practice
// - Progress
// - Rewards
// - Settings
//
// It uses `IndexedStack` to preserve state between screens,
// and `PageStorageBucket` to maintain scroll position and
// internal widget states per tab.
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:dj_learning_app/presentation/screens/home/home_screen.dart';
import 'package:dj_learning_app/presentation/screens/practice/practice_screen.dart';
import 'package:dj_learning_app/presentation/screens/progress/progress_screen.dart';
import 'package:dj_learning_app/presentation/screens/rewards/rewards_screen.dart';
import 'package:dj_learning_app/presentation/screens/settings/settings_screen.dart';
import '../../core/constants/colors.dart';

class MainScaffold extends StatefulWidget {
  final Widget child; // Placeholder for deep navigation context

  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0; // Track the current selected tab index

  final PageStorageBucket _bucket = PageStorageBucket(); // Preserve scroll state per tab

  // Define the list of screens used in the tab navigation
  final List<Widget> _screens = const [
    KeyedSubtree(key: PageStorageKey('HomeScreen'), child: HomeScreen()),
    KeyedSubtree(key: PageStorageKey('PracticeScreen'), child: PracticeScreen()),
    KeyedSubtree(key: PageStorageKey('ProgressScreen'), child: ProgressScreen()),
    KeyedSubtree(key: PageStorageKey('RewardsScreen'), child: RewardsScreen()),
    KeyedSubtree(key: PageStorageKey('SettingsScreen'), child: SettingsScreen()),
  ];

  /// Update the selected index when the user taps a nav item
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use IndexedStack to preserve widget state between tab switches
      body: PageStorage(
        bucket: _bucket,
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
      // Bottom tab bar with icon navigation
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory, // Disable ripple animation
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 247, 246, 246),
          selectedItemColor: AppColors.primary, // Highlight active tab
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