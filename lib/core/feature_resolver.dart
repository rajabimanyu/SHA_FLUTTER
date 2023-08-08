import 'package:sha/core/di/injection_module.dart';
import 'package:sha/core/route/router_module.dart';

abstract class FeatureResolver {
  const FeatureResolver();

  RouterModule? get routerModule => null;

  InjectionModule? get injectionModule => null;
}
