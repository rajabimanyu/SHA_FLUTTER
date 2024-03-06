sealed class CreateEvent {
  const CreateEvent();
}

final class InitNewDeviceEvent extends CreateEvent {
  const InitNewDeviceEvent();
}

final class CreateDeviceEvent extends CreateEvent {
  final String surroundingId;
  final String deviceId;
  const CreateDeviceEvent(this.surroundingId, this.deviceId);
}

final class CreateSurroundingWithDeviceEvent extends CreateEvent {
  final String deviceId;
  final String surroundingName;
  const CreateSurroundingWithDeviceEvent(this.deviceId, this.surroundingName);
}