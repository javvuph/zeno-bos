enum UserStatus { active, suspended, invited }

class User {
  final String id;
  final String email;
  final String displayName;
  final UserStatus status;
  final String? profileImageUrl;
  final List<String> roleIds;
  final List<String> branchPermissions; // IDs of branches this user can access

  const User({
    required this.id,
    required this.email,
    required this.displayName,
    this.status = UserStatus.invited,
    this.profileImageUrl,
    this.roleIds = const [],
    this.branchPermissions = const [],
  });
}

class UserRole {
  final String id;
  final String name;
  final String description;
  final bool isSystemRole;
  final List<Permission> permissionMatrix;

  const UserRole({
    required this.id,
    required this.name,
    required this.description,
    this.isSystemRole = false,
    this.permissionMatrix = const [],
  });
}

class Permission {
  final String id;
  final String module; // e.g., 'billing', 'inventory'
  final String screen; // e.g., 'invoice_list', 'stock_adjustment'
  final bool canView;
  final bool canCreate;
  final bool canEdit;
  final bool canDelete;
  final bool canApprove;

  const Permission({
    required this.id,
    required this.module,
    required this.screen,
    this.canView = false,
    this.canCreate = false,
    this.canEdit = false,
    this.canDelete = false,
    this.canApprove = false,
  });
}

class SecurityAuditLog {
  final String id;
  final String userId;
  final String
      eventType; // e.g., 'login', 'logout', 'failed_login', 'password_change'
  final String details;
  final String ipAddress;
  final String deviceId;
  final DateTime timestamp;

  const SecurityAuditLog({
    required this.id,
    required this.userId,
    required this.eventType,
    required this.details,
    required this.ipAddress,
    required this.deviceId,
    required this.timestamp,
  });
}

class LoginHistory {
  final String id;
  final String userId;
  final DateTime loginTime;
  final DateTime? logoutTime;
  final String status; // 'success', 'failed'
  final String failureReason;

  const LoginHistory({
    required this.id,
    required this.userId,
    required this.loginTime,
    this.logoutTime,
    required this.status,
    this.failureReason = '',
  });
}

class UserSession {
  final String id;
  final String userId;
  final String deviceId;
  final DateTime startTime;
  final DateTime? endTime;
  final String ipAddress;

  const UserSession({
    required this.id,
    required this.userId,
    required this.deviceId,
    required this.startTime,
    this.endTime,
    required this.ipAddress,
  });
}
