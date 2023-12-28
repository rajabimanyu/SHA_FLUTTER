import 'package:sha/models/surrounding.dart';

import '../../../core/network/network_error.dart';
import '../../../core/network/response.dart';

abstract class SurroundingsRepository {
  Future<ApiResponse<List<Surrounding>, NetworkError>> fetchSurroundings(String environmentId);
}