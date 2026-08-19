import 'package:flutter/material.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../../domain/models/purchase_order.dart';
import '../../domain/models/purchase_requisition.dart';
import '../../domain/models/grn.dart' as model_grn;
import '../../domain/services/procurement_business_logic.dart';
import '../../domain/services/purchase_master_data_service.dart';
import '../../domain/services/inventory_update_service.dart';
import '../../domain/services/finance_journal_service.dart';
import 'package:zeno/core/di/service_locator.dart';

class PurchaseController extends ChangeNotifier {
  final IPurchaseRepository _repository;
  final ProcurementBusinessLogic _logic = ProcurementBusinessLogic();
  final PurchaseMasterDataService _masterData = PurchaseMasterDataService();
  final InventoryUpdateService _inventoryService = sl<InventoryUpdateService>();
  final FinanceJournalService _financeService = sl<FinanceJournalService>();

  PurchaseController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<PurchaseOrder> _pos = [];
  List<PurchaseOrder> get purchaseOrders =>
      _pos.isEmpty ? _masterData.getMockPurchaseOrders() : _pos;

  final List<PurchaseRequisition> _prs = [];
  List<PurchaseRequisition> get requisitions =>
      _prs.isEmpty ? _masterData.getMockRequisitions() : _prs;

  final List<model_grn.GRN> _grns = [];
  List<model_grn.GRN> get grns =>
      _grns.isEmpty ? _masterData.getMockGRNs() : _grns;

  // KPI Bridges
  double get totalPurchaseValue =>
      purchaseOrders.fold(0, (sum, po) => sum + po.totalAmount);
  int get pendingApprovalCount => purchaseOrders
      .where((po) => po.status == POStatus.pendingApproval)
      .length;

  Future<void> loadPurchaseOrders() async {
    _isLoading = true;
    notifyListeners();
    try {
      _pos = await _repository.getPurchaseOrders();
    } catch (e) {
      debugPrint("Error loading POs: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Calculates readiness for a specific PO
  double getPOReadiness(PurchaseOrder po) => _logic.calculatePOReadiness(po);

  /// Performs multi-currency conversion for analytics
  double convertToLocal(double amount, double rate) =>
      _logic.convertCurrency(amount, rate);

  Future<void> savePO(PurchaseOrder po) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.savePO(po);
      await loadPurchaseOrders();
    } catch (e) {
      debugPrint("Error saving PO: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveGRN(model_grn.GRN grn) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveGRN(grn);

      // Phase 2: Downstream Integration via Services
      await _inventoryService.updateStockFromGRN(grn);

      double totalReceivedValue = grn.receivedItems.fold(
          0,
          (sum, item) =>
              sum + (item.acceptedQuantity * item.orderItem.unitPrice));
      await _financeService.recordGRNReceipt(grn, totalReceivedValue);

      // Auto-update PO status based on GRN
      final po = await _repository.getPOById(grn.poId);
      if (po != null) {
        final allGrns = await _repository.getGRNs();
        final poGrns = allGrns.where((g) => g.poId == po.id).toList();
        final newStatus = _logic.calculatePOStatus(po, poGrns);
        if (newStatus != po.status) {
          final updatedPO = po.copyWith(status: newStatus);
          await _repository.savePO(updatedPO);
        }
      }
      await loadPurchaseOrders();
    } catch (e) {
      debugPrint("Error saving GRN: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> approvePO(String poId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final po = await _repository.getPOById(poId);
      if (po != null) {
        final updatedPO = po.copyWith(status: POStatus.approved);
        await _repository.savePO(updatedPO);
        await loadPurchaseOrders();
      }
    } catch (e) {
      debugPrint("Error approving PO: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelPO(String poId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final po = await _repository.getPOById(poId);
      if (po != null) {
        final updatedPO = po.copyWith(status: POStatus.cancelled);
        await _repository.savePO(updatedPO);
        await loadPurchaseOrders();
      }
    } catch (e) {
      debugPrint("Error cancelling PO: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
