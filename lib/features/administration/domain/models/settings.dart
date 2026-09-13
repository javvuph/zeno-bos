class BusinessSettings {
  final String currencyCode;
  final String languageCode;
  final String timeZone;
  final String dateFormat;
  final String environment; // 'dev', 'test', 'prod'
  final bool maintenanceMode;
  final TaxDefaults taxDefaults;
  final Map<String, String> numberSeries;
  final SecurityPolicy securityPolicy;
  final LicenseInfo license;
  final List<FeatureFlag> featureFlags;

  BusinessSettings({
    this.currencyCode = 'USD',
    this.languageCode = 'en',
    this.timeZone = 'UTC',
    this.dateFormat = 'dd/MM/yyyy',
    this.environment = 'prod',
    this.maintenanceMode = false,
    this.taxDefaults = const TaxDefaults(),
    this.numberSeries = const {},
    this.securityPolicy = const SecurityPolicy(),
    LicenseInfo? license,
    this.featureFlags = const [],
  }) : license = license ?? LicenseInfo();
}

class LicenseInfo {
  final String plan;
  final DateTime expiry;
  final int userLimit;
  final int activeUsers;
  final bool isSupportActive;

  LicenseInfo({
    this.plan = 'ENTERPRISE',
    DateTime? expiry,
    this.userLimit = 100,
    this.activeUsers = 1,
    this.isSupportActive = true,
  }) : expiry = expiry ?? DateTime(2027, 12, 31);
}

class FeatureFlag {
  final String id;
  final String name;
  final bool isEnabled;

  const FeatureFlag(
      {required this.id, required this.name, required this.isEnabled});
}

class TaxDefaults {
  final double salesTaxRate;
  final double purchaseTaxRate;
  final bool isTaxInclusive;
  final String defaultTaxCode;

  const TaxDefaults({
    this.salesTaxRate = 0.0,
    this.purchaseTaxRate = 0.0,
    this.isTaxInclusive = false,
    this.defaultTaxCode = 'GST-0',
  });
}

class SecurityPolicy {
  final int minPasswordLength;
  final bool requireSpecialChars;
  final int sessionTimeoutMinutes;
  final bool enable2FA;
  final int maxFailedLogins;

  const SecurityPolicy({
    this.minPasswordLength = 8,
    this.requireSpecialChars = true,
    this.sessionTimeoutMinutes = 60,
    this.enable2FA = false,
    this.maxFailedLogins = 5,
  });
}
