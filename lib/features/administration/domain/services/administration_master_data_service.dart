import '../models/organization.dart';
import '../models/user_security.dart';
import '../models/settings.dart';
import '../models/system.dart';

class AdministrationMasterDataService {
  Company getMockCompany() => const Company(
        id: 'zeno_corp',
        name: 'ZENO Global Industries',
        taxId: 'TX-9900221',
        gst: '27AAAAA0000A1Z5',
        pan: 'AAAAA0000A',
        address: '123 Enterprise Way, Silicon Valley, CA',
        website: 'https://zeno.io',
        currency: 'USD',
        timezone: 'PST',
        isDefault: true,
      );

  List<Branch> getMockBranches() => [
        const Branch(
            id: 'br_1',
            companyId: 'zeno_corp',
            name: 'Main HQ',
            code: 'HQ-01',
            address: 'San Francisco',
            phone: '1-800-ZENO'),
        const Branch(
            id: 'br_2',
            companyId: 'zeno_corp',
            name: 'East Coast Hub',
            code: 'NY-05',
            address: 'New York',
            phone: '1-800-ZENO-NY'),
      ];

  List<User> getMockUsers() => [
        const User(
            id: 'usr_1',
            email: 'alex@zeno.io',
            displayName: 'Alex Rivera',
            status: UserStatus.active,
            roleIds: ['admin'],
            branchPermissions: ['br_1', 'br_2']),
        const User(
            id: 'usr_2',
            email: 'maria@zeno.io',
            displayName: 'Maria Santos',
            status: UserStatus.active,
            roleIds: ['manager'],
            branchPermissions: ['br_1']),
      ];

  List<UserRole> getMockRoles() => [
        const UserRole(
          id: 'admin',
          name: 'Global Administrator',
          description: 'Full system access',
          isSystemRole: true,
          permissionMatrix: [
            Permission(
                id: 'p1',
                module: 'all',
                screen: 'all',
                canView: true,
                canCreate: true,
                canEdit: true,
                canDelete: true,
                canApprove: true),
          ],
        ),
        const UserRole(
          id: 'manager',
          name: 'Operations Manager',
          description: 'Module specific management',
          permissionMatrix: [
            Permission(
                id: 'p2',
                module: 'billing',
                screen: 'all',
                canView: true,
                canCreate: true,
                canEdit: true),
            Permission(
                id: 'p3',
                module: 'inventory',
                screen: 'all',
                canView: true,
                canCreate: true),
          ],
        ),
      ];

  BusinessSettings getMockSettings() => BusinessSettings(
        currencyCode: 'USD',
        languageCode: 'en_US',
        timeZone: 'EST',
        taxDefaults: const TaxDefaults(
            salesTaxRate: 8.5, purchaseTaxRate: 5.0, defaultTaxCode: 'GST-18'),
        numberSeries: const {'INV': 'INV-', 'PO': 'PO-', 'GRN': 'GRN-'},
      );

  SystemHealth getMockHealth() => const SystemHealth(
        cpuUsage: 14.5,
        memoryUsage: 42.8,
        databaseSize: 156.4,
        storageUsage: 890.0,
        apiStatus: 'online',
        aiStatus: 'online',
        syncStatus: 'stable',
        activeUsers: 34,
        connectedBranches: 12,
        uptime: '428h 12m',
      );

  SyncStats getMockSyncStats() => SyncStats(
        lastSyncTime: DateTime.now().subtract(const Duration(minutes: 5)),
        pendingQueue: 0,
        conflictsResolved: 12,
        replicationHealth: 0.99,
      );

  List<AuditLog> getMockAuditLogs() => [
        AuditLog(
            id: 'a1',
            userId: 'usr_1',
            action: 'CREATE',
            module: 'BILLING',
            timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
            details: 'Created Invoice INV-2026-001'),
        AuditLog(
            id: 'a2',
            userId: 'usr_2',
            action: 'UPDATE',
            module: 'INVENTORY',
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
            details: 'Adjusted stock for SKU-992'),
      ];

  List<BackgroundJob> getMockJobs() => [
        BackgroundJob(
            id: 'j1',
            name: 'Database Maintenance',
            status: 'running',
            startTime: DateTime.now().subtract(const Duration(minutes: 20)),
            progress: 0.65),
        BackgroundJob(
            id: 'j2',
            name: 'Cloud Sync',
            status: 'queued',
            startTime: DateTime.now()),
      ];

  DiagnosticReport getMockDiagnostic() => DiagnosticReport(
        id: 'd1',
        timestamp: DateTime.now(),
        componentStatus: {
          'Database': 'Healthy',
          'Sync': 'Stable',
          'AI': 'Online'
        },
        criticalIssues: [],
        recommendation: 'All systems operational.',
      );
}
