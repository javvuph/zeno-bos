import '../models/sales_item.dart';
import '../models/sales_order.dart';
import '../models/sales_order_status.dart';
import '../models/shipment.dart';

class SalesBusinessLogic {
  /// Calculates total tax and amount for a list of sales items
  double calculateTotalTax(List<SalesItem> items) =>
      items.fold(0.0, (sum, item) => sum + item.taxAmount);
  double calculateTotalAmount(List<SalesItem> items) =>
      items.fold(0.0, (sum, item) => sum + item.total);

  /// Determines the next logical status for an order based on fulfillment
  SalesOrderStatus calculateNextStatus(
      SalesOrder order, List<Shipment> shipments) {
    if (order.status == SalesOrderStatus.cancelled) {
      return SalesOrderStatus.cancelled;
    }

    bool hasShipments = shipments.isNotEmpty;
    if (!hasShipments) return order.status;

    bool allDelivered = true;
    bool partial = false;

    for (var orderItem in order.items) {
      double totalShipped = 0;
      for (var shipment in shipments) {
        if (shipment.status == ShipmentStatus.delivered) {
          for (var shipItem in shipment.items) {
            if (shipItem.variantId == orderItem.variantId) {
              totalShipped += shipItem.quantity;
            }
          }
        }
      }
      if (totalShipped < orderItem.quantity) {
        allDelivered = false;
        if (totalShipped > 0) partial = true;
      }
    }

    if (allDelivered) return SalesOrderStatus.delivered;
    if (partial) {
      return SalesOrderStatus
          .processing; // Or a specific 'partially_shipped' if added
    }
    return SalesOrderStatus.shipped;
  }

  /// Calculates order readiness (0.0 to 1.0) based on critical criteria
  double calculateOrderReadiness(SalesOrder order) {
    int points = 0;
    int total = 100;

    if (order.customerId.isNotEmpty) points += 20;
    if (order.items.isNotEmpty) points += 30;
    if (order.warehouseId.isNotEmpty) points += 20;
    if (order.totalAmount > 0) points += 30;

    return points / total;
  }

  /// Identifies back-order items (items where ordered > fulfilled)
  List<SalesItem> getBackOrderItems(SalesOrder order) {
    return order.items.where((item) => item.pendingQuantity > 0).toList();
  }

  /// Detects potential duplicate orders based on customer and recent timestamp
  bool isPotentialDuplicate(SalesOrder a, SalesOrder b) {
    if (a.id == b.id) return false;
    final sameCustomer = a.customerId == b.customerId;
    final sameAmount = a.totalAmount == b.totalAmount;
    final withinTime = a.orderDate.difference(b.orderDate).inMinutes.abs() < 30;
    return sameCustomer && sameAmount && withinTime;
  }

  /// Formats an audit trail entry for a specific status change
  String formatAuditTrail(String orderId, SalesOrderStatus oldStatus,
      SalesOrderStatus newStatus, String userId) {
    return "[AUDIT] ORDER $orderId | STATUS: ${oldStatus.name} -> ${newStatus.name} | USER: $userId | TIMESTAMP: ${DateTime.now().toIso8601String()}";
  }
}
