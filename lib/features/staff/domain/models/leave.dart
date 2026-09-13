enum LeaveStatus { pending, approved, rejected, cancelled }

class LeaveRequest {
  final String id;
  final String employeeId;
  final String type; // e.g., Sick, Casual, Earned
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final LeaveStatus status;
  final String? approvedById;

  const LeaveRequest({
    required this.id,
    required this.employeeId,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.reason,
    this.status = LeaveStatus.pending,
    this.approvedById,
  });
}
