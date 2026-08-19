import '../models/accounts_payable.dart';
import '../models/payment_status.dart';

class PayablesBusinessLogic {
  /// Calculates Early Payment Discount if applicable
  double calculateDiscount(AccountsPayable payable, double discountRate) {
    if (payable.daysOutstanding < 0) {
      return payable.amount * discountRate;
    }
    return 0.0;
  }

  /// AI-Driven Payment Prioritization Logic
  List<AccountsPayable> prioritizePayments(List<AccountsPayable> payables) {
    final sorted = List<AccountsPayable>.from(payables);
    sorted.sort((a, b) {
      // 1. Priority (Urgent first)
      if (a.priority != b.priority) {
        return b.priority.index.compareTo(a.priority.index);
      }
      // 2. Due Date (Earlier first)
      return a.dueDate.compareTo(b.dueDate);
    });
    return sorted;
  }

  /// Validates a payment against the outstanding amount
  bool isValidPayment(AccountsPayable payable, double paymentAmount) {
    return paymentAmount > 0 && paymentAmount <= payable.amount;
  }

  /// AI Risk Score Calculation for Payables
  double calculateAiRiskScore(AccountsPayable payable) {
    double score = 0.0;
    if (payable.daysOutstanding > 30) score += 40;
    if (payable.priority == PayablePriority.urgent) score += 20;
    if (payable.status == PaymentStatus.disputed) score += 30;
    return score.clamp(0, 100);
  }
}
