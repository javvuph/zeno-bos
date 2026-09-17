import 'sku.dart';
import 'barcode.dart';

class ProductVariant {
  final String id;
  final String productId;
  final SKU sku;
  final Barcode? barcode;
  final Map<String, String> attributes; // e.g. {"Size": "XL", "Color": "Blue"}
  final double priceAdjustment; // Difference from base price
  final double stockLevel;

  const ProductVariant({
    required this.id,
    required this.productId,
    required this.sku,
    this.barcode,
    required this.attributes,
    this.priceAdjustment = 0.0,
    this.stockLevel = 0.0,
  });

  String get displayName => attributes.values.join(' / ');

  ProductVariant copyWith({
    String? id,
    String? productId,
    SKU? sku,
    Barcode? barcode,
    Map<String, String>? attributes,
    double? priceAdjustment,
    double? stockLevel,
  }) {
    return ProductVariant(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      attributes: attributes ?? this.attributes,
      priceAdjustment: priceAdjustment ?? this.priceAdjustment,
      stockLevel: stockLevel ?? this.stockLevel,
    );
  }
}
