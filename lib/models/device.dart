import 'package:sha/models/thing.dart';

class Device {
  final String deviceId;
  final String accessKey;
  final List<Thing> things;

  Device({
    required this.deviceId,
    required this.accessKey,
    this.things = const [],
  });
}
