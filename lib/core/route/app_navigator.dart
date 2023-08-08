import 'package:flutter/material.dart';

mixin AppNavigator {
  Future<R?> navigateTo<R, A>(
    BuildContext context,
    String routeName, {
    A? arguments,
    bool pushAndReplace = false,
    String? anchor,
  }) async {
    if (pushAndReplace && anchor != null) {
      return Navigator.of(context).pushNamedAndRemoveUntil<R>(
        routeName,
        (route) => route.settings.name == anchor,
        arguments: arguments,
      );
    }

    return await Navigator.of(context).pushNamed<R>(
      routeName,
      arguments: arguments,
    );
  }
}
