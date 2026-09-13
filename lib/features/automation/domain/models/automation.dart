import 'automation_enums.dart';
import 'automation_logic.dart';

class Automation {
  final String id;
  final String name;
  final String? description;
  final AutomationStatus status;
  final AutomationTrigger trigger;
  final List<AutomationCondition> conditions;
  final List<AutomationAction> actions;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int totalRuns;
  final int failedRuns;
  final Map<String, dynamic> analytics;

  const Automation({
    required this.id,
    required this.name,
    this.description,
    required this.status,
    required this.trigger,
    this.conditions = const [],
    this.actions = const [],
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.totalRuns = 0,
    this.failedRuns = 0,
    this.analytics = const {},
  });

  double get successRate =>
      totalRuns > 0 ? ((totalRuns - failedRuns) / totalRuns) * 100 : 0.0;
}
