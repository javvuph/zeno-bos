import 'payment_status.dart';

enum PayablePriority { low, medium, high, urgent }

class AccountsPayable {
  final String id;
  final String supplierId;
  final String vendorBillId;
  final String invoiceNumber;
  final String? poId;
  final double amount;
  final double discountAvailable;
  final DateTime dueDate;
  final DateTime? scheduledDate;
  final PayablePriority priority;
  final PaymentStatus status;
  final String? bankAccountId;
  final String? approvalStatus; // pending, approved, rejected
  final double aiRiskScore;
  final List<String> aiInsights;

  const AccountsPayable({
    required this.id,
    required this.supplierId,
    required this.vendorBillId,
    required this.invoiceNumber,
    this.poId,
    required this.amount,
    this.discountAvailable = 0.0,
    required this.dueDate,
    this.scheduledDate,
    this.priority = PayablePriority.medium,
    this.status = PaymentStatus.pending,
    this.bankAccountId,
    this.approvalStatus = 'pending',
    this.aiRiskScore = 0.0,
    this.aiInsights = const [],
  });

  int get daysOutstanding => DateTime.now().difference(dueDate).inDays;

  AccountsPayable copyWith({
    PaymentStatus? status,
    DateTime? scheduledDate,
    String? approvalStatus,
    String? bankAccountId,
    PayablePriority? priority,
    double? aiRiskScore,
  }) {
    return AccountsPayable(
      id: id,
      supplierId: supplierId,
      vendorBillId: vendorBillId,
      invoiceNumber: invoiceNumber,
      poId: poId,
      amount: amount,
      discountAvailable: discountAvailable,
      dueDate: dueDate,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      bankAccountId: bankAccountId ?? this.bankAccountId,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      aiRiskScore: aiRiskScore ?? this.aiRiskScore,
      aiInsights: aiInsights,
    );
  }
}
