import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sha/route/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _splashPage();
  }
}

class _splashPage extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkLoginAndNavigate(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: GestureDetector(
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

  void checkLoginAndNavigate(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.of(context).popUntil((route) => route.settings.name == ShaRoutes.splashRoute);
        Navigator.of(context).popAndPushNamed(ShaRoutes.loginPageRoute);
      } else {
        Navigator.of(context).popUntil((route) => route.settings.name == ShaRoutes.splashRoute);
        Navigator.of(context).popAndPushNamed(ShaRoutes.homePageRoute);
      }
    });
  }
}