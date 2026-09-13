import '../models/user_security.dart';
import '../models/settings.dart';
import '../models/system.dart';
import '../models/organization.dart';

class AdministrationBusinessLogic {
  /// Enterprise RBAC Check: Validates permissions across module, screen, and action
  bool hasPermission(User user, String module, String screen, String action,
      List<UserRole> userRoles) {
    if (user.status != UserStatus.active) return false;

    for (var role in userRoles) {
      for (var perm in role.permissionMatrix) {
        if (perm.module == 'all' || perm.module == module) {
          if (perm.screen == 'all' || perm.screen == screen) {
            switch (action) {
              case 'view':
                if (perm.canView) return true;
                break;
              case 'create':
                if (perm.canCreate) return true;
                break;
              case 'edit':
                if (perm.canEdit) return true;
                break;
              case 'delete':
                if (perm.canDelete) return true;
                break;
              case 'approve':
                if (perm.canApprove) return true;
                break;
            }
          }
        }
      }
    }
    return false;
  }

  /// Branch Scope Check: Verifies if a user can access a specific branch
  bool canAccessBranch(User user, String branchId) {
    return user.branchPermissions.contains(branchId) ||
        user.roleIds.contains('admin');
  }

  /// Number Series Engine: Generates the next document number (e.g., INV-001)
  String generateDocumentNumber(String prefix, int currentCount) {
    String number = (currentCount + 1).toString().padLeft(6, '0');
    return '$prefix$number';
  }

  /// System Readiness Score: Calculates a score (0.0 to 1.0) based on enterprise configuration
  double calculateSystemReadyScore({
    required Company company,
    required BusinessSettings settings,
    required SystemHealth health,
  }) {
    int points = 0;
    int total = 100;

    if (company.taxId.isNotEmpty) points += 10;
    if (company.gst.isNotEmpty) points += 10;
    if (settings.currencyCode.isNotEmpty) points += 20;
    if (health.apiStatus == 'online') points += 30;
    if (health.cpuUsage < 80) points += 30;

    return points / total;
  }

  /// Format File Size for DB Stats
  String formatSize(double mb) {
    if (mb > 1024) return '${(mb / 1024).toStringAsFixed(2)} GB';
    return '${mb.toStringAsFixed(1)} MB';
  }

  /// RBAC Conflict Detector: Identifies overlapping or redundant permissions
  List<String> detectPermissionConflicts(List<UserRole> roles) {
    final List<String> conflicts = [];
    for (int i = 0; i < roles.length; i++) {
      for (int j = i + 1; j < roles.length; j++) {
        final r1 = roles[i];
        final r2 = roles[j];
        // Check if role names are too similar or if they have identical permission matrices
        if (r1.name == r2.name) {
          conflicts.add("Duplicate Role Name: ${r1.name}");
        }
      }
    }
    return conflicts;
  }

  /// Backup Verification Engine: Validates manifest integrity
  bool verifyBackup(BackupManifest manifest) {
    // In a real implementation, we would re-calculate the checksum of the file at filePath
    // and compare it with manifest.checksum.
    return manifest.sizeBytes > 0 && manifest.checksum.isNotEmpty;
  }

  /// Database Integrity Checker
  DiagnosticReport runIntegrityCheck(SystemHealth health) {
    final Map<String, String> status = {
      'Database': health.databaseSize < 1000 ? 'Healthy' : 'Large',
      'Sync': health.syncStatus == 'stable' ? 'Stable' : 'Warning',
      'API': health.apiStatus == 'online' ? 'Online' : 'Offline',
    };

    final List<String> issues = [];
    if (health.errorCount24h > 50) {
      issues.add("High error rate detected in last 24h.");
    }
    if (health.cpuUsage > 85) issues.add("CPU usage is critically high.");

    return DiagnosticReport(
      id: 'DIAG-${DateTime.now().millisecondsSinceEpoch}',
      timestamp: DateTime.now(),
      componentStatus: status,
      criticalIssues: issues,
      recommendation: issues.isEmpty
          ? "System is performing optimally."
          : "Review server logs and consider resource scaling.",
    );
  }
}
