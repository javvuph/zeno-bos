import 'package:flutter/material.dart';
import 'package:zeno/features/inventory/domain/models/product.dart';

// ============================================================================
// DART MODELS (USE 'double' FOR ALL QUANTITIES & STOCK)
// ============================================================================

class ProductVariant {
  final String id;
  final String sku;
  final String barcode;
  final String color;
  final String size;
  final double qty;

  const ProductVariant({
    required this.id,
    required this.sku,
    required this.barcode,
    required this.color,
    required this.size,
    required this.qty,
  });

  ProductVariant copyWith({
    String? id,
    String? sku,
    String? barcode,
    String? color,
    String? size,
    double? qty,
  }) {
    return ProductVariant(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      color: color ?? this.color,
      size: size ?? this.size,
      qty: qty ?? this.qty,
    );
  }
}

class ProductMaster {
  final String id;
  final String name;
  final String sku;
  final double retail;
  final double cost;
  final double stock; // For standalone products
  final double reorderLevel;
  final String category;
  final String brand;
  final String location;
  final DateTime addedDate;
  final bool isStandalone;
  final List<ProductVariant> variants;
  final bool isExpanded;

  const ProductMaster({
    required this.id,
    required this.name,
    required this.sku,
    required this.retail,
    required this.cost,
    required this.stock,
    required this.reorderLevel,
    required this.category,
    required this.brand,
    required this.location,
    required this.addedDate,
    required this.isStandalone,
    this.variants = const [],
    this.isExpanded = false,
  });

  factory ProductMaster.fromDomain(Product p, {bool isExpanded = false}) {
    final standalone = p.variants.isEmpty;
    return ProductMaster(
      id: p.id,
      name: p.name,
      sku: p.sku.value,
      retail: p.basePrice,
      cost: p.baseCost,
      stock: standalone ? p.openingStock : 0.0,
      reorderLevel: p.reorderLevel,
      category: p.category?.name ?? "General",
      brand: p.brand?.name ?? "ZENO",
      location: p.warehouseLocation.isNotEmpty ? p.warehouseLocation : "MAIN HQ",
      addedDate: p.createdAt,
      isStandalone: standalone,
      variants: p.variants.map((v) => ProductVariant(
        id: v.id,
        sku: v.sku.value,
        barcode: v.barcode?.value ?? "AUTO",
        color: v.attributes["Color"] ?? v.attributes["Colour"] ?? "Default",
        size: v.attributes["Size"] ?? "Default",
        qty: v.stockLevel,
      )).toList(),
      isExpanded: isExpanded,
    );
  }

  double get totalStock {
    if (!isStandalone && variants.isNotEmpty) {
      return variants.fold<double>(0.0, (sum, v) => sum + v.qty);
    }
    return stock;
  }

  double get marginPercentage {
    if (retail <= 0) return 0.0;
    return (((retail - cost) / retail) * 100);
  }

  ProductMaster copyWith({
    String? id,
    String? name,
    String? sku,
    double? retail,
    double? cost,
    double? stock,
    double? reorderLevel,
    String? category,
    String? brand,
    String? location,
    DateTime? addedDate,
    bool? isStandalone,
    List<ProductVariant>? variants,
    bool? isExpanded,
  }) {
    return ProductMaster(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      retail: retail ?? this.retail,
      cost: cost ?? this.cost,
      stock: stock ?? this.stock,
      reorderLevel: reorderLevel ?? this.reorderLevel,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      location: location ?? this.location,
      addedDate: addedDate ?? this.addedDate,
      isStandalone: isStandalone ?? this.isStandalone,
      variants: variants ?? this.variants,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

// ============================================================================
// STOCK AGING HELPER METADATA
// ============================================================================

class AgingMeta {
  final String tag;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;
  final double months;

  const AgingMeta({
    required this.tag,
    required this.bgColor,
    required this.textColor,
    required this.borderColor,
    required this.months,
  });
}

AgingMeta getAgingMeta(DateTime addedDate) {
  final today = DateTime.now();
  final diffDays = today.difference(addedDate).inDays;
  final diffMonths = diffDays / 30.44;

  if (diffMonths < 1) {
    return AgingMeta(
      tag: "🟢 NEW (<1M)",
      bgColor: const Color(0xFFDCFCE7),
      textColor: const Color(0xFF15803D),
      borderColor: const Color(0xFF86EFAC),
      months: diffMonths,
    );
  } else if (diffMonths < 3) {
    return AgingMeta(
      tag: "🔵 1–3M AGED",
      bgColor: const Color(0xFFEEF2FF),
      textColor: const Color(0xFF3730A3),
      borderColor: const Color(0xFFA5B4FC),
      months: diffMonths,
    );
  } else if (diffMonths < 6) {
    return AgingMeta(
      tag: "🟡 3–6M AGED",
      bgColor: const Color(0xFFFEF3C7),
      textColor: const Color(0xFF92400E),
      borderColor: const Color(0xFFFCD34D),
      months: diffMonths,
    );
  } else if (diffMonths < 12) {
    return AgingMeta(
      tag: "🟠 6–12M AGED",
      bgColor: const Color(0xFFFFEDD5),
      textColor: const Color(0xFF9A3412),
      borderColor: const Color(0xFFFDBA74),
      months: diffMonths,
    );
  } else {
    return AgingMeta(
      tag: "🔴 1Y+ DEAD STOCK",
      bgColor: const Color(0xFFFEE2E2),
      textColor: const Color(0xFF991B1B),
      borderColor: const Color(0xFFFCA5A5),
      months: diffMonths,
    );
  }
}

String formatDate(DateTime d) {
  final months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  final day = d.day.toString().padLeft(2, '0');
  final month = months[d.month - 1];
  final year = d.year;
  return "$day $month $year";
}
