import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Settings', style: TextStyle(color: AppColors.textPrimary)),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Settings content goes here...',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}