import 'package:flutter/material.dart';

class AppSettings {
  final GeneralSettings general;
  final ModuleSettings modules;
  final CommunicationSettings communication;
  final HardwareSettings hardware;
  final PaymentSettings payment;
  final SecuritySettings security;
  final SystemSettings system;

  const AppSettings({
    this.general = const GeneralSettings(),
    this.modules = const ModuleSettings(),
    this.communication = const CommunicationSettings(),
    this.hardware = const HardwareSettings(),
    this.payment = const PaymentSettings(),
    this.security = const SecuritySettings(),
    this.system = const SystemSettings(),
  });

  AppSettings copyWith({
    GeneralSettings? general,
    ModuleSettings? modules,
    CommunicationSettings? communication,
    HardwareSettings? hardware,
    PaymentSettings? payment,
    SecuritySettings? security,
    SystemSettings? system,
  }) {
    return AppSettings(
      general: general ?? this.general,
      modules: modules ?? this.modules,
      communication: communication ?? this.communication,
      hardware: hardware ?? this.hardware,
      payment: payment ?? this.payment,
      security: security ?? this.security,
      system: system ?? this.system,
    );
  }
}

class GeneralSettings {
  final String language;
  final String currency;
  final String timezone;
  final ThemeMode themeMode;
  final String dateFormat;

  const GeneralSettings({
    this.language = 'en_US',
    this.currency = 'USD',
    this.timezone = 'UTC',
    this.themeMode = ThemeMode.system,
    this.dateFormat = 'dd/MM/yyyy',
  });
}

class ModuleSettings {
  final Map<String, dynamic> billing;
  final Map<String, dynamic> inventory;
  final Map<String, dynamic> purchase;
  final Map<String, dynamic> finance;
  final Map<String, dynamic> crm;
  final Map<String, dynamic> staff;
  final Map<String, dynamic> delivery;
  final Map<String, dynamic> ai;

  const ModuleSettings({
    this.billing = const {},
    this.inventory = const {},
    this.purchase = const {},
    this.finance = const {},
    this.crm = const {},
    this.staff = const {},
    this.delivery = const {},
    this.ai = const {},
  });
}

class CommunicationSettings {
  final EmailConfig email;
  final SMSConfig sms;
  final WhatsAppConfig whatsapp;
  final NotificationConfig notifications;

  const CommunicationSettings({
    this.email = const EmailConfig(),
    this.sms = const SMSConfig(),
    this.whatsapp = const WhatsAppConfig(),
    this.notifications = const NotificationConfig(),
  });
}

class EmailConfig {
  final String smtpServer;
  final int port;
  final String username;
  final String password;
  final bool useSSL;

  const EmailConfig({
    this.smtpServer = '',
    this.port = 587,
    this.username = '',
    this.password = '',
    this.useSSL = true,
  });
}

class SMSConfig {
  final String provider;
  final String apiKey;
  final String senderId;

  const SMSConfig({this.provider = '', this.apiKey = '', this.senderId = ''});
}

class WhatsAppConfig {
  final String accessToken;
  final String phoneNumberId;

  const WhatsAppConfig({this.accessToken = '', this.phoneNumberId = ''});
}

class NotificationConfig {
  final bool enablePush;
  final bool enableEmail;
  final bool enableSMS;

  const NotificationConfig(
      {this.enablePush = true,
      this.enableEmail = true,
      this.enableSMS = false});
}

class HardwareSettings {
  final PrinterConfig printer;
  final BarcodeConfig barcode;

  const HardwareSettings({
    this.printer = const PrinterConfig(),
    this.barcode = const BarcodeConfig(),
  });
}

class PrinterConfig {
  final String name;
  final String type; // thermal, inkjet, etc.
  final String connection; // usb, network, bluetooth

  const PrinterConfig(
      {this.name = '', this.type = 'thermal', this.connection = 'usb'});
}

class BarcodeConfig {
  final String scannerType; // built-in, external
  final String prefix;

  const BarcodeConfig({this.scannerType = 'external', this.prefix = ''});
}

class PaymentSettings {
  final Map<String, dynamic> gateways;
  final String upiId;
  final Map<String, dynamic> bankIntegration;

  const PaymentSettings({
    this.gateways = const {},
    this.upiId = '',
    this.bankIntegration = const {},
  });
}

class SecuritySettings {
  final bool enable2FA;
  final int sessionTimeout;
  final String passwordPolicy;
  final bool privacyMode;

  const SecuritySettings({
    this.enable2FA = false,
    this.sessionTimeout = 60,
    this.passwordPolicy = 'medium',
    this.privacyMode = false,
  });
}

class SystemSettings {
  final Map<String, String> apiKeys;
  final List<String> webhooks;
  final Map<String, dynamic> backup;
  final Map<String, dynamic> sync;
  final Map<String, dynamic> performance;
  final Map<String, String> customData;

  const SystemSettings({
    this.apiKeys = const {},
    this.webhooks = const [],
    this.backup = const {},
    this.sync = const {},
    this.performance = const {},
    this.customData = const {},
  });

  SystemSettings copyWith({
    Map<String, String>? apiKeys,
    List<String>? webhooks,
    Map<String, dynamic>? backup,
    Map<String, dynamic>? sync,
    Map<String, dynamic>? performance,
    Map<String, String>? customData,
  }) {
    return SystemSettings(
      apiKeys: apiKeys ?? this.apiKeys,
      webhooks: webhooks ?? this.webhooks,
      backup: backup ?? this.backup,
      sync: sync ?? this.sync,
      performance: performance ?? this.performance,
      customData: customData ?? this.customData,
    );
  }
}
