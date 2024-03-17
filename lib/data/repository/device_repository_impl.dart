import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';
import 'package:sha/data/network/service/models/Device.dart';
import 'package:sha/data/repository/device_repository.dart';
import 'package:sha/util/ShaUtils.dart';

import '../../base/ShaConstants.dart';

import '../../models/surrounding.dart';
import '../../models/thing.dart';
import '../network/service/api_service.dart';
import 'package:sha/data/network/service/models/Environment.dart' as env;
import 'package:sha/models/environment.dart' as envDBModel;
import 'package:sha/models/device.dart' as deviceDBModel;
import 'package:sha/data/network/service/models/surrounding.dart' as surrounding;
import '../../base/boxes.dart';

@Injectable(as: DeviceRepository)
class DeviceRepositoryImpl extends DeviceRepository {
  final ApiService _service;
  DeviceRepositoryImpl(this._service);

  @override
  Future<bool> createDevice(String deviceID, String environmentID, String surroundingID) async {
    try {
      Map<String, dynamic> requestMap = {
        'deviceID': deviceID,
        'environmentID': environmentID,
        'surroundingID': surroundingID
      };
      final ApiResponse<Device, NetworkError> deviceResponse = await _service.createDevice(requestMap);
      if(deviceResponse.success) {
        final device = deviceResponse.data;

        final deviceDB = deviceDBModel.Device(environmentID: device?.environmentId ?? '', surroundingID: device?.surroundingId ?? '',
            id: device?.deviceId ?? '', things: device!.things.map((t) => Thing(
            environmentID: t.environmentId,
            deviceID: t.deviceId,
            id: t.id,
            status: t.status,
            thingType: t.thingType,
            totalStep: int.parse(t.totalStep),
            currentStep: int.parse(t.currentStep),
            lastUpdatedTime: t.lastUpdatedTime
        )).toList());
        final List<deviceDBModel.Device> devicesDB = deviceBox.get(surroundingID, defaultValue: List.empty(growable: true))?.cast<deviceDBModel.Device>();
        devicesDB.add(deviceDB);
        deviceBox.put(surroundingID, devicesDB);
        return true;
      }
    }catch(error, stack) {
      log('Error in creating Environment $error');
      log('Stack trace $stack');
      return false;
    };
    return false;
  }

  @override
  Future<Surrounding?> createSurrounding(String surroundingName, String environmentId) async {
    try {
      Map<String, dynamic> requestMap = {
        'name': surroundingName,
        'environmentID': environmentId
      };
      final ApiResponse<surrounding.Surrounding, NetworkError> surroundingResponse = await _service.createSurrounding(requestMap);
      if(surroundingResponse.success) {
        final surroundingData = surroundingResponse.data;
        final surroundingDB = Surrounding(uuid: surroundingData?.id ?? '', name: surroundingData?.name ?? '');
        final Box surroundingBox = await Hive.openBox(HIVE_SURROUNDING_BOX);
        String surroundingKey = getSurroundingKey(environmentId);
        final List<Surrounding> surroundingsDB = surroundingBox.get(surroundingKey, defaultValue: List.empty(growable: true));
        surroundingsDB.add(surroundingDB);
        surroundingBox.put(surroundingKey, surroundingsDB);
        return surroundingDB;
      }
    }catch(error, stack) {
      log('Error in creating Environment $error');
      log('Stack trace $stack');
      return null;
    }
    return null;
  }

}