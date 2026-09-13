import 'dart:convert';
import 'package:isar/isar.dart';
import '../../../../core/sync/sync_manager.dart';
import '../../../../core/sync/sync_action.dart';
import '../models/bill.dart';

extension BillToJson on Bill {
  Map<String, dynamic> toJson() => {
    'id': id,
    'timestamp': timestamp.toIso8601String(),
    'grandTotal': grandTotal,
  };
}

class PosSyncManager {
  final SyncManager _syncManager;
  final Isar _isar;

  PosSyncManager(this._syncManager, this._isar);

  Future<void> queueTransaction(Bill bill) async {
    final action = SyncAction()
      ..collectionName = 'Bills'
      ..entityUuid = bill.id
      ..operation = SyncOperation.create
      ..payload = jsonEncode(bill.toJson())
      ..createdAt = DateTime.now()
      ..idempotencyKey = "TXN-${bill.id}-${DateTime.now().millisecondsSinceEpoch}";

    await _syncManager.addToQueue(action);
  }

  Future<List<SyncAction>> getPendingTransactions() async {
    return await _isar.collection<SyncAction>()
        .filter()
        .collectionNameEqualTo('Bills')
        .isFailedEqualTo(false)
        .findAll();
  }

  // Idempotent sync logic to be called by SyncManager background process
  Future<void> syncTransaction(SyncAction action) async {
    // 1. Check server if transaction exists using idempotencyKey
    // 2. If not exists, POST to /api/pos/transactions
    // 3. Handle 201 Created or 200 OK as success
  }
}
