import '../models/warehouse.dart';
import '../models/storage_location.dart';
import '../models/stock_transaction.dart';
import '../models/stock_level.dart';
import '../models/stock_reservation.dart';

abstract class IInventoryRepository {
  Future<List<Warehouse>> getWarehouses();
  Future<List<StorageLocation>> getLocations(String warehouseId);
  Future<StockLevel> getStockLevel(String variantId, String warehouseId);
  Future<List<StockLevel>> getAllStockLevels();
  Future<void> recordTransaction(StockTransaction transaction);
  Future<void> recordTransactions(List<StockTransaction> transactions);
  Future<void> createReservation(StockReservation reservation);
  Future<void> cancelReservation(String reservationId);
}
