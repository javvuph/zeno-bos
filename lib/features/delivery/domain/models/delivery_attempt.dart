import 'delivery_order.dart';

class DeliveryAttempt {
  final String id;
  final String deliveryOrderId;
  final DateTime timestamp;
  final DeliveryStatus status; // Usually 'delivered' or 'failed'
  final String? failureReason;
  final bool canRedeliver;

  const DeliveryAttempt({
    required this.id,
    required this.deliveryOrderId,
    required this.timestamp,
    required this.status,
    this.failureReason,
    this.canRedeliver = true,
  });
}
