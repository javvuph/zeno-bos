class UserRoleMapping {
  final String userId;
  final String roleId;
  final List<String> permissions;
  final List<String> restrictedBranches;

  const UserRoleMapping({
    required this.userId,
    required this.roleId,
    this.permissions = const [],
    this.restrictedBranches = const [],
  });
}
