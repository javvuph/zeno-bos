import 'dart:async';
import 'dart:convert';

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
    await Future.delayed(const Duration(milliseconds: 300));
    return AIResponse(
      text: _buildMockInventoryJson(input),
      provider: providerName,
    );
  }

  String _buildMockInventoryJson(String input) {
    final lower = input.toLowerCase();
    final hasJeans = lower.contains('jeans');
    final hasKurti = lower.contains('kurti');
    final hasBill = lower.contains('bill') ||
        lower.contains('invoice') ||
        lower.contains('supplier');
    final hasPrompt = lower.contains('cost') ||
        lower.contains('sell') ||
        lower.contains('size') ||
        lower.contains('white') ||
        lower.contains('blue');

    String productName = 'Men Slim Fit Cotton Shirt';
    String category = 'Men / Shirts';
    String brand = 'In-House';
    double cost = 350.0;
    double sell = 699.0;
    int taxRate = 5;
    String hsn = '6109';
    if (hasJeans) {
      productName = 'Men Slim Fit Denim Jeans';
      category = 'Men / Jeans';
      hsn = '6203';
    } else if (hasKurti) {
      productName = 'Women Printed Cotton Kurti';
      category = 'Women / Kurtis';
      hsn = '6107';
    }

    final matchCost =
        RegExp(r'cost\s*[:=]?\s*(\d+(?:\.\d+)?)', caseSensitive: false)
            .firstMatch(input);
    final matchSell =
        RegExp(r'sell\s*[:=]?\s*(\d+(?:\.\d+)?)', caseSensitive: false)
            .firstMatch(input);
    final matchQty =
        RegExp(r'(\d+)\s*pieces?', caseSensitive: false).firstMatch(input);
    if (matchCost != null) {
      cost = double.tryParse(matchCost.group(1) ?? '350') ?? cost;
    }
    if (matchSell != null) {
      sell = double.tryParse(matchSell.group(1) ?? '699') ?? sell;
    }

    final sizeList = ['M', 'L'];
    final colorList = ['White', 'Blue'];
    if (hasPrompt) {
      if (lower.contains('black')) colorList[0] = 'Black';
      if (lower.contains('navy')) colorList[1] = 'Navy';
      if (lower.contains('m') && lower.contains('xl')) {
        sizeList.clear();
        sizeList.addAll(['M', 'L', 'XL']);
      }
    }

    final stockQty = matchQty != null ? int.parse(matchQty.group(1)!) : 12;
    final perVariant = stockQty ~/ (sizeList.length * colorList.length);
    final variantStock =
        List.generate(sizeList.length * colorList.length, (index) {
      final color = colorList[index % colorList.length];
      final size = sizeList[index ~/ colorList.length];
      return {
        'color': color,
        'size': size,
        'stock_quantity': perVariant > 0 ? perVariant : 2,
        'sku':
            '${productName.substring(0, 3).toUpperCase()}-${productName.replaceAll(RegExp(r'[^A-Za-z]'), '').substring(0, 4).toUpperCase()}-${color.substring(0, 3).toUpperCase()}-$size',
        'cost_price': cost,
        'selling_price': sell,
      };
    });

    final payload = {
      'product_name': productName,
      'category': category,
      'brand': brand,
      'cost_price': cost,
      'selling_price': sell,
      'tax_rate_percentage': taxRate,
      'hsn_code': hsn,
      'low_stock_threshold': 2,
      'discount': {'type': 'percentage', 'value': 0},
      'is_variant_product': true,
      'variants': variantStock,
      'total_calculated_stock': stockQty,
      if (hasBill) 'opening_stock': stockQty,
    };

    return jsonEncode(payload);
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
