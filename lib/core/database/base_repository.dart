import 'database_service.dart';
import 'package:isar/isar.dart';
import '../services/global_context_manager.dart';
import '../di/service_locator.dart';

abstract class BaseRepository<T> {
  final DatabaseService db;
  final GlobalContextManager contextManager = sl<GlobalContextManager>();

  BaseRepository(this.db);

  IsarCollection<T> get collection => db.isar.collection<T>();

  /// Basic Pagination & Filtering Placeholder
  Future<List<T>> getPaged({int offset = 0, int limit = 50}) async {
    return await collection.where().offset(offset).limit(limit).findAll();
  }

  Future<T?> getById(Id id) async {
    return await collection.get(id);
  }

  /// Transactional Batch Insert
  Future<void> bulkSave(List<T> items) async {
    await db.isar.writeTxn(() async {
      await collection.putAll(items);
    });
  }

  Future<void> save(T item) async {
    await db.isar.writeTxn(() async {
      await collection.put(item);
    });
  }

  Future<void> delete(Id id) async {
    await db.isar.writeTxn(() async {
      await collection.delete(id);
    });
  }
}
