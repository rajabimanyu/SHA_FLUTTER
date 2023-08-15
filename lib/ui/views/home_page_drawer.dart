import 'package:flutter/material.dart';
import 'package:sha/auth/auth_service.dart';
import 'package:sha/route/routes.dart';
import 'package:sha/ui/views/drawer_homes_section.dart';
import 'package:sha/ui/views/drawer_item.dart';
import 'package:sha/ui/views/drawer_header.dart' as dh;
import 'package:sliver_tools/sliver_tools.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  Color _getDrawerColor(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.surface;
    final surfaceTint = theme.colorScheme.surfaceTint;
    return Color.alphaBlend(surfaceTint.withOpacity(0.05), backgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPinnedHeader(
              child: Container(
                color: _getDrawerColor(context),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: dh.DrawerHeader(),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 16)),
            SliverToBoxAdapter(
              child: DrawerHomesSection(
                homesList: const ['John\'s Home', 'Jane\'s Home'],
                onHomeClick: (_) {},
              ),
            ),
            const SliverToBoxAdapter(
              child: DrawerItem(
                title: 'Settings',
                iconData: Icons.settings,
                navigateToRoute: ShaRoutes.settingsPageRoute,
              ),
            ),
            const SliverToBoxAdapter(
              child: DrawerItem(
                title: 'Notifications',
                iconData: Icons.notifications,
                navigateToRoute: ShaRoutes.notificationsPageRoute,
              ),
            ),
            const SliverToBoxAdapter(
              child: DrawerItem(
                title: 'Scan Device',
                iconData: Icons.qr_code_scanner,
                navigateToRoute: ShaRoutes.qrPageRoute,
              ),
            ),
            SliverToBoxAdapter(
              child: DrawerItem(
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
            ),
          ],
        ),
      ),
    );
  }
}
