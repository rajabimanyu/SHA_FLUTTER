import 'package:flutter/material.dart';
import 'package:sha/core/route/sha_page_route_handler.dart';
import 'package:sha/util/glowless_scroll_behavior.dart';
import 'package:sizer/sizer.dart';

class MyApp extends StatelessWidget {
  final ShaPageRouteHandler routeHandler;

  const MyApp({required this.routeHandler, super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          onGenerateRoute: (settings) => routeHandler.getPageRoute(settings),
          builder: (context, child) => Scaffold(body: child),
          debugShowCheckedModeBanner: false,
          scrollBehavior: GlowlessScrollBehavior(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: ThemeMode.dark,
        );
      },
    );
  }
}
