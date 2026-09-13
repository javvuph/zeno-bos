enum AttributeType { text, numeric, selection, toggle }

class AttributeDefinition {
  final String key;
  final String label;
  final AttributeType type;
  final List<String>? options; // For selection type
  final String? defaultValue;

  const AttributeDefinition({
    required this.key,
    required this.label,
    required this.type,
    this.options,
    this.defaultValue,
  });
}

class IndustrySchema {
  final String industryId;
  final String displayName;
  final List<AttributeDefinition> attributes;

  const IndustrySchema({
    required this.industryId,
    required this.displayName,
    required this.attributes,
  });
}

class IndustryRegistry {
  static const List<IndustrySchema> all = [
    IndustrySchema(
      industryId: 'general',
      displayName: 'General Inventory',
      attributes: [
        AttributeDefinition(
            key: 'category', label: 'Category', type: AttributeType.text),
        AttributeDefinition(
            key: 'brand', label: 'Brand', type: AttributeType.text),
        AttributeDefinition(
            key: 'sku', label: 'SKU/Barcode', type: AttributeType.text),
      ],
    ),
  ];

  static final Map<String, IndustrySchema> _cache = {
    for (var schema in all) schema.industryId: schema
  };

  static IndustrySchema getById(String id) {
    return _cache[id] ?? all.first;
  }
}
