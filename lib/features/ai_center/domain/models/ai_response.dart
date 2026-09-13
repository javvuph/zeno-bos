class AIResponse {
  final String content;
  final String modelId;
  final Map<String, dynamic> metadata;
  final bool isError;

  const AIResponse({
    required this.content,
    required this.modelId,
    this.metadata = const {},
    this.isError = false,
  });
}
