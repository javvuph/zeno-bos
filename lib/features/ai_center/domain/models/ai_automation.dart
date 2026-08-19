enum AutomationTrigger { schedule, event, manual, threshold, anomaly }

enum AutomationStatus { active, paused, completed, failed, draft }

class AIAutomation {
  final String id;
  final String name;
  final String description;
  final AutomationTrigger trigger;
  final Map<String, dynamic> action;
  final AutomationStatus status;

  const AIAutomation({
    required this.id,
    required this.name,
    required this.description,
    required this.trigger,
    required this.action,
    this.status = AutomationStatus.active,
  });
}

class AITask {
  final String id;
  final String automationId;
  final String name;
  final String status;
  final DateTime startedAt;
  final DateTime? finishedAt;

  const AITask({
    required this.id,
    required this.automationId,
    required this.name,
    required this.status,
    required this.startedAt,
    this.finishedAt,
  });
}
