import 'package:equatable/equatable.dart';
import 'package:zeno/features/billing/domain/models/tax_details.dart';
import 'package:zeno/features/billing/domain/models/discount_details.dart';

/// Represents an individual line item in a Bill.
class BillItem extends Equatable {
  final String productId;
  final String productName;
  final String sku;
  final String variant;
  final double unitPrice;
  final double? originalPrice; // For tracking price overrides
  final int quantity;
  final List<TaxDetails> taxes;
  final List<DiscountDetails> discounts;
  final double totalAmount;

  // Advanced Tracking
  final String? serialNumber;
  final String? batchNumber;
  final DateTime? expiryDate;
  final String? notes;

  const BillItem({
    required this.productId,
    required this.productName,
    required this.sku,
    required this.variant,
    required this.unitPrice,
    this.originalPrice,
    this.quantity = 1,
    this.taxes = const [],
    this.discounts = const [],
    required this.totalAmount,
    this.serialNumber,
    this.batchNumber,
    this.expiryDate,
    this.notes,
  });

  BillItem copyWith({
    String? productId,
    String? productName,
    String? sku,
    String? variant,
    double? unitPrice,
    double? originalPrice,
    int? quantity,
    List<TaxDetails>? taxes,
    List<DiscountDetails>? discounts,
    double? totalAmount,
    String? serialNumber,
    String? batchNumber,
    DateTime? expiryDate,
    String? notes,
  }) {
    return BillItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      sku: sku ?? this.sku,
      variant: variant ?? this.variant,
      unitPrice: unitPrice ?? this.unitPrice,
      originalPrice: originalPrice ?? this.originalPrice,
      quantity: quantity ?? this.quantity,
      taxes: taxes ?? this.taxes,
      discounts: discounts ?? this.discounts,
      totalAmount: totalAmount ?? this.totalAmount,
      serialNumber: serialNumber ?? this.serialNumber,
      batchNumber: batchNumber ?? this.batchNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      notes: notes ?? this.notes,
    );
  }

  bool get isPriceOverridden =>
      originalPrice != null && originalPrice != unitPrice;

  @override
  List<Object?> get props => [
        productId,
        productName,
        sku,
        variant,
        unitPrice,
        originalPrice,
        quantity,
        taxes,
        discounts,
        totalAmount,
        serialNumber,
        batchNumber,
        expiryDate,
        notes,
      ];
}
