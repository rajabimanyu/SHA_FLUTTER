import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';
import 'package:sha/data/repository/NewDeviceRepository.dart';
import 'package:sha/util/ShaUtils.dart';

import '../../base/ShaConstants.dart';

import '../../models/surrounding.dart';
import '../network/service/api_service.dart';
import 'package:sha/data/network/service/models/Environment.dart' as env;
import 'package:sha/models/environment.dart' as envDBModel;
import 'package:sha/data/network/service/models/surrounding.dart' as surrounding;


@Injectable(as: NewDeviceRepository)
class NewDeviceRepositoryImpl extends NewDeviceRepository {
  final ApiService _service;
  NewDeviceRepositoryImpl(this._service);

  @override
  void createDevice(String deviceID, String environmentID, String surroundingID) async {
    try {
      Box envBox = await Hive.openBox(HIVE_ENVIRONMENT_BOX);
      Map<String, dynamic> requestMap = {
        'deviceID': deviceID,
        'environmentID': environmentID,
        'surroundingID': surroundingID
      };
      final ApiResponse<env.Environment, NetworkError> envResponse = await _service.createEnvironment(requestMap);
      if(envResponse.success) {
        final environment = envResponse.data;
        final environmentDB = envDBModel.Environment(uuid: environment?.id ?? "", name: environment?.name ?? "", isCurrentEnvironment: false);
        final List<envDBModel.Environment> environmentsFromDB = envBox.get(HIVE_ENVIRONMENT_BOX, defaultValue: List.empty(growable: true));
        environmentsFromDB.add(environmentDB);
        envBox.put(HIVE_ENVIRONMENT_BOX, environmentsFromDB);
      }
    }catch(error, stack) {
      log('Error in creating Environment $error');
      log('Stack trace $stack');
    };
  }

  @override
  void createEnvironment(String envName) async {
    try {
      Box envBox = await Hive.openBox(HIVE_ENVIRONMENT_BOX);
      Map<String, dynamic> requestMap = {
        'name': envName
      };
      final ApiResponse<env.Environment, NetworkError> envResponse = await _service.createEnvironment(requestMap);
      if(envResponse.success) {
        final environment = envResponse.data;
        final environmentDB = envDBModel.Environment(uuid: environment?.id ?? "", name: environment?.name ?? "", isCurrentEnvironment: false);
        final List<envDBModel.Environment> environmentsFromDB = envBox.get(HIVE_ENVIRONMENT_BOX, defaultValue: List.empty(growable: true));
        environmentsFromDB.add(environmentDB);
        envBox.put(HIVE_ENVIRONMENT_BOX, environmentsFromDB);
      }
    }catch(error, stack) {
      log('Error in creating Environment $error');
      log('Stack trace $stack');
    };
  }

  @override
  void createSurrounding(String surroundingName, String environmentId) async {
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
      }
    }catch(error, stack) {
      log('Error in creating Environment $error');
      log('Stack trace $stack');
    }
  }

}