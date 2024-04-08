sealed class AddHomeEvent {
  const AddHomeEvent();
}

final class FetchHomeEvent extends AddHomeEvent {
  const FetchHomeEvent();
}

final class CreateHomeEvent extends AddHomeEvent {
  final String envName;
  const CreateHomeEvent({required this.envName});
}