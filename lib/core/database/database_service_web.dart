import 'package:shared_preferences/shared_preferences.dart';
import 'database_service_interface.dart';

class DatabaseService implements IDatabaseService {
  late SharedPreferences _prefs;

  @override
  dynamic get isar => null; // Isar is not supported on Web

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<T> runTransaction<T>(Future<T> Function() callback) async {
    // Web fallback transaction execution
    return await callback();
  }

  @override
  Future<void> createBackup(String path) async {
    // Backup is not supported in the web storage fallback
  }

  // Helper for web fallback storage if needed
  Shprefs get prefs => _prefs;
}

typedef Shprefs = SharedPreferences;
