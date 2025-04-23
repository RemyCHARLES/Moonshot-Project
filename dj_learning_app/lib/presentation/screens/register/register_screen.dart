import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<String?> _getUsername() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'username');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              const storage = FlutterSecureStorage();
              await storage.deleteAll();
              if (context.mounted) context.go('/login');
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<String?>(
          future: _getUsername(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data != null) {
              return Text(
                'Welcome, ${snapshot.data}!',
                style: const TextStyle(fontSize: 20),
              );
            } else {
              return const Text(
                'Welcome to the Home Screen!',
                style: TextStyle(fontSize: 20),
              );
            }
          },
        ),
      ),
    );
  }
}