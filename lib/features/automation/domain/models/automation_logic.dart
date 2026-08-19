import 'automation_enums.dart';

class AutomationTrigger {
  final TriggerSource source;
  final TriggerType type;
  final Map<String, dynamic> metadata;

  const AutomationTrigger({
    required this.source,
    required this.type,
    this.metadata = const {},
  });
}

class AutomationCondition {
  final String? field;
  final ConditionOperator? operator;
  final dynamic value;
  final LogicalOperator logicalOperator;
  final List<AutomationCondition> nestedConditions;

  const AutomationCondition({
    this.field,
    this.operator,
    this.value,
    this.logicalOperator = LogicalOperator.and,
    this.nestedConditions = const [],
  });

  bool get isGroup => nestedConditions.isNotEmpty;
}

class AutomationAction {
  final String id;
  final ActionType type;
  final Map<String, dynamic> parameters;
  final ActionStatus status;
  final int order;
  final bool waitForCompletion;

  const AutomationAction({
    required this.id,
    required this.type,
    this.parameters = const {},
    this.status = ActionStatus.pending,
    this.order = 0,
    this.waitForCompletion = true,
  });
}

class AutomationRun {
  final String id;
  final String automationId;
  final DateTime startedAt;
  final DateTime? completedAt;
  final RunStatus status;
  final String? errorMessage;
  final List<String> executedActionIds;
  final Map<String, dynamic> contextData;

  const AutomationRun({
    required this.id,
    required this.automationId,
    required this.startedAt,
    this.completedAt,
    required this.status,
    this.errorMessage,
    this.executedActionIds = const [],
    this.contextData = const {},
  });
}
