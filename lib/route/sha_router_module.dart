import 'package:flutter/material.dart';
import 'package:sha/core/route/router_module.dart';
import 'package:sha/route/routes.dart';
import 'package:sha/ui/pages/connect_device.dart';
import 'package:sha/ui/pages/select_surrounding_page.dart';
import 'package:sha/ui/pages/pages.dart';

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
      },
      ShaRoutes.qrPageRoute: (settings) {
        return ShaPageRoute(
          builder: (_) => const QrScannerPage(),
          settings: settings,
        );
      },
      ShaRoutes.homePageRoute: (settings) {
        return ShaPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      },
      ShaRoutes.addDeviceRoute: (settings) {
        return ShaPageRoute(
          builder: (_) => const SelectSurroundingPage(),
          settings: settings,
        );
      },
      ShaRoutes.settingsPageRoute: (settings) {
        return ShaPageRoute(
          builder: (_) => const SettingsPage(),
          settings: settings,
        );
      },
      ShaRoutes.notificationsPageRoute: (settings) {
        return ShaPageRoute(
          builder: (_) => const NotificationsPage(),
          settings: settings,
        );
      },
      ShaRoutes.registerNewEnvRoute: (settings) {
        return ShaPageRoute(
          builder: (_) => const RegisterNewEnvPage(),
          settings: settings,
        );
      },
      ShaRoutes.connectDeviceRoute: (settings) {
        return ShaPageRoute(
          builder: (_) => const ConnectDevicePage(),
          settings: settings,
        );
      }
    };
  }
}
