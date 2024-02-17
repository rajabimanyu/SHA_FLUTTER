import 'package:sha/models/surrounding.dart';

abstract class DeviceRepository {
  Future<bool> createDevice(String deviceID, String environmentID, String surroundingID);
  Future<Surrounding?> createSurrounding(String surroundingName, String environmentId);
}