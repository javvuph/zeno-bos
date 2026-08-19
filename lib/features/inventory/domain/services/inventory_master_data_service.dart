import '../models/warehouse.dart';
import '../models/stock_level.dart';
import '../models/stock_transaction.dart';

class InventoryMasterDataService {
  List<Warehouse> getWarehouses() => [
        const Warehouse(
            id: 'wh_1', name: 'Main HQ Warehouse', address: 'London, UK'),
        const Warehouse(
            id: 'wh_2',
            name: 'Dubai Distribution Center',
            address: 'Dubai, UAE'),
        const Warehouse(
            id: 'wh_3', name: 'Singapore Hub', address: 'Singapore'),
        const Warehouse(
            id: 'wh_4', name: 'Colombo Transit', address: 'Colombo, Sri Lanka'),
      ];

  List<StockLevel> getMockStockLevels() => [
        const StockLevel(
            productId: 'p1',
            variantId: 'v1',
            warehouseId: 'wh_1',
            physical: 1250,
            reserved: 45),
        const StockLevel(
            productId: 'p2',
            variantId: 'v2',
            warehouseId: 'wh_1',
            physical: 450,
            reserved: 120),
        const StockLevel(
            productId: 'p3',
            variantId: 'v3',
            warehouseId: 'wh_2',
            physical: 890,
            reserved: 10),
        const StockLevel(
            productId: 'p4',
            variantId: 'v4',
            warehouseId: 'wh_3',
            physical: 2300,
            reserved: 500),
      ];

  List<StockTransaction> getRecentTransactions() => [
        StockTransaction(
            id: 'trx_1',
            stockItemId: 'si_1',
            quantityDelta: 500,
            type: TransactionType.inPurchase,
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            userId: 'user_1',
            notes: 'Monthly restock'),
        StockTransaction(
            id: 'trx_2',
            stockItemId: 'si_2',
            quantityDelta: -12,
            type: TransactionType.outSale,
            timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
            userId: 'user_2',
            notes: 'Order #SO-450'),
      ];
}
