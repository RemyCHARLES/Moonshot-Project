// lib/main.dart
// ------------------------------------------------------------
// Beatquest – Main Entry Point
// ------------------------------------------------------------
// This file initializes the Flutter application and configures
// global theming and routing. It defines the app structure using
// GoRouter for navigation and AudioSession for audio handling.
//
// Features:
// - Defines all app routes (Welcome, Login, Register, Home, etc.)
// - Sets up audio session for playback consistency
// - Applies global themes (light/dark)
// - Wraps screen navigation in ShellRoute with MainScaffold
// ------------------------------------------------------------

import 'package:audio_session/audio_session.dart';
import 'core/theme/app_theme.dart'; // Theme for the app (colors, fonts, etc.)
import 'package:flutter/material.dart'; // Flutter framework for building UI
import 'package:go_router/go_router.dart'; // Package for routing and navigation
import 'presentation/screens/welcome/welcome_screen.dart'; // Welcome screen of the app
import 'presentation/screens/login/login_screen.dart'; // Login screen of the app
import 'presentation/screens/register/register_screen.dart'; // Register screen of the app
import 'presentation/screens/main_scaffold.dart';
import 'presentation/screens/lesson_runner/lesson_runner_sreen.dart'; // Lesson runner screen
import 'presentation/screens/practice/practice_screen.dart';
import 'presentation/screens/progress/progress_screen.dart';
import 'presentation/screens/rewards/rewards_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';
import 'presentation/screens/home/home_screen.dart'; // Home screen of the app
import 'core/navigation/route_observer.dart'; // Global route observer for navigation tracking



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.music()); // Configure app-wide audio settings
  runApp(const MyApp());
}

// App routing configuration (navigation between pages)
final _router = GoRouter(
  observers: [routeObserver], // Track route changes globally
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(), // Entry screen
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) =>
          MainScaffold(child: child), // Wrap main tabs in scaffold
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/practice',
          builder: (context, state) => const PracticeScreen(),
        ),
        GoRoute(
          path: '/progress',
          builder: (context, state) => const ProgressScreen(),
        ),
        GoRoute(
          path: '/rewards',
          builder: (context, state) => const RewardsScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/lesson-runner/:lessonId',
      name: 'lesson-runner',
      builder: (context, state) {
        final lessonId = state.pathParameters['lessonId'] ?? ''; // Read dynamic lesson ID
        return LessonRunnerScreen(lessonId: lessonId);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router, // Use declarative router
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Only light mode for now
    );
  }
}