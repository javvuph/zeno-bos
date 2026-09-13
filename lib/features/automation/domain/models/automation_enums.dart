enum AutomationStatus { active, draft, paused, failed, archived }

enum TriggerSource {
  inventory,
  sales,
  procurement,
  crm,
  hr,
  finance,
  reports,
  system,
  custom
}

enum TriggerType {
  // Inventory
  productCreated,
  productUpdated,
  stockLow,
  stockOut,
  stockReceived,
  stockTransferred,
  stockCountCompleted,
  stockAdjustment,

  // Sales
  saleCreated,
  invoiceCreated,
  paymentReceived,
  creditLimitReached,
  paymentOverdue,
  salesTargetReached,
  salesReturnCreated,

  // Procurement
  purchaseOrderCreated,
  poApproved,
  poPending,
  grnCreated,
  vendorBillCreated,
  vendorBillDue,
  supplierPerformanceAlert,

  // CRM
  leadCreated,
  leadQualified,
  opportunityCreated,
  opportunityStageChanged,
  opportunityWon,
  opportunityLost,
  customerInactive,
  customerChurnRisk,
  ticketCreated,
  slaNearBreach,
  slaBreached,
  campaignCompleted,

  // HR
  employeeCreated,
  employeeJoined,
  leaveRequested,
  leaveApproved,
  leaveRejected,
  attendanceException,
  overtimeThreshold,
  payrollReady,
  payrollApproved,
  payrollCompleted,
  performanceReviewDue,

  // Finance
  expenseCreated,
  expenseApproved,
  expenseRejected,
  paymentDue,
  receivableOverdue,
  payableDue,
  bankTransactionCreated,
  bankReconciliationCompleted,
  budgetThresholdReached,
  budgetExceeded,
  assetDueForMaintenance,
  depreciationPosted,
  taxFilingDue,
  financialPeriodClosing,

  // Reports
  reportGenerated,
  reportScheduled,
  kpiThresholdReached,
  biAnomalyDetected,

  // System
  userCreated,
  roleChanged,
  approvalPending,
  securityEvent,
  integrationFailure,
  backupFailure,
  systemHealthAlert,

  // General
  timeScheduled,
  webhookInbound
}

enum ConditionOperator {
  equals,
  notEquals,
  greaterThan,
  lessThan,
  greaterThanOrEqual,
  lessThanOrEqual,
  contains,
  startsWith,
  isEmpty,
  isNotEmpty,
  dateBefore,
  dateAfter,
  inRange
}

enum LogicalOperator { and, or, not }

enum ActionType {
  sendNotification,
  sendEmail,
  sendSMS,
  sendWhatsApp,
  updateStatus,
  createRecord,
  callWebhook,
  requestApproval,
  delay,
  stop,
  escalate,
  triggerWorkflow,
  generateReport,
  postLedger
}

enum ActionStatus { pending, inProgress, completed, failed, cancelled }

enum RunStatus { success, failed, partiallySuccessful, running }
