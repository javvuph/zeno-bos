import 'package:isar/isar.dart';
import 'package:zeno/core/database/collections/transaction_collections.dart';

class FashionAnalyticsService {
  final Isar _isar;

  FashionAnalyticsService(this._isar);

  Future<Map<String, double>> calculateSizeCurve(String productId, {DateTime? startDate, DateTime? endDate}) async {
    final query = _isar.collection<SalesOrderCollection>()
        .filter()
        .itemsElement((q) => q.productIdEqualTo(productId));
    
    // Applying date filters if provided
    var filteredQuery = query;
    if (startDate != null) filteredQuery = filteredQuery.and().dateGreaterThan(startDate);
    if (endDate != null) filteredQuery = filteredQuery.and().dateLessThan(endDate);

    final orders = await filteredQuery.findAll();
    
    Map<String, double> sizeCounts = {};
    double totalQty = 0;

    for (var order in orders) {
      if (order.items == null) continue;
      for (var item in order.items!) {
        if (item.productId == productId && item.variantId != null) {
          // Assuming variantId contains size info or we need to look up variant
          // For this implementation, we extract from variantId if it follows pattern "$productId-$color-$size"
          final parts = item.variantId!.split('-');
          if (parts.length >= 3) {
            final size = parts.last;
            sizeCounts[size] = (sizeCounts[size] ?? 0) + item.quantity;
            totalQty += item.quantity;
          }
        }
      }
    }

    if (totalQty == 0) return {};
    return sizeCounts.map((key, value) => MapEntry(key, (value / totalQty)));
  }

  Future<Map<String, double>> calculateColorCurve(String productId) async {
     final orders = await _isar.collection<SalesOrderCollection>()
        .filter()
        .itemsElement((q) => q.productIdEqualTo(productId))
        .findAll();
    
    Map<String, double> colorCounts = {};
    double totalQty = 0;

    for (var order in orders) {
      if (order.items == null) continue;
      for (var item in order.items!) {
        if (item.productId == productId && item.variantId != null) {
          final parts = item.variantId!.split('-');
          if (parts.length >= 3) {
            final color = parts[parts.length - 2];
            colorCounts[color] = (colorCounts[color] ?? 0) + item.quantity;
            totalQty += item.quantity;
          }
        }
      }
    }

    if (totalQty == 0) return {};
    return colorCounts.map((key, value) => MapEntry(key, (value / totalQty)));
  }
}
