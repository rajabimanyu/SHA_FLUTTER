import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sha/core/di/app_injector.dart';
import 'package:sha/core/network/api_services.dart';
import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';
import 'package:sha/data/network/service/mock_response_data.dart';
import 'package:sha/models/surrounding.dart';
import 'package:sha/models/user.dart';

@injectable
class ApiService {
  final ApiClient _apiClient = AppInjector.I.get();
  final Logger _logger = AppInjector.I.get();
  final String _baseUrl = '';
  final _defaultError = const NetworkError(message: 'Some error occurred!');

  Future<ApiResponse<User, NetworkError>> loginUser() async {
    await Future.delayed(const Duration(seconds: 1));
    return const ApiResponse.completed(User(sessionId: "sample_session", name: "raj abimanyu", email: "rajabimanyu1@gmail.com"));
  }

  Future<ApiResponse<List<String>, NetworkError>> getEnvList() async {
    final url = '$_baseUrl/environments';
    try {
      await MockResponseData.mockApiDelay();
      // final result = await _apiClient.get(url);
      final List<String> result = (jsonDecode(MockResponseData.getEnvListResponse) as List<dynamic>).cast<String>();
      return ApiResponse.completed(result);
    } catch (e) {
      return ApiResponse.error(_defaultError);
    }
  }

  Future<ApiResponse<List<Surrounding>, NetworkError>> fetchSurroundings(String environmentId) async {
    final url = '$_baseUrl/surroundings';
    try {
      await MockResponseData.mockApiDelay();
      // final result = await _apiClient.get(url);

      var jsonResponse = jsonDecode(MockResponseData.fetchSurroundingsListResponse);

      final List<Surrounding> result =
      (jsonResponse as List).map((e) => Surrounding.fromJson(e)).toList();

      return ApiResponse.completed(result);
    } catch (e) {
      return ApiResponse.error(_defaultError);
    }
  }


}
