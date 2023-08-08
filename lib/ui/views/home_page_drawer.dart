import 'package:flutter/material.dart';
import 'package:sha/auth/auth_service.dart';
import 'package:sha/route/routes.dart';
import 'package:sha/ui/views/drawer_item.dart';
import 'package:sha/ui/views/drawer_header.dart' as dh;

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: dh.DrawerHeader(),
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            const SizedBox(
              height: 16,
            ),
            const DrawerItem(
              title: 'Settings',
              iconData: Icons.settings,
              navigateToRoute: ShaRoutes.settingsPageRoute,
            ),
            const DrawerItem(
              title: 'Notifications',
              iconData: Icons.notifications,
              navigateToRoute: ShaRoutes.notificationsPageRoute,
            ),
            const DrawerItem(
              title: 'Scan Device',
              iconData: Icons.qr_code_scanner,
              navigateToRoute: ShaRoutes.qrPageRoute,
            ),
            DrawerItem(
              title: 'Logout',
              iconData: Icons.logout,
              onClick: () {
                AuthService().signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  ShaRoutes.loginPageRoute,
                  (route) => route.settings.name == ShaRoutes.splashRoute,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
