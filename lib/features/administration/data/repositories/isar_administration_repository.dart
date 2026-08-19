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
  Future<Company> getCompanyProfile() async {
    final c = await compCol.where().findFirst();
    if (c != null) {
      return Company(
        id: c.uuid,
        name: c.name,
        taxId: c.taxId,
        gst: c.gst,
        pan: c.pan,
        address: c.address,
        currency: c.currency,
        timezone: c.timezone,
        isDefault: c.isDefault,
      );
    }
    return const Company(id: 'default', name: 'ZENO Corp', taxId: 'TX-000');
  }

  @override
  Future<void> updateCompanyProfile(Company company) async {
    final existing = await compCol.filter().uuidEqualTo(company.id).findFirst();
    final entry = (existing ?? CompanyCollection())
      ..uuid = company.id
      ..name = company.name
      ..taxId = company.taxId
      ..gst = company.gst
      ..pan = company.pan
      ..address = company.address
      ..currency = company.currency
      ..timezone = company.timezone
      ..isDefault = company.isDefault;

    await db.isar.writeTxn(() async => await compCol.put(entry));
  }

  @override
  Future<List<Branch>> getBranches() async {
    final results = await branchCol.where().findAll();
    return results
        .map((e) => Branch(
              id: e.uuid,
              companyId: e.companyId,
              name: e.name,
              code: e.code,
              address: e.address,
              phone: e.phone,
              isActive: e.isActive,
            ))
        .toList();
  }

  @override
  Future<void> saveBranch(Branch branch) async {
    final existing =
        await branchCol.filter().uuidEqualTo(branch.id).findFirst();
    final entry = (existing ?? BranchCollection())
      ..uuid = branch.id
      ..companyId = branch.companyId
      ..name = branch.name
      ..code = branch.code
      ..address = branch.address
      ..phone = branch.phone
      ..isActive = branch.isActive;

    await db.isar.writeTxn(() async => await branchCol.put(entry));
  }

  @override
  Future<List<User>> getUsers() async {
    final results = await userCol.where().findAll();
    return results
        .map((e) => User(
              id: e.uuid,
              email: e.email,
              displayName: e.displayName,
              status: UserStatus.values.firstWhere((s) => s.name == e.status,
                  orElse: () => UserStatus.active),
              roleIds: e.roleIds ?? [],
              branchPermissions: e.branchPermissions ?? [],
            ))
        .toList();
  }

  @override
  Future<List<UserRole>> getRoles() async {
    final results = await roleCol.where().findAll();
    return results.map((e) {
      final List<dynamic> matrix = jsonDecode(e.permissionMatrixJson);
      return UserRole(
        id: e.uuid,
        name: e.name,
        description: e.description,
        isSystemRole: e.isSystemRole,
        permissionMatrix: matrix
            .map((p) => Permission(
                  id: p['id'],
                  module: p['module'],
                  screen: p['screen'],
                  canView: p['canView'] ?? false,
                  canCreate: p['canCreate'] ?? false,
                  canEdit: p['canEdit'] ?? false,
                  canDelete: p['canDelete'] ?? false,
                  canApprove: p['canApprove'] ?? false,
                ))
            .toList(),
      );
    }).toList();
  }

  @override
  Future<BusinessSettings> getSettings() async {
    final s = await settingsCol.where().findFirst();
    if (s == null) return BusinessSettings();

    final security = jsonDecode(s.securityPolicyJson);
    final license = jsonDecode(s.licenseInfoJson);
    final flags = jsonDecode(s.featureFlagsJson) as List;

    return BusinessSettings(
      currencyCode: s.currencyCode,
      languageCode: s.languageCode,
      timeZone: s.timeZone,
      environment: s.environment,
      maintenanceMode: s.maintenanceMode,
      taxDefaults: TaxDefaults(
        salesTaxRate: s.defaultSalesTax,
        purchaseTaxRate: s.defaultPurchaseTax,
      ),
      numberSeries: Map<String, String>.from(jsonDecode(s.numberSeriesJson)),
      securityPolicy: SecurityPolicy(
        minPasswordLength: security['minLength'],
        requireSpecialChars: security['requireSpecial'],
        sessionTimeoutMinutes: security['timeout'],
        enable2FA: security['enable2FA'],
        maxFailedLogins: security['maxFailed'],
      ),
      license: LicenseInfo(
        plan: license['plan'],
        expiry: DateTime.parse(license['expiry']),
        userLimit: license['limit'],
        activeUsers: license['active'],
      ),
      featureFlags: flags
          .map((f) => FeatureFlag(
              id: f['id'], name: f['name'], isEnabled: f['enabled']))
          .toList(),
    );
  }

  @override
  Future<void> updateSettings(BusinessSettings settings) async {
    final existing = await settingsCol.where().findFirst();
    final entry = (existing ?? BusinessSettingsCollection())
      ..currencyCode = settings.currencyCode
      ..languageCode = settings.languageCode
      ..timeZone = settings.timeZone
      ..environment = settings.environment
      ..maintenanceMode = settings.maintenanceMode
      ..defaultSalesTax = settings.taxDefaults.salesTaxRate
      ..defaultPurchaseTax = settings.taxDefaults.purchaseTaxRate
      ..numberSeriesJson = jsonEncode(settings.numberSeries)
      ..securityPolicyJson = jsonEncode({
        'minLength': settings.securityPolicy.minPasswordLength,
        'requireSpecial': settings.securityPolicy.requireSpecialChars,
        'timeout': settings.securityPolicy.sessionTimeoutMinutes,
        'enable2FA': settings.securityPolicy.enable2FA,
        'maxFailed': settings.securityPolicy.maxFailedLogins,
      })
      ..licenseInfoJson = jsonEncode({
        'plan': settings.license.plan,
        'expiry': settings.license.expiry.toIso8601String(),
        'limit': settings.license.userLimit,
        'active': settings.license.activeUsers,
      })
      ..featureFlagsJson = jsonEncode(settings.featureFlags
          .map((f) => {
                'id': f.id,
                'name': f.name,
                'enabled': f.isEnabled,
              })
          .toList());

    await db.isar.writeTxn(() async => await settingsCol.put(entry));
  }

  @override
  Future<SystemHealth> getSystemHealth() async => const SystemHealth(
        apiStatus: "Healthy",
        cpuUsage: 14.2,
        memoryUsage: 45.8,
        databaseSize: 22.4,
        uptime: "128h 45m",
      );

  @override
  Future<void> saveUser(User user) async {
    final existing = await userCol.filter().uuidEqualTo(user.id).findFirst();
    final u = (existing ?? UserCollection())
      ..uuid = user.id
      ..email = user.email
      ..displayName = user.displayName
      ..status = user.status.name
      ..roleIds = user.roleIds
      ..branchPermissions = user.branchPermissions;

    await db.isar.writeTxn(() async {
      await userCol.put(u);
    });
  }

  @override
  Future<void> saveRole(UserRole role) async {
    final existing = await roleCol.filter().uuidEqualTo(role.id).findFirst();
    final r = (existing ?? RoleCollection())
      ..uuid = role.id
      ..name = role.name
      ..description = role.description
      ..isSystemRole = role.isSystemRole
      ..permissionMatrixJson = jsonEncode(role.permissionMatrix
          .map((p) => {
                'id': p.id,
                'module': p.module,
                'screen': p.screen,
                'canView': p.canView,
                'canCreate': p.canCreate,
                'canEdit': p.canEdit,
                'canDelete': p.canDelete,
                'canApprove': p.canApprove,
              })
          .toList());

    await db.isar.writeTxn(() async {
      await roleCol.put(r);
    });
  }

  @override
  Future<List<SecurityAuditLog>> getSecurityLogs() async {
    final results = await securityCol.where().findAll();
    final sorted = results..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted
        .map((e) => SecurityAuditLog(
              id: e.uuid,
              timestamp: e.timestamp,
              eventType: e.eventType,
              userId: e.userId,
              details: '',
              ipAddress: e.ipAddress,
              deviceId: '',
            ))
        .toList();
  }

  @override
  Future<List<AuditLog>> getAuditLogs(String module) async {
    final results = module == 'all'
        ? await auditCol.where().findAll()
        : await auditCol.where().filter().moduleEqualTo(module).findAll();

    final sorted = results..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return sorted
        .map((e) => AuditLog(
              id: e.uuid,
              timestamp: e.timestamp,
              module: e.module,
              action: e.action,
              userId: e.userId,
              details: e.details,
            ))
        .toList();
  }

  @override
  Future<List<LoginHistory>> getLoginHistory() async => [];

  @override
  Future<SyncStats> getSyncStats() async =>
      SyncStats(lastSyncTime: DateTime.now());

  @override
  Future<void> performBackup() async =>
      await Future.delayed(const Duration(seconds: 1));

  @override
  Future<void> performRestore(String path) async {}

  @override
  Future<List<BackupManifest>> getBackupHistory() async => [];

  @override
  Future<List<BackgroundJob>> getBackgroundJobs() async => [];

  @override
  Future<List<WebhookSubscription>> getWebhooks() async => [];

  @override
  Future<void> saveWebhook(WebhookSubscription webhook) async {}
}
