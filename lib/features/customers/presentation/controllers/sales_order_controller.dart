import 'package:flutter/material.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../../domain/models/sales_order.dart';
import '../../domain/services/crm_master_data_service.dart';

class SalesOrderController extends ChangeNotifier {
  final ICustomerRepository _repository;
  final CRMMasterDataService _masterData = CRMMasterDataService();

  SalesOrderController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SalesOrder> _orders = [];
  List<SalesOrder> get orders =>
      _orders.isEmpty ? _masterData.getMockOrders() : _orders;

  Future<void> loadOrders() async {
    _isLoading = true;
    notifyListeners();
    try {
      _orders = await _repository.getSalesOrders();
    } catch (e) {
      debugPrint("Error loading sales orders: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveOrder(SalesOrder order) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveSalesOrder(order);
      await loadOrders();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
