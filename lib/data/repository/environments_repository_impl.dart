

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/data/network/service/models/Thing.dart';
import 'package:sha/data/network/service/models/surrounding.dart' as surrounding;
import 'package:sha/data/repository/environments_repository.dart';

import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';
import 'package:sha/data/network/service/api_service.dart';
import 'package:sha/data/network/service/models/Device.dart' as device;
import'package:sha/data/network/service/models/Environment.dart' as env;
import 'package:sha/models/environment.dart' as envDBModel;
import 'package:sha/models/surrounding.dart' as surroundingDBModel;
import 'package:sha/models/device.dart' as deviceDBModel;
import 'package:sha/models/thing.dart' as thingDBModel;
import 'package:sha/util/ShaUtils.dart';

import '../../base/ShaConstants.dart';
import '../../base/boxes.dart';
import '../../models/device.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final ApiService _service;

  HomeRepositoryImpl(this._service);

  @override
  Future<List<envDBModel.Environment>> fetchEnvironments() async {
    try {
      log("fetchenvapi");
      Box environmentsBox = await Hive.openBox(HIVE_ENVIRONMENT_BOX);
      log("after box");
      final ApiResponse<List<env.Environment>, NetworkError> envResponse = await _service.getEnvList();
      if(envResponse.success) {
        List<env.Environment> environments = envResponse.data ?? List.empty(growable: false);
        log('environments from api $environments');
        if(environments.isNotEmpty) {
          final currentEnvironment = await getCurrentEnvironment(envDBModel.Environment(uuid: environments[0].id, name: environments[0].name, isCurrentEnvironment: true));
          final List<envDBModel.Environment> environmentsDB = environments.map((e) => envDBModel.Environment(uuid: e.id, name: e.name, isCurrentEnvironment: currentEnvironment.uuid == e.id)).toList();
          await environmentsBox.put(HIVE_ENVIRONMENTS, environmentsDB);
          return environmentsDB;
        }
      } else {
        if(environmentsBox.containsKey(HIVE_ENVIRONMENTS)) {
          final List<envDBModel.Environment> finalEnvironments = environmentsBox.get(HIVE_ENVIRONMENTS)?.cast<envDBModel.Environment>();
          return finalEnvironments;
        }
      }
    } catch (e, stack) {
      print("exception in fetchEnv : $e");
      print("stacktrace : $stack");
    }
    return List.empty(growable: false);
  }

  @override
  Future<envDBModel.Environment> getCurrentEnvironment(envDBModel.Environment defaultCurrentEnvironment) async {
    Box environmentsBox = await Hive.openBox(HIVE_ENVIRONMENT_BOX);
    if(environmentsBox.containsKey(HIVE_ENVIRONMENTS)) {
      final List<envDBModel.Environment> environments = environmentsBox.get(HIVE_ENVIRONMENTS)?.cast<envDBModel.Environment>();
      final envDBModel.Environment currentEnvironment = environments.firstWhere(
              (element) => element.isCurrentEnvironment == true, orElse: () => defaultCurrentEnvironment
      );
      return currentEnvironment;
    }

    return defaultCurrentEnvironment;
  }

  @override
  Future<List<surroundingDBModel.Surrounding>> fetchHomeSurroundings() async {
    try {
      final List<envDBModel.Environment> environments = await fetchEnvironments();
      if(environments.isNotEmpty) {
        Box surroundingsBox = await Hive.openBox(HIVE_SURROUNDING_BOX);
        final envDBModel.Environment currentEnvironment = environments.firstWhere((element) => element.isCurrentEnvironment == true, orElse:() => environments[0]);
        final ApiResponse<List<surrounding.Surrounding>, NetworkError> surroundingResponse = await _service.fetchSurroundings(currentEnvironment.uuid);
        if(surroundingResponse.success) {
          final List<surrounding.Surrounding> surroundings = surroundingResponse.data ?? List.empty(growable: false);
          log('environments from api $surroundings');
          final List<surroundingDBModel.Surrounding> surroundingsDB = surroundings.map((e) => surroundingDBModel.Surrounding(uuid: e.id, name: e.name)).toList();
          if(surroundingsDB.isNotEmpty) {
            surroundingsBox.put(getSurroundingKey(currentEnvironment.uuid), surroundingsDB);
            return surroundingsDB;
          } else {
            return List.empty(growable: false);
          }
        } else {
          if(surroundingsBox.containsKey(getSurroundingKey(currentEnvironment.uuid))) {
            final List<surroundingDBModel.Surrounding> finalSurroundings = surroundingsBox.get(getSurroundingKey(currentEnvironment.uuid))?.cast<surroundingDBModel.Surrounding>();
            return finalSurroundings;
          }
        }
      }
    } catch (e, stack) {
      log("exception in homedata $stack");
      print(stack);
    }
    return List.empty(growable: false);
  }

  @override
  Future<List<Device>> fetchDevices(String surroundingId) async {
    try {
      log('fetching devices for surrounding $surroundingId');
      final ApiResponse<List<device.Device>, NetworkError> devicesResponse = await _service.fetchDevices(surroundingId);
      Box devicesBox = await Hive.openBox(HIVE_DEVICES_BOX);
      if(devicesResponse.success) {
        final List<device.Device> devices = devicesResponse.data ?? List.empty(growable: false);
        final List<deviceDBModel.Device> devicesDB = devices.map((e) => deviceDBModel.Device(
            environmentID: e.environmentId,
            surroundingID: e.surroundingId,
            id: e.deviceId,
            things: e.things.map((t) => thingDBModel.Thing(
                environmentID: t.environmentId,
                deviceID: t.deviceId,
                id: t.id,
                status: t.status,
                thingType: t.thingType,
                totalStep: int.parse(t.totalStep),
                currentStep: int.parse(t.currentStep),
                lastUpdatedTime: t.lastUpdatedTime
            )).toList())
        ).toList();
        if(devicesDB.isNotEmpty) {
          await devicesBox.put(surroundingId, devicesDB);
          return devicesDB;
        }
      }
    } catch (e, stack) {
      log('exception in devices fetch : $e');
      print('$stack');
    }
    return List.empty(growable: false);
  }

  @override
  void toggleThingState(String surroundingId, String deviceId, String id, String thingType, String status, String currentStep, String totalStep) async {
    try {
      Map<String, dynamic> requestMap = {
        'id': id,
        'thingType': thingType,
        'status': status,
        'totalStep': totalStep,
        'currentStep': currentStep
      };

      ApiResponse<Thing, NetworkError> response = await _service.toggleThingSettings(requestMap);
      log('before all ${response.success}');
      log('before all ${response.error}');
      log('request $requestMap');
      if(response.success) {
        log('succ');
        Thing? thingResponse = response.data;
        log('succ $thingResponse');
        if(thingResponse != null) {
          log('resp null $thingResponse');
          if (deviceBox.containsKey(surroundingId)) {
            log('device box has $surroundingId');
            List<Device> devicesDB = deviceBox.get(surroundingId).cast<Device>();
            Device deviceDB = devicesDB.firstWhere((element) => element.id == deviceId);
            int deviceIndexToReplace = devicesDB.indexWhere((element) => element.id == deviceId);
            thingDBModel.Thing thingDB = thingDBModel.Thing(environmentID: thingResponse.environmentId,
                deviceID: thingResponse.deviceId,
                id: thingResponse.id,
                status: thingResponse.status,
                thingType: thingResponse.thingType,
                totalStep: int.parse(thingResponse.totalStep),
                currentStep: int.parse(thingResponse.currentStep),
                lastUpdatedTime: thingResponse.lastUpdatedTime);

            List<thingDBModel.Thing> thingsDB = deviceDB.things;
            int thingIndexToReplace = thingsDB.indexWhere((element) => element.id == thingDB.id);
            if(thingIndexToReplace >= 0 && thingIndexToReplace < thingsDB.length) {
              log('thing index $thingIndexToReplace');
              thingsDB[thingIndexToReplace] = thingDB;
              if(deviceIndexToReplace >= 0 && deviceIndexToReplace < devicesDB.length) {
                log('dewv index $deviceIndexToReplace');
                deviceDBModel.Device device = deviceDBModel.Device(
                    environmentID: deviceDB.environmentID, surroundingID: deviceDB.surroundingID, id: deviceDB.id, things: thingsDB);
                devicesDB[deviceIndexToReplace] = device;
                deviceBox.put(surroundingId, devicesDB);
              }
            }
          }
        }
      }
    } catch (e, stack) {
      log('exception in toggle thing settings : $e');
      print('$stack');
    }
  }
}