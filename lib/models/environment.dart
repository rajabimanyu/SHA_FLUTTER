import 'package:sha/models/surrounding.dart';

class Environment {
  final String uuid;
  final String name;
  final List<Surrounding> surroundings;

  Environment({
    required this.uuid,
    required this.name,
    this.surroundings = const [],
  });
}
