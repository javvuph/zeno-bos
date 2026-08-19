import 'package:isar/isar.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/transaction_collections.dart';

class BillingSyncService {
  final DatabaseService db;
  BillingSyncService(this.db);

  Future<void> updateInvoiceStatusUponDelivery(String salesOrderId) async {
    final col = db.isar.collection<InvoiceCollection>();
    final invoice = await col.filter().orderIdEqualTo(salesOrderId).findFirst();

    if (invoice != null) {
      invoice.status = 'paid'; // Assuming COD or payment upon delivery
      await db.isar.writeTxn(() async {
        await col.put(invoice);
      });
    }
  }
}
