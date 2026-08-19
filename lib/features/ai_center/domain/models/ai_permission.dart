class AIPermission {
  final String userId;
  final List<String> allowedModelIds;
  final int monthlyTokenLimit;
  final bool canManageModels;

  const AIPermission({
    required this.userId,
    this.allowedModelIds = const [],
    this.monthlyTokenLimit = 1000000,
    this.canManageModels = false,
  });
}
