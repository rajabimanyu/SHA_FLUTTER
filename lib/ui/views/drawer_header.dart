import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerHeader extends StatefulWidget {
  const DrawerHeader({super.key});

  @override
  State<DrawerHeader> createState() => _DrawerHeaderState();
}

class _DrawerHeaderState extends State<DrawerHeader> {
  late final String userName;

  @override
  void initState() {
    super.initState();
    userName = FirebaseAuth.instance.currentUser?.displayName ?? 'User';
    setState(() {});
  }

  Widget _buildCircularAvatar(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.secondary,
      ),
      alignment: Alignment.center,
      height: 56,
      width: 56,
      child: Text(
        userName[0],
        style: theme.textTheme.headlineLarge
            ?.copyWith(color: theme.colorScheme.onSecondary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCircularAvatar(context),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              userName,
              style: theme.textTheme.headlineLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
