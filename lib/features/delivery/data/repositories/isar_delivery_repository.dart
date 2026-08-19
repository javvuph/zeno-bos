import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/logistics_collections.dart';
import '../../domain/repositories/i_delivery_repository.dart';
import '../../domain/models/delivery_order.dart';
import '../../domain/models/dispatch_plan.dart';
import '../../domain/models/driver.dart';
import '../../domain/models/vehicle.dart';
import '../../domain/models/pod.dart';
import '../../domain/models/delivery_attempt.dart';
import 'package:isar/isar.dart';

class IsarDeliveryRepository implements IDeliveryRepository {
  final DatabaseService db;
  IsarDeliveryRepository(this.db);

  IsarCollection<DeliveryOrderCollection> get delCol =>
      db.isar.collection<DeliveryOrderCollection>();
  IsarCollection<DriverCollection> get drvCol =>
      db.isar.collection<DriverCollection>();
  IsarCollection<VehicleCollection> get vhcCol =>
      db.isar.collection<VehicleCollection>();

  @override
  Future<List<DeliveryOrder>> getPendingDeliveries() async {
    final results = await delCol
        .filter()
        .statusLessThan(DeliveryStatus.delivered.name)
        .findAll();
    return results.map((e) => _toDomain(e)).toList();
  }

  @override
  Future<void> saveDeliveryOrder(DeliveryOrder order) async {
    final existing = await delCol.filter().uuidEqualTo(order.id).findFirst();
    final entry = (existing ?? DeliveryOrderCollection())
      ..uuid = order.id
      ..salesOrderId = order.salesOrderId
      ..customerId = order.customerId
      ..address = order.address
      ..status = order.status.name
      ..expectedTime = order.expectedDeliveryTime;

    await db.isar.writeTxn(() async {
      await delCol.put(entry);
    });
  }

  @override
  Future<List<DispatchPlan>> getActivePlans() async => [];

  @override
  Future<void> saveDispatchPlan(DispatchPlan plan) async {}

  @override
  Future<List<Driver>> getDrivers() async {
    final results = await drvCol.where().findAll();
    return results
        .map((e) => Driver(
              id: e.uuid,
              name: e.name,
              phone: e.phone,
              licenseNumber: e.licenseNumber,
              status: e.status,
            ))
        .toList();
  }

  @override
  Future<void> saveDriver(Driver driver) async {
    final existing = await drvCol.filter().uuidEqualTo(driver.id).findFirst();
    final entry = (existing ?? DriverCollection())
      ..uuid = driver.id
      ..name = driver.name
      ..phone = driver.phone
      ..licenseNumber = driver.licenseNumber
      ..status = driver.status;

    await db.isar.writeTxn(() async {
      await drvCol.put(entry);
    });
  }

  @override
  Future<List<Vehicle>> getVehicles() async {
    final results = await vhcCol.where().findAll();
    return results
        .map((e) => Vehicle(
              id: e.uuid,
              plateNumber: e.plateNumber,
              model: e.model,
              type: VehicleType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => VehicleType.van),
              maxWeightCapacity: 1000.0,
              maxVolumeCapacity: 10.0,
              isActive: e.isActive,
            ))
        .toList();
  }

  @override
  Future<void> saveVehicle(Vehicle vehicle) async {
    final existing = await vhcCol.filter().uuidEqualTo(vehicle.id).findFirst();
    final entry = (existing ?? VehicleCollection())
      ..uuid = vehicle.id
      ..plateNumber = vehicle.plateNumber
      ..model = vehicle.model
      ..type = vehicle.type.name
      ..isActive = vehicle.isActive;

    await db.isar.writeTxn(() async {
      await vhcCol.put(entry);
    });
  }

  @override
  Future<void> recordAttempt(DeliveryAttempt attempt) async {}

  @override
  Future<void> submitPOD(ProofOfDelivery pod) async {
    final order =
        await delCol.filter().uuidEqualTo(pod.deliveryOrderId).findFirst();
    if (order != null) {
      order.status = 'delivered';
      order.actualTime = pod.timestamp;
      order.otp = pod.otp;
      order.signatureUrl = pod.signatureUrl;

      await db.isar.writeTxn(() async {
        await delCol.put(order);
      });
    }
  }

  @override
  Future<void> updateDriverLocation(
      String driverId, double lat, double lng) async {}

  DeliveryOrder _toDomain(DeliveryOrderCollection e) {
    return DeliveryOrder(
      id: e.uuid,
      salesOrderId: e.salesOrderId,
      customerId: e.customerId,
      address: e.address,
      status: DeliveryStatus.values.firstWhere((s) => s.name == e.status,
          orElse: () => DeliveryStatus.pending),
      expectedDeliveryTime: e.expectedTime,
    );
  }
}
