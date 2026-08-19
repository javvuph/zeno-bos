import 'package:workmanager/workmanager.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'sync_manager.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    debugPrint("Native Background Task Triggered: $task");

    try {
      // Initialize DI for background isolate
      await setupServiceLocator();

      final syncManager = sl<SyncManager>();
      await syncManager.processOfflineQueue();

      return Future.value(true);
    } catch (e) {
      debugPrint("Background Sync Task Failed: $e");
      return Future.value(false);
    }
  });
}

class BackgroundSyncWorker {
  static const String syncTaskName = "com.zeno.bos.sync_task";

  static bool get _isSupported =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static Future<void> initialize() async {
    if (!_isSupported) {
      debugPrint(
          "BackgroundSyncWorker: Workmanager not supported on this platform.");
      return;
    }
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );
  }

  static Future<void> schedulePeriodicSync() async {
    if (!_isSupported) return;
    await Workmanager().registerPeriodicTask(
      "1",
      syncTaskName,
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
    );
  }

  static Future<void> triggerOneOffSync() async {
    if (!_isSupported) return;
    await Workmanager().registerOneOffTask(
      DateTime.now().millisecondsSinceEpoch.toString(),
      syncTaskName,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }
}
