import 'dart:async';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:zeno/core/ai/ai_gateway.dart';

class GeminiAIProvider implements AIGateway {
  final String _apiKey;
  late final GenerativeModel _model;

  GeminiAIProvider({required String apiKey}) : _apiKey = apiKey {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
    );
  }

  @override
  String get providerName => 'Google Gemini';

  @override
  Future<AIResponse> prompt(String input,
      {Map<String, dynamic>? context}) async {
    try {
      final content = [Content.text(input)];
      final response = await _model.generateContent(content);

      return AIResponse(
        text: response.text ?? 'No response from Gemini.',
        provider: providerName,
      );
    } catch (e) {
      return AIResponse(
        text: 'Error connecting to Gemini: $e',
        provider: providerName,
      );
    }
  }

  @override
  Stream<String> streamPrompt(String input,
      {Map<String, dynamic>? context}) async* {
    try {
      final content = [Content.text(input)];
      final responses = _model.generateContentStream(content);

      await for (final response in responses) {
        if (response.text != null) {
          yield response.text!;
        }
      }
    } catch (e) {
      yield 'Error: $e';
    }
  }
}
