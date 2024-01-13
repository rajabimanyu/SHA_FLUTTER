import 'package:sha/models/device.dart';

class Surrounding {
  final String id;
  final String name;

  Surrounding({
    required this.id,
    required this.name,
  });

  factory Surrounding.fromJson(Map<String, dynamic> parsedJson) {
    return Surrounding(id: parsedJson['id'], name: parsedJson['name']);
  }
}