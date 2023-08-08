import 'dart:async';

import 'package:sha/core/di/injector.dart';

abstract class InjectionModule {
  const InjectionModule();

  FutureOr<void> registerDependencies({
    required Injector injector,
  });
}
