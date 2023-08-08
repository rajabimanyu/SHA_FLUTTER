import 'package:flutter/material.dart';
import 'package:sha/ui/views/home_page_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerButton(),
      ),
      drawer: const HomePageDrawer(),
      body: const Center(
        child: Text(
          '🏠',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
