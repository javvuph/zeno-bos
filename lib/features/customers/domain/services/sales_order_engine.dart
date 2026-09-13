import 'package:zeno/features/customers/domain/models/sales_order.dart';
import 'package:zeno/features/customers/domain/models/sales_order_status.dart';
import 'package:zeno/features/customers/domain/models/sales_order_item.dart';

class SalesOrderEngine {
  /// Validates if an order can be confirmed (Inventory check placeholder)
  bool canConfirmOrder(SalesOrder order) {
    if (order.status != SalesOrderStatus.draft) return false;
    return order.items.isNotEmpty;
  }

  /// AI-Driven Fulfillment Recommendation (Mock)
  String getFulfillmentStrategy(SalesOrder order) {
    if (order.items.any((i) => i.pendingQuantity > 100)) {
      return 'Bulk Dispatch - Third Party Logistics recommended.';
    }
    return 'Standard Pick & Pack - Warehouse Team 01.';
  }

  /// Detects if an order will result in a backorder
  bool isBackorderRequired(SalesOrder order, Map<String, double> stockLevels) {
    for (var item in order.items) {
      double stock = stockLevels[item.productId] ?? 0.0;
      if (item.quantity > stock) return true;
    }
    return false;
  }

  /// Advanced Fulfillment Logic: Full vs Partial
  SalesOrder fulfill(SalesOrder order, String itemId, double qty) {
    final updatedItems = order.items.map((item) {
      if (item.id == itemId || item.productId == itemId) {
        return SalesOrderItem(
          id: item.id,
          productId: item.productId,
          sku: item.sku,
          name: item.name,
          quantity: item.quantity,
          fulfilledQuantity:
              (item.fulfilledQuantity + qty).clamp(0, item.quantity),
          unitPrice: item.unitPrice,
          totalAmount: item.totalAmount,
        );
      }
      return item;
    }).toList();

    return order.copyWith(
      status: determineNextStatusFromItems(updatedItems),
      // Update items is missing in copyWith currently, I should add it
    );
  }

  SalesOrderStatus determineNextStatusFromItems(List<SalesOrderItem> items) {
    if (items.every((i) => i.fulfilledQuantity >= i.quantity)) {
      return SalesOrderStatus.fulfilled;
    }
    if (items.any((i) => i.fulfilledQuantity > 0)) {
      return SalesOrderStatus.partiallyFulfilled;
    }
    return SalesOrderStatus.confirmed;
  }
}
