class AIConfig {
  final String provider; // 'openai', 'gemini'
  final String modelName;
  final String apiKey;
  final bool isEnabled;

  const AIConfig({
    required this.provider,
    required this.modelName,
    required this.apiKey,
    this.isEnabled = false,
  });
}

class AIUsageStats {
  final int totalTokens;
  final double totalCost;
  final int requestCount;

  const AIUsageStats({
    this.totalTokens = 0,
    this.totalCost = 0.0,
    this.requestCount = 0,
  });
}
