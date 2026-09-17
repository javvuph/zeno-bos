part of '../isar_administration_repository.dart';

extension IsarAdministrationRepositoryLogsSyncPart on IsarAdministrationRepository {
  Future<List<SecurityAuditLog>> getSecurityLogsImpl() async {
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

  Future<List<AuditLog>> getAuditLogsImpl(String module) async {
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

  Future<List<LoginHistory>> getLoginHistoryImpl() async => [];

  Future<SyncStats> getSyncStatsImpl() async =>
      SyncStats(lastSyncTime: DateTime.now());

  Future<void> performBackupImpl() async =>
      await Future.delayed(const Duration(seconds: 1));

  Future<void> performRestoreImpl(String path) async {}

  Future<List<BackupManifest>> getBackupHistoryImpl() async => [];

  Future<List<BackgroundJob>> getBackgroundJobsImpl() async => [];

  Future<List<WebhookSubscription>> getWebhooksImpl() async => [];

  Future<void> saveWebhookImpl(WebhookSubscription webhook) async {}
}
