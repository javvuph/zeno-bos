enum ZenoRole {
  ceo,
  manager,
  cashier,
  warehouse,
  accountant,
  hr,
  admin,
}

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  ZenoRole _currentRole = ZenoRole.ceo; // Default for demo

  ZenoRole get currentRole => _currentRole;

  void setRole(ZenoRole role) {
    _currentRole = role;
  }

  bool hasPermission(String permission) {
    // Enterprise role-based logic
    switch (_currentRole) {
      case ZenoRole.admin:
      case ZenoRole.ceo:
        return true; // Full access
      case ZenoRole.cashier:
        return ["sales_view", "sales_create", "inventory_view"]
            .contains(permission);
      case ZenoRole.warehouse:
        return ["inventory_view", "inventory_edit", "delivery_view"]
            .contains(permission);
      case ZenoRole.accountant:
        return ["finance_view", "finance_edit", "sales_view"]
            .contains(permission);
      case ZenoRole.hr:
        return ["hr_view", "hr_edit", "staff_view"].contains(permission);
      case ZenoRole.manager:
        return !permission.contains("delete") && !permission.contains("admin");
    }
  }

  bool canViewWidget(List<String> requiredPermissions) {
    if (requiredPermissions.isEmpty) return true;
    return requiredPermissions.any((p) => hasPermission(p));
  }
}
