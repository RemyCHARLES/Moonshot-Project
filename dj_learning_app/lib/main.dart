import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'presentation/screens/welcome/welcome_screen.dart';
import 'presentation/screens/login/login_screen.dart';
import 'presentation/screens/register/register_screen.dart';

void main() {
  runApp(const MyApp());
}

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
    GoRoute(path: '/home', builder: (context, state) {
      // This is a placeholder for the home screen
      return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: const Center(child: Text('Welcome to the Home Screen!')),
      );
    }),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}