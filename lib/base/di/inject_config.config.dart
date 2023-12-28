// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sha/data/network/repository/environments_repository.dart';
import 'package:sha/data/network/repository/environments_repository_impl.dart';
import 'package:sha/data/network/repository/surroundings_repository.dart';
import 'package:sha/data/network/repository/surroundings_repository_impl.dart';

import '../../data/network/repository/auth_repository.dart';
import '../../data/network/repository/auth_repository_impl.dart';
import '../../data/network/repository/auth_repository.dart';
import '../../data/network/repository/auth_repository_impl.dart';
import '../../data/network/service/api_service.dart';

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
GetIt $initGetIt(
  GetIt getIt, {
  String? environment,
  EnvironmentFilter? environmentFilter,
}) {
  final gh = GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<ApiService>(() => ApiService());
  gh.factory<AuthRepository>(
      () => AuthRepositoryImpl(gh<ApiService>()));
  gh.factory<EnvironmentsRepository>(
          () => EnvironmentsRepositoryImpl(gh<ApiService>()));
  gh.factory<SurroundingsRepository>(
          () => SurroundingsRepositoryImpl(gh<ApiService>()));
  return getIt;
}
