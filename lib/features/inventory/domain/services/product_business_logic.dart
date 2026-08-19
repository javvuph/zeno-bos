import 'dart:math';
import '../models/product.dart';
import '../models/sku.dart';
import '../models/barcode.dart';
import '../models/product_variant.dart';

class ProductBusinessLogic {
  /// Generates a unique SKU based on product attributes
  SKU generateSKU(String categoryName, String brandName, String productName) {
    final catCode = categoryName.length >= 3
        ? categoryName.substring(0, 3).toUpperCase()
        : 'GEN';
    final brandCode =
        brandName.length >= 2 ? brandName.substring(0, 2).toUpperCase() : 'ZN';
    final timestamp =
        DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    return SKU('$catCode-$brandCode-$timestamp');
  }

  /// Generates a mock EAN-13 barcode
  Barcode generateBarcode() {
    final random = Random();
    String code = '890'; // Mock country code
    for (var i = 0; i < 9; i++) {
      code += random.nextInt(10).toString();
    }
    // Simple check digit calculation (mocked for simplicity)
    code += random.nextInt(10).toString();
    return Barcode(code, type: 'EAN13');
  }

  /// Calculates the readiness score (0.0 to 1.0) based on domain rules
  double calculateReadiness(Product product) {
    int totalPoints = 0;
    int earnedPoints = 0;

    // Weightage-based scoring
    void check(bool condition, int weight) {
      totalPoints += weight;
      if (condition) earnedPoints += weight;
    }

    check(product.name.isNotEmpty, 20);
    check(product.sku.isValid, 15);
    check(product.description != null && product.description!.length > 20, 10);
    check(product.category != null, 15);
    check(product.brand != null, 10);
    check(product.basePrice > 0, 15);
    check(product.barcode != null && product.barcode!.isValid, 10);
    check(product.variants.isNotEmpty, 5);

    return earnedPoints / totalPoints;
  }

  /// Validates a product and returns a list of error messages
  List<String> validateProduct(Product product) {
    final errors = <String>[];
    if (product.name.isEmpty) errors.add("Product name is required.");
    if (!product.sku.isValid) errors.add("Valid SKU is required.");
    if (product.basePrice <= 0) {
      errors.add("Base price must be greater than zero.");
    }
    if (product.unit.id.isEmpty) errors.add("Unit of measure is required.");
    return errors;
  }

  /// Creates a new variant with inherited attributes
  ProductVariant createVariant(
      Product product, Map<String, String> attributes) {
    return ProductVariant(
      id: 'v-${product.id}-${DateTime.now().millisecondsSinceEpoch}',
      productId: product.id,
      sku: SKU(
          '${product.sku.value}-${attributes.values.join("-").toUpperCase()}'),
      attributes: attributes,
      priceAdjustment: 0.0,
    );
  }
}
