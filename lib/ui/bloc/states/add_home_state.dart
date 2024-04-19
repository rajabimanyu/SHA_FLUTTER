import 'package:sha/models/environment.dart';

sealed class AddHomeState {
  const AddHomeState();
}

final class InitialState extends AddHomeState {
  const InitialState();
}

class FetchEnvState extends AddHomeState {
  final List<Environment> environments;
  final String errMessage;
  const FetchEnvState({this.environments = const [], this.errMessage = ''});
}

class CreateHomeState extends AddHomeState {
  final Environment environment;
  const CreateHomeState({required this.environment});
}

class AddHomeFailureState extends AddHomeState {
  final String errMessage;
  const AddHomeFailureState({required this.errMessage});
}

class SwitchHomeState extends AddHomeState {
  final bool isSwitched;
  const SwitchHomeState({required this.isSwitched});
}