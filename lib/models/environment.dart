import 'package:hive/hive.dart';
part 'environment.g.dart';

@HiveType(typeId: 0)
class Environment {
  Environment({
    required this.uuid,
    required this.name,
    required this.isCurrentEnvironment
  });

  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isCurrentEnvironment;
}
