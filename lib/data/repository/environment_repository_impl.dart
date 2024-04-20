import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sha/data/repository/environment_repository.dart';
import 'package:sha/models/environment.dart' as envDBModel;
import '../../base/ShaConstants.dart';
import '../network/service/api_service.dart';

@Injectable(as: EnvironmentRepository)
class EnvironmentRepositoryImpl implements EnvironmentRepository {
  final ApiService _service;
  EnvironmentRepositoryImpl(this._service);
  @override
  Future<bool> switchEnvironment(String envId) async {
    try {
      Box environmentsBox = await Hive.openBox(HIVE_ENVIRONMENT_BOX);
      final List<envDBModel.Environment> environments = environmentsBox.get(HIVE_ENVIRONMENTS)?.cast<envDBModel.Environment>();
      final envDBModel.Environment currentEnvironment = environments.firstWhere(
              (element) => element.isCurrentEnvironment == true
      );
      final int currentEnvironmentIndex = environments.indexWhere(
              (element) => element.isCurrentEnvironment == true
      );
      envDBModel.Environment replaceCurrentEnvironment = envDBModel.Environment(
          uuid: currentEnvironment.uuid,
          name: currentEnvironment.name,
          isCurrentEnvironment: false);
      environments[currentEnvironmentIndex] = replaceCurrentEnvironment;

      final envDBModel.Environment selectedEnvironment = environments.firstWhere(
              (element) => element.uuid == envId
      );
      final int selectedEnvironmentIndex = environments.indexWhere(
              (element) => element.uuid == envId
      );
      envDBModel.Environment newSelectedCurrentEnvironment = envDBModel.Environment(
          uuid: selectedEnvironment.uuid,
          name: selectedEnvironment.name,
          isCurrentEnvironment: true);
      environments[selectedEnvironmentIndex] = newSelectedCurrentEnvironment;
      return true;
    } catch (e, stack) {
      log('error in switching environment ${e.toString()}');
      log('error in switching environment stacktrace ${stack.toString()}');
    }
    return false;
  }

  @override
  Future<bool> deleteEnvironment(String envId) async {
    try {

      return true;
    } catch(e, stack) {
      log('error in deleting environment ${e.toString()}');
      log('error in deleting environment stacktrace ${stack.toString()}');
    }
    return false;
  }
}