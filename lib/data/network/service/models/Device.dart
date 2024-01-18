import 'package:sha/data/network/service/models/Thing.dart';

class Device {
  final String environmentId;
  final String surroundingId;
  final String deviceId;
  final List<Thing> things;

  Device({
    required this.environmentId,
    required this.surroundingId,
    required this.deviceId,
    required this.things
  });

  factory Device.fromJson(Map<String, dynamic> parsedJson) {
    final String environmentId = parsedJson['environmentID'];
    final String surroundingId = parsedJson['surroundingID'];
    final String id = parsedJson['id'];
    final List<Thing> things = <Thing>[];
    if (parsedJson['things'] != null) {
      parsedJson['things'].forEach((v) {
        things.add(Thing.fromJson(v));
      });
    }
    return Device(environmentId: environmentId, surroundingId: surroundingId, deviceId: id, things: things);
  }
}