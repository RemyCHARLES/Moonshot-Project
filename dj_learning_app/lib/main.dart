import 'core/theme/app_theme.dart'; // Theme for the app (colors, fonts, etc.)
import 'package:flutter/material.dart'; // Flutter framework for building UI
import 'package:go_router/go_router.dart'; // Package for routing and navigation
import 'presentation/screens/welcome/welcome_screen.dart'; // Welcome screen of the app
import 'presentation/screens/login/login_screen.dart'; // Login screen of the app
import 'presentation/screens/register/register_screen.dart'; // Register screen of the app
import 'presentation/screens/home/home_screen.dart'; // Home screen of the app
import 'presentation/screens/lesson_runner/lesson_runner_sreen.dart'; // Lesson runner screen

// Entry point of the application
void main() {
  runApp(const MyApp());
}

// App routing configuration (navigation between pages)
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/lesson-runner/:lessonId',
      name: 'lesson-runner',
      builder: (context, state) {
        final lessonId = state.pathParameters['lessonId'] ?? '';
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
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Light theme configuration
      darkTheme: AppTheme.darkTheme, // Dark theme configuration
      themeMode: ThemeMode.light, // Force light theme for now
    );
  }
}