import 'package:flutter/material.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../../domain/models/account.dart';
import '../../domain/models/journal_entry.dart';
import '../../domain/models/trial_balance.dart';
import '../../domain/services/financial_engine.dart';
import '../../domain/services/finance_master_data_service.dart';

class FinanceController extends ChangeNotifier {
  final IFinanceRepository _repository;
  final FinancialEngine _engine = FinancialEngine();
  final FinanceMasterDataService _masterData = FinanceMasterDataService();

  FinanceController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Account> _accounts = [];
  List<Account> get accounts =>
      _accounts.isEmpty ? _masterData.getMockAccounts() : _accounts;

  final List<JournalEntry> _entries = [];
  List<JournalEntry> get entries =>
      _entries.isEmpty ? _masterData.getMockEntries() : _entries;

  // KPI Bridges
  double get operatingCash => (kpis['cash_on_hand'] as double?) ?? 0.0;
  double get totalReceivables => accounts
      .where((a) => a.type == AccountType.receivable)
      .fold(0.0, (sum, a) => sum + a.currentBalance);

  Map<String, dynamic> get kpis => _engine.calculateKPIs(accounts);

  // Reports State
  Map<String, dynamic>? _pAndL;
  Map<String, dynamic>? get pAndL => _pAndL;

  Map<String, dynamic>? _balanceSheet;
  Map<String, dynamic>? get balanceSheet => _balanceSheet;

  TrialBalance? _trialBalance;
  TrialBalance? get trialBalance => _trialBalance;

  Future<void> generateFinancialReports() async {
    _isLoading = true;
    notifyListeners();
    try {
      final accs = await _repository.getChartOfAccounts();
      _trialBalance = _engine.generateTrialBalance(accs);
      _pAndL = _engine.generateProfitAndLoss(accs);
      _balanceSheet = _engine.generateBalanceSheet(accs);
    } catch (e) {
      debugPrint("Error generating reports: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadChartOfAccounts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _accounts = await _repository.getChartOfAccounts();
    } catch (e) {
      debugPrint("Error loading COA: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Automatically generates accounting entries for a business event
  Future<void> syncBusinessEvent(JournalEntry entry) async {
    if (_engine.validateEntry(entry)) {
      await _repository.postJournalEntry(entry);
      await loadChartOfAccounts(); // Refresh
      notifyListeners();
    }
  }

  Future<void> saveAccount(Account account) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveAccount(account);
      await loadChartOfAccounts();
    } catch (e) {
      debugPrint("Error saving account: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createJournalEntry(JournalEntry entry) async {
    _isLoading = true;
    notifyListeners();
    try {
      if (_engine.validateEntry(entry)) {
        await _repository.postJournalEntry(entry);
        await loadChartOfAccounts();
      }
    } catch (e) {
      debugPrint("Error saving journal: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
