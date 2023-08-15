import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sha/core/di/app_injector.dart';
import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';

@injectable
class ApiService {
  final Logger _logger = AppInjector.I.get();

  Future<ApiResponse<bool, NetworkError>> loginUser() async {
    await Future.delayed(const Duration(seconds: 3));
    return const ApiResponse.completed(true);
  }
}