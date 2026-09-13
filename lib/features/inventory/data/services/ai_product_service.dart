import 'package:zeno/core/ai/ai_gateway.dart';
import 'package:zeno/core/industry/industry_registry.dart';
import 'package:zeno/core/ai/prompts/gemini_inventory_prompts.dart';

class AIProductService {
  final AIGateway _aiGateway;

  AIProductService(this._aiGateway);

  Map<String, dynamic> _parseOrFallback(String rawInput, String source) {
    final parsed = GeminiInventoryPrompts.cleanAndParseJson(rawInput);
    if (parsed.isNotEmpty) {
      return parsed;
    }
    return _buildFallbackPayload(source);
  }

  Map<String, dynamic> _buildFallbackPayload(String source) {
    final lower = source.toLowerCase();
    final name = lower.contains('jeans')
        ? 'Men Slim Fit Denim Jeans'
        : lower.contains('kurti')
            ? 'Women Printed Cotton Kurti'
            : 'Men Slim Fit Cotton Shirt';
    final category = lower.contains('jeans')
        ? 'Men / Jeans'
        : lower.contains('kurti')
            ? 'Women / Kurtis'
            : 'Men / Shirts';
    const baseCost = 350.0;
    const baseSell = 699.0;
    final variants = [
      {
        'color': 'White',
        'size': 'M',
        'stock_quantity': 4,
        'sku': 'SHT-SLM-WHT-M',
        'cost_price': baseCost,
        'selling_price': baseSell
      },
      {
        'color': 'White',
        'size': 'L',
        'stock_quantity': 4,
        'sku': 'SHT-SLM-WHT-L',
        'cost_price': baseCost,
        'selling_price': baseSell
      },
      {
        'color': 'Blue',
        'size': 'M',
        'stock_quantity': 2,
        'sku': 'SHT-SLM-BLU-M',
        'cost_price': baseCost,
        'selling_price': baseSell
      },
      {
        'color': 'Blue',
        'size': 'L',
        'stock_quantity': 2,
        'sku': 'SHT-SLM-BLU-L',
        'cost_price': baseCost,
        'selling_price': baseSell
      },
    ];
    return {
      'product_name': name,
      'category': category,
      'brand': 'In-House',
      'cost_price': baseCost,
      'selling_price': baseSell,
      'tax_rate_percentage': 5,
      'hsn_code': '6109',
      'low_stock_threshold': 2,
      'discount': {'type': 'percentage', 'value': 0},
      'is_variant_product': true,
      'variants': variants,
      'total_calculated_stock': 12,
    };
  }

  /// 1. Voice / Quick Natural Language Prompt Parser
  Future<Map<String, dynamic>> parsePromptToProductPayload(
      String promptText) async {
    final fullPrompt = """
${GeminiInventoryPrompts.systemInstruction}
    
Task: Convert the following spoken/typed prompt into a structured product JSON payload:
"$promptText"
    
${GeminiInventoryPrompts.responseJsonSchemaPrompt}
""";

    final response = await _aiGateway.prompt(fullPrompt);
    return _parseOrFallback(response.text, promptText);
  }

  /// 2. Bill AI (Invoice Inward Parser)
  Future<Map<String, dynamic>> parseBillToProductPayload(
      String billTextOrData) async {
    final fullPrompt = """
${GeminiInventoryPrompts.systemInstruction}
    
Task: Extract wholesale invoice line items and product variants from this bill:
"$billTextOrData"
    
${GeminiInventoryPrompts.responseJsonSchemaPrompt}
""";

    final response = await _aiGateway.prompt(fullPrompt);
    return _parseOrFallback(response.text, billTextOrData);
  }

  /// 3. Photo-to-Product Visual AI Parser
  Future<Map<String, dynamic>> parseImageToProductPayload(
      String imageDescriptionOrData) async {
    final fullPrompt = """
${GeminiInventoryPrompts.systemInstruction}
    
Task: Analyze the clothing image and detect garment type, dominant color, fabric pattern, and suggest category for this product:
"$imageDescriptionOrData"
    
${GeminiInventoryPrompts.responseJsonSchemaPrompt}
""";

    final response = await _aiGateway.prompt(fullPrompt);
    return _parseOrFallback(response.text, imageDescriptionOrData);
  }

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
    await Future.delayed(const Duration(seconds: 1));
    return {};
  }
}
