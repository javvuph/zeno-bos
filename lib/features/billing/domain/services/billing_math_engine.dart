import 'package:zeno/features/billing/domain/models/bill.dart';
import 'package:zeno/features/billing/domain/models/bill_item.dart';
import 'package:zeno/features/billing/domain/models/tax_details.dart';
import 'package:zeno/features/billing/domain/models/discount_details.dart';

/// Pure math engine for billing calculations.
/// Supports multi-national tax systems and precise rounding.
class BillingMathEngine {
  /// Calculates totals for a single [BillItem].
  static BillItem calculateItemTotals(BillItem item) {
    double itemSubtotal = item.unitPrice * item.quantity;

    // 1. Calculate Discounts
    double itemDiscountAmount = 0.0;
    List<DiscountDetails> updatedDiscounts = item.discounts.map((d) {
      double amount = d.isPercentage ? (itemSubtotal * d.value) / 100 : d.value;
      itemDiscountAmount += amount;
      return DiscountDetails(
        label: d.label,
        value: d.value,
        isPercentage: d.isPercentage,
        calculatedAmount: amount,
      );
    }).toList();

    double amountAfterDiscount = itemSubtotal - itemDiscountAmount;

    // 2. Calculate Taxes (applied on amount after item discounts)
    double itemTaxAmount = 0.0;
    List<TaxDetails> updatedTaxes = item.taxes.map((t) {
      double amount = (amountAfterDiscount * t.percentage) / 100;
      itemTaxAmount += amount;
      return TaxDetails(
        label: t.label,
        percentage: t.percentage,
        amount: amount,
      );
    }).toList();

    return item.copyWith(
      discounts: updatedDiscounts,
      taxes: updatedTaxes,
      totalAmount: amountAfterDiscount + itemTaxAmount,
    );
  }

  /// Recalculates the entire [Bill] including global discounts and round-off.
  static Bill calculateBillTotals(Bill bill) {
    double subtotal = 0.0;
    double totalTax = 0.0;
    double totalItemDiscount = 0.0;

    List<BillItem> processedItems = bill.items.map((item) {
      final processed = calculateItemTotals(item);
      subtotal += (processed.unitPrice * processed.quantity);
      totalTax += processed.taxes.fold(0.0, (p, t) => p + t.amount);
      totalItemDiscount +=
          processed.discounts.fold(0.0, (p, d) => p + d.calculatedAmount);
      return processed;
    }).toList();

    double grandTotalRaw = subtotal - totalItemDiscount + totalTax;

    // TODO: Implement Global Cart Discount logic if needed in Phase 2

    // Precision Rounding (Standard 2 decimal places for most currencies)
    double grandTotal = double.parse(grandTotalRaw.toStringAsFixed(2));

    return bill.copyWith(
      items: processedItems,
      subtotal: subtotal,
      totalTax: totalTax,
      totalDiscount: totalItemDiscount,
      grandTotal: grandTotal,
    );
  }
}
