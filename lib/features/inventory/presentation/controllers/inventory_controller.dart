import 'package:flutter/material.dart';
import '../../domain/repositories/i_inventory_repository.dart';
import '../../domain/models/stock_level.dart';
import '../../domain/services/inventory_business_logic.dart';
import '../../domain/services/inventory_master_data_service.dart';
import '../../domain/models/stock_transaction.dart';
import '../../domain/models/warehouse.dart';

class InventoryController extends ChangeNotifier {
  final IInventoryRepository _repository;
  final InventoryBusinessLogic _logic = InventoryBusinessLogic();
  final InventoryMasterDataService _masterData = InventoryMasterDataService();

  InventoryController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StockLevel? _currentStockLevel;
  StockLevel? get currentStockLevel => _currentStockLevel;

  // Domain State
  List<StockLevel> _allStockLevels = [];
  List<StockLevel> get allStockLevels => _allStockLevels;

  List<Warehouse> _warehouses = [];
  List<Warehouse> get warehouses =>
      _warehouses.isEmpty ? _masterData.getWarehouses() : _warehouses;

  List<StockTransaction> get recentTransactions =>
      _masterData.getRecentTransactions();

  double get availableStock => _currentStockLevel != null
      ? _logic.calculateAvailable(_currentStockLevel!)
      : 0.0;

  // Analytics Bridges
  double get totalPhysicalStock =>
      allStockLevels.fold(0, (sum, item) => sum + item.physical);
  double get totalReservedStock =>
      allStockLevels.fold(0, (sum, item) => sum + item.reserved);
  int get outOfStockCount =>
      allStockLevels.where((s) => _logic.calculateAvailable(s) <= 0).length;

  Future<void> refreshAll() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allStockLevels = await _repository.getAllStockLevels();
      _warehouses = await _repository.getWarehouses();
    } catch (e) {
      debugPrint("Refresh all failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshStock(String productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentStockLevel = await _repository.getStockLevel(productId, 'main');
    } catch (e) {
      debugPrint("Error fetching stock: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> processInward(
      String productId, double qty, String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final trx = StockTransaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        stockItemId: productId,
        type: TransactionType.inPurchase,
        quantityDelta: qty,
        timestamp: DateTime.now(),
        userId: userId,
      );
      await _repository.recordTransaction(trx);
      await refreshAll();
    } catch (e) {
      debugPrint("Error in stock inward: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> processOutward(
      String productId, double qty, String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final trx = StockTransaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        stockItemId: productId,
        type: TransactionType.outSale,
        quantityDelta: -qty,
        timestamp: DateTime.now(),
        userId: userId,
      );
      await _repository.recordTransaction(trx);
      await refreshAll();
    } catch (e) {
      debugPrint("Error in stock outward: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> processTransfer(String productId, double qty, String fromNode,
      String toNode, String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      // 1. Out from source
      final trxOut = StockTransaction(
        id: 'TRF-OUT-${DateTime.now().millisecondsSinceEpoch}',
        stockItemId: productId,
        type: TransactionType.transferOut,
        quantityDelta: -qty,
        timestamp: DateTime.now(),
        userId: userId,
        notes: 'Transfer to $toNode',
      );
      await _repository.recordTransaction(trxOut);

      // 2. In to destination
      final trxIn = StockTransaction(
        id: 'TRF-IN-${DateTime.now().millisecondsSinceEpoch}',
        stockItemId: productId,
        type: TransactionType.transferIn,
        quantityDelta: qty,
        timestamp: DateTime.now(),
        userId: userId,
        notes: 'Transfer from $fromNode',
      );
      await _repository.recordTransaction(trxIn);

      await refreshAll();
    } catch (e) {
      debugPrint("Error in stock transfer: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> processAdjustment(
      String productId, double newQty, String userId, String reason) async {
    _isLoading = true;
    notifyListeners();
    try {
      final current = await _repository.getStockLevel(productId, 'main');
      final delta = newQty - current.physical;

      final trx = StockTransaction(
        id: 'ADJ-${DateTime.now().millisecondsSinceEpoch}',
        stockItemId: productId,
        type: TransactionType.adjustment,
        quantityDelta: delta,
        timestamp: DateTime.now(),
        userId: userId,
        notes: reason,
      );
      await _repository.recordTransaction(trx);
      await refreshAll();
    } catch (e) {
      debugPrint("Error in stock adjustment: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> bulkImportProducts(List<dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Logic for bulk import
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      debugPrint("Bulk import failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
