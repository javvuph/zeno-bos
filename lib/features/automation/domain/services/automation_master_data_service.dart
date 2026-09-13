import '../models/automation.dart';
import '../models/automation_enums.dart';
import '../models/automation_logic.dart';

class AutomationMasterDataService {
  List<Automation> getMockAutomations() {
    return [
      Automation(
        id: 'auto_1',
        name: 'Low Stock Alert & PO Suggestion',
        description:
            'Automatically notify procurement and draft a PO when stock level drops below reorder point.',
        status: AutomationStatus.active,
        trigger: const AutomationTrigger(
            source: TriggerSource.inventory, type: TriggerType.stockLow),
        conditions: [
          const AutomationCondition(
            field: 'warehouse',
            operator: ConditionOperator.equals,
            value: 'Main HQ',
          ),
        ],
        actions: [
          const AutomationAction(
            id: 'act_1_1',
            type: ActionType.sendNotification,
            parameters: {'target': 'Procurement Team', 'priority': 'High'},
            order: 1,
          ),
          const AutomationAction(
            id: 'act_1_2',
            type: ActionType.createRecord,
            parameters: {'type': 'PurchaseOrderSuggestion'},
            order: 2,
          ),
        ],
        createdBy: 'Admin',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
        totalRuns: 145,
        failedRuns: 3,
      ),
      Automation(
        id: 'auto_2',
        name: 'High Value Sales Approval',
        description: 'Orders above ₹500,000 require CFO approval.',
        status: AutomationStatus.active,
        trigger: const AutomationTrigger(
            source: TriggerSource.sales, type: TriggerType.saleCreated),
        conditions: [
          const AutomationCondition(
            field: 'total_amount',
            operator: ConditionOperator.greaterThan,
            value: 500000.0,
          ),
        ],
        actions: [
          const AutomationAction(
            id: 'act_2_1',
            type: ActionType.requestApproval,
            parameters: {'approver': 'CFO', 'timeout': '24h'},
            order: 1,
          ),
        ],
        createdBy: 'CFO Office',
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
        updatedAt: DateTime.now().subtract(const Duration(days: 10)),
        totalRuns: 28,
        failedRuns: 0,
      ),
      Automation(
        id: 'auto_3',
        name: 'Daily Financial Summary',
        description: 'Generate and email the EOD summary to directors.',
        status: AutomationStatus.paused,
        trigger: const AutomationTrigger(
            source: TriggerSource.system, type: TriggerType.timeScheduled),
        actions: [
          const AutomationAction(
            id: 'act_3_1',
            type: ActionType.generateReport,
            parameters: {'report_id': 'financial_summary_eod'},
            order: 1,
          ),
          const AutomationAction(
            id: 'act_3_2',
            type: ActionType.sendEmail,
            parameters: {'recipients': 'directors@zeno.com'},
            order: 2,
          ),
        ],
        createdBy: 'Finance Manager',
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        totalRuns: 12,
        failedRuns: 1,
      ),
    ];
  }

  List<AutomationRun> getMockRuns() {
    return [
      AutomationRun(
        id: 'run_101',
        automationId: 'auto_1',
        startedAt: DateTime.now().subtract(const Duration(minutes: 45)),
        completedAt: DateTime.now().subtract(const Duration(minutes: 44)),
        status: RunStatus.success,
        executedActionIds: ['act_1_1', 'act_1_2'],
      ),
      AutomationRun(
        id: 'run_102',
        automationId: 'auto_2',
        startedAt: DateTime.now().subtract(const Duration(hours: 3)),
        status: RunStatus.running,
        contextData: {'order_id': 'SO-9921', 'amount': 650000.0},
      ),
      AutomationRun(
        id: 'run_103',
        automationId: 'auto_1',
        startedAt: DateTime.now().subtract(const Duration(hours: 5)),
        completedAt: DateTime.now().subtract(const Duration(hours: 5)),
        status: RunStatus.failed,
        errorMessage: 'Connection timeout to Notification service',
        executedActionIds: [],
      ),
    ];
  }
}
