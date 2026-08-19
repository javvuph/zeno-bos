import '../models/expense_entry.dart';

class ExpenseBusinessLogic {
  /// Validates individual expense policy (e.g., Daily Meal Cap)
  List<String> checkPolicyViolations(ExpenseEntry entry) {
    final violations = <String>[];

    if (entry.category == ExpenseCategory.meal && entry.amount > 2500) {
      violations.add("Meal expense exceeds daily policy cap of ₹2,500.");
    }

    if (entry.amount > 500 && !entry.hasReceipt) {
      violations.add("Receipt mandatory for expenses over ₹500.");
    }

    return violations;
  }

  /// AI Anomaly Detection: Detects potential duplicate or fraud
  double calculateAnomalyScore(ExpenseEntry entry, List<ExpenseEntry> history) {
    // Check for identical entries within 24 hours
    final duplicates = history.where((h) =>
        h.employeeId == entry.employeeId &&
        h.amount == entry.amount &&
        h.category == entry.category &&
        h.date.difference(entry.date).inHours.abs() < 24);

    if (duplicates.isNotEmpty) return 95.0; // High probability of duplicate
    return 5.0;
  }

  /// Calculates total tax benefit for the company from expense pool
  double calculateTaxBenefit(List<ExpenseEntry> entries) {
    return entries.fold(0.0, (sum, entry) => sum + entry.taxAmount);
  }
}
