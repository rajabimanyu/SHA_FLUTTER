import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';

abstract class AuthRepository {
  Future<ApiResponse<bool, NetworkError>> loginUser();
}