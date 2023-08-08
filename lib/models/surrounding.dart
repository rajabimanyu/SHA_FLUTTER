import 'package:sha/models/device.dart';

class Surrounding {
  final String uuid;
  final String name;
  final List<Device> devices;

  Surrounding({
    required this.uuid,
    required this.name,
    this.devices = const [],
  });
}