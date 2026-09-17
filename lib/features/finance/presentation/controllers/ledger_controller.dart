import 'package:flutter/material.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../../domain/models/journal_entry.dart';
import '../../domain/models/trial_balance.dart';
import '../../domain/services/financial_engine.dart';
import '../../domain/services/finance_master_data_service.dart';

class LedgerController extends ChangeNotifier {
  final IFinanceRepository _repository;
  final FinancialEngine _engine = FinancialEngine();
  final FinanceMasterDataService _masterData = FinanceMasterDataService();

  LedgerController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<JournalEntry> _journalEntries = [];
  List<JournalEntry> get journalEntries =>
      _journalEntries.isEmpty ? _masterData.getMockEntries() : _journalEntries;

  TrialBalance? _trialBalance;
  TrialBalance? get trialBalance => _trialBalance;

  // KPI Bridges
  double get totalAssets => 0.0;
  double get netProfit => 0.0;

  Future<void> loadLedger() async {
    _isLoading = true;
    notifyListeners();
    try {
      _journalEntries = await _repository.getAllJournalEntries();
      final accounts = await _repository.getChartOfAccounts();
      _trialBalance = _engine.generateTrialBalance(accounts);
    } catch (e) {
      debugPrint("Error loading ledger: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> postJournal(JournalEntry entry) async {
    if (!_engine.validateEntry(entry)) {
      throw Exception(
          "Double-entry validation failed: Debits must equal Credits.");
    }
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.postJournalEntry(entry);
      await loadLedger();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
