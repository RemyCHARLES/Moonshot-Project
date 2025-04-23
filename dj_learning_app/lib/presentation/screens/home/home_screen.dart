import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  final _storage = const FlutterSecureStorage();
  String? _username;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final username = await _storage.read(key: 'username');
    final userId = await _storage.read(key: 'user_id');
    setState(() {
      _username = username;
      _userId = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Center(
        child: _username == null || _userId == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hello, $_username!', style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 8),
                  Text('Your user ID is $_userId', style: const TextStyle(fontSize: 16)),
                ],
              ),
      ),
    );
  }
}
