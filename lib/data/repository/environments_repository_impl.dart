

import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:sha/data/network/service/models/surrounding.dart' as surrounding;
import 'package:sha/data/repository/environments_repository.dart';

import 'package:sha/core/network/network_error.dart';
import 'package:sha/core/network/response.dart';
import 'package:sha/data/network/service/api_service.dart';
import 'package:sha/data/network/service/models/Environment.dart' as env;
import 'package:sha/models/environment.dart' as envDBModel;
import 'package:sha/models/surrounding.dart' as surroundingDBModel;

import '../../base/ShaConstants.dart';

@Injectable(as: EnvironmentsRepository)
class EnvironmentsRepositoryImpl implements EnvironmentsRepository {
  final ApiService _service;

  EnvironmentsRepositoryImpl(this._service);

  @override
  Future<List<envDBModel.Environment>> fetchEnvironments() async {
    try {
      log("fetchenvapi");
      Box environmentsBox = await Hive.openBox(HIVE_ENVIRONMENT_BOX);
      final ApiResponse<List<env.Environment>, NetworkError> envResponse = await _service.getEnvList();
      List<env.Environment> environments = envResponse.data ?? List.empty(growable: false);
      log('environments from api $environments');
      if(environments.isNotEmpty) {
        final currentEnvironment = await _getCurrentEnvironment(envDBModel.Environment(uuid: environments[0].id, name: environments[0].name, isCurrentEnvironment: true));
        final List<envDBModel.Environment> environmentsDB = environments.map((e) => envDBModel.Environment(uuid: e.id, name: e.name, isCurrentEnvironment: currentEnvironment.uuid == e.id)).toList();
        await environmentsBox.put(HIVE_ENVIRONMENTS, environmentsDB);
        late var finalEnvironments;
        if(environmentsBox.containsKey(HIVE_ENVIRONMENTS)) {
          finalEnvironments = environmentsBox.get(HIVE_ENVIRONMENTS)?.cast<envDBModel.Environment>();
          environmentsBox.close();
          return finalEnvironments;
        }
      }
      environmentsBox.close();
    } catch (e, stack) {
      print("exception in fetchEnv $e");
      print("stacktrace : $stack");
    }
    return List.empty(growable: false);
  }

  Future<envDBModel.Environment> _getCurrentEnvironment(envDBModel.Environment defaultCurrentEnvironment) async {
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
        final envDBModel.Environment currentEnvironment = environments.firstWhere((element) => element.isCurrentEnvironment == true, orElse:() => environments[0]);
        final ApiResponse<List<surrounding.Surrounding>, NetworkError> surroundingResponse = await _service.fetchSurroundings(currentEnvironment.uuid);
        final List<surrounding.Surrounding> surroundings = surroundingResponse.data ?? List.empty(growable: false);
        log('environments from api $surroundings');
        final List<surroundingDBModel.Surrounding> surroundingsDB = surroundings.map((e) => surroundingDBModel.Surrounding(uuid: e.id, name: e.name)).toList();
        if(surroundingsDB.isNotEmpty) {
          Box surroundingsBox = await Hive.openBox(HIVE_SURROUNDING_BOX);
          surroundingsBox.put(HIVE_SURROUNDINGS, surroundingsDB);
          return surroundingsDB;
        } else {
          return List.empty(growable: false);
        }
      }
    } catch (e, stack) {
      log("exception in homedata $stack");
      print(stack);
    }
    return List.empty(growable: false);
  }
}