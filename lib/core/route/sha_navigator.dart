import 'package:flutter/material.dart';

abstract class ShaNavigator {
  void navigateToRoute(BuildContext context, String route, String anchor,
      {dynamic args});
}
