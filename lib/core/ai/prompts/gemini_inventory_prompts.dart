import 'dart:convert';

/// Strict ZENO BOS Gemini System Instruction & Response Schema
class GeminiInventoryPrompts {
  static const String systemInstruction = """
You are the Inventory Intelligence Engine for Zeno BOS, an ERP and POS system.
Your job is to parse supplier invoices, product images, or natural language prompts into a structured Product and Variant JSON payload.

Rules:
1. Always output strictly valid JSON matching the provided schema. Do not include markdown formatting, backticks (```json), or conversational filler.
2. For Fashion products:
   - Identify or standardize sizes into standard Alpha (S, M, L, XL, XXL) or Numeric waist sizes.
   - Separate parent product details from variant-specific details (Size, Color, Variant Stock).
3. If Cost Price is given but Selling Price is missing, suggest a default Selling Price with a 60% markup (Cost * 1.6).
4. Auto-generate clean, readable SKUs: [3-LETTER-CATEGORY]-[NAME_SHORT]-[COLOR]-[SIZE].
""";

  static const String responseJsonSchemaPrompt = """
Output strictly a JSON object with this exact structure:
{
  "product_name": "String",
  "category": "String",
  "brand": "String",
  "cost_price": 0.0,
  "selling_price": 0.0,
  "tax_rate_percentage": 5,
  "hsn_code": "String",
  "low_stock_threshold": 2,
  "discount": {
    "type": "percentage",
    "value": 0
  },
  "is_variant_product": true,
  "variants": [
    {
      "color": "String",
      "size": "String",
      "stock_quantity": 0,
      "sku": "String",
      "cost_price": 0.0,
      "selling_price": 0.0
    }
  ],
  "total_calculated_stock": 0
}
""";

  static Map<String, dynamic> cleanAndParseJson(String rawText) {
    try {
      String clean = rawText.trim();
      if (clean.startsWith("```json")) {
        clean = clean.substring(7);
      } else if (clean.startsWith("```")) {
        clean = clean.substring(3);
      }
      if (clean.endsWith("```")) {
        clean = clean.substring(0, clean.length - 3);
      }
      return jsonDecode(clean.trim()) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }
}
