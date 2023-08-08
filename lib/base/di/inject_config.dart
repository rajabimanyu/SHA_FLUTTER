import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sha/base/di/inject_config.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureLocalDependencies() => $initGetIt(getIt);
