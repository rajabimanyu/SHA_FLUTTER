import 'package:sha/models/surrounding.dart';

sealed class CreateState {
  const CreateState();
}

final class InitialState extends CreateState {
  const InitialState();
}

final class InitCreateDeviceState extends CreateState {
  final List<Surrounding> surroundings;
  const InitCreateDeviceState(this.surroundings);
}

final class CreateDeviceState extends CreateState {
  final int status;
  const CreateDeviceState(this.status);
}

final class CreateDeviceFailureState extends CreateState {
  final String errorMessage;
  const CreateDeviceFailureState(this.errorMessage);
}