class IsarMigrationManager {
  static const int currentVersion = 1;

  Future<void> handleMigrations(int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Migration logic for future versions
    }
  }
}
