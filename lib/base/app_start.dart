import 'dart:async';
import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sha/base/di/app_component.dart';
import 'package:sha/base/my_app.dart';
import 'package:sha/base/resolver/app_resolver.dart';
import 'package:sha/core/di/injection_module.dart';
import 'package:sha/core/feature_resolver.dart';
import 'package:sha/core/route/router_module.dart';
import 'package:sha/core/route/sha_page_route_handler.dart';
import 'package:sha/firebase_options.dart';
import 'package:sha/models/environment.dart';
import 'package:sha/models/surrounding.dart';

abstract class AppStart {
  final resolvers = const <FeatureResolver>[AppResolver()];

  const AppStart();

  Future<void> startApp() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EnvironmentAdapter());
    Hive.registerAdapter(SurroundingAdapter());

    final injections = <InjectionModule>[];

    final Map<String, ShaPageRoute Function(RouteSettings settings)> routesMap =
        HashMap();

    for (final resolver in resolvers) {
      if (resolver.routerModule != null) {
        routesMap.addAll(resolver.routerModule!.getRoutes());
      }

      if (resolver.injectionModule != null) {
        injections.add(resolver.injectionModule!);
      }
    }

    final routeHandler = ShaPageRouteHandler(routeInfoMap: routesMap);

    await AppInjectionComponent.instance.registerModules(modules: injections);

    await runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        _initFirebase();
        runApp(
          MyApp(routeHandler: routeHandler),
        );
      },
      (_, __) {},
    );
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
