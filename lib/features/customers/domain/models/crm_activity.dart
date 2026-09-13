enum ActivityType { call, email, meeting, task, visit, demo, negotiation }

enum ActivityPriority { low, medium, high, critical }

enum ActivityStatus { pending, inProgress, completed, cancelled, overdue }

class CRMActivity {
  final String id;
  final String title;
  final String? description;
  final ActivityType type;
  final ActivityPriority priority;
  final ActivityStatus status;
  final DateTime scheduledAt;
  final DateTime? completedAt;
  final String assignedToId;
  final String? customerId;
  final String? leadId;
  final String? opportunityId;
  final String? ticketId;
  final String? salesOrderId;
  final bool reminderEnabled;
  final DateTime? reminderAt;

  const CRMActivity({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    this.priority = ActivityPriority.medium,
    this.status = ActivityStatus.pending,
    required this.scheduledAt,
    this.completedAt,
    required this.assignedToId,
    this.customerId,
    this.leadId,
    this.opportunityId,
    this.ticketId,
    this.salesOrderId,
    this.reminderEnabled = false,
    this.reminderAt,
  });
}
