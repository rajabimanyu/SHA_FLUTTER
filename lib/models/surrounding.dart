import 'package:hive/hive.dart';
part 'surrounding.g.dart';

@HiveType(typeId: 0)
class Surrounding {
  Surrounding({
    required this.uuid,
    required this.name
  });

  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final String name;
}
