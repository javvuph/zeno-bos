import 'package:flutter/material.dart';
import '../../domain/repositories/i_administration_repository.dart';
import '../../domain/models/system.dart';
import '../../domain/models/organization.dart';
import '../../domain/models/settings.dart';
import '../../domain/models/user_security.dart';
import '../../domain/services/administration_business_logic.dart';
import '../../domain/services/administration_master_data_service.dart';
import 'package:zeno/core/services/global_context_manager.dart';
import 'package:zeno/core/sync/sync_manager.dart';
import 'package:zeno/core/sync/replication_manager.dart';
import 'package:zeno/core/di/service_locator.dart';

class AdministrationController extends ChangeNotifier {
  final IAdministrationRepository _repository;
  final AdministrationBusinessLogic _logic = AdministrationBusinessLogic();
  final AdministrationMasterDataService _masterData =
      AdministrationMasterDataService();
  final GlobalContextManager _contextManager = sl<GlobalContextManager>();
  final SyncManager _syncManager = sl<SyncManager>();
  final ReplicationManager _replicationManager = sl<ReplicationManager>();

  AdministrationController(this._repository) {
    _contextManager.addListener(notifyListeners);
    _syncManager.addListener(notifyListeners);
    _replicationManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _contextManager.removeListener(notifyListeners);
    _syncManager.removeListener(notifyListeners);
    _replicationManager.removeListener(notifyListeners);
    super.dispose();
  }

  SyncManager get syncManager => _syncManager;
  ReplicationManager get replicationManager => _replicationManager;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Branch> _branches = [];
  List<Branch> get branches =>
      _branches.isEmpty ? _masterData.getMockBranches() : _branches;

  List<AuditLog> _auditLogs = [];
  List<AuditLog> get auditLogs =>
      _auditLogs.isEmpty ? _masterData.getMockAuditLogs() : _auditLogs;

  SyncStats? _syncStats;
  SyncStats get syncStats => _syncStats ?? _masterData.getMockSyncStats();

  SystemHealth? _health;
  SystemHealth get health => _health ?? _masterData.getMockHealth();

  List<BackgroundJob> _jobs = [];
  List<BackgroundJob> get jobs =>
      _jobs.isEmpty ? _masterData.getMockJobs() : _jobs;

  List<User> _users = [];
  List<User> get users => _users.isEmpty ? _masterData.getMockUsers() : _users;

  List<UserRole> _roles = [];
  List<UserRole> get roles =>
      _roles.isEmpty ? _masterData.getMockRoles() : _roles;

  DiagnosticReport? _lastDiagnostic;
  DiagnosticReport get lastDiagnostic =>
      _lastDiagnostic ?? _masterData.getMockDiagnostic();

  Company get company =>
      _contextManager.current.company ?? _masterData.getMockCompany();
  BusinessSettings get settings => _masterData.getMockSettings();

  Future<void> refreshDashboard() async {
    _isLoading = true;
    notifyListeners();
    try {
      _branches = await _repository.getBranches();
      _auditLogs = await _repository.getAuditLogs('all');
      _syncStats = await _repository.getSyncStats();
      _jobs = await _repository.getBackgroundJobs();
      _users = await _repository.getUsers();
      _roles = await _repository.getRoles();
      await loadSystemHealth();
    } catch (e) {
      debugPrint("Refresh Admin Dashboard Failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void switchBranchContext(Branch branch) {
    _contextManager.updateBranch(branch);
    notifyListeners();
  }

  // KPI Bridges
  double get systemReadyScore => _logic.calculateSystemReadyScore(
        company: company,
        settings: settings,
        health: health,
      );

  Future<void> runDiagnostics() async {
    _isLoading = true;
    notifyListeners();
    try {
      _lastDiagnostic = _logic.runIntegrityCheck(health);
    } catch (e) {
      debugPrint("Diagnostics Failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSystemHealth() async {
    _isLoading = true;
    notifyListeners();
    try {
      _health = await _repository.getSystemHealth();
    } catch (e) {
      debugPrint("Error loading system health: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> triggerBackup() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.performBackup();
      await refreshDashboard();
    } catch (e) {
      debugPrint("Backup Failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> triggerRestore(String path) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.performRestore(path);
      await refreshDashboard();
    } catch (e) {
      debugPrint("Restore Failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveUser(User user) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveUser(user);
      await refreshDashboard();
    } catch (e) {
      debugPrint("Save User Failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveRole(UserRole role) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveRole(role);
      await refreshDashboard();
    } catch (e) {
      debugPrint("Save Role Failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCompany(Company company) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.updateCompanyProfile(company);
      await refreshDashboard();
    } catch (e) {
      debugPrint("Update Company Failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateSettings(BusinessSettings settings) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.updateSettings(settings);
      await refreshDashboard();
    } catch (e) {
      debugPrint("Update Settings Failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Master switch for document number generation
  String getNextDocumentNumber(String module, int count) {
    String prefix = settings.numberSeries[module] ?? '$module-';
    return _logic.generateDocumentNumber(prefix, count);
  }
}
