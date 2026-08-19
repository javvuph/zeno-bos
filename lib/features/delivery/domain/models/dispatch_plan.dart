class DispatchPlan {
  final String id;
  final String routeId;
  final String driverId;
  final String vehicleId;
  final DateTime scheduledDate;
  final String status; // 'draft', 'published', 'in_progress', 'completed'

  const DispatchPlan({
    required this.id,
    required this.routeId,
    required this.driverId,
    required this.vehicleId,
    required this.scheduledDate,
    this.status = 'draft',
  });
}
