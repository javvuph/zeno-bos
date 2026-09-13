import 'package:isar/isar.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/inventory_collections.dart';
import '../models/grn.dart';

class InventoryUpdateService {
  final DatabaseService db;
  InventoryUpdateService(this.db);

  Future<void> updateStockFromGRN(GRN grn) async {
    final col = db.isar.collection<StockItemCollection>();

    await db.isar.writeTxn(() async {
      for (var item in grn.receivedItems) {
        if (item.acceptedQuantity <= 0) continue;

        // Try to find existing stock item
        var stockItem = await col
            .filter()
            .productIdEqualTo(item.orderItem.productId)
            .and()
            .warehouseIdEqualTo(grn.warehouseId)
            .findFirst();

        if (stockItem != null) {
          stockItem.quantity += item.acceptedQuantity;
          stockItem.lastUpdated = DateTime.now();
          await col.put(stockItem);
        } else {
          // Create new stock item
          final newStock = StockItemCollection()
            ..productId = item.orderItem.productId
            ..warehouseId = grn.warehouseId
            ..quantity = item.acceptedQuantity
            ..reservedQuantity = 0.0
            ..lastUpdated = DateTime.now();
          await col.put(newStock);
        }
      }
    });
  }
}
