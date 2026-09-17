import 'package:flutter/material.dart';
import '../../domain/models/automation.dart';
import '../../domain/models/automation_logic.dart';
import '../../domain/models/automation_enums.dart';
import '../../domain/repositories/i_automation_repository.dart';

class AutomationController extends ChangeNotifier {
  final IAutomationRepository _repository;

  AutomationController(this._repository) {
    loadData();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Automation> _automations = [];
  List<Automation> get automations => _automations;

  List<AutomationRun> _recentRuns = [];
  List<AutomationRun> get recentRuns => _recentRuns;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _automations = await _repository.getAutomations();
      _recentRuns = await _repository.getRuns();
    } catch (e) {
      debugPrint("Error loading automation data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Dashboard Stats
  int get activeCount =>
      _automations.where((a) => a.status == AutomationStatus.active).length;
  int get draftCount =>
      _automations.where((a) => a.status == AutomationStatus.draft).length;
  int get failureCount => _recentRuns.where((r) => r.status == RunStatus.failed).length;

  double get totalTimeSaved => 0.0; // Mock hours saved
  int get actionsExecutedToday => 0; // Mock action count

  Automation? _selectedAutomation;
  Automation? get selectedAutomation => _selectedAutomation;

  void selectAutomation(Automation? automation) {
    _selectedAutomation = automation;
    notifyListeners();
  }

  Future<void> toggleStatus(String id) async {
    final index = _automations.indexWhere((a) => a.id == id);
    if (index != -1) {
      final current = _automations[index];
      final newStatus = current.status == AutomationStatus.active
          ? AutomationStatus.paused
          : AutomationStatus.active;
      
      // In a real app we would call the repo here
      _automations[index] = Automation(
        id: current.id,
        name: current.name,
        status: newStatus,
        trigger: current.trigger,
        conditions: current.conditions,
        actions: current.actions,
        createdBy: current.createdBy,
        createdAt: current.createdAt,
        updatedAt: DateTime.now(),
        totalRuns: current.totalRuns,
        failedRuns: current.failedRuns,
      );
      notifyListeners();
    }
  }
}
