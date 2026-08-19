import 'expense_status.dart';

enum ExpenseCategory {
  travel,
  meal,
  mileage,
  officeSupplies,
  software,
  entertainment,
  utilities,
  other
}

class ExpenseEntry {
  final String id;
  final String employeeId;
  final DateTime date;
  final ExpenseCategory category;
  final double amount;
  final double taxAmount;
  final String currency;
  final String description;
  final String? receiptUrl;
  final String? claimId;
  final String? departmentId;
  final String? projectId;
  final ExpenseStatus status;
  final double aiAnomalyScore;
  final List<String> aiPolicyViolations;

  const ExpenseEntry({
    required this.id,
    required this.employeeId,
    required this.date,
    required this.category,
    required this.amount,
    this.taxAmount = 0.0,
    required this.currency,
    required this.description,
    this.receiptUrl,
    this.claimId,
    this.departmentId,
    this.projectId,
    this.status = ExpenseStatus.draft,
    this.aiAnomalyScore = 0.0,
    this.aiPolicyViolations = const [],
  });

  bool get hasReceipt => receiptUrl != null;

  ExpenseEntry copyWith({
    String? claimId,
    ExpenseStatus? status,
    double? aiAnomalyScore,
    List<String>? aiPolicyViolations,
  }) {
    return ExpenseEntry(
      id: id,
      employeeId: employeeId,
      date: date,
      category: category,
      amount: amount,
      taxAmount: taxAmount,
      currency: currency,
      description: description,
      receiptUrl: receiptUrl,
      claimId: claimId ?? this.claimId,
      departmentId: departmentId,
      projectId: projectId,
      status: status ?? this.status,
      aiAnomalyScore: aiAnomalyScore ?? this.aiAnomalyScore,
      aiPolicyViolations: aiPolicyViolations ?? this.aiPolicyViolations,
    );
  }
}
