import 'package:isar/isar.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/finance_collections.dart';
import 'package:zeno/features/finance/domain/models/journal_entry.dart';
import 'package:zeno/features/finance/domain/models/journal_line.dart';
import 'package:zeno/features/finance/domain/repositories/i_finance_repository.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:uuid/uuid.dart';

class BillingFinanceService {
  final DatabaseService db;
  BillingFinanceService(this.db);

  Future<void> recordSale(
      String billId, double totalAmount, double taxAmount) async {
    final financeRepo = sl<IFinanceRepository>();
    final accountCol = db.isar.collection<AccountCollection>();

    var salesAccount =
        await accountCol.filter().codeEqualTo('4000').findFirst();
    var cashAccount = await accountCol.filter().codeEqualTo('1000').findFirst();
    var taxAccount = await accountCol.filter().codeEqualTo('2200').findFirst();

    // Ensure accounts exist (Demo/Auto-setup logic)
    if (salesAccount == null || cashAccount == null || taxAccount == null) {
      await db.isar.writeTxn(() async {
        if (salesAccount == null) {
          salesAccount = AccountCollection()
            ..uuid = 'acc-sales-001'
            ..code = '4000'
            ..name = 'Sales Revenue'
            ..category = 'income'
            ..type = 'sales'
            ..currency = 'USD';
          await accountCol.put(salesAccount!);
        }
        if (cashAccount == null) {
          cashAccount = AccountCollection()
            ..uuid = 'acc-cash-001'
            ..code = '1000'
            ..name = 'Cash on Hand'
            ..category = 'asset'
            ..type = 'cash'
            ..currency = 'USD';
          await accountCol.put(cashAccount!);
        }
        if (taxAccount == null) {
          taxAccount = AccountCollection()
            ..uuid = 'acc-tax-001'
            ..code = '2200'
            ..name = 'Sales Tax Payable'
            ..category = 'liability'
            ..type = 'tax'
            ..currency = 'USD';
          await accountCol.put(taxAccount!);
        }
      });
    }

    final entry = JournalEntry(
      id: const Uuid().v4(),
      referenceNumber: "JN-SALE-$billId",
      date: DateTime.now(),
      description: "Sales recognized from bill $billId",
      status: JournalEntryStatus.posted,
      createdById: 'pos_system',
      sourceModule: 'billing',
      sourceDocumentId: billId,
      lines: [
        JournalLine(
          accountId: cashAccount!.uuid,
          debit: totalAmount,
          memo: "Cash Receipt",
        ),
        JournalLine(
          accountId: salesAccount!.uuid,
          credit: totalAmount - taxAmount,
          memo: "Revenue Recognition",
        ),
        JournalLine(
          accountId: taxAccount!.uuid,
          credit: taxAmount,
          memo: "Tax Component",
        ),
      ],
    );

    await financeRepo.postJournalEntry(entry);
  }
}
