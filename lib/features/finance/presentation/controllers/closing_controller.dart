import 'package:flutter/material.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../../domain/models/closing_task.dart';
import '../../domain/models/fiscal_period.dart';
import '../../domain/services/closing_engine.dart';
import '../../domain/services/finance_master_data_service.dart';

class ClosingController extends ChangeNotifier {
  final IFinanceRepository _repository;
  final ClosingEngine _engine = ClosingEngine();
  final FinanceMasterDataService _masterData = FinanceMasterDataService();

  ClosingController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ClosingTask> _tasks = [];
  List<ClosingTask> get tasks =>
      _tasks.isEmpty ? _masterData.getMockClosingTasks() : _tasks;

  String _selectedPeriodId = 'p_2026_08';
  String get selectedPeriodId => _selectedPeriodId;

  // KPI Bridges
  double get closingReadiness => _engine.calculateReadinessScore(tasks);
  int get pendingTasksCount =>
      tasks.where((t) => t.status != ClosingTaskStatus.completed).length;

  Future<void> loadClosingData(String periodId) async {
    _selectedPeriodId = periodId;
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await _repository.getClosingChecklist(periodId);
    } catch (e) {
      debugPrint("Error loading closing data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleTaskStatus(ClosingTask task) async {
    final newStatus = task.status == ClosingTaskStatus.completed
        ? ClosingTaskStatus.pending
        : ClosingTaskStatus.completed;
    final updated = task.copyWith(
        status: newStatus,
        completedAt:
            newStatus == ClosingTaskStatus.completed ? DateTime.now() : null);

    // Optimistic update
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = updated;
      notifyListeners();
    }

    try {
      await _repository.updateClosingTask(updated);
    } catch (e) {
      debugPrint("Error updating closing task: $e");
    }
  }

  Future<void> lockPeriod() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.updatePeriodStatus(
          _selectedPeriodId, FiscalPeriodStatus.locked);
      await loadClosingData(_selectedPeriodId);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
