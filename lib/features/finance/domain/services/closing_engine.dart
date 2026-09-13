import '../models/closing_task.dart';
import '../models/journal_entry.dart';

class ClosingEngine {
  /// Generates a standard closing checklist for a specific fiscal period
  List<ClosingTask> generateClosingChecklist(String periodId) {
    return [
      const ClosingTask(
        id: 'TASK-GL-01',
        title: 'Reconcile Bank Statements',
        description:
            'Verify all bank transactions match internal treasury ledgers.',
        category: 'Banking',
      ),
      const ClosingTask(
        id: 'TASK-ASST-01',
        title: 'Run Depreciation Cycle',
        description: 'Post depreciation journals for the current period.',
        category: 'Assets',
      ),
      const ClosingTask(
        id: 'TASK-TAX-01',
        title: 'Finalize GST/VAT Returns',
        description: 'Prepare and validate tax return data for the period.',
        category: 'Tax',
      ),
      const ClosingTask(
        id: 'TASK-GL-02',
        title: 'Accrue Outstanding Expenses',
        description: 'Record accrual journals for unbilled services.',
        category: 'GL',
      ),
      const ClosingTask(
        id: 'TASK-INV-01',
        title: 'Inventory Valuation Lock',
        description: 'Finalize and freeze stock valuation for the period.',
        category: 'Inventory',
      ),
    ];
  }

  /// AI-Driven Closing Readiness Score
  double calculateReadinessScore(List<ClosingTask> tasks) {
    if (tasks.isEmpty) return 0.0;
    int completed =
        tasks.where((t) => t.status == ClosingTaskStatus.completed).length;
    return (completed / tasks.length) * 100;
  }

  /// Validates if a period is ready for Hard Close
  bool canHardClose(
      List<ClosingTask> tasks, List<JournalEntry> unpostedJournals) {
    bool allMandatoryDone = tasks
        .where((t) => t.isMandatory)
        .every((t) => t.status == ClosingTaskStatus.completed);
    return allMandatoryDone && unpostedJournals.isEmpty;
  }

  /// Suggests Exchange Rate Revaluation Adjustments (Mock)
  double calculateFxRevaluation(
      double balance, double oldRate, double newRate) {
    return (balance * newRate) - (balance * oldRate);
  }
}
