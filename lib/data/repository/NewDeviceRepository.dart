abstract class NewDeviceRepository {
  void createEnvironment(String envName);
  void createSurrounding(String surroundingName, String environmentId);
  void createDevice(String deviceID, String environmentID, String surroundingID);
}