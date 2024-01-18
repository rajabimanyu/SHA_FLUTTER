import 'package:hive/hive.dart';
part 'thing.g.dart';

@HiveType(typeId: 3)
class Thing {
  Thing({
    required this.environmentID,
    required this.deviceID,
    required this.id,
    required this.status,
    required this.thingType,
    required this.totalStep,
    required this.currentStep,
    required this.lastUpdatedTime
  });

  @HiveField(0)
  final String environmentID;

  @HiveField(1)
  final String deviceID;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final String thingType;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final int totalStep;

  @HiveField(6)
  final int currentStep;

  @HiveField(7)
  final String lastUpdatedTime;
}


// "[
// {
// ""environmentID"": ""environment63c66138-2105-4f29-b1d4-6f12ae1c051d"",
// ""id"": ""thing75d07515-8370-4e50-94b6-c74232f3799d"",
// ""thingType"": ""FAN"",
// ""status"": ""ON"",
// ""totalStep"": 5,
// ""currentStep"": 2,
// ""lastUpdatedTime"": 1693044552412,
// ""deviceID"": ""devicenew1""
// },
// {
// ""environmentID"": ""environment63c66138-2105-4f29-b1d4-6f12ae1c051d"",
// ""id"": ""thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ac"",
// ""thingType"": ""BULB"",
// ""status"": ""ON"",
// ""totalStep"": 5,
// ""currentStep"": 2,
// ""lastUpdatedTime"": 1693044552710,
// ""deviceID"": ""devicenew1""
// }
// ]"