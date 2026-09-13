enum AIProviderType { gemini, openai, claude, local }

class AIProvider {
  final String id;
  final String name;
  final AIProviderType type;
  final String? apiKey;
  final String? baseUrl;
  final bool isActive;

  const AIProvider({
    required this.id,
    required this.name,
    required this.type,
    this.apiKey,
    this.baseUrl,
    this.isActive = true,
  });
}
