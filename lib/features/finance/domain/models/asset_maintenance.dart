enum MaintenanceStatus { scheduled, inProgress, completed, cancelled }

class AssetMaintenance {
  final String id;
  final String assetId;
  final DateTime maintenanceDate;
  final String description;
  final double cost;
  final MaintenanceStatus status;
  final String? vendorName;

  const AssetMaintenance({
    required this.id,
    required this.assetId,
    required this.maintenanceDate,
    required this.description,
    required this.cost,
    required this.status,
    this.vendorName,
  });
}
