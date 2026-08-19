import 'governance_enums.dart';

class SystemHealthEntry {
  final String component;
  final HealthStatus status;
  final String message;
  final double latencyMs;
  final DateTime lastChecked;

  const SystemHealthEntry({
    required this.component,
    required this.status,
    required this.message,
    this.latencyMs = 0.0,
    required this.lastChecked,
  });
}

class IntegrationHealth {
  final String id;
  final String name;
  final IntegrationType type;
  final HealthStatus status;
  final DateTime lastSync;
  final int errorCount24h;
  final String? lastErrorMessage;

  const IntegrationHealth({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.lastSync,
    this.errorCount24h = 0,
    this.lastErrorMessage,
  });
}

class BackupStatus {
  final String id;
  final DateTime timestamp;
  final double sizeMB;
  final String status; // success, failed, running
  final String location;
  final String createdBy;
  final bool isVerified;

  const BackupStatus({
    required this.id,
    required this.timestamp,
    required this.sizeMB,
    required this.status,
    required this.location,
    required this.createdBy,
    this.isVerified = false,
  });
}

class UserSessionMonitor {
  final String id;
  final String userId;
  final String userName;
  final String device;
  final String ipAddress;
  final DateTime loginTime;
  final DateTime lastActivity;
  final bool isMfaVerified;

  const UserSessionMonitor({
    required this.id,
    required this.userId,
    required this.userName,
    required this.device,
    required this.ipAddress,
    required this.loginTime,
    required this.lastActivity,
    this.isMfaVerified = false,
  });
}
