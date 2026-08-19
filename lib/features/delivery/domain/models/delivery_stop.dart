import 'delivery_order.dart';

class DeliveryStop {
  final String deliveryOrderId;
  final int sequence;
  final DeliveryStatus status;
  final DateTime? arrivalTime;
  final DateTime? departureTime;

  const DeliveryStop({
    required this.deliveryOrderId,
    required this.sequence,
    this.status = DeliveryStatus.pending,
    this.arrivalTime,
    this.departureTime,
  });
}
