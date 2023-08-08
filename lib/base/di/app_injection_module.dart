import 'dart:async';

import 'package:logger/logger.dart';
import 'package:sha/base/di/inject_config.dart';
import 'package:sha/core/di/injection_module.dart';
import 'package:sha/core/di/injector.dart';
import 'package:sha/core/network/api_services.dart';
import 'package:sha/core/route/app_router.dart';
import 'package:sha/core/route/sha_navigator.dart';

class AppInjectionModule implements InjectionModule {
  const AppInjectionModule();

  @override
  FutureOr<void> registerDependencies({required Injector injector}) {
    injector.registerSingleton<ShaNavigator>(const ShaAppNavigator());

    injector.registerSingleton<ApiClient>(ApiClient());

    configureLocalDependencies();

    injector.registerSingleton<Logger>(Logger());
  }
}
