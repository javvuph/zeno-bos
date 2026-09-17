import 'dart:math';
import '../models/product.dart';
import '../models/sku.dart';
import '../models/barcode.dart';
import '../models/product_variant.dart';

class ProductBusinessLogic {
  const ProductBusinessLogic();

  /// Calculates profit margin percentage: ((retail - cost) / retail) * 100
  static double calculateMargin({
    required double retailPrice,
    required double costPrice,
  }) {
    if (retailPrice <= 0) return 0.0;
    final margin = ((retailPrice - costPrice) / retailPrice) * 100.0;
    return margin < 0 ? 0.0 : margin;
  }

  /// Determines stock status string based on quantity and threshold
  static String calculateStockStatus({
    required double stock,
    required double reorderLevel,
  }) {
    if (stock <= 0) return 'OUT OF STOCK';
    if (stock <= reorderLevel) return 'LOW STOCK';
    return 'IN STOCK';
  }

  /// Calculates stock aging in months and returns the color tier
  static String calculateAgingTier(DateTime addedDate) {
    final now = DateTime.now();
    final differenceDays = now.difference(addedDate).inDays;
    final months = differenceDays / 30.44;

    if (months < 1) return 'NEW'; // Green (< 1 month)
    if (months < 3) return '1-3M'; // Blue
    if (months < 6) return '3-6M'; // Yellow
    if (months < 12) return '6-12M'; // Orange
    return '1Y+'; // Red Dead Stock
  }

  /// Computes total aggregate stock across all variants
  static double calculateTotalStock(List<double> variantQuantities) {
    return variantQuantities.fold(0.0, (sum, qty) => sum + qty);
  }

  /// Validates product data before saving to database
  static List<String> validate({
    required String name,
    required String sku,
    required double retailPrice,
    required double costPrice,
    required double stock,
    required double reorderLevel,
  }) {
    final List<String> errors = [];

    if (name.trim().isEmpty) {
      errors.add('Product name is required');
    }

    if (sku.trim().isEmpty) {
      errors.add('Style SKU / Barcode is required');
    }

    if (retailPrice < 0) {
      errors.add('Retail price cannot be negative');
    }

    if (costPrice < 0) {
      errors.add('Cost price cannot be negative');
    }

    if (stock < 0) {
      errors.add('Stock quantity cannot be negative');
    }

    if (reorderLevel < 0) {
      errors.add('Reorder threshold cannot be negative');
    }

    return errors;
  }

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
    if (product.basePrice < 0) {
      errors.add("Base price cannot be negative.");
    }
    if (product.unit.id.isEmpty && product.unit.name.isEmpty) {
      errors.add("Unit of measure is required.");
    }
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
