import 'i_automation_repository.dart';
import '../models/automation.dart';
import '../models/automation_logic.dart';
import '../services/automation_master_data_service.dart';

class AutomationRepositoryImpl implements IAutomationRepository {
  final _masterData = AutomationMasterDataService();

  @override
  Future<List<Automation>> getAutomations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _masterData.getMockAutomations();
  }

  @override
  Future<Automation?> getAutomationById(String id) async {
    final list = await getAutomations();
    return list.firstWhere((a) => a.id == id);
  }

  @override
  Future<void> saveAutomation(Automation automation) async {
    // Mock save
    return;
  }

  @override
  Future<void> deleteAutomation(String id) async {
    // Mock delete
    return;
  }

  @override
  Future<List<AutomationRun>> getRuns({String? automationId}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final runs = _masterData.getMockRuns();
    if (automationId != null) {
      return runs.where((r) => r.automationId == automationId).toList();
    }
    return runs;
  }

  @override
  Future<void> triggerAutomation(
      String automationId, Map<String, dynamic> context) async {
    // Execution logic would go here
    return;
  }
}
