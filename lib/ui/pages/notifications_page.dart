import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '🔔',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
      ),
    );
  }
}
