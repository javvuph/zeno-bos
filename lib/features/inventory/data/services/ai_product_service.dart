import 'package:zeno/core/ai/ai_gateway.dart';
import 'package:zeno/core/industry/industry_registry.dart';

class AIProductService {
  final AIGateway _aiGateway;

  AIProductService(this._aiGateway);

  /// Generates a professional product description based on industry and attributes.
  Future<String> generateDescription({
    required String productName,
    required IndustrySchema industry,
    required Map<String, String> attributes,
  }) async {
    final attributeSummary =
        attributes.entries.map((e) => "${e.key}: ${e.value}").join(", ");

    final prompt = """
      Act as a professional marketing writer for ZENO BOS.
      Generate a concise, engaging product description for a ${industry.displayName} business.
      Product: $productName
      Attributes: $attributeSummary
      Output only the description text.
    """;

    final response = await _aiGateway.prompt(prompt);
    return response.text;
  }

  /// Suggests missing attributes based on product name.
  Future<Map<String, String>> suggestAttributes(
      String productName, IndustrySchema industry) async {
    // In a real implementation, this would parse JSON from the AI
    // For now, we simulate with a delay
    await Future.delayed(const Duration(seconds: 1));
    return {};
  }
}
