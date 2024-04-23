class DeleteEnvironment {
  final bool success;

  DeleteEnvironment({
    required this.success
  });

  factory DeleteEnvironment.fromJson(Map<String, dynamic> parsedJson) {
    return DeleteEnvironment(success: parsedJson['success']);
  }
}