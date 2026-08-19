import 'package:isar/isar.dart';

part 'sync_action.g.dart';

enum SyncOperation { create, update, delete }

@collection
class SyncAction {
  Id id = Isar.autoIncrement;

  @Index()
  late String collectionName;

  @Index()
  late String entityUuid;

  @enumerated
  late SyncOperation operation;

  late String payload; // JSON representation

  @Index()
  late DateTime createdAt;

  @Index()
  int retryCount = 0;

  @Index()
  bool isFailed = false;

  @Index()
  String? idempotencyKey;

  String? lastError;
}
