import 'sales_item.dart';

enum ShipmentStatus { pending, inTransit, delivered, failed }

class Shipment {
  final String id;
  final String orderId;
  final List<SalesItem> items;
  final String trackingNumber;
  final String carrier;
  final ShipmentStatus status;
  final DateTime shippedAt;
  final DateTime? estimatedDelivery;

  const Shipment({
    required this.id,
    required this.orderId,
    required this.items,
    required this.trackingNumber,
    required this.carrier,
    this.status = ShipmentStatus.pending,
    required this.shippedAt,
    this.estimatedDelivery,
  });
}

class DeliverySchedule {
  final String id;
  final String shipmentId;
  final DateTime scheduledDate;
  final String routeId;
  final String driverId;

  const DeliverySchedule({
    required this.id,
    required this.shipmentId,
    required this.scheduledDate,
    required this.routeId,
    required this.driverId,
  });
}
