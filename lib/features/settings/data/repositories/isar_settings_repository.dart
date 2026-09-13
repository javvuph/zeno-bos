import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/admin_collections.dart';
import '../../domain/models/app_settings.dart';
import '../../domain/repositories/i_settings_repository.dart';

class IsarSettingsRepository implements ISettingsRepository {
  final DatabaseService db;
  IsarSettingsRepository(this.db);

  IsarCollection<BusinessSettingsCollection> get settingsCol =>
      db.isar.businessSettingsCollections;

  @override
  Future<AppSettings> getSettings() async {
    final record = await settingsCol.where().findFirst();
    if (record == null) return const AppSettings();

    try {
      // Attempt to load full settings from the JSON field
      if (record.numberSeriesJson.startsWith('{') &&
          record.numberSeriesJson.endsWith('}')) {
        // This is a hack to store everything in one field since we can't run build_runner
        final Map<String, dynamic> data = jsonDecode(record.numberSeriesJson);
        return _fromMap(data);
      }
    } catch (e) {
      // Fallback to basic fields if JSON is invalid or old format
    }

    return AppSettings(
      general: GeneralSettings(
        currency: record.currencyCode,
        language: record.languageCode,
        timezone: record.timeZone,
      ),
    );
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    final existing = await settingsCol.where().findFirst();
    final entry = (existing ?? BusinessSettingsCollection())
      ..currencyCode = settings.general.currency
      ..languageCode = settings.general.language
      ..timeZone = settings.general.timezone
      ..defaultSalesTax = settings.modules.billing['defaultSalesTax'] ?? 0.0
      ..defaultPurchaseTax =
          settings.modules.billing['defaultPurchaseTax'] ?? 0.0
      ..numberSeriesJson = jsonEncode(_toMap(settings));

    await db.isar.writeTxn(() async {
      await settingsCol.put(entry);
    });
  }

  @override
  Future<void> resetSettings() async {
    await db.isar.writeTxn(() async {
      await settingsCol.clear();
    });
  }

  Map<String, dynamic> _toMap(AppSettings s) {
    return {
      'language': s.general.language,
      'currency': s.general.currency,
      'timezone': s.general.timezone,
      'themeMode': s.general.themeMode.index,
      'dateFormat': s.general.dateFormat,
      'modules': s.modules.billing, // Simplified for brevity in this mock-up
      'communication': {
        'email': {
          'server': s.communication.email.smtpServer,
          'port': s.communication.email.port
        },
        'notifications': {'push': s.communication.notifications.enablePush},
      },
      'security': {'enable2FA': s.security.enable2FA},
    };
  }

  AppSettings _fromMap(Map<String, dynamic> map) {
    return AppSettings(
      general: GeneralSettings(
        language: map['language'] ?? 'en_US',
        currency: map['currency'] ?? 'USD',
        timezone: map['timezone'] ?? 'UTC',
        themeMode: ThemeMode.values[map['themeMode'] ?? 0],
        dateFormat: map['dateFormat'] ?? 'dd/MM/yyyy',
      ),
      security: SecuritySettings(
        enable2FA: map['security']?['enable2FA'] ?? false,
      ),
    );
  }
}
