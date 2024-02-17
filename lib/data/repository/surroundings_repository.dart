
import 'package:sha/models/surrounding.dart';

abstract class SurroundingsRepository {
  Future<List<Surrounding>> fetchSurroundings();
}