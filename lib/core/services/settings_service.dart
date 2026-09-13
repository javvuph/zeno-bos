import 'package:flutter/material.dart';
import '../../features/settings/domain/models/app_settings.dart';
import '../../features/settings/domain/repositories/i_settings_repository.dart';
import '../di/service_locator.dart';

class SettingsService extends ChangeNotifier {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  AppSettings _settings = const AppSettings();
  AppSettings get settings => _settings;

  Future<void> init() async {
    final repo = sl<ISettingsRepository>();
    _settings = await repo.getSettings();
    notifyListeners();
  }

  Future<void> updateSettings(AppSettings newSettings) async {
    _settings = newSettings;
    notifyListeners();
    await sl<ISettingsRepository>().saveSettings(_settings);
  }

  // Helper getters for cross-module usage
  String get currency => _settings.general.currency;
  String get language => _settings.general.language;
  ThemeMode get themeMode => _settings.general.themeMode;

  String? getCustomValue(String key) {
    return _settings.system.customData[key];
  }

  Future<void> setCustomValue(String key, String value) async {
    final Map<String, String> updatedCustomData =
        Map.from(_settings.system.customData);
    updatedCustomData[key] = value;

    final newSettings = _settings.copyWith(
      system: _settings.system.copyWith(customData: updatedCustomData),
    );

    await updateSettings(newSettings);
  }
}
