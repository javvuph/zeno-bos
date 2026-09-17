import '../models/organization.dart';
import '../models/user_security.dart';
import '../models/settings.dart';
import '../models/system.dart';

class AdministrationMasterDataService {
  Company getMockCompany() => const Company(
        id: '',
        name: '',
        taxId: '',
        gst: '',
        pan: '',
        address: '',
        website: '',
        currency: 'USD',
        timezone: 'UTC',
        isDefault: true,
      );

  List<Branch> getMockBranches() => [];

  List<User> getMockUsers() => [];

  List<UserRole> getMockRoles() => [];

  BusinessSettings getMockSettings() => BusinessSettings(
        currencyCode: 'USD',
        languageCode: 'en_US',
        timeZone: 'UTC',
        taxDefaults: const TaxDefaults(
            salesTaxRate: 0.0, purchaseTaxRate: 0.0, defaultTaxCode: ''),
        numberSeries: const {},
      );

  SystemHealth getMockHealth() => const SystemHealth(
        cpuUsage: 0.0,
        memoryUsage: 0.0,
        databaseSize: 0.0,
        storageUsage: 0.0,
        apiStatus: 'offline',
        aiStatus: 'offline',
        syncStatus: 'idle',
        activeUsers: 0,
        connectedBranches: 0,
        uptime: '0h 0m',
      );

  SyncStats getMockSyncStats() => SyncStats(
        lastSyncTime: DateTime.now(),
        pendingQueue: 0,
        conflictsResolved: 0,
        replicationHealth: 1.0,
      );

  List<AuditLog> getMockAuditLogs() => [];

  List<BackgroundJob> getMockJobs() => [];

  DiagnosticReport getMockDiagnostic() => DiagnosticReport(
        id: '',
        timestamp: DateTime.now(),
        componentStatus: {},
        criticalIssues: [],
        recommendation: '',
      );
}
