import 'package:flutter/material.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../../domain/models/rfq.dart';
import '../../domain/models/supplier_quotation.dart';
import '../../domain/services/procurement_business_logic.dart';
import '../../domain/services/purchase_master_data_service.dart';

class RFQController extends ChangeNotifier {
  final IPurchaseRepository _repository;
  final ProcurementBusinessLogic _logic = ProcurementBusinessLogic();
  final PurchaseMasterDataService _masterData = PurchaseMasterDataService();

  RFQController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<RFQ> _rfqs = [];
  List<RFQ> get rfqs => _rfqs.isEmpty ? _masterData.getMockRFQs() : _rfqs;

  RFQ? _selectedRFQ;
  RFQ? get selectedRFQ => _selectedRFQ;

  List<SupplierQuotation> _quotations = [];
  List<SupplierQuotation> get quotations => _quotations;

  // KPI Bridges
  int get activeRFQCount =>
      rfqs.where((r) => r.status == RFQStatus.open).length;
  int get closingTodayCount => rfqs
      .where((r) =>
          r.closingDate.year == DateTime.now().year &&
          r.closingDate.month == DateTime.now().month &&
          r.closingDate.day == DateTime.now().day)
      .length;

  Future<void> loadRFQs() async {
    _isLoading = true;
    notifyListeners();
    try {
      _rfqs = await _repository.getRFQs();
    } catch (e) {
      debugPrint("Error loading RFQs: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectRFQ(RFQ rfq) async {
    _selectedRFQ = rfq;
    _isLoading = true;
    notifyListeners();

    try {
      final results = await _repository.getQuotations(rfq.id);
      _quotations =
          results.isEmpty ? _masterData.getMockQuotations(rfq.id) : results;

      // Auto-apply AI scoring for comparison
      _quotations = _logic.applyAiScoring(_quotations);
    } catch (e) {
      debugPrint("Error loading quotations: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveRFQ(RFQ rfq) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveRFQ(rfq);
      await loadRFQs();
    } catch (e) {
      debugPrint("Error saving RFQ: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> approveRFQ(String rfqId) async {
    final rfq = rfqs.firstWhere((r) => r.id == rfqId);
    final updated = rfq.copyWith(status: RFQStatus.approved);
    await saveRFQ(updated);
  }

  Future<void> convertToPO(String rfqId, String winningQuotationId) async {
    // Business logic to create PO from RFQ/Quotation
    final rfq = rfqs.firstWhere((r) => r.id == rfqId);
    final updated = rfq.copyWith(status: RFQStatus.converted);
    await saveRFQ(updated);
  }
}
