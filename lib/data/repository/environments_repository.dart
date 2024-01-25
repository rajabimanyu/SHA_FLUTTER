import 'dart:async';
import 'package:sha/models/device.dart';
import 'package:sha/models/environment.dart';
import 'package:sha/models/surrounding.dart';

abstract class EnvironmentsRepository {
  Future<List<Surrounding>> fetchHomeSurroundings();
  Future<List<Environment>> fetchEnvironments();
  Future<List<Device>> fetchDevices(String surroundingId);
  void toggleThingState(String surroundingId, String deviceId, String id, String thingType, String status, String currentStep, String totalStep);
}