import 'package:sha/models/thing_status.dart';
import 'package:sha/models/thing_type.dart';

class Thing {
  final String uuid;
  final String name;
  final String resourceId;
  final String? thingData;
  final ThingType thingType;
  final ThingStatus thingStatus;
  final int? totalStep;
  final int? currentStep;
  final String timestamp;

  Thing({
    required this.uuid,
    required this.name,
    required this.resourceId,
    this.thingData,
    required this.thingType,
    required this.thingStatus,
    required this.timestamp,
    this.totalStep,
    this.currentStep,
  });
}
