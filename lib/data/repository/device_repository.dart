import 'package:sha/core/model/ui_state.dart';
import 'package:sha/data/repository/data_response.dart';
import 'package:sha/data/repository/models/create_device_response.dart';
import 'package:sha/models/surrounding.dart';

abstract class DeviceRepository {
  Future<DataResponse<CreateDeviceResponse, DataError>> createDevice(String deviceID, String environmentID, String surroundingID);
  Future<Surrounding?> createSurrounding(String surroundingName, String environmentId);
}