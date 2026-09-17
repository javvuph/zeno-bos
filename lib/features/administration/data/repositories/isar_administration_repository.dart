import 'dart:convert';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/admin_collections.dart';
import '../../domain/repositories/i_administration_repository.dart';
import '../../domain/models/organization.dart';
import '../../domain/models/user_security.dart';
import '../../domain/models/settings.dart';
import '../../domain/models/communication.dart';
import '../../domain/models/system.dart';
import 'package:isar/isar.dart';

part 'parts/isar_administration_repository_org_security.part.dart';
part 'parts/isar_administration_repository_logs_sync.part.dart';

class IsarAdministrationRepository implements IAdministrationRepository {
  final DatabaseService db;
  IsarAdministrationRepository(this.db);

  IsarCollection<CompanyCollection> get compCol =>
      db.isar.collection<CompanyCollection>();
  IsarCollection<UserCollection> get userCol =>
      db.isar.collection<UserCollection>();
  IsarCollection<BranchCollection> get branchCol =>
      db.isar.collection<BranchCollection>();
  IsarCollection<RoleCollection> get roleCol =>
      db.isar.collection<RoleCollection>();
  IsarCollection<AuditLogCollection> get auditCol =>
      db.isar.collection<AuditLogCollection>();
  IsarCollection<SecurityLogCollection> get securityCol =>
      db.isar.collection<SecurityLogCollection>();
  IsarCollection<BusinessSettingsCollection> get settingsCol =>
      db.isar.collection<BusinessSettingsCollection>();

  @override
  Future<Company> getCompanyProfile() => getCompanyProfileImpl();

  @override
  Future<void> updateCompanyProfile(Company company) => updateCompanyProfileImpl(company);

  @override
  Future<List<Branch>> getBranches() => getBranchesImpl();

  @override
  Future<void> saveBranch(Branch branch) => saveBranchImpl(branch);

  @override
  Future<List<User>> getUsers() => getUsersImpl();

  @override
  Future<List<UserRole>> getRoles() => getRolesImpl();

  @override
  Future<BusinessSettings> getSettings() => getSettingsImpl();

  @override
  Future<void> updateSettings(BusinessSettings settings) => updateSettingsImpl(settings);

  @override
  Future<SystemHealth> getSystemHealth() => getSystemHealthImpl();

  @override
  Future<void> saveUser(User user) => saveUserImpl(user);

  @override
  Future<void> saveRole(UserRole role) => saveRoleImpl(role);

  @override
  Future<List<SecurityAuditLog>> getSecurityLogs() => getSecurityLogsImpl();

  @override
  Future<List<AuditLog>> getAuditLogs(String module) => getAuditLogsImpl(module);

  @override
  Future<List<LoginHistory>> getLoginHistory() => getLoginHistoryImpl();

  @override
  Future<SyncStats> getSyncStats() => getSyncStatsImpl();

  @override
  Future<void> performBackup() => performBackupImpl();

  @override
  Future<void> performRestore(String path) => performRestoreImpl(path);

  @override
  Future<List<BackupManifest>> getBackupHistory() => getBackupHistoryImpl();

  @override
  Future<List<BackgroundJob>> getBackgroundJobs() => getBackgroundJobsImpl();

  @override
  Future<List<WebhookSubscription>> getWebhooks() => getWebhooksImpl();

  @override
  Future<void> saveWebhook(WebhookSubscription webhook) => saveWebhookImpl(webhook);
}
