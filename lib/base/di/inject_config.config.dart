// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/network/service/api_service.dart' as _i3;
import '../../data/repository/environments_repository.dart' as _i4;
import '../../data/repository/environments_repository_impl.dart' as _i5;
import '../../data/repository/surroundings_repository.dart' as _i6;
import '../../data/repository/surroundings_repository_impl.dart' as _i7;
import '../../data/repository/NewDeviceRepository.dart' as _i8;
import '../../data/repository/new_device_repository_impl.dart' as _i9;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.ApiService>(() => _i3.ApiService());
  gh.factory<_i4.HomeRepository>(
      () => _i5.HomeRepositoryImpl(gh<_i3.ApiService>()));
  gh.factory<_i6.SurroundingsRepository>(
      () => _i7.SurroundingsRepositoryImpl(gh<_i3.ApiService>()));
  gh.factory<_i8.NewDeviceRepository>(
          () => _i9.NewDeviceRepositoryImpl(gh<_i3.ApiService>()));
  return getIt;
}
