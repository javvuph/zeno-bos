import 'package:flutter/material.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../../domain/models/budget.dart';
import '../../domain/models/cost_center.dart';
import '../../domain/services/finance_master_data_service.dart';

class BudgetController extends ChangeNotifier {
  final IFinanceRepository _repository;
  final FinanceMasterDataService _masterData = FinanceMasterDataService();

  BudgetController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Budget> _budgets = [];
  List<Budget> get budgets =>
      _budgets.isEmpty ? _masterData.getMockBudgets() : _budgets;

  List<CostCenter> _costCenters = [];
  List<CostCenter> get costCenters =>
      _costCenters.isEmpty ? _masterData.getMockCostCenters() : _costCenters;

  Budget? _selectedBudget;
  Budget? get selectedBudget => _selectedBudget;

  // KPI Bridges
  double get totalBudget =>
      budgets.fold(0, (sum, b) => sum + b.allocatedAmount);
  double get budgetUtilized =>
      budgets.fold(0, (sum, b) => sum + b.utilizedAmount);

  Future<void> loadBudgets() async {
    _isLoading = true;
    notifyListeners();
    try {
      _budgets = await _repository.getBudgets();
      _costCenters = await _repository.getCostCenters();
    } catch (e) {
      debugPrint("Error loading budgets: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectBudget(Budget budget) {
    _selectedBudget = budget;
    notifyListeners();
  }

  Future<void> reviseBudget(Budget budget) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveBudget(budget);
      await loadBudgets();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
