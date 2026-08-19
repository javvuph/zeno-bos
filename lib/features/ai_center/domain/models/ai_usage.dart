class AIUsage {
  final String id;
  final String modelId;
  final String userId;
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;
  final double estimatedCost;
  final DateTime timestamp;

  const AIUsage({
    required this.id,
    required this.modelId,
    required this.userId,
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
    required this.estimatedCost,
    required this.timestamp,
  });
}

class AICost {
  final String usageId;
  final double amount;
  final String currency;

  const AICost({
    required this.usageId,
    required this.amount,
    this.currency = 'USD',
  });
}
