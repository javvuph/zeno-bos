import '../models/delivery_order.dart';
import '../models/dispatch_plan.dart';
import '../models/driver.dart';
import '../models/vehicle.dart';
import '../models/pod.dart';
import '../models/delivery_attempt.dart';

abstract class IDeliveryRepository {
  // Core Logistics
  Future<List<DeliveryOrder>> getPendingDeliveries();
  Future<void> saveDeliveryOrder(DeliveryOrder order);
  Future<List<DispatchPlan>> getActivePlans();
  Future<void> saveDispatchPlan(DispatchPlan plan);

  // Fleet Management
  Future<List<Driver>> getDrivers();
  Future<void> saveDriver(Driver driver);
  Future<List<Vehicle>> getVehicles();
  Future<void> saveVehicle(Vehicle vehicle);

  // Fulfillment
  Future<void> recordAttempt(DeliveryAttempt attempt);
  Future<void> submitPOD(ProofOfDelivery pod);

  // Real-time
  Future<void> updateDriverLocation(String driverId, double lat, double lng);
}
