import 'package:isar/isar.dart';

part 'sync_conflict.g.dart';

enum ConflictResolutionStrategy { lastWriteWins, manual, serverWins }

@collection
class SyncConflict {
  Id id = Isar.autoIncrement;

  @Index()
  late String collectionName;

  @Index()
  late String entityUuid;

  late String localPayload;
  late String remotePayload;

  @Index()
  late DateTime conflictAt;

  bool isResolved = false;
  String? resolvedByUserId;
  DateTime? resolvedAt;

  @enumerated
  ConflictResolutionStrategy resolutionStrategy =
      ConflictResolutionStrategy.manual;
}
