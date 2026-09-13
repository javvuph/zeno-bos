import '../models/customer.dart';
import '../models/customer_loyalty.dart';

class CustomerBusinessLogic {
  /// Calculates the next Tier based on lifetime spent
  CustomerTier calculateTier(double lifetimeSpent) {
    if (lifetimeSpent >= 50000) return CustomerTier.vip;
    if (lifetimeSpent >= 10000) return CustomerTier.gold;
    if (lifetimeSpent >= 2500) return CustomerTier.silver;
    return CustomerTier.standard;
  }

  /// Calculates points to award for a purchase
  double calculateAwardPoints(double purchaseAmount, CustomerTier tier) {
    double multiplier = 1.0;
    switch (tier) {
      case CustomerTier.vip:
        multiplier = 3.0;
        break;
      case CustomerTier.gold:
        multiplier = 2.0;
        break;
      case CustomerTier.silver:
        multiplier = 1.5;
        break;
      case CustomerTier.standard:
        multiplier = 1.0;
        break;
    }
    return purchaseAmount * multiplier * 0.01; // 1% base
  }

  /// Checks if customer has enough credit for a transaction
  bool hasEnoughCredit(Customer customer, double amount) {
    if (customer.credit.isBlocked) return false;
    return (customer.credit.creditLimit - customer.credit.currentBalance) >=
        amount;
  }

  /// Calculates profile readiness score (0.0 to 1.0)
  double calculateReadiness(Customer customer) {
    int total = 0;
    int filled = 0;

    void check(bool condition, int weight) {
      total += weight;
      if (condition) filled += weight;
    }

    check(customer.name.isNotEmpty, 20);
    check(customer.email.contains('@'), 15);
    check(customer.phone.length > 5, 15);
    check(customer.addresses.isNotEmpty, 15);
    check(customer.taxId != null && customer.taxId!.isNotEmpty, 10);
    check(customer.groupIds.isNotEmpty, 10);
    check(
        customer.type == CustomerType.business
            ? customer.companyName != null
            : true,
        15);

    return filled / total;
  }

  /// AI-Driven Customer Health Score
  double calculateHealthScore(Customer customer) {
    double score = 100.0;
    if (customer.credit.isBlocked) score -= 40;
    if (customer.outstandingBalance > customer.credit.creditLimit) score -= 30;

    final lastPurchase = customer.lastPurchaseAt;
    final daysSinceLastPurchase =
        DateTime.now().difference(lastPurchase ?? customer.createdAt).inDays;
    if (daysSinceLastPurchase > 90) score -= 20;

    return score.clamp(0, 100);
  }

  /// Detects duplicates based on email or phone
  bool isDuplicate(Customer a, Customer b) {
    if (a.id == b.id) return false;
    return a.email.toLowerCase() == b.email.toLowerCase() ||
        a.phone.replaceAll(' ', '') == b.phone.replaceAll(' ', '');
  }

  /// Merges profile B into profile A
  Customer mergeCustomers(Customer primary, Customer secondary) {
    return primary.copyWith(
      companyName: primary.companyName ?? secondary.companyName,
      taxId: primary.taxId ?? secondary.taxId,
      addresses: [...primary.addresses, ...secondary.addresses],
      contacts: [...primary.contacts, ...secondary.contacts],
      groupIds: {...primary.groupIds, ...secondary.groupIds}.toList(),
      notes: [...primary.notes, ...secondary.notes],
      loyalty: CustomerLoyalty(
        points: primary.loyalty.points + secondary.loyalty.points,
        totalSpent: primary.loyalty.totalSpent + secondary.loyalty.totalSpent,
      ),
      updatedAt: DateTime.now(),
    );
  }

  /// Categorizes customer into segments based on behavior
  List<String> autoSegment(Customer customer) {
    final segments = <String>[];
    if (customer.loyalty.totalSpent > 25000) segments.add('seg_high_value');
    if (customer.credit.currentBalance > (customer.credit.creditLimit * 0.8))
      segments.add('seg_credit_risk');

    final lastPurchase = customer.lastPurchaseAt;
    if (lastPurchase != null &&
        DateTime.now().difference(lastPurchase).inDays > 90) {
      segments.add('seg_churn_risk');
    }

    return segments;
  }
}
