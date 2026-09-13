enum LocationType { zone, aisle, rack, shelf, bin }

class StorageLocation {
  final String id;
  final String warehouseId;
  final String name;
  final String? parentId;
  final LocationType type;
  final int sequence;

  const StorageLocation({
    required this.id,
    required this.warehouseId,
    required this.name,
    this.parentId,
    required this.type,
    this.sequence = 0,
  });
}
