import 'package:isar/isar.dart';

part 'sync_audit_log.g.dart';

@collection
class SyncAuditLog {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime timestamp;

  @Index()
  late String module;

  @Index()
  late String status; // 'success', 'failure', 'conflict'

  late String message;
  String? details;

  SyncAuditLog({
    required this.timestamp,
    required this.module,
    required this.status,
    required this.message,
    this.details,
  });
}
