import 'dart:async';

import 'package:sha/core/di/injector.dart';

// TODO: Is this needed?
abstract class InjectionModule {
  const InjectionModule();

  FutureOr<void> registerDependencies({
    required Injector injector,
  });
}
