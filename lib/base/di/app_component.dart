import 'package:sha/core/di/app_injector.dart';
import 'package:sha/core/di/injection_module.dart';

class AppInjectionComponent {
  const AppInjectionComponent._();

  static AppInjectionComponent instance = const AppInjectionComponent._();

  Future<void> registerModules({
    required List<InjectionModule> modules,
  }) async {
    for (final module in modules) {
      await module.registerDependencies(injector: AppInjector.I);
    }
  }
}
