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
}
