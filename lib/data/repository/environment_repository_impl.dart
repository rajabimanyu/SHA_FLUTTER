import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sha/data/repository/environment_repository.dart';
import 'package:sha/models/environment.dart' as envDBModel;
import '../../base/ShaConstants.dart';

@Injectable(as: EnvironmentRepository)
class EnvironmentRepositoryImpl implements EnvironmentRepository {
  EnvironmentRepositoryImpl();
  @override
  Future<bool> switchEnvironment(String envId) async {
    try {
      log("swicth home env");
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
      log("swicth home true");

      final List<envDBModel.Environment> finalenvironments = environmentsBox.get(HIVE_ENVIRONMENTS)?.cast<envDBModel.Environment>();
      log('changed env $finalenvironments');
      for (var element in finalenvironments) {
        log('env info ${element.uuid}, ${element.name}, ${element.isCurrentEnvironment}');
      }

      return true;
    } catch (e, stack) {
      log('error in switching environment ${e.toString()}');
      log('error in switching environment stacktrace ${stack.toString()}');
    }
    log("swicth home fail");
    return false;
  }
}