import '../models/enterprise_user.dart';
import '../models/audit_entry.dart';
import '../models/system_governance_models.dart';

abstract class IGovernanceRepository {
  Future<List<EnterpriseUser>> getUsers();
  Future<List<EnterpriseRole>> getRoles();
  Future<List<AuditEntry>> getAuditLogs({String? userId, String? module});
  Future<List<SystemHealthEntry>> getSystemHealth();
  Future<List<IntegrationHealth>> getIntegrationHealth();
  Future<List<BackupStatus>> getBackupHistory();
  Future<List<UserSessionMonitor>> getActiveSessions();
  
  Future<void> revokeSession(String sessionId);
  Future<void> triggerBackup();
  Future<void> saveUser(EnterpriseUser user);
  Future<void> saveRole(EnterpriseRole role);
}
