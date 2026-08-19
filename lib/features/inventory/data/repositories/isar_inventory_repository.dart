import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/inventory_collections.dart';
import '../../domain/repositories/i_inventory_repository.dart';
import '../../domain/models/warehouse.dart';
import '../../domain/models/storage_location.dart';
import '../../domain/models/stock_level.dart';
import '../../domain/models/stock_transaction.dart';
import '../../domain/models/stock_reservation.dart';
import 'package:isar/isar.dart';

class IsarInventoryRepository implements IInventoryRepository {
  final DatabaseService db;
  IsarInventoryRepository(this.db);

  IsarCollection<StockItemCollection> get collection =>
      db.isar.collection<StockItemCollection>();
  IsarCollection<WarehouseCollection> get warehouseCollection =>
      db.isar.collection<WarehouseCollection>();

  @override
  Future<List<Warehouse>> getWarehouses() async {
    final list = await warehouseCollection.where().findAll();
    return list
        .map((w) => Warehouse(
              id: w.uuid,
              name: w.name,
              address: w.address,
              isActive: !w.isDeleted,
            ))
        .toList();
  }

  @override
  Future<List<StorageLocation>> getLocations(String warehouseId) async => [];

  @override
  Future<StockLevel> getStockLevel(String variantId, String warehouseId) async {
    final item = await collection
        .filter()
        .productIdEqualTo(variantId)
        .and()
        .warehouseIdEqualTo(warehouseId)
        .findFirst();

    if (item == null) {
      return StockLevel(
        productId: variantId,
        variantId: variantId,
        warehouseId: warehouseId,
        physical: 0,
        reserved: 0,
      );
    }

    return StockLevel(
      productId: item.productId,
      variantId: item.productId,
      warehouseId: item.warehouseId,
      physical: item.quantity,
      reserved: item.reservedQuantity,
    );
  }

  @override
  Future<void> recordTransaction(StockTransaction transaction) async {
    await recordTransactions([transaction]);
  }

  @override
  Future<void> recordTransactions(List<StockTransaction> transactions) async {
    await db.isar.writeTxn(() async {
      for (var transaction in transactions) {
        final existing = await collection
            .filter()
            .productIdEqualTo(transaction.stockItemId)
            .findFirst();

        if (existing != null) {
          existing.quantity += transaction.quantityDelta;
          existing.lastUpdated = DateTime.now();
          await collection.put(existing);
        } else {
          final newItem = StockItemCollection()
            ..productId = transaction.stockItemId
            ..warehouseId = 'default'
            ..quantity = transaction.quantityDelta
            ..reservedQuantity = 0.0;
          await collection.put(newItem);
        }
      }
    });
  }

  @override
  Future<void> createReservation(StockReservation reservation) async {
    await db.isar.writeTxn(() async {
      final item = await collection
          .filter()
          .productIdEqualTo(reservation.variantId)
          .findFirst();
      if (item != null) {
        item.reservedQuantity += reservation.quantity;
        await collection.put(item);
      }
    });
  }

  @override
  Future<void> cancelReservation(String reservationId) async {
    // Implementation for cancelling reservation
    // In a real app, you'd find the reservation and reverse the quantity
  }

  @override
  Future<List<StockLevel>> getAllStockLevels() async {
    final items = await collection.where().findAll();
    return items
        .map((item) => StockLevel(
              productId: item.productId,
              variantId: item.productId,
              warehouseId: item.warehouseId,
              physical: item.quantity,
              reserved: item.reservedQuantity,
            ))
        .toList();
  }
}
