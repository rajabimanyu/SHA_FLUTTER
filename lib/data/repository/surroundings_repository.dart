
import 'package:sha/models/surrounding.dart';

import '../../core/model/ui_state.dart';
import 'data_response.dart';

abstract class SurroundingsRepository {
  Future<List<Surrounding>> fetchSurroundings(String currentEnvironmentId);
  Future<DataResponse<Surrounding?, DataError>> createSurrounding(String surroundingName, String environmentId);
}