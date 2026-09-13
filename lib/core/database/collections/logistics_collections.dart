import 'package:isar/isar.dart';

part 'logistics_collections.g.dart';

@collection
class DeliveryOrderCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String salesOrderId;

  @Index()
  late String customerId;

  late String address;

  @Index()
  late String
      status; // pending, assigned, picked_up, out_for_delivery, delivered, failed, returned, cancelled

  DateTime? expectedTime;
  DateTime? pickedUpTime;
  DateTime? actualTime; // deliveredTime

  String? driverId;
  String? vehicleId;

  String? otp;
  String? signatureUrl;
  String? notes;
  double deliveryCharges = 0.0;
}

@collection
class VehicleCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String plateNumber;

  late String model;
  late String type; // bike, van, truck

  bool isActive = true;
}

@collection
class DriverCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  late String phone;
  late String licenseNumber;

  @Index()
  late String status; // on_duty, off_duty, on_break
}
