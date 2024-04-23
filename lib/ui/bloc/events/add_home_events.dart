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

final class SwitchHomeEvent extends AddHomeEvent {
  final String envId;
  const SwitchHomeEvent({required this.envId});
}

final class DeleteHomeEvent extends AddHomeEvent {
  final String envId;
  const DeleteHomeEvent({required this.envId});
}