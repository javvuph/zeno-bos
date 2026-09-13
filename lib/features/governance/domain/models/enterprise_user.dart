import 'governance_enums.dart';

class EnterpriseUser {
  final String id;
  final String email;
  final String displayName;
  final GovernanceStatus status;
  final String? profileImageUrl;
  final List<String> roleIds;
  
  // Organization Assignments
  final List<String> companyIds;
  final List<String> branchIds;
  final String? primaryBranchId;
  final String? departmentId;
  
  // ABAC Attributes
  final Map<String, dynamic> attributes;
  
  // Security State
  final DateTime? lastLogin;
  final bool mfaEnabled;
  final int failedLoginAttempts;

  const EnterpriseUser({
    required this.id,
    required this.email,
    required this.displayName,
    this.status = GovernanceStatus.active,
    this.profileImageUrl,
    this.roleIds = const [],
    this.companyIds = const [],
    this.branchIds = const [],
    this.primaryBranchId,
    this.departmentId,
    this.attributes = const {},
    this.lastLogin,
    this.mfaEnabled = false,
    this.failedLoginAttempts = 0,
  });
}

class EnterpriseRole {
  final String id;
  final String name;
  final String description;
  final bool isSystemRole;
  final List<EnterprisePermission> permissions;

  const EnterpriseRole({
    required this.id,
    required this.name,
    required this.description,
    this.isSystemRole = false,
    this.permissions = const [],
  });
}

class EnterprisePermission {
  final String id;
  final String module;
  final String entity;
  final Set<PermissionLevel> levels;

  const EnterprisePermission({
    required this.id,
    required this.module,
    required this.entity,
    this.levels = const {PermissionLevel.view},
  });
}
