import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '⚙️',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
      ),
    );
  }
}
