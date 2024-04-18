import 'dart:async';
import 'package:sha/data/repository/data_response.dart';
import 'package:sha/models/device.dart';
import 'package:sha/models/environment.dart';
import 'package:sha/models/surrounding.dart';

import '../../core/model/ui_state.dart';

abstract class HomeRepository {
  Future<List<Surrounding>> fetchHomeSurroundings({bool isOffline = false});
  Future<List<Environment>> fetchEnvironments({bool isOffline = false});
  Future<List<Device>> fetchDevices(String surroundingId);
  void toggleThingState(String surroundingId, String deviceId, String id, String thingType, String status, String currentStep, String totalStep);
  Future<Environment> getCurrentEnvironment(Environment defaultCurrentEnvironment);
  Future<DataResponse<Environment, DataError>> createEnvironment(String envName);
}