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
  final bool isSuccessful;
  const CreateDeviceState(this.isSuccessful);
}