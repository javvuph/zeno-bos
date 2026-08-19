import 'package:flutter/material.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../../domain/models/accounts_payable.dart';
import '../../domain/models/payment.dart';
import '../../domain/models/payment_status.dart';
import '../../domain/services/payables_business_logic.dart';
import '../../domain/services/finance_master_data_service.dart';

class PayablesController extends ChangeNotifier {
  final IFinanceRepository _repository;
  final PayablesBusinessLogic _logic = PayablesBusinessLogic();
  final FinanceMasterDataService _masterData = FinanceMasterDataService();

  PayablesController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<AccountsPayable> _payables = [];
  List<AccountsPayable> get payables =>
      _payables.isEmpty ? _masterData.getMockPayables() : _payables;

  AccountsPayable? _selectedPayable;
  AccountsPayable? get selectedPayable => _selectedPayable;

  // KPI Bridges
  double get totalOutstanding => payables
      .where((p) => p.status != PaymentStatus.paid)
      .fold(0.0, (sum, p) => sum + p.amount);
  int get overdueCount =>
      payables.where((p) => p.status == PaymentStatus.overdue).length;

  Future<void> loadPayables() async {
    _isLoading = true;
    notifyListeners();
    try {
      _payables = await _repository.getAccountsPayable();
      // AI Priority Sort
      _payables = _logic.prioritizePayments(_payables);
    } catch (e) {
      debugPrint("Error loading payables: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectPayable(AccountsPayable payable) {
    _selectedPayable = payable;
    notifyListeners();
  }

  Future<void> approvePayment(String payableId) async {
    final index = _payables.indexWhere((p) => p.id == payableId);
    if (index != -1) {
      _payables[index] = _payables[index]
          .copyWith(approvalStatus: 'approved', status: PaymentStatus.approved);
      notifyListeners();
    }
  }

  Future<void> executePayment(Payment payment) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.savePayment(payment);
      // Update payable status to paid
      final index = _payables.indexWhere((p) => p.id == payment.payableId);
      if (index != -1) {
        _payables[index] =
            _payables[index].copyWith(status: PaymentStatus.paid);
      }
      await loadPayables();
    } catch (e) {
      debugPrint("Error executing payment: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
