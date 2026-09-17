import 'package:flutter/material.dart';
import '../../domain/models/customer.dart';
import '../../domain/models/customer_segment.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../../domain/services/customer_business_logic.dart';
import '../../domain/services/crm_master_data_service.dart';

class CustomerController extends ChangeNotifier {
  final ICustomerRepository _repository;
  final CustomerBusinessLogic _logic = CustomerBusinessLogic();
  final CRMMasterDataService _masterData = CRMMasterDataService();

  CustomerController(this._repository) {
    loadCustomers();
  }

  List<Customer> _customers = [];
  List<Customer> get customers => _customers;

  List<Customer> _deletedCustomers = [];
  List<Customer> get deletedCustomers => _deletedCustomers;

  final List<CustomerSegment> _groups = [];
  List<CustomerSegment> get groups =>
      _groups.isEmpty ? _masterData.getSegments() : _groups;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  // Analytics Bridges
  double get totalReceivables =>
      customers.fold(0, (sum, c) => sum + c.credit.currentBalance);
  int get vipCount => customers.where((c) => c.tier == CustomerTier.vip).length;

  /// Performs an in-memory search across key fields
  List<Customer> search(String query) {
    if (query.isEmpty) return customers;
    final q = query.toLowerCase();
    return customers
        .where((c) =>
            c.name.toLowerCase().contains(q) ||
            c.email.toLowerCase().contains(q) ||
            c.phone.contains(q) ||
            (c.companyName?.toLowerCase().contains(q) ?? false))
        .toList();
  }

  /// Calculates profile completion for a customer
  double getReadiness(Customer customer) => _logic.calculateReadiness(customer);

  /// Validates credit availability
  bool canAfford(Customer customer, double amount) =>
      _logic.hasEnoughCredit(customer, amount);

  Future<void> loadCustomers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _customers = await _repository.getAllCustomers();
      _deletedCustomers = await _repository.getDeletedCustomers();
      // _groups = await _repository.getGroups(); // Handled by master data
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCustomer(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.deleteCustomer(id);
      await loadCustomers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> restoreCustomer(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.restoreCustomer(id);
      await loadCustomers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveCustomer(Customer customer) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveCustomer(customer);
      await loadCustomers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveGroup(CustomerSegment group) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveGroup(group);
      await loadCustomers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
