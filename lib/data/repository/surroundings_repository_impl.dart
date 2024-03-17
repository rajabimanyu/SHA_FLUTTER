import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/data/repository/data_response.dart';
import 'package:sha/data/repository/surroundings_repository.dart';
import 'package:sha/models/surrounding.dart' as surrdingDB;
import 'package:sha/data/network/service/models/surrounding.dart' as surroundingAPI;

import 'package:sha/models/environment.dart' as envDB;
import '../../base/ShaConstants.dart';
import '../../core/network/network_error.dart';
import '../../core/network/response.dart';
import 'package:sha/data/network/service/api_service.dart';
import '../../util/ShaUtils.dart';

@Injectable(as: SurroundingsRepository)
class SurroundingsRepositoryImpl extends SurroundingsRepository {
  final ApiService _service;
  SurroundingsRepositoryImpl(this._service);

  @override
  Future<List<surrdingDB.Surrounding>> fetchSurroundings(String currentEnvironmentId) async {
    try {
      Box surroundingsBox = await Hive.openBox(HIVE_SURROUNDING_BOX);
      final List<surrdingDB.Surrounding> surroundings = surroundingsBox.get(getSurroundingKey(currentEnvironmentId));
      return surroundings;
    } catch(e, stack) {
      log('error in fetching surroundings ${e.toString()}');
      log('error in fetching surroundings stacktrace ${stack.toString()}');
    }
    return List.empty(growable: false);
  }

  @override
  Future<DataResponse<surrdingDB.Surrounding?, DataError>> createSurrounding(String surroundingName, String environmentId) async {
    try {
      Map<String, dynamic> requestMap = {
        'name': surroundingName,
        'environmentID': environmentId
      };
      final ApiResponse<surroundingAPI.Surrounding, NetworkError> surroundingResponse = await _service.createSurrounding(requestMap);
      if(surroundingResponse.success) {
        final surroundingData = surroundingResponse.data;
        final surroundingDB = surrdingDB.Surrounding(uuid: surroundingData?.id ?? '', name: surroundingData?.name ?? '');
        final Box surroundingBox = await Hive.openBox(HIVE_SURROUNDING_BOX);
        String surroundingKey = getSurroundingKey(environmentId);
        final List<surrdingDB.Surrounding> surroundingsDB = surroundingBox.get(surroundingKey, defaultValue: List.empty(growable: true));
        surroundingsDB.add(surroundingDB);
        surroundingBox.put(surroundingKey, surroundingsDB);
        return DataResponse.completed(surroundingDB);
      } else {
        log('surrounding creation failed : ${surroundingResponse.error?.message}');
        return DataResponse.error(DataError(message: surroundingResponse.error?.message ?? 'Surrounding creation failed', dataErrorType: DataErrorType.CREATE_SURROUNDING_ERROR));
      }
    }catch(error, stack) {
      log('Error in creating Environment $error');
      log('Stack trace $stack');
      return DataResponse.error(DataError(message: stack.toString(), dataErrorType: DataErrorType.CREATE_SURROUNDING_ERROR));
    }
  }
}