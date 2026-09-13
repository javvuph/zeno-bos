import 'package:flutter/material.dart';
import '../../domain/repositories/i_sales_repository.dart';
import '../../domain/models/sales_order.dart';
import '../../domain/models/sales_order_status.dart';
import '../../domain/models/sales_quotation.dart';
import '../../domain/services/sales_business_logic.dart';
import '../../domain/services/sales_master_data_service.dart';
import 'package:zeno/features/delivery/domain/models/delivery_order.dart';
import 'package:zeno/features/delivery/domain/repositories/i_delivery_repository.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:uuid/uuid.dart';

class SalesController extends ChangeNotifier {
  final ISalesRepository _repository;
  final IDeliveryRepository _deliveryRepository = sl<IDeliveryRepository>();
  final SalesBusinessLogic _logic = SalesBusinessLogic();
  final SalesMasterDataService _masterData = SalesMasterDataService();

  SalesController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SalesOrder> _orders = [];
  List<SalesOrder> get orders =>
      _orders.isEmpty ? _masterData.getMockOrders() : _orders;

  final List<SalesQuotation> _quotations = [];
  List<SalesQuotation> get quotations =>
      _quotations.isEmpty ? _masterData.getMockQuotations() : _quotations;

  // KPI Bridges
  double get totalSalesVolume =>
      orders.fold(0, (sum, o) => sum + o.totalAmount);
  int get activeOrderCount => orders.length;

  Future<void> loadOrders() async {
    _isLoading = true;
    notifyListeners();
    try {
      _orders = await _repository.getOrders();
    } catch (e) {
      debugPrint("Error loading orders: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Calculates the readiness for a specific order
  double getOrderReadiness(SalesOrder order) =>
      _logic.calculateOrderReadiness(order);

  Future<void> saveOrder(SalesOrder order) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveOrder(order);
      await loadOrders();
    } catch (e) {
      debugPrint("Error saving order: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> processFulfillment(String orderId) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoading = false;
    notifyListeners();
  }

  Future<void> dispatchOrder(SalesOrder order) async {
    _isLoading = true;
    notifyListeners();
    try {
      // 1. Create Delivery Order
      final delivery = DeliveryOrder(
        id: 'DEL-${const Uuid().v4().substring(0, 8).toUpperCase()}',
        salesOrderId: order.id,
        customerId: order.customerId,
        address: "CUSTOMER MAIN ADDRESS", // Needs real address from CRM
        status: DeliveryStatus.pending,
        expectedDeliveryTime: DateTime.now().add(const Duration(days: 1)),
      );
      await _deliveryRepository.saveDeliveryOrder(delivery);

      // 2. Update Sales Order Status
      final updatedOrder = SalesOrder(
        id: order.id,
        customerId: order.customerId,
        warehouseId: order.warehouseId,
        items: order.items,
        currency: order.currency,
        orderDate: order.orderDate,
        status: SalesOrderStatus.shipped,
        totalAmount: order.totalAmount,
        totalTax: order.totalTax,
      );
      await _repository.saveOrder(updatedOrder);

      await loadOrders();
    } catch (e) {
      debugPrint("Dispatch Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteOrder(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.deleteOrder(id);
      await loadOrders();
    } catch (e) {
      debugPrint("Delete Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
