import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sha/data/network/service/api_service.dart';
import 'package:sha/data/repository/surroundings_repository.dart';
import 'package:sha/models/surrounding.dart';

import 'package:sha/models/environment.dart' as envDB;
import 'package:sha/models/surrounding.dart';
import '../../base/ShaConstants.dart';
import '../../util/ShaUtils.dart';

@Injectable(as: SurroundingsRepository)
class SurroundingsRepositoryImpl extends SurroundingsRepository {
  SurroundingsRepositoryImpl();

  @override
  Future<List<Surrounding>> fetchSurroundings(String currentEnvironmentId) async {
    try {
      Box surroundingsBox = await Hive.openBox(HIVE_SURROUNDING_BOX);
      final List<Surrounding> surroundings = surroundingsBox.get(getSurroundingKey(currentEnvironmentId));
      return surroundings;
    } catch(e, stack) {
      log('error in fetching surroundings ${e.toString()}');
      log('error in fetching surroundings stacktrace ${stack.toString()}');
    }
    return List.empty(growable: false);
  }
}