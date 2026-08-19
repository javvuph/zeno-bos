import '../models/enterprise_user.dart';
import '../models/governance_enums.dart';
import '../models/audit_entry.dart';
import '../models/system_governance_models.dart';

class GovernanceMasterDataService {
  List<EnterpriseUser> getMockUsers() {
    return [
      EnterpriseUser(
        id: 'user_1',
        email: 'alex@zeno.com',
        displayName: 'Alex Rivera',
        status: GovernanceStatus.active,
        roleIds: ['role_admin'],
        companyIds: ['comp_1'],
        branchIds: ['br_1', 'br_2'],
        primaryBranchId: 'br_1',
        departmentId: 'dept_it',
        mfaEnabled: true,
        lastLogin: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      EnterpriseUser(
        id: 'user_2',
        email: 'maria@zeno.com',
        displayName: 'Maria Santos',
        status: GovernanceStatus.active,
        roleIds: ['role_manager'],
        companyIds: ['comp_1'],
        branchIds: ['br_2'],
        primaryBranchId: 'br_2',
        departmentId: 'dept_sales',
        lastLogin: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      EnterpriseUser(
        id: 'user_3',
        email: 'john@zeno.com',
        displayName: 'John Perera',
        status: GovernanceStatus.restricted,
        roleIds: ['role_user'],
        companyIds: ['comp_1'],
        branchIds: ['br_1'],
        primaryBranchId: 'br_1',
        departmentId: 'dept_finance',
        failedLoginAttempts: 4,
      ),
    ];
  }

  List<EnterpriseRole> getMockRoles() {
    return [
      const EnterpriseRole(
        id: 'role_admin',
        name: 'Global Administrator',
        description: 'Full access to all system modules and governance settings.',
        isSystemRole: true,
        permissions: [
          EnterprisePermission(
            id: 'p_1',
            module: 'system',
            entity: 'all',
            levels: {PermissionLevel.admin},
          ),
        ],
      ),
      const EnterpriseRole(
        id: 'role_manager',
        name: 'Branch Manager',
        description: 'Manage operations within assigned branches.',
        permissions: [
          EnterprisePermission(
            id: 'p_2',
            module: 'sales',
            entity: 'orders',
            levels: {PermissionLevel.view, PermissionLevel.create, PermissionLevel.approve},
          ),
        ],
      ),
    ];
  }

  List<AuditEntry> getMockAuditLogs() {
    return [
      AuditEntry(
        id: 'audit_1001',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        userId: 'user_1',
        userName: 'Alex Rivera',
        roleName: 'Global Administrator',
        companyId: 'comp_1',
        branchId: 'br_1',
        module: 'governance',
        entityType: EntityType.role,
        entityId: 'role_manager',
        action: 'EDIT_PERMISSION',
        previousValue: {'levels': ['view']},
        newValue: {'levels': ['view', 'approve']},
        source: 'desktop',
        ipAddress: '192.168.1.45',
        severity: AuditSeverity.medium,
      ),
      AuditEntry(
        id: 'audit_1002',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        userId: 'user_3',
        userName: 'John Perera',
        roleName: 'Standard User',
        companyId: 'comp_1',
        branchId: 'br_1',
        module: 'finance',
        entityType: EntityType.database,
        entityId: 'ledger_entries',
        action: 'EXPORT',
        source: 'web',
        ipAddress: '203.0.113.12',
        severity: AuditSeverity.high,
      ),
    ];
  }

  List<SystemHealthEntry> getMockHealth() {
    return [
      SystemHealthEntry(
        component: 'Core Database (Isar)',
        status: HealthStatus.healthy,
        message: 'All collections synchronized. 1.2GB utilized.',
        latencyMs: 12.0,
        lastChecked: DateTime.now(),
      ),
      SystemHealthEntry(
        component: 'Automation Engine',
        status: HealthStatus.degraded,
        message: 'Worker node 3 responding slowly.',
        latencyMs: 450.0,
        lastChecked: DateTime.now(),
      ),
      SystemHealthEntry(
        component: 'AI Intelligence Layer',
        status: HealthStatus.healthy,
        message: 'Gemini-1.5-Pro online.',
        lastChecked: DateTime.now(),
      ),
    ];
  }

  List<IntegrationHealth> getMockIntegrations() {
    return [
      IntegrationHealth(
        id: 'int_1',
        name: 'Stripe Payments',
        type: IntegrationType.payment,
        status: HealthStatus.healthy,
        lastSync: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
      IntegrationHealth(
        id: 'int_2',
        name: 'WhatsApp Business API',
        type: IntegrationType.messaging,
        status: HealthStatus.critical,
        lastSync: DateTime.now().subtract(const Duration(hours: 12)),
        errorCount24h: 145,
        lastErrorMessage: 'Authentication Token Expired',
      ),
    ];
  }

  List<BackupStatus> getMockBackups() {
    return [
      BackupStatus(
        id: 'bak_001',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        sizeMB: 450.5,
        status: 'success',
        location: 'AWS S3 / Global-Backup-01',
        createdBy: 'System Scheduler',
        isVerified: true,
      ),
    ];
  }

  List<UserSessionMonitor> getMockSessions() {
    return [
      UserSessionMonitor(
        id: 'sess_101',
        userId: 'user_1',
        userName: 'Alex Rivera',
        device: 'Windows Desktop / Chrome',
        ipAddress: '192.168.1.45',
        loginTime: DateTime.now().subtract(const Duration(hours: 4)),
        lastActivity: DateTime.now().subtract(const Duration(minutes: 2)),
        isMfaVerified: true,
      ),
      UserSessionMonitor(
        id: 'sess_102',
        userId: 'user_2',
        userName: 'Maria Santos',
        device: 'MacBook Pro / Safari',
        ipAddress: '110.23.45.67',
        loginTime: DateTime.now().subtract(const Duration(hours: 1)),
        lastActivity: DateTime.now().subtract(const Duration(seconds: 30)),
      ),
    ];
  }
}
