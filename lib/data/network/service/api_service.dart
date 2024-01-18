import 'dart:collection';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sha/core/di/app_injector.dart';
import 'package:sha/core/network/api_services.dart';
import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';
import 'package:sha/data/network/service/mock_response_data.dart';
import 'package:sha/data/network/service/models/Device.dart';
import 'package:sha/data/network/service/models/Environment.dart' as env;
import 'package:sha/data/network/service/models/surrounding.dart';
import 'package:sha/models/user.dart';

@injectable
class ApiService {
  final ApiClient _apiClient = AppInjector.I.get();
  final Logger _logger = AppInjector.I.get();
  final String _baseUrl = 'http://127.0.0.1:8080';
  final _defaultError = const NetworkError(message: 'Some error occurred!');

  Future<ApiResponse<List<env.Environment>, NetworkError>> getEnvList() async {
    final url = '$_baseUrl/environments';
    try {
      await MockResponseData.mockApiDelay();
      // final result = await _apiClient.get(url);
      var jsonResponse = jsonDecode(MockResponseData.getEnvListResponse);
      final List<env.Environment> result = (jsonResponse as List).map((e) => env.Environment.fromJson(e)).toList();
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

      final List<Surrounding> result = (jsonResponse as List).map((e) => Surrounding.fromJson(e)).toList();
      return ApiResponse.completed(result);
    } catch (e) {
      return ApiResponse.error(_defaultError);
    }
  }

  Future<ApiResponse<List<Device>, NetworkError>> fetchDevices(String surroundingId) async {
    final url = '$_baseUrl/devices';
    try {
      await MockResponseData.mockApiDelay();
      // final result = await _apiClient.get(url);
      var jsonResponse = jsonDecode(MockResponseData.fetchSurroundingsListResponse);

      final List<Device> result = (jsonResponse as List).map((e) => Device.fromJson(e)).toList();
      return ApiResponse.completed(result);
    } catch (e) {
      return ApiResponse.error(_defaultError);
    }
  }


}
