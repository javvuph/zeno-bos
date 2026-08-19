import 'ai_prompt.dart';
import 'ai_response.dart';

class AIConversation {
  final String id;
  final String title;
  final DateTime createdAt;
  final List<AIInteraction> history;
  final String? systemPrompt;
  final String? moduleContext;

  const AIConversation({
    required this.id,
    required this.title,
    required this.createdAt,
    this.history = const [],
    this.systemPrompt,
    this.moduleContext,
  });
}

class AIInteraction {
  final AIPrompt prompt;
  final AIResponse response;
  final DateTime timestamp;

  const AIInteraction({
    required this.prompt,
    required this.response,
    required this.timestamp,
  });
}
