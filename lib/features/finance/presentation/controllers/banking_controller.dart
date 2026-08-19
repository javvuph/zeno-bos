import 'package:flutter/material.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../../domain/models/bank_account.dart';
import '../../domain/models/bank_transaction.dart';
import '../../domain/services/finance_master_data_service.dart';

class BankingController extends ChangeNotifier {
  final IFinanceRepository _repository;
  final FinanceMasterDataService _masterData = FinanceMasterDataService();

  BankingController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<BankAccount> _accounts = [];
  List<BankAccount> get accounts =>
      _accounts.isEmpty ? _masterData.getMockBankAccounts() : _accounts;

  List<BankTransaction> _transactions = [];
  List<BankTransaction> get transactions => _transactions.isEmpty
      ? _masterData.getMockBankTransactions()
      : _transactions;

  BankAccount? _selectedAccount;
  BankAccount? get selectedAccount => _selectedAccount;

  // KPI Bridges
  double get cashOnHand => accounts
      .where((a) =>
          a.type == BankAccountType.cash || a.type == BankAccountType.vault)
      .fold(0, (sum, a) => sum + a.currentBalance);
  double get bankBalance => accounts
      .where((a) =>
          a.type == BankAccountType.current ||
          a.type == BankAccountType.savings)
      .fold(0, (sum, a) => sum + a.currentBalance);

  Future<void> loadBanking() async {
    _isLoading = true;
    notifyListeners();
    try {
      _accounts = await _repository.getBankAccounts();
      if (_accounts.isNotEmpty) {
        _selectedAccount = _accounts.first;
        _transactions =
            await _repository.getBankTransactions(_selectedAccount!.id);
      }
    } catch (e) {
      debugPrint("Error loading banking: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectAccount(BankAccount account) {
    _selectedAccount = account;
    notifyListeners();
  }

  Future<void> recordTransaction(BankTransaction tx) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.recordBankTransaction(tx);
      await loadBanking();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
