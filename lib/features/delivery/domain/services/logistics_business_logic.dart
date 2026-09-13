import '../models/delivery_order.dart';
import '../models/delivery_stop.dart';
import '../models/route.dart';
import '../models/pod.dart';
import '../models/vehicle.dart';

class LogisticsBusinessLogic {
  /// Validates if a POD is complete based on enterprise requirements
  bool isPODComplete(ProofOfDelivery pod, {bool requireOtp = false}) {
    if (requireOtp && (pod.otp == null || pod.otp!.length < 4)) return false;
    return pod.recipientName.isNotEmpty &&
        (pod.signatureUrl != null || pod.photoUrls.isNotEmpty);
  }

  /// Calculates the next stop in a delivery route
  DeliveryStop? getNextPendingStop(DeliveryRoute route) {
    final pending =
        route.stops.where((s) => s.status == DeliveryStatus.pending).toList();
    pending.sort((a, b) => a.sequence.compareTo(b.sequence));
    return pending.isNotEmpty ? pending.first : null;
  }

  /// Simple ETA calculation based on remaining stops and average time per stop
  DateTime calculateETA(DeliveryStop stop, int averageStopMinutes) {
    return DateTime.now()
        .add(Duration(minutes: averageStopMinutes * stop.sequence));
  }

  /// Calculates driver performance score (0.0 to 1.0)
  double calculateDriverScore(int successfulDeliveries, int totalDeliveries) {
    if (totalDeliveries == 0) return 0.0;
    return successfulDeliveries / totalDeliveries;
  }

  /// Evaluates vehicle capacity for a route load
  bool isVehicleCapable(Vehicle vehicle, double loadWeight, double loadVolume) {
    return vehicle.maxWeightCapacity >= loadWeight &&
        vehicle.maxVolumeCapacity >= loadVolume;
  }

  /// Calculates delivery readiness score (0.0 to 1.0)
  double calculateDeliveryReadiness(DeliveryOrder order) {
    int points = 0;
    int total = 100;

    if (order.address.isNotEmpty) points += 30;
    if (order.destinationGps != null) points += 30;
    if (order.customerId.isNotEmpty) points += 20;
    if (order.expectedDeliveryTime != null) points += 20;

    return points / total;
  }

  /// Transitions delivery status based on operational events
  DeliveryStatus getNextStatus(DeliveryStatus current, String action) {
    switch (action) {
      case 'ASSIGN':
        return DeliveryStatus.assigned;
      case 'PICK_UP':
        return DeliveryStatus.picked_up;
      case 'START_DELIVERY':
        return DeliveryStatus.out_for_delivery;
      case 'MARK_DELIVERED':
        return DeliveryStatus.delivered;
      case 'MARK_FAILED':
        return DeliveryStatus.failed;
      case 'SCHEDULE_REDELIVERY':
        return DeliveryStatus.redelivery_scheduled;
      case 'INITIATE_RTO':
        return DeliveryStatus.rto;
      default:
        return current;
    }
  }

  /// Formats an audit trail event for logistics tracking
  String formatLogisticsAudit(String deliveryId, String action, String userId) {
    return "[LOGISTICS] DEL-$deliveryId | ACTION: $action | USER: $userId | TIMESTAMP: ${DateTime.now().toIso8601String()}";
  }
}
