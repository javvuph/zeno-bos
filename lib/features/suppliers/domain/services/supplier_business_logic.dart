import '../models/supplier.dart';
import '../models/supplier_rating.dart';
import '../models/supplier_payment_terms.dart';

class SupplierBusinessLogic {
  /// Calculates the overall rating based on weighted scores
  SupplierRating updateScorecard({
    required SupplierRating current,
    required double newQuality,
    required double newDelivery,
    required double newValue,
    required bool wasPerfect,
  }) {
    final int newTotalCount = current.totalOrderCount + 1;
    final int newPerfectCount =
        wasPerfect ? current.perfectOrderCount + 1 : current.perfectOrderCount;

    // Simple moving average for scores (enterprise level would use more complex decay)
    final double updatedQuality =
        (current.qualityScore * current.totalOrderCount + newQuality) /
            newTotalCount;
    final double updatedDelivery =
        (current.deliveryScore * current.totalOrderCount + newDelivery) /
            newTotalCount;
    final double updatedValue =
        (current.valueScore * current.totalOrderCount + newValue) /
            newTotalCount;

    // Overall is 40% Quality, 40% Delivery, 20% Value
    final double updatedOverall =
        (updatedQuality * 0.4) + (updatedDelivery * 0.4) + (updatedValue * 0.2);

    return SupplierRating(
      overallScore: updatedOverall,
      qualityScore: updatedQuality,
      deliveryScore: updatedDelivery,
      valueScore: updatedValue,
      perfectOrderCount: newPerfectCount,
      totalOrderCount: newTotalCount,
    );
  }

  /// Calculates the readiness score (0.0 to 1.0) of a supplier profile
  double calculateReadiness(Supplier supplier) {
    int totalPoints = 0;
    int earnedPoints = 0;

    void check(bool condition, int weight) {
      totalPoints += weight;
      if (condition) earnedPoints += weight;
    }

    check(supplier.name.isNotEmpty, 20);
    check(supplier.email.contains('@'), 15);
    check(supplier.taxProfile != null, 15);
    check(supplier.bankAccounts.isNotEmpty, 10);
    check(supplier.paymentTerms != null, 10);
    check(supplier.contacts.isNotEmpty, 10);
    check(supplier.addresses.isNotEmpty, 10);
    check(supplier.averageLeadTime > 0, 10);

    return earnedPoints / totalPoints;
  }

  /// Validates if a supplier can be considered for a 'Preferred' status
  bool evaluatePreferredStatus(Supplier supplier) {
    return supplier.rating.overallScore >= 0.85 &&
        supplier.rating.perfectOrderCount >= 10 &&
        supplier.averageLeadTime <= 7;
  }

  /// Detects duplicates based on taxId or email
  bool isDuplicate(Supplier a, Supplier b) {
    if (a.id == b.id) return false;
    if (a.taxProfile?.taxId != null && b.taxProfile?.taxId != null) {
      if (a.taxProfile!.taxId == b.taxProfile!.taxId) return true;
    }
    return a.email.toLowerCase() == b.email.toLowerCase();
  }

  /// Checks if a payment is within agreed terms
  bool isPaymentOverdue(DateTime invoiceDate, SupplierPaymentTerms terms) {
    final dueDate = invoiceDate.add(Duration(days: terms.dueDays));
    return DateTime.now().isAfter(dueDate);
  }
}
