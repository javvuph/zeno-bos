import 'package:flutter/material.dart';
import '../../domain/models/enterprise_user.dart';
import '../../domain/models/audit_entry.dart';
import '../../domain/models/system_governance_models.dart';
import '../../domain/repositories/i_governance_repository.dart';

class GovernanceController extends ChangeNotifier {
  final IGovernanceRepository _repository;

  GovernanceController(this._repository) {
    refreshAll();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<EnterpriseUser> _users = [];
  List<EnterpriseUser> get users => _users;

  List<EnterpriseRole> _roles = [];
  List<EnterpriseRole> get roles => _roles;

  List<AuditEntry> _auditLogs = [];
  List<AuditEntry> get auditLogs => _auditLogs;

  List<SystemHealthEntry> _health = [];
  List<SystemHealthEntry> get health => _health;

  List<IntegrationHealth> _integrations = [];
  List<IntegrationHealth> get integrations => _integrations;

  List<BackupStatus> _backups = [];
  List<BackupStatus> get backups => _backups;

  List<UserSessionMonitor> _sessions = [];
  List<UserSessionMonitor> get sessions => _sessions;

  Future<void> refreshAll() async {
    _isLoading = true;
    notifyListeners();
    try {
      final results = await Future.wait([
        _repository.getUsers(),
        _repository.getRoles(),
        _repository.getAuditLogs(),
        _repository.getSystemHealth(),
        _repository.getIntegrationHealth(),
        _repository.getBackupHistory(),
        _repository.getActiveSessions(),
      ]);

      _users = results[0] as List<EnterpriseUser>;
      _roles = results[1] as List<EnterpriseRole>;
      _auditLogs = results[2] as List<AuditEntry>;
      _health = results[3] as List<SystemHealthEntry>;
      _integrations = results[4] as List<IntegrationHealth>;
      _backups = results[5] as List<BackupStatus>;
      _sessions = results[6] as List<UserSessionMonitor>;
    } catch (e) {
      debugPrint("Governance refresh error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Dashboard Stats
  int get activeUserCount => _users.length;
  int get sessionCount => _sessions.length;
  int get healthScore => 0; // Mock score
  int get securityScore => 0; // Mock score
  int get pendingApprovals => 0; // Mock count
  
  EnterpriseUser? _selectedUser;
  EnterpriseUser? get selectedUser => _selectedUser;

  void selectUser(EnterpriseUser? user) {
    _selectedUser = user;
    notifyListeners();
  }

  Future<void> revokeSession(String sessionId) async {
    await _repository.revokeSession(sessionId);
    _sessions.removeWhere((s) => s.id == sessionId);
    notifyListeners();
  }

  Future<void> triggerBackup() async {
    await _repository.triggerBackup();
    refreshAll();
  }
}
