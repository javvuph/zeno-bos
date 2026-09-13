class WarehouseZone {
  final String id;
  final String name;
  final String description;
  final bool hasTemperatureControl;

  const WarehouseZone({
    required this.id,
    required this.name,
    this.description = "",
    this.hasTemperatureControl = false,
  });
}

class StorageNode {
  final String id;
  final String zoneId;
  final String aisle;
  final String shelf;
  final String bin;
  final double capacity; // In cubic meters or units
  final double currentLoad;

  const StorageNode({
    required this.id,
    required this.zoneId,
    required this.aisle,
    required this.shelf,
    required this.bin,
    this.capacity = 0.0,
    this.currentLoad = 0.0,
  });

  String get locationCode => "$aisle-$shelf-$bin";
}

class Warehouse {
  final String id;
  final String name;
  final String? address;
  final String? contactNumber;
  final bool isActive;
  final String branchId;
  final List<WarehouseZone> zones;
  final List<StorageNode> nodes;

  const Warehouse({
    required this.id,
    required this.name,
    this.address,
    this.contactNumber,
    this.isActive = true,
    this.branchId = "MAIN-001",
    this.zones = const [],
    this.nodes = const [],
  });
}
