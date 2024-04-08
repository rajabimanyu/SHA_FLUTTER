import 'package:sha/data/network/service/models/Device.dart';

class CreateDevice {
  final bool success;
  final int status;
  final Device device;

  CreateDevice({
    required this.success,
    required this.device,
    required this.status
  });

  factory CreateDevice.fromJson(Map<String, dynamic> parsedJson) {
    final bool success = parsedJson['success'];
    final int status = parsedJson['deviceStatus'];
    final Device device = Device.fromJson(parsedJson['data']);

    return CreateDevice(success: success, device: device, status: status);
  }
}