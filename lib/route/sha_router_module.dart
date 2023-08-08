import 'package:flutter/material.dart';
import 'package:sha/core/route/router_module.dart';
import 'package:sha/route/routes.dart';
import 'package:sha/ui/pages/login_page.dart';
import 'package:sha/ui/pages/splash_page.dart';

class ShaRouterModule implements RouterModule {
  const ShaRouterModule();

  @override
  Map<String, ShaPageRoute Function(RouteSettings settings)> getRoutes() {
    return {
      ShaRoutes.splashRoute: (settings) {
        return ShaPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
      },
      ShaRoutes.loginPageRoute: (settings) {
        return ShaPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      }
    };
  }
}
