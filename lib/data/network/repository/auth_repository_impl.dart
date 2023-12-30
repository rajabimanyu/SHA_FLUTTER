import 'package:injectable/injectable.dart';
import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';
import 'package:sha/data/network/repository/auth_repository.dart';
import 'package:sha/data/network/service/api_service.dart';
import 'package:sha/models/user.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final ApiService _service;

  AuthRepositoryImpl(this._service);
}