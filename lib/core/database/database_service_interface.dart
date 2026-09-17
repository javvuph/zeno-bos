abstract class IDatabaseService {
  Future<void> init();
  Future<T> runTransaction<T>(Future<T> Function() callback);
  Future<void> createBackup(String path);
  dynamic get isar;
}
