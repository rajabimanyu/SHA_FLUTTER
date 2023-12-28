import 'package:injectable/injectable.dart';
import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';
import 'package:sha/data/network/repository/surroundings_repository.dart';
import 'package:sha/models/surrounding.dart';

import '../service/api_service.dart';

@Injectable(as: SurroundingsRepository)
class SurroundingsRepositoryImpl extends SurroundingsRepository {
  final ApiService _service;

  SurroundingsRepositoryImpl(this._service);

  @override
  Future<ApiResponse<List<Surrounding>, NetworkError>> fetchSurroundings(String environmentId) async {
    return _service.fetchSurroundings(environmentId);
  }
}