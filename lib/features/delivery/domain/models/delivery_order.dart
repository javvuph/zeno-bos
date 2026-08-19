import 'gps_location.dart';

enum DeliveryStatus {
  pending,
  assigned,
  picked_up,
  out_for_delivery,
  delivered,
  failed,
  redelivery_scheduled,
  rto
}

class DeliveryOrder {
  final String id;
  final String salesOrderId;
  final String customerId;
  final String address;
  final GPSLocation? destinationGps;
  final DeliveryStatus status;
  final DateTime? expectedDeliveryTime;
  final Map<String, dynamic> aiOptimizationData;

  const DeliveryOrder({
    required this.id,
    required this.salesOrderId,
    required this.customerId,
    required this.address,
    this.destinationGps,
    this.status = DeliveryStatus.pending,
    this.expectedDeliveryTime,
    this.aiOptimizationData = const {},
  });
}
