import 'sales_item.dart';

class PickingList {
  final String id;
  final String orderId;
  final String warehouseId;
  final List<PickingItem> items;
  final DateTime generatedAt;
  final String? assignedToId;

  const PickingList({
    required this.id,
    required this.orderId,
    required this.warehouseId,
    required this.items,
    required this.generatedAt,
    this.assignedToId,
  });
}

class PickingItem {
  final SalesItem orderItem;
  final String locationId; // Bin/Shelf
  final double pickQuantity;
  final bool isPicked;

  const PickingItem({
    required this.orderItem,
    required this.locationId,
    required this.pickQuantity,
    this.isPicked = false,
  });
}

class PackingList {
  final String id;
  final String orderId;
  final List<Package> packages;
  final DateTime packedAt;

  const PackingList({
    required this.id,
    required this.orderId,
    required this.packages,
    required this.packedAt,
  });
}

class Package {
  final String packageNumber;
  final List<SalesItem> items;
  final double weight;
  final String dimensions;

  const Package({
    required this.packageNumber,
    required this.items,
    required this.weight,
    required this.dimensions,
  });
}
