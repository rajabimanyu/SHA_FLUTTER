import 'package:sha/models/surrounding.dart';

class Environment {
  final String uuid;
  final String name;
  final bool isCurrentEnvironment;

  Environment({
    required this.uuid,
    required this.name,
    this.isCurrentEnvironment = false,
  });
}
