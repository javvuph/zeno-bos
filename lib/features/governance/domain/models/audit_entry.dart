import 'governance_enums.dart';

class AuditEntry {
  final String id;
  final DateTime timestamp;
  final String userId;
  final String userName;
  final String roleName;
  final String companyId;
  final String branchId;
  final String module;
  final EntityType entityType;
  final String entityId;
  final String action; // CREATE, EDIT, DELETE, APPROVE, etc.
  final dynamic previousValue;
  final dynamic newValue;
  final String source; // web, mobile, desktop, system
  final String ipAddress;
  final AuditSeverity severity;
  final String result; // success, failure

  const AuditEntry({
    required this.id,
    required this.timestamp,
    required this.userId,
    required this.userName,
    required this.roleName,
    required this.companyId,
    required this.branchId,
    required this.module,
    required this.entityType,
    required this.entityId,
    required this.action,
    this.previousValue,
    this.newValue,
    required this.source,
    required this.ipAddress,
    this.severity = AuditSeverity.low,
    this.result = 'success',
  });
}
