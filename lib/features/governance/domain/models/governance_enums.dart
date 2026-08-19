enum GovernanceStatus { active, inactive, restricted, pending_approval }

enum PermissionLevel {
  view,
  create,
  edit,
  delete,
  approve,
  export,
  execute,
  admin
}

enum AuditSeverity { low, medium, high, critical }

enum EntityType {
  user,
  role,
  permission,
  company,
  branch,
  department,
  warehouse,
  costCenter,
  tax,
  currency,
  automation,
  report,
  integration,
  securityPolicy,
  database,
  backup
}

enum HealthStatus { healthy, degraded, critical, offline }

enum IntegrationType {
  payment,
  banking,
  messaging,
  email,
  ai,
  tax_service,
  api_external
}

enum AuthEventType {
  login_success,
  login_failed,
  logout,
  password_reset,
  mfa_verified,
  mfa_failed,
  session_revoked,
  force_logout
}
