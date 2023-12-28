import 'package:injectable/injectable.dart';
import 'package:sha/data/network/repository/environments_repository.dart';

import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';
import 'package:sha/data/network/service/api_service.dart';

@Injectable(as: EnvironmentsRepository)
class EnvironmentsRepositoryImpl implements EnvironmentsRepository {
  final ApiService _service;

  EnvironmentsRepositoryImpl(this._service);

  @override
  Future<ApiResponse<List<String>, NetworkError>> fetchEnvironments() async {
    return _service.getEnvList();
  }

  @override
  void storeCurrentHomeDB() {

  }


}