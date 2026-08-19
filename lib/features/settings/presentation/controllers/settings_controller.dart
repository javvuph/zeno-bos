import 'package:flutter/material.dart';
import 'package:zeno/core/services/settings_service.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/app_settings.dart';

class SettingsController extends ChangeNotifier {
  final SettingsService _settingsService = sl<SettingsService>();

  SettingsController() {
    _settingsService.addListener(notifyListeners);
  }

  AppSettings get settings => _settingsService.settings;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _settingsService.removeListener(notifyListeners);
    super.dispose();
  }

  Future<void> updateSettings(AppSettings newSettings) async {
    _isLoading = true;
    notifyListeners();
    await _settingsService.updateSettings(newSettings);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateGeneral(GeneralSettings general) async {
    await updateSettings(AppSettings(
      general: general,
      modules: settings.modules,
      communication: settings.communication,
      hardware: settings.hardware,
      payment: settings.payment,
      security: settings.security,
      system: settings.system,
    ));
  }

  Future<void> toggleTheme() async {
    final newMode = settings.general.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    await updateGeneral(GeneralSettings(
      language: settings.general.language,
      currency: settings.general.currency,
      timezone: settings.general.timezone,
      themeMode: newMode,
      dateFormat: settings.general.dateFormat,
    ));
  }
}
