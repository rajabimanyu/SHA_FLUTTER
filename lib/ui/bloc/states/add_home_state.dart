import 'package:sha/models/environment.dart';

sealed class AddHomeState {
  const AddHomeState();
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