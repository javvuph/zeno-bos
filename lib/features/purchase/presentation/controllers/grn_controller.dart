import 'package:flutter/material.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../../domain/models/grn.dart';
import '../../domain/services/purchase_master_data_service.dart';
import '../../../inventory/domain/models/inventory_transaction.dart';
import '../../../inventory/domain/services/inventory_transaction_engine.dart';
import 'package:zeno/core/di/service_locator.dart';

class GRNController extends ChangeNotifier {
  final IPurchaseRepository _repository;
  final PurchaseMasterDataService _masterData = PurchaseMasterDataService();
  final InventoryTransactionEngine _ite = sl<InventoryTransactionEngine>();

  GRNController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<GRN> _grns = [];
  List<GRN> get grns => _grns.isEmpty ? _masterData.getMockGRNs() : _grns;

  GRN? _selectedGRN;
  GRN? get selectedGRN => _selectedGRN;

  // KPI Bridges
  int get expectedToday => 0; // Mock
  int get receivedToday =>
      grns.where((g) => g.receivedDate.day == DateTime.now().day).length;

  Future<void> loadGRNs() async {
    _isLoading = true;
    notifyListeners();
    try {
      _grns = await _repository.getGRNs();
    } catch (e) {
      debugPrint("Error loading GRNs: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectGRN(GRN grn) {
    _selectedGRN = grn;
    notifyListeners();
  }

  Future<void> saveGRN(GRN grn) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveGRN(grn);
      await loadGRNs();
    } catch (e) {
      debugPrint("Error saving GRN: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> completeGRN(String grnId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final grn = grns.firstWhere((g) => g.id == grnId);
      final updated = grn.copyWith(status: GRNStatus.completed);
      await saveGRN(updated);

      // ITE Integration: Post to Inventory
      for (var item in updated.receivedItems) {
        if (item.acceptedQuantity > 0) {
          final tx = _ite.createTx(
            type: InventoryTransactionType.purchaseReceipt,
            productId: item.orderItem.productId,
            variantId: item.orderItem.variantId,
            warehouseId: updated.warehouseId,
            quantity: item.acceptedQuantity,
            unitId: item.orderItem.unitId,
            userId: updated.receivedById,
            branchId: updated.branchId,
            reference: updated.id,
          );
          await _ite.processTransaction(tx);
        }
      }
    } catch (e) {
      debugPrint("Error completing GRN: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
