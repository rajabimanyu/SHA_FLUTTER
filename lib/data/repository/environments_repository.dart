import 'dart:async';
import 'package:sha/models/environment.dart';
import 'package:sha/models/surrounding.dart';

abstract class EnvironmentsRepository {
  Future<List<Surrounding>> fetchHomeSurroundings();
  Future<List<Environment>> fetchEnvironments();
}