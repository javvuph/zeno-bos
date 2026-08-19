import '../models/budget.dart';

class BudgetBusinessLogic {
  /// Validates an expense against the remaining budget
  bool canAfford(Budget budget, double expenseAmount) {
    if (budget.status != BudgetStatus.active) return false;
    return budget.remainingAmount >= expenseAmount;
  }

  /// Calculates variance analysis for a list of budgets
  Map<String, double> calculateVariance(List<Budget> budgets) {
    return {
      'total_allocated': budgets.fold(0, (sum, b) => sum + b.allocatedAmount),
      'total_utilized': budgets.fold(0, (sum, b) => sum + b.utilizedAmount),
      'total_remaining': budgets.fold(0, (sum, b) => sum + b.remainingAmount),
    };
  }

  /// AI-Driven Budget Overrun Prediction
  double predictOverrun(Budget budget, List<double> historicalTrend) {
    // Highly complex linear regression mock
    if (historicalTrend.isEmpty) return 0.0;
    double avgSpending =
        historicalTrend.reduce((a, b) => a + b) / historicalTrend.length;
    double projection = budget.utilizedAmount + avgSpending;
    return projection > budget.allocatedAmount
        ? (projection - budget.allocatedAmount)
        : 0.0;
  }
}
