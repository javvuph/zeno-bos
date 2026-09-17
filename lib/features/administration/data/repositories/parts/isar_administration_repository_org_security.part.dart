part of '../isar_administration_repository.dart';

extension IsarAdministrationRepositoryOrgSecurityPart on IsarAdministrationRepository {
  Future<Company> getCompanyProfileImpl() async {
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

  Future<void> updateCompanyProfileImpl(Company company) async {
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

  Future<List<Branch>> getBranchesImpl() async {
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

  Future<void> saveBranchImpl(Branch branch) async {
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

  Future<List<User>> getUsersImpl() async {
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

  Future<List<UserRole>> getRolesImpl() async {
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

  Future<BusinessSettings> getSettingsImpl() async {
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

  Future<void> updateSettingsImpl(BusinessSettings settings) async {
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

  Future<SystemHealth> getSystemHealthImpl() async => const SystemHealth(
        apiStatus: "Healthy",
        cpuUsage: 14.2,
        memoryUsage: 45.8,
        databaseSize: 22.4,
        uptime: "128h 45m",
      );

  Future<void> saveUserImpl(User user) async {
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

  Future<void> saveRoleImpl(UserRole role) async {
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
}
