part of '../zeno_router.dart';

Widget? resolveRoutePart2(String route, Map<String, dynamic>? params) {
  switch (route) {
    case 'procurement/orders':
      return const PurchaseOrderCommandCenterScreen();
    case 'procurement/suppliers':
      return const SupplierDashboardScreen();
    case 'procurement/rfq':
      return const RFQCommandCenterScreen();
    case 'procurement/receiving':
      return const GoodsReceivedListScreen();
    case 'procurement/bills':
      return const VendorBillCommandCenterScreen();
    case 'procurement/payables':
      return const PayablesCommandCenterScreen();
    case 'procurement/landed-cost':
      return const UnifiedReportViewerScreen(
          reportTitle: "Landed Cost Analysis", module: 'procurement');
    case 'procurement/intelligence':
      return const SupplierAIHubScreen();
    case 'procurement/reports':
      return const UnifiedReportViewerScreen(
          reportTitle: "Procurement Analytics", module: 'procurement');

    case 'crm/customers':
      return const Customer360DashboardScreen();
    case 'crm/leads':
      return const OpportunityPipelineScreen();
    case 'crm/activities':
      return const CRMExecutiveDashboard();
    case 'crm/campaigns':
      return const CampaignDashboardScreen();
    case 'crm/tickets':
      return const ServiceDeskScreen();
    case 'crm/loyalty':
      return const LoyaltyProgramScreen();
    case 'crm/intelligence':
      return const CustomerAIHubScreen();
    case 'crm/reports':
      return const UnifiedReportViewerScreen(
          reportTitle: "CRM Analytics", module: 'crm');

    case 'hr/staff':
      return const StaffListScreen();
    case 'hr/attendance':
      return const AttendanceHubScreen();
    case 'hr/leave':
      return const LeaveManagementScreen();
    case 'hr/payroll':
      return const PayrollCommandCenterScreen();
    case 'hr/recruitment':
      return const RecruitmentHubScreen();
    case 'hr/performance':
      return const PerformanceDashboardScreen();
    case 'hr/intelligence':
      return const StaffAIHubScreen();
    case 'hr/reports':
      return const UnifiedReportViewerScreen(
          reportTitle: "HR Analytics", module: 'hr');

    case 'reports/builder':
      return const ReportBuilderScreen();
    case 'reports/executive':
      return const ExecutiveBIScreen();
    case 'reports/financial':
      return const UnifiedReportViewerScreen(
          reportTitle: "Profit \u0026 Loss", module: 'finance');
    case 'reports/sales':
      return const UnifiedReportViewerScreen(
          reportTitle: "Sales Performance", module: 'sales');
    case 'reports/inventory':
      return const UnifiedReportViewerScreen(
          reportTitle: "Inventory Valuation", module: 'inventory');
    case 'reports/procurement':
      return const UnifiedReportViewerScreen(
          reportTitle: "Procurement Analytics", module: 'procurement');
    case 'reports/hr':
      return const UnifiedReportViewerScreen(
          reportTitle: "HR Analytics", module: 'hr');
    case 'reports/crm':
      return const UnifiedReportViewerScreen(
          reportTitle: "CRM Analytics", module: 'crm');

    case 'finance/ledger':
      return const GeneralLedgerCommandCenterScreen();
    case 'finance/journal':
      return const JournalEntryFormScreen();
    case 'finance/payables':
      return const PayablesCommandCenterScreen();
    case 'finance/banking':
      return const BankingCommandCenterScreen();
    case 'finance/budget':
      return const BudgetCommandCenterScreen();
    case 'finance/assets':
      return const FixedAssetCommandCenterScreen();
    case 'finance/tax':
      return const TaxManagementHubScreen();
    case 'finance/closing':
      return const FinancialClosingCommandCenterScreen();
    case 'finance/intelligence':
      return const FinanceIntelligenceCommandCenterScreen();
    case 'finance/reports':
      return const UnifiedReportViewerScreen(
          reportTitle: "Finance Analytics", module: 'finance');

    case 'ai/home':
      return const AIChatScreen();
    case 'ai/risk':
    case 'ai/sales-forecast':
    case 'ai/stock-forecast':
      return const AIDashboardScreen();
    case 'ai/fraud':
      return const SecurityCenterScreen();
    case 'ai/automation':
      return const AutomationCommandCenterScreen();

    case 'admin/profile':
      return const StoreSetupModal();
    case 'admin/security':
      return const SecurityCenterScreen();
    case 'admin/workflows':
      return const AutomationCommandCenterScreen();
    case 'admin/governance':
      return const GovernanceHubScreen();
    case 'admin/automation':
      return const AutomationCommandCenterScreen();
    case 'admin/automation/builder':
      return const AutomationBuilderScreen();
    case 'admin/audit':
      return const AuditCenterScreen();
    case 'admin/backup':
      return const BackupCenterScreen();
    case 'admin/settings':
      return const SettingsMainScreen();
    case 'admin/integrations':
      return const IntegrationGovernanceScreen();
    case 'admin/security-policy':
      return const SecurityPolicyScreen();
    case 'admin/health':
      return const SystemHealthScreen();
    default:
      return null;
  }
}
