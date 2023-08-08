import 'package:flutter/material.dart';
import 'package:sha/core/route/app_navigator.dart';
import 'package:sha/core/route/sha_navigator.dart';

class ShaAppNavigator with AppNavigator implements ShaNavigator {
  const ShaAppNavigator();

  @override
  void navigateToRoute(
    BuildContext context,
    String route,
    String anchor, {
    dynamic args,
    bool pushAndReplace = false,
  }) =>
      navigateTo(
        context,
        route,
        pushAndReplace: pushAndReplace,
        anchor: anchor,
        arguments: args,
      );
}
