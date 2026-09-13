import 'i_governance_repository.dart';
import '../models/enterprise_user.dart';
import '../models/audit_entry.dart';
import '../models/system_governance_models.dart';
import '../services/governance_master_data_service.dart';

class GovernanceRepositoryImpl implements IGovernanceRepository {
  final _masterData = GovernanceMasterDataService();

  @override
  Future<List<EnterpriseUser>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _masterData.getMockUsers();
  }

  @override
  Future<List<EnterpriseRole>> getRoles() async {
    return _masterData.getMockRoles();
  }

  @override
  Future<List<AuditEntry>> getAuditLogs({String? userId, String? module}) async {
    var logs = _masterData.getMockAuditLogs();
    if (userId != null) logs = logs.where((l) => l.userId == userId).toList();
    if (module != null) logs = logs.where((l) => l.module == module).toList();
    return logs;
  }

  @override
  Future<List<SystemHealthEntry>> getSystemHealth() async {
    return _masterData.getMockHealth();
  }

  @override
  Future<List<IntegrationHealth>> getIntegrationHealth() async {
    return _masterData.getMockIntegrations();
  }

  @override
  Future<List<BackupStatus>> getBackupHistory() async {
    return _masterData.getMockBackups();
  }

  @override
  Future<List<UserSessionMonitor>> getActiveSessions() async {
    return _masterData.getMockSessions();
  }

  @override
  Future<void> revokeSession(String sessionId) async {
    return;
  }

  @override
  Future<void> triggerBackup() async {
    return;
  }

  @override
  Future<void> saveUser(EnterpriseUser user) async {
    return;
  }

  @override
  Future<void> saveRole(EnterpriseRole role) async {
    return;
  }
}
