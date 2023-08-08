import 'package:flutter/material.dart';
import 'package:sha/core/route/router_module.dart';
import 'package:sha/util/safe_try.dart';

class ShaPageRouteHandler {
  final Map<String, ShaPageRoute Function(RouteSettings settings)> routeInfoMap;

  const ShaPageRouteHandler({required this.routeInfoMap});

  ShaPageRoute? getPageRoute(RouteSettings settings) {
    return safeTry(() {
      final pathUri = Uri.parse(settings.name!);
      return routeInfoMap[pathUri.path]!(settings);
    });
  }
}
