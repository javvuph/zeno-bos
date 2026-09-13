import '../models/organization.dart';
import '../models/user_security.dart';
import '../models/settings.dart';
import '../models/communication.dart';
import '../models/system.dart';

abstract class IAdministrationRepository {
  // Organization
  Future<Company> getCompanyProfile();
  Future<void> updateCompanyProfile(Company company);
  Future<List<Branch>> getBranches();
  Future<void> saveBranch(Branch branch);

  // Users & Roles
  Future<List<User>> getUsers();
  Future<List<UserRole>> getRoles();
  Future<void> saveUser(User user);
  Future<void> saveRole(UserRole role);

  // Settings
  Future<BusinessSettings> getSettings();
  Future<void> updateSettings(BusinessSettings settings);

  // Security & Audit
  Future<List<SecurityAuditLog>> getSecurityLogs();
  Future<List<AuditLog>> getAuditLogs(String module);
  Future<List<LoginHistory>> getLoginHistory();

  // System & Health
  Future<SystemHealth> getSystemHealth();
  Future<SyncStats> getSyncStats();
  Future<void> performBackup();
  Future<void> performRestore(String path);
  Future<List<BackupManifest>> getBackupHistory();

  // Background Jobs
  Future<List<BackgroundJob>> getBackgroundJobs();

  // Webhooks
  Future<List<WebhookSubscription>> getWebhooks();
  Future<void> saveWebhook(WebhookSubscription webhook);
}
