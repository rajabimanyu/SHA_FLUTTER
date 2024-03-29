class Thing {
  final String environmentId;
  final String id;
  final String deviceId;
  final String thingType;
  final String status;
  final String totalStep;
  final String currentStep;
  final String lastUpdatedTime;
  
  Thing({
    required this.environmentId,
    required this.id,
    required this.deviceId,
    required this.thingType,
    required this.status,
    required this.totalStep,
    required this.currentStep,
    required this.lastUpdatedTime
  });
  
  factory Thing.fromJson(Map<String, dynamic> parsedJson) {
    return Thing(environmentId: parsedJson['environmentID'], id: parsedJson['id'], deviceId: parsedJson['deviceID'], thingType: parsedJson['thingType'],
        status: parsedJson['status'], totalStep: parsedJson['totalStep'].toString(), currentStep: parsedJson['currentStep'].toString(), lastUpdatedTime: parsedJson['lastUpdatedTime'].toString());
  }
}