import 'package:flutter/material.dart';

class RouteMissingArgsFailure implements Exception {}

T getArgsOrThrow<T>(Object? arguments) {
  if (arguments == null) {
    throw RouteMissingArgsFailure();
  }

  return arguments as T;
}

T? tryToGetArgsOrIgnore<T>(Object? arguments) {
  if (arguments != null) {
    return arguments as T;
  }

  return null;
}

abstract class RouterModule {
  const RouterModule();

  Map<String, ShaPageRoute Function(RouteSettings settings)> getRoutes();
}

class ShaPageRoute extends MaterialPageRoute {
  ShaPageRoute({
    required super.builder,
    required super.settings,
    super.maintainState = true,
    super.fullscreenDialog,
    super.allowSnapshotting = true,
  });
}
