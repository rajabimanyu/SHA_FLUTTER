import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';

abstract class EnvironmentsRepository {
  Future<ApiResponse<List<String>, NetworkError>> fetchEnvironments();
  void storeCurrentHomeDB();
}