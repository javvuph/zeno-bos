import '../models/automation.dart';
import '../models/automation_logic.dart';

abstract class IAutomationRepository {
  Future<List<Automation>> getAutomations();
  Future<Automation?> getAutomationById(String id);
  Future<void> saveAutomation(Automation automation);
  Future<void> deleteAutomation(String id);
  Future<List<AutomationRun>> getRuns({String? automationId});
  Future<void> triggerAutomation(String automationId, Map<String, dynamic> context);
}
