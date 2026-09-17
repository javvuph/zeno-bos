import 'package:flutter/material.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../../domain/models/tax_rule.dart';
import '../../domain/models/tax_return.dart';
import '../../domain/services/finance_master_data_service.dart';

class TaxController extends ChangeNotifier {
  final IFinanceRepository _repository;
  final FinanceMasterDataService _masterData = FinanceMasterDataService();

  TaxController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<TaxRule> _taxRules = [];
  List<TaxRule> get taxRules =>
      _taxRules.isEmpty ? _masterData.getMockTaxRules() : _taxRules;

  List<TaxReturn> _taxReturns = [];
  List<TaxReturn> get taxReturns =>
      _taxReturns.isEmpty ? _masterData.getMockTaxReturns() : _taxReturns;

  TaxRule? _selectedRule;
  TaxRule? get selectedRule => _selectedRule;

  // KPI Bridges
  double get gstCollected => 0.0;
  double get gstPayable => 0.0;
  double get complianceRate => 0.0;

  Future<void> loadTaxManagement() async {
    _isLoading = true;
    notifyListeners();
    try {
      _taxRules = await _repository.getTaxRules();
      _taxReturns = await _repository.getTaxReturns();
    } catch (e) {
      debugPrint("Error loading tax management: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectTaxRule(TaxRule rule) {
    _selectedRule = rule;
    notifyListeners();
  }

  Future<void> saveTaxRule(TaxRule rule) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveTaxRule(rule);
      await loadTaxManagement();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
