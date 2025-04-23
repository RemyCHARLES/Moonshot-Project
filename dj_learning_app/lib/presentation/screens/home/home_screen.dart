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
    print('Loaded username: $username');
    print('Loaded userId: $userId');
    if (username == null || userId == null) {
      // Set a timeout in case data isn't available
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _username = username ?? 'Unknown';
          _userId = userId ?? 'Unknown';
        });
      });
    } else {
      setState(() {
        _username = username;
        _userId = userId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: _username == null || _userId == null
          ? const Center(child: CircularProgressIndicator())
          : (_username == 'Unknown' || _userId == 'Unknown')
              ? const Center(child: Text('User data not found. Please log in again.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('🎧 Welcome back, $_username!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Text('🆔 Your user ID is $_userId', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 20),
                      const Text(
                        'You can now start learning or improving your DJ skills with interactive lessons and real-time feedback.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
    );
  }
}
