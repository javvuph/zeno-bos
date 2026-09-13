import 'package:flutter/material.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../../domain/models/vendor_bill.dart';
import '../../domain/models/vendor_bill_status.dart';
import '../../domain/models/purchase_order.dart';
import '../../domain/models/grn.dart';
import '../../domain/services/procurement_business_logic.dart';
import '../../domain/services/purchase_master_data_service.dart';

class VendorBillController extends ChangeNotifier {
  final IPurchaseRepository _repository;
  final ProcurementBusinessLogic _logic = ProcurementBusinessLogic();
  final PurchaseMasterDataService _masterData = PurchaseMasterDataService();

  VendorBillController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<VendorBill> _bills = [];
  List<VendorBill> get bills =>
      _bills.isEmpty ? _masterData.getMockVendorBills() : _bills;

  VendorBill? _selectedBill;
  VendorBill? get selectedBill => _selectedBill;

  // KPI Bridges
  int get pendingVerificationCount =>
      bills.where((b) => b.status == VendorBillStatus.draft).length;
  double get totalOutstanding => bills
      .where((b) => b.status != VendorBillStatus.paid)
      .fold(0, (sum, b) => sum + b.balanceDue);

  Future<void> loadBills() async {
    _isLoading = true;
    notifyListeners();
    try {
      // In a real implementation, we'd fetch from repository
      // _bills = await _repository.getVendorBills();
    } catch (e) {
      debugPrint("Error loading bills: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectBill(VendorBill bill) {
    _selectedBill = bill;
    notifyListeners();
  }

  Future<void> perform3WayMatch(String billId) async {
    final bill = bills.firstWhere((b) => b.id == billId);

    // Fetch source documents for matching
    PurchaseOrder? po;
    GRN? grn;

    if (bill.poId != null) {
      po = await _repository.getPOById(bill.poId!);
    }
    if (bill.grnId != null) {
      final allGrns = await _repository.getGRNs();
      grn = allGrns.firstWhere((g) => g.id == bill.grnId);
    }

    final matchedBill = _logic.perform3WayMatch(bill, po, grn);

    // Update local state (in real app, save to repository)
    final index = bills.indexOf(bill);
    if (index != -1) {
      _bills[index] = matchedBill;
      notifyListeners();
    }
  }

  Future<void> approveBill(String billId) async {
    final index = bills.indexWhere((b) => b.id == billId);
    if (index != -1) {
      _bills[index] = _bills[index].copyWith(status: VendorBillStatus.approved);
      notifyListeners();
    }
  }
}
