import 'package:sha/models/thing.dart';
import 'package:hive/hive.dart';
part 'device.g.dart';

@HiveType(typeId: 2)
class Device {
  Device({
    required this.environmentID,
    required this.surroundingID,
    required this.id,
    required this.things,
  });

  @HiveField(0)
  final String environmentID;

  @HiveField(1)
  final String surroundingID;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final List<Thing> things;
}


// "[
// {
// ""environmentID"": ""environment63c66138-2105-4f29-b1d4-6f12ae1c051d"",
// ""surroundingID"": ""surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d25"",
// ""id"": ""devicenew1"",
// ""things"": null
// },
// {
// ""environmentID"": ""environment63c66138-2105-4f29-b1d4-6f12ae1c051d"",
// ""surroundingID"": ""surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d25"",
// ""id"": ""device12w3"",
// ""things"": null
// },
// {
// ""environmentID"": ""environment63c66138-2105-4f29-b1d4-6f12ae1c051d"",
// ""surroundingID"": ""surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d25"",
// ""id"": ""device12345678"",
// ""things"": null
// },
// {
// ""environmentID"": ""-"",
// ""surroundingID"": ""surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d25"",
// ""id"": ""device123"",
// ""things"": null
// }
// ]"