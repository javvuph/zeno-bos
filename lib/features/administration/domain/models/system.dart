class AuditLog {
  final String id;
  final String userId;
  final String action;
  final String module;
  final DateTime timestamp;
  final String details;
  final String? branchId;
  final Map<String, dynamic> metadata;

  const AuditLog({
    required this.id,
    required this.userId,
    required this.action,
    required this.module,
    required this.timestamp,
    required this.details,
    this.branchId,
    this.metadata = const {},
  });
}

class SystemHealth {
  final double cpuUsage;
  final double memoryUsage;
  final double databaseSize; // In MB
  final double storageUsage; // In MB
  final String apiStatus; // 'online', 'degraded', 'offline'
  final String aiStatus;
  final String syncStatus;
  final int activeUsers;
  final int connectedBranches;
  final int errorCount24h;
  final double p99Latency;
  final String uptime;

  const SystemHealth({
    this.cpuUsage = 0.0,
    this.memoryUsage = 0.0,
    this.databaseSize = 0.0,
    this.storageUsage = 0.0,
    this.apiStatus = 'online',
    this.aiStatus = 'online',
    this.syncStatus = 'stable',
    this.activeUsers = 0,
    this.connectedBranches = 0,
    this.errorCount24h = 0,
    this.p99Latency = 0.0,
    this.uptime = '0h',
  });
}

class BackupManifest {
  final String id;
  final DateTime timestamp;
  final String filePath;
  final int sizeBytes;
  final String checksum;
  final bool isVerified;
  final String version;

  const BackupManifest({
    required this.id,
    required this.timestamp,
    required this.filePath,
    required this.sizeBytes,
    required this.checksum,
    this.isVerified = false,
    this.version = '1.0',
  });
}

class BackgroundJob {
  final String id;
  final String name;
  final String status; // 'running', 'queued', 'completed', 'failed'
  final DateTime startTime;
  final DateTime? endTime;
  final double progress; // 0.0 to 1.0

  const BackgroundJob({
    required this.id,
    required this.name,
    required this.status,
    required this.startTime,
    this.endTime,
    this.progress = 0.0,
  });
}

class DiagnosticReport {
  final String id;
  final DateTime timestamp;
  final Map<String, String> componentStatus; // Component -> Status
  final List<String> criticalIssues;
  final String recommendation;

  const DiagnosticReport({
    required this.id,
    required this.timestamp,
    required this.componentStatus,
    required this.criticalIssues,
    required this.recommendation,
  });
}

class SyncStats {
  final DateTime lastSyncTime;
  final int pendingQueue;
  final int conflictsResolved;
  final double replicationHealth; // 0.0 to 1.0
  final bool isCloudReady;

  const SyncStats({
    required this.lastSyncTime,
    this.pendingQueue = 0,
    this.conflictsResolved = 0,
    this.replicationHealth = 1.0,
    this.isCloudReady = true,
  });
}
