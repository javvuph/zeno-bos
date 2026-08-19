import 'dart:async';

/// Abstract interface for AI Providers.
/// Supports switching between OpenAI, Gemini, Claude, and local models.
abstract class AIGateway {
  String get providerName;

  /// Sends a prompt to the AI and returns the response.
  /// [context] can include historical messages or system instructions.
  Future<AIResponse> prompt(String input, {Map<String, dynamic>? context});

  /// Streams the AI response for real-time UI updates.
  Stream<String> streamPrompt(String input, {Map<String, dynamic>? context});
}

class AIResponse {
  final String text;
  final Map<String, dynamic>? rawData; // For structured outputs (JSON)
  final String provider;

  AIResponse({
    required this.text,
    this.rawData,
    required this.provider,
  });
}

/// A Mock Provider for testing and initial development.
class MockAIProvider implements AIGateway {
  @override
  String get providerName => 'MockProvider';

  @override
  Future<AIResponse> prompt(String input,
      {Map<String, dynamic>? context}) async {
    await Future.delayed(const Duration(seconds: 1));
    return AIResponse(
      text: "This is a mock response to: '$input'. AI Integration is pending.",
      provider: providerName,
    );
  }

  @override
  Stream<String> streamPrompt(String input,
      {Map<String, dynamic>? context}) async* {
    final words = "Mock streaming response for: $input".split(' ');
    for (var word in words) {
      await Future.delayed(const Duration(milliseconds: 100));
      yield "$word ";
    }
  }
}
