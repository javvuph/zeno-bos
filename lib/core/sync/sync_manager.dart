import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:isar/isar.dart';
import '../database/database_service.dart';
import 'sync_action.dart';
import 'sync_conflict.dart';
import 'sync_audit_log.dart';

class SyncManager extends ChangeNotifier {
  final DatabaseService _db;
  final Connectivity _connectivity = Connectivity();

  bool _isSyncing = false;
  bool get isSyncing => _isSyncing;

  double _progress = 0.0;
  double get progress => _progress;

  SyncManager(this._db) {
    // Listen for network changes to trigger sync
    _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        processOfflineQueue();
      }
    });
  }

  /// Adds a new operation to the offline queue
  Future<void> addToQueue(SyncAction action) async {
    await _db.isar.writeTxn(() async {
      await _db.isar.syncActions.put(action);
    });
    processOfflineQueue();
  }

  /// Detects conflicts by comparing local and remote versions
  Future<bool> detectConflict(
      String collectionName, String uuid, int localVersion) async {
    // Logic to query remote server for latest version
    // For now, return false (no conflict)
    return false;
  }

  /// The primary Push Engine: Process all pending actions
  Future<void> processOfflineQueue() async {
    if (_isSyncing) return;

    final connectivity = await _connectivity.checkConnectivity();
    if (connectivity == ConnectivityResult.none) return;

    final pending = await _db.isar
        .collection<SyncAction>()
        .where()
        .isFailedEqualTo(false)
        .sortByCreatedAt()
        .findAll();

    if (pending.isEmpty) return;

    _isSyncing = true;
    _progress = 0.0;
    notifyListeners();

    int completed = 0;
    for (var action in pending) {
      try {
        // 1. Conflict Detection
        bool hasConflict =
            await detectConflict(action.collectionName, action.entityUuid, 1);

        if (hasConflict) {
          await _handleConflict(action);
          continue;
        }

        // 2. Logic to push to remote API (placeholder)
        await Future.delayed(const Duration(milliseconds: 300));

        // 3. Log Success
        await _logSync(
            action.collectionName, 'success', 'Synced ${action.entityUuid}');

        // 4. On success, remove from queue
        await _db.isar.writeTxn(() async {
          await _db.isar.syncActions.delete(action.id);
        });
      } catch (e) {
        // 5. Retry Engine Logic
        await _db.isar.writeTxn(() async {
          action.retryCount++;
          if (action.retryCount >= 5) {
            action.isFailed = true;
          }
          action.lastError = e.toString();
          await _db.isar.syncActions.put(action);
        });
        await _logSync(action.collectionName, 'failure', e.toString());
      }

      completed++;
      _progress = completed / pending.length;
      notifyListeners();
    }

    _isSyncing = false;
    _progress = 1.0;
    notifyListeners();
  }

  Future<void> _handleConflict(SyncAction action) async {
    final conflict = SyncConflict()
      ..collectionName = action.collectionName
      ..entityUuid = action.entityUuid
      ..localPayload = action.payload
      ..remotePayload = '{}' // Placeholder
      ..conflictAt = DateTime.now();

    await _db.isar.writeTxn(() async {
      await _db.isar.syncConflicts.put(conflict);
      await _db.isar.syncActions
          .delete(action.id); // Remove from queue, move to review
    });

    await _logSync(action.collectionName, 'conflict',
        'Conflict detected for ${action.entityUuid}');
  }

  Future<void> _logSync(String module, String status, String message) async {
    final log = SyncAuditLog(
      timestamp: DateTime.now(),
      module: module,
      status: status,
      message: message,
    );
    await _db.isar.writeTxn(() async {
      await _db.isar.syncAuditLogs.put(log);
    });
  }

  /// Pull Engine: Framework for incremental updates from Cloud
  Future<void> pullIncrementalUpdates() async {
    // Logic for fetching remote changes and applying to Isar
  }
}
