import '../models/purchase_item.dart';
import '../models/purchase_order.dart';
import '../models/supplier_quotation.dart';
import '../models/grn.dart';
import '../models/vendor_bill.dart';
import '../models/vendor_bill_status.dart';

class ProcurementBusinessLogic {
  /// Calculates the total tax for a list of items
  double calculateTotalTax(List<PurchaseItem> items) {
    return items.fold(0.0, (sum, item) => sum + item.taxAmount);
  }

  /// Calculates the total amount for a list of items including tax and minus discounts
  double calculateTotalAmount(List<PurchaseItem> items) {
    return items.fold(0.0, (sum, item) => sum + item.total);
  }

  /// Apportions landed costs across purchase items based on value
  Map<String, double> allocateLandedCost(
      List<PurchaseItem> items, double totalExtraCost) {
    final double totalBaseValue =
        items.fold(0.0, (sum, item) => sum + item.subtotal);
    if (totalBaseValue == 0) return {};

    final Map<String, double> allocations = {};
    for (var item in items) {
      final double share = (item.subtotal / totalBaseValue) * totalExtraCost;
      allocations[item.variantId] = share;
    }
    return allocations;
  }

  /// Compares supplier quotations and returns them sorted by overall score or price
  List<SupplierQuotation> rankQuotations(List<SupplierQuotation> quotations,
      {bool sortByPrice = false}) {
    final sorted = List<SupplierQuotation>.from(quotations);
    if (sortByPrice) {
      sorted.sort((a, b) => a.totalAmount.compareTo(b.totalAmount));
    } else {
      sorted.sort((a, b) => b.overallScore.compareTo(a.overallScore));
    }
    return sorted;
  }

  /// AI Recommendation Engine: Assigns a score (0-100) to each quotation
  List<SupplierQuotation> applyAiScoring(List<SupplierQuotation> quotations) {
    if (quotations.isEmpty) return [];

    // Find min/max for normalization
    double minPrice =
        quotations.map((q) => q.totalAmount).reduce((a, b) => a < b ? a : b);
    int minLeadTime =
        quotations.map((q) => q.leadTimeDays).reduce((a, b) => a < b ? a : b);

    return quotations.map((q) {
      double priceScore = (minPrice / q.totalAmount) * 40; // 40% weight
      double leadTimeScore = (minLeadTime / q.leadTimeDays) * 20; // 20% weight
      double performanceScore =
          (q.pastPerformanceScore / 100) * 20; // 20% weight
      double qualityScore = (q.qualityRating / 100) * 20; // 20% weight

      double totalAiScore =
          priceScore + leadTimeScore + performanceScore + qualityScore;
      return q.copyWith(aiScore: totalAiScore);
    }).toList();
  }

  /// Determines if a PO requires multi-level approval based on amount
  bool requiresExecutiveApproval(PurchaseOrder po, double threshold) {
    return po.totalAmount >= threshold;
  }

  /// Calculates the status of a PO based on GRN receipts
  POStatus calculatePOStatus(PurchaseOrder po, List<GRN> receipts) {
    if (receipts.isEmpty) return po.status;

    bool allReceived = true;
    bool partial = false;

    for (var orderItem in po.items) {
      double totalReceived = 0;
      for (var grn in receipts) {
        for (var grnItem in grn.receivedItems) {
          if (grnItem.orderItem.variantId == orderItem.variantId) {
            totalReceived += grnItem.acceptedQuantity;
          }
        }
      }
      if (totalReceived < orderItem.quantity) {
        allReceived = false;
        if (totalReceived > 0) partial = true;
      }
    }

    if (allReceived) return POStatus.received;
    if (partial) return POStatus.partiallyReceived;
    return POStatus.ordered;
  }

  /// GRN Logic: Validates receiving quantities against PO
  List<String> validateGRN(GRN grn, PurchaseOrder po) {
    final errors = <String>[];
    for (var item in grn.receivedItems) {
      final poItem = po.items.firstWhere(
          (i) => i.variantId == item.orderItem.variantId,
          orElse: () => const PurchaseItem(
              productId: '', variantId: '', name: '', quantity: 0, unitId: ''));

      if (poItem.productId.isEmpty) {
        errors.add("Item ${item.orderItem.name} not found in PO.");
      } else if (item.receivedQuantity > poItem.quantity * 1.1) {
        // Allow 10% over-delivery
        errors
            .add("Item ${item.orderItem.name} over-received by more than 10%.");
      }
    }
    return errors;
  }

  /// Calculates readiness score (0.0 to 1.0) for a Purchase Order
  double calculatePOReadiness(PurchaseOrder po) {
    int points = 0;
    int total = 100;

    if (po.supplierId.isNotEmpty) points += 20;
    if (po.items.isNotEmpty) points += 30;
    if (po.expectedDeliveryDate.isAfter(po.orderDate)) points += 20;
    if (po.currency.isNotEmpty) points += 15;
    if (po.totalAmount > 0) points += 15;

    return points / total;
  }

  /// Detects potential duplicate POs based on supplier and date
  bool isPotentialDuplicate(PurchaseOrder a, PurchaseOrder b) {
    if (a.id == b.id) return false;
    return a.supplierId == b.supplierId &&
        a.orderDate.year == b.orderDate.year &&
        a.orderDate.month == b.orderDate.month &&
        a.orderDate.day == b.orderDate.day &&
        a.totalAmount == b.totalAmount;
  }

  /// 3-Way Match Engine: Validates PO, GRN, and Invoice
  VendorBill perform3WayMatch(VendorBill bill, PurchaseOrder? po, GRN? grn) {
    final discrepancies = <String>[];
    double matchScore = 100.0;

    if (po == null) {
      discrepancies.add("Source Purchase Order not found.");
      matchScore -= 30;
    }
    if (grn == null) {
      discrepancies.add("Goods Receipt Note not found.");
      matchScore -= 30;
    }

    if (po != null && grn != null) {
      // 1. Quantity Match (Invoice vs GRN)
      for (var billItem in bill.items) {
        final grnItem = grn.receivedItems.firstWhere(
            (i) => i.orderItem.productId == billItem.productId,
            orElse: () => const GRNItem(
                orderItem: PurchaseItem(
                    productId: '',
                    variantId: '',
                    name: '',
                    quantity: 0,
                    unitId: ''),
                receivedQuantity: 0));

        if (billItem.quantity > grnItem.acceptedQuantity) {
          discrepancies.add(
              "Qty Mismatch: ${billItem.name} invoiced ${billItem.quantity} vs ${grnItem.acceptedQuantity} received.");
          matchScore -= 10;
        }

        // 2. Price Match (Invoice vs PO)
        final poItem = po.items.firstWhere(
            (i) => i.productId == billItem.productId,
            orElse: () => const PurchaseItem(
                productId: '',
                variantId: '',
                name: '',
                quantity: 0,
                unitId: ''));

        if (billItem.unitPrice > poItem.unitPrice) {
          discrepancies.add(
              "Price Mismatch: ${billItem.name} charged \$${billItem.unitPrice} vs \$${poItem.unitPrice} ordered.");
          matchScore -= 15;
        }
      }
    }

    return bill.copyWith(
      matchDiscrepancies: discrepancies,
      aiMatchScore: matchScore.clamp(0, 100),
      is3WayMatched: discrepancies.isEmpty,
      status: discrepancies.isEmpty
          ? VendorBillStatus.verified
          : VendorBillStatus.mismatch,
    );
  }

  /// Converts a value between currencies
  double convertCurrency(double amount, double rate) {
    return amount * rate;
  }
}
