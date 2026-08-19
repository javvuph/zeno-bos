import 'package:flutter/material.dart';
import '../../domain/repositories/i_delivery_repository.dart';
import '../../domain/models/delivery_order.dart';
import '../../domain/models/driver.dart';
import '../../domain/models/vehicle.dart';
import '../../domain/models/pod.dart';
import '../../domain/services/logistics_business_logic.dart';
import '../../domain/services/logistics_master_data_service.dart';
import '../../domain/services/delivery_workflow_service.dart';
import '../../../billing/domain/services/billing_sync_service.dart';
import 'package:zeno/core/di/service_locator.dart';

class DeliveryController extends ChangeNotifier {
  final IDeliveryRepository _repository;
  final LogisticsBusinessLogic _logic = LogisticsBusinessLogic();
  final LogisticsMasterDataService _masterData = LogisticsMasterDataService();
  final DeliveryWorkflowService _workflow = sl<DeliveryWorkflowService>();
  final BillingSyncService _billingSync = sl<BillingSyncService>();

  DeliveryController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<DeliveryOrder> _deliveries = [];
  List<DeliveryOrder> get deliveries =>
      _deliveries.isEmpty ? _masterData.getMockDeliveries() : _deliveries;

  List<Driver> _drivers = [];
  List<Driver> get drivers =>
      _drivers.isEmpty ? _masterData.getMockDrivers() : _drivers;

  List<Vehicle> _vehicles = [];
  List<Vehicle> get vehicles =>
      _vehicles.isEmpty ? _masterData.getMockVehicles() : _vehicles;

  // KPI Bridges
  int get activeDeliveryCount => deliveries
      .where((d) => d.status == DeliveryStatus.out_for_delivery)
      .length;
  int get pendingAssignmentCount =>
      deliveries.where((d) => d.status == DeliveryStatus.pending).length;

  double get fleetOnTimeRate => 0.945; // Mocked for now

  Future<void> loadDeliveries() async {
    _isLoading = true;
    notifyListeners();
    try {
      _deliveries = await _repository.getPendingDeliveries();
      _drivers = await _repository.getDrivers();
      _vehicles = await _repository.getVehicles();
    } catch (e) {
      debugPrint("Error loading deliveries: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Calculates readiness for a specific delivery
  double getDeliveryReadiness(DeliveryOrder order) =>
      _logic.calculateDeliveryReadiness(order);

  Future<void> updateStatus(DeliveryOrder order, DeliveryStatus status) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _workflow.transitionStatus(order, status);
      if (status == DeliveryStatus.delivered) {
        await _billingSync.updateInvoiceStatusUponDelivery(order.salesOrderId);
      }
      await loadDeliveries();
    } catch (e) {
      debugPrint("Error updating status: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> assignAgent(
      DeliveryOrder order, String driverId, String vehicleId) async {
    _isLoading = true;
    notifyListeners();
    try {
      // In production, we'd update these fields in the repo
      await _workflow.transitionStatus(order, DeliveryStatus.assigned);
      await loadDeliveries();
    } catch (e) {
      debugPrint("Error assigning agent: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitPOD(ProofOfDelivery pod) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.submitPOD(pod);
      await loadDeliveries();
    } catch (e) {
      debugPrint("Error submitting POD: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Triggers the route optimization framework
  Future<void> optimizeFleetRoutes() async {
    _isLoading = true;
    notifyListeners();
    // Complex routing algorithm skeleton
    await Future.delayed(const Duration(seconds: 1));
    _isLoading = false;
    notifyListeners();
  }
}
