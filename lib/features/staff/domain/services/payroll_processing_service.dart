import 'package:zeno/features/finance/domain/models/journal_entry.dart';
import 'package:zeno/features/finance/domain/models/journal_line.dart';
import 'package:zeno/features/finance/domain/repositories/i_finance_repository.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../models/employee.dart';
import '../models/payroll_record.dart';
import '../repositories/i_staff_repository.dart';
import 'package:uuid/uuid.dart';

class PayrollProcessingService {
  final IStaffRepository _repository;

  PayrollProcessingService(this._repository);

  Future<void> processMonthlyPayroll(String month) async {
    final employees = await _repository.getEmployees();
    final financeRepo = sl<IFinanceRepository>();

    for (var emp in employees) {
      if (emp.status != EmployeeStatus.active) continue;

      // In production, we'd fetch actual attendance and salary structure
      // For this implementation, we simulate a standard payroll record
      final record = PayrollRecord(
        id: const Uuid().v4(),
        employeeId: emp.id,
        month: month,
        grossAmount: 3500.0,
        netAmount: 3000.0,
        taxes: 500.0,
        isPaid: true,
        paymentDate: DateTime.now(),
      );

      await _repository.savePayrollRecord(record);

      // Integration: Post Journal Entry to Finance
      final journal = JournalEntry(
        id: const Uuid().v4(),
        referenceNumber: "PAY-$month-${emp.id}",
        date: DateTime.now(),
        description: "Salary Disbursement - ${emp.name}",
        createdById: 'admin',
        sourceModule: 'staff',
        sourceDocumentId: record.id,
        lines: [
          const JournalLine(
            accountId: 'acc-exp-sal-001', // Salary Expense
            debit: 3500.0,
            memo: "Gross Salary",
          ),
          const JournalLine(
            accountId: 'acc-cash-001', // Cash/Bank
            credit: 3000.0,
            memo: "Net Paid",
          ),
          const JournalLine(
            accountId: 'acc-tax-pay-001', // Tax Payable
            credit: 500.0,
            memo: "Withholding Tax",
          ),
        ],
        status: JournalEntryStatus.posted,
      );

      await financeRepo.postJournalEntry(journal);
    }
  }
}
