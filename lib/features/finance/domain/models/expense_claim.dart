import 'expense_status.dart';
import 'expense_entry.dart';

class ExpenseClaim {
  final String id;
  final String employeeId;
  final String title;
  final DateTime submissionDate;
  final List<ExpenseEntry> entries;
  final ExpenseStatus status;
  final double totalAmount;
  final String? approvedById;
  final DateTime? approvalDate;
  final String? rejectionReason;
  final String? reimbursementTxId;

  const ExpenseClaim({
    required this.id,
    required this.employeeId,
    required this.title,
    required this.submissionDate,
    required this.entries,
    this.status = ExpenseStatus.draft,
    required this.totalAmount,
    this.approvedById,
    this.approvalDate,
    this.rejectionReason,
    this.reimbursementTxId,
  });

  ExpenseClaim copyWith({
    ExpenseStatus? status,
    String? approvedById,
    DateTime? approvalDate,
    String? rejectionReason,
    String? reimbursementTxId,
  }) {
    return ExpenseClaim(
      id: id,
      employeeId: employeeId,
      title: title,
      submissionDate: submissionDate,
      entries: entries,
      status: status ?? this.status,
      totalAmount: totalAmount,
      approvedById: approvedById ?? this.approvedById,
      approvalDate: approvalDate ?? this.approvalDate,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      reimbursementTxId: reimbursementTxId ?? this.reimbursementTxId,
    );
  }
}
