import 'package:isar/isar.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/finance_collections.dart';
import 'package:zeno/features/finance/domain/models/journal_entry.dart';
import 'package:zeno/features/finance/domain/models/journal_line.dart';
import 'package:zeno/features/finance/domain/repositories/i_finance_repository.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../models/purchase_order.dart';
import '../models/grn.dart';
import 'package:uuid/uuid.dart';

class FinanceJournalService {
  final DatabaseService db;
  FinanceJournalService(this.db);

  Future<void> recordPurchaseOrderApproval(PurchaseOrder po) async {
    // Log commitment if needed
  }

  Future<void> recordGRNReceipt(GRN grn, double totalValue) async {
    final financeRepo = sl<IFinanceRepository>();
    final accountCol = db.isar.collection<AccountCollection>();

    var inventoryAccount =
        await accountCol.filter().codeEqualTo('1200').findFirst();
    var apAccount = await accountCol.filter().codeEqualTo('2100').findFirst();

    if (inventoryAccount == null || apAccount == null) {
      await db.isar.writeTxn(() async {
        if (inventoryAccount == null) {
          inventoryAccount = AccountCollection()
            ..uuid = 'acc-inv-001'
            ..code = '1200'
            ..name = 'Inventory Assets'
            ..category = 'asset'
            ..type = 'current'
            ..currency = 'USD';
          await accountCol.put(inventoryAccount!);
        }
        if (apAccount == null) {
          apAccount = AccountCollection()
            ..uuid = 'acc-ap-001'
            ..code = '2100'
            ..name = 'Accounts Payable'
            ..category = 'liability'
            ..type = 'current'
            ..currency = 'USD';
          await accountCol.put(apAccount!);
        }
      });
    }

    final entry = JournalEntry(
      id: const Uuid().v4(),
      referenceNumber: "JN-GRN-${grn.id}",
      date: grn.receivedDate,
      description: "Purchase receipt against ${grn.poId}",
      status: JournalEntryStatus.posted,
      createdById: 'purchase_system',
      sourceModule: 'purchase',
      sourceDocumentId: grn.id,
      lines: [
        JournalLine(
          accountId: inventoryAccount!.uuid,
          debit: totalValue,
          memo: "Inventory Inward",
        ),
        JournalLine(
          accountId: apAccount!.uuid,
          credit: totalValue,
          memo: "Accrued Liability",
        ),
      ],
    );

    await financeRepo.postJournalEntry(entry);
  }
}
