class ReturnToOrigin {
  final String id;
  final String deliveryOrderId;
  final String reason;
  final String targetWarehouseId;
  final DateTime timestamp;
  final bool isReceivedAtWarehouse;

  const ReturnToOrigin({
    required this.id,
    required this.deliveryOrderId,
    required this.reason,
    required this.targetWarehouseId,
    required this.timestamp,
    this.isReceivedAtWarehouse = false,
  });
}
