import 'package:flutter/material.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../../domain/models/expense_entry.dart';
import '../../domain/models/expense_claim.dart';
import '../../domain/models/expense_status.dart';
import '../../domain/services/finance_master_data_service.dart';

class ExpenseController extends ChangeNotifier {
  final IFinanceRepository _repository;
  final FinanceMasterDataService _masterData = FinanceMasterDataService();

  ExpenseController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ExpenseEntry> _expenses = [];
  List<ExpenseEntry> get expenses =>
      _expenses.isEmpty ? _masterData.getMockExpenses() : _expenses;

  List<ExpenseClaim> _claims = [];
  List<ExpenseClaim> get claims =>
      _claims.isEmpty ? _masterData.getMockClaims() : _claims;

  ExpenseEntry? _selectedExpense;
  ExpenseEntry? get selectedExpense => _selectedExpense;

  // KPI Bridges
  double get totalExpenses => expenses.fold(0, (sum, e) => sum + e.amount);
  int get pendingApprovalsCount =>
      claims.where((c) => c.status == ExpenseStatus.pendingApproval).length;

  Future<void> loadExpenses() async {
    _isLoading = true;
    notifyListeners();
    try {
      _expenses = await _repository.getExpenses();
      _claims = await _repository.getExpenseClaims();
    } catch (e) {
      debugPrint("Error loading expenses: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectExpense(ExpenseEntry expense) {
    _selectedExpense = expense;
    notifyListeners();
  }

  Future<void> approveClaim(String claimId) async {
    final index = _claims.indexWhere((c) => c.id == claimId);
    if (index != -1) {
      _claims[index] = _claims[index].copyWith(
          status: ExpenseStatus.approved,
          approvedById: 'admin',
          approvalDate: DateTime.now());
      notifyListeners();
    }
  }
}
