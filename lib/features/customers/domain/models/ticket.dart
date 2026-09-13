enum TicketPriority { low, medium, high, critical }

enum TicketStatus {
  new_ticket,
  assigned,
  inProgress,
  waiting,
  resolved,
  closed
}

class Ticket {
  final String id;
  final String ticketNumber;
  final String subject;
  final String? description;
  final String customerId;
  final TicketPriority priority;
  final TicketStatus status;
  final String category;
  final String? assignedToId;
  final DateTime createdAt;
  final DateTime? resolvedAt;
  final DateTime slaDeadline;
  final bool isSlaBreached;
  final List<String> resolutionNotes;

  const Ticket({
    required this.id,
    required this.ticketNumber,
    required this.subject,
    this.description,
    required this.customerId,
    this.priority = TicketPriority.medium,
    this.status = TicketStatus.new_ticket,
    required this.category,
    this.assignedToId,
    required this.createdAt,
    this.resolvedAt,
    required this.slaDeadline,
    this.isSlaBreached = false,
    this.resolutionNotes = const [],
  });
}
