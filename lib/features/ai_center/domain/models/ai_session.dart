class AISession {
  final String id;
  final String userId;
  final String currentModelId;
  final DateTime startTime;
  final DateTime? endTime;

  const AISession({
    required this.id,
    required this.userId,
    required this.currentModelId,
    required this.startTime,
    this.endTime,
  });
}
