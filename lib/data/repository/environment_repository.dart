abstract class EnvironmentRepository {
  Future<bool> switchEnvironment(String envId);
  Future<bool> deleteEnvironment(String envId, bool isCurrentEnvironment);
}