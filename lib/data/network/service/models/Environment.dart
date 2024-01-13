class Environment {
  final String id;
  final String name;

  Environment({
    required this.id,
    required this.name,
  });

  factory Environment.fromJson(Map<String, dynamic> parsedJson) {
    return Environment(id: parsedJson['id'], name: parsedJson['name']);
  }
}