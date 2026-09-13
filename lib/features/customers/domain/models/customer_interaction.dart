enum InteractionType { call, email, meeting, note, ticket }

class CustomerInteraction {
  final String id;
  final String customerId;
  final InteractionType type;
  final String summary;
  final String? details;
  final DateTime timestamp;
  final String userId;

  const CustomerInteraction({
    required this.id,
    required this.customerId,
    required this.type,
    required this.summary,
    this.details,
    required this.timestamp,
    required this.userId,
  });
}
