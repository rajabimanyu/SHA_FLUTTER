import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sha/core/di/app_injector.dart';
import 'package:sha/core/network/api_services.dart';
import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';
import 'package:sha/data/network/service/mock_response_data.dart';
import 'package:sha/data/network/service/models/Device.dart';
import 'package:sha/data/network/service/models/Environment.dart' as env;
import 'package:sha/data/network/service/models/Thing.dart';
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
    } catch (e, stack) {
      log('error in environments fetch : $e');
      print('error in environments fetch stack : $stack');
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
    } catch (e, stack) {
      log('error in surroundings fetch : $e');
      print('error in surroundings fetch stack : $stack');
      return ApiResponse.error(_defaultError);
    }
  }

  Future<ApiResponse<List<Device>, NetworkError>> fetchDevices(String surroundingId) async {
    final url = '$_baseUrl/devices';
    try {
      await MockResponseData.mockApiDelay();
      // final result = await _apiClient.get(url);

      var jsonResponse = jsonDecode(_getDevices(surroundingId));

      final List<Device> result = (jsonResponse as List).map((e) => Device.fromJson(e)).toList();
      return ApiResponse.completed(result);
    } catch (e, stack) {
      log('error in devices fetch : $e');
      print('error in devices fetch stack : $stack');
      return ApiResponse.error(_defaultError);
    }
  }

  Future<ApiResponse<Thing, NetworkError>> toggleThingSettings(Map<String, dynamic> requestData) async {
    final url = '$_baseUrl/things';
    try {
      await MockResponseData.mockApiDelay();
      // final result = await _apiClient.get(url);
      late var jsonResponse;
      if(requestData['status'] == "ON") {
        jsonResponse = jsonDecode(MockResponseData.toggleBulbStatusOFF);
      } else {
        jsonResponse = jsonDecode(MockResponseData.toggleBulbStatusON);
      }
      final Thing result = Thing.fromJson(jsonResponse);
      return ApiResponse.completed(result);
    } catch (e, stack) {
      log('error in devices fetch : $e');
      print('error in devices fetch stack : $stack');
      return ApiResponse.error(_defaultError);
    }
  }

  String _getDevices(String surroundingId) {
    switch (surroundingId) {
      case "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d25":
        return MockResponseData.surroundingBedroom;
      case "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d26":
        return MockResponseData.surroundingKitchen;
      case "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d27":
        return MockResponseData.surroundingLiving;
      case "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d28":
        return MockResponseData.surroundingMaster;
      case "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d29":
        return MockResponseData.surroundingBalcony;
      case "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d30":
        return MockResponseData.surroundingStore;
      case "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d31":
        return MockResponseData.surroundingWaiting;
      case "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d32":
        return MockResponseData.surroundingBedFirst;
      case "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d33":
        return MockResponseData.surroundingBathroom;
    }
    
    return "";
  }


}
