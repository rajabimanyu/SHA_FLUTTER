import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sha/route/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (FirebaseAuth.instance.currentUser == null) {
            Navigator.of(context).popAndPushNamed(ShaRoutes.loginPageRoute);
            // Navigator.of(context).pushNamed(ShaRoutes.homePageRoute);
          } else {
            Navigator.of(context).pushNamed(ShaRoutes.homePageRoute);
          }
        },
        child: const Text(
          'SHA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
