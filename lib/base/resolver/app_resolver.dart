import 'package:sha/base/di/app_injection_module.dart';
import 'package:sha/core/di/injection_module.dart';
import 'package:sha/core/feature_resolver.dart';
import 'package:sha/core/route/router_module.dart';
import 'package:sha/route/sha_router_module.dart';

class AppResolver extends FeatureResolver {
  const AppResolver();

  @override
  InjectionModule? get injectionModule => const AppInjectionModule();

  @override
  RouterModule? get routerModule => const ShaRouterModule();
}
