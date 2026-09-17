import '../models/enterprise_user.dart';
import '../models/audit_entry.dart';
import '../models/system_governance_models.dart';

class GovernanceMasterDataService {
  List<EnterpriseUser> getMockUsers() => [];

  List<EnterpriseRole> getMockRoles() => [];

  List<AuditEntry> getMockAuditLogs() => [];

  List<SystemHealthEntry> getMockHealth() => [];

  List<IntegrationHealth> getMockIntegrations() => [];

  List<BackupStatus> getMockBackups() => [];

  List<UserSessionMonitor> getMockSessions() => [];
}
