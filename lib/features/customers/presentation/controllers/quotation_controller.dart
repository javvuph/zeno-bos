import 'package:flutter/material.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../../domain/models/quotation.dart';
import '../../domain/services/crm_master_data_service.dart';

class QuotationController extends ChangeNotifier {
  final ICustomerRepository _repository;
  final CRMMasterDataService _masterData = CRMMasterDataService();

  QuotationController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Quotation> _quotations = [];
  List<Quotation> get quotations =>
      _quotations.isEmpty ? _masterData.getMockQuotations() : _quotations;

  Future<void> loadQuotations() async {
    _isLoading = true;
    notifyListeners();
    try {
      _quotations = await _repository.getQuotations();
    } catch (e) {
      debugPrint("Error loading quotations: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveQuotation(Quotation quote) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveQuotation(quote);
      await loadQuotations();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
