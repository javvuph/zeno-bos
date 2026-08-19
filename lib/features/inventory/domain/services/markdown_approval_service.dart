import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:zeno/core/database/collections/admin_collections.dart';

class MarkdownApprovalService {
  final Isar _isar;

  MarkdownApprovalService(this._isar);

  Future<void> proposeMarkdown({
    required String productId,
    required double currentPrice,
    required double proposedPrice,
    required double discountPct,
    required DateTime effectiveDate,
    required String requestedBy,
    String? reason,
  }) async {
    final payload = {
      'type': 'MARKDOWN_PROPOSAL',
      'productId': productId,
      'currentPrice': currentPrice,
      'proposedPrice': proposedPrice,
      'discountPct': discountPct,
      'effectiveDate': effectiveDate.toIso8601String(),
      'status': 'PENDING_APPROVAL',
      'reason': reason,
    };

    final auditEntry = AuditLogCollection()
      ..uuid = 'AUD-${DateTime.now().millisecondsSinceEpoch}'
      ..module = 'Fashion'
      ..action = 'PROPOSE_MARKDOWN'
      ..userId = requestedBy
      ..timestamp = DateTime.now()
      ..details = jsonEncode(payload);

    await _isar.writeTxn(() async {
      await _isar.collection<AuditLogCollection>().put(auditEntry);
    });
  }

  Future<List<AuditLogCollection>> getPendingMarkdowns() async {
    final logs = await _isar.collection<AuditLogCollection>()
        .where()
        .findAll();
    
    return logs.where((log) {
      if (log.module != 'Fashion' || log.action != 'PROPOSE_MARKDOWN') return false;
      try {
        final data = jsonDecode(log.details);
        return data['status'] == 'PENDING_APPROVAL';
      } catch (_) {
        return false;
      }
    }).toList();
  }
}
