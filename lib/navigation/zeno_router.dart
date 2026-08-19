import 'package:flutter/material.dart';

// --- ADMIN / GOVERNANCE ---
import 'package:zeno/features/administration/presentation/screens/security_policy_screen.dart';
import 'package:zeno/features/administration/presentation/widgets/store_setup_modal.dart';
import 'package:zeno/features/governance/presentation/screens/governance_hub_screen.dart';
import 'package:zeno/features/governance/presentation/screens/audit_center_screen.dart';
import 'package:zeno/features/governance/presentation/screens/security_center_screen.dart';
import 'package:zeno/features/governance/presentation/screens/system_health_screen.dart';
import 'package:zeno/features/governance/presentation/screens/backup_center_screen.dart';
import 'package:zeno/features/governance/presentation/screens/integration_governance_screen.dart';

// --- INVENTORY ---
import 'package:zeno/features/inventory/presentation/screens/category_command_center_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/product_command_center_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/brand_command_center_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/unit_command_center_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/variants_command_center_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/warehouse_command_center_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/inventory_rules_command_center_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/stock_operations_command_center_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/barcode_studio_command_center_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/inventory_intelligence_command_center_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/product_list_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/report_list_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/price_management_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/physical_count_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/goods_received_list_screen.dart';
import 'package:zeno/features/inventory/presentation/screens/product_studio_screen.dart';

// --- AI CENTER ---
import 'package:zeno/features/ai_center/presentation/screens/ai_chat_screen.dart';
import 'package:zeno/features/ai_center/presentation/screens/ai_dashboard_screen.dart';

// --- CRM / CUSTOMERS ---
import 'package:zeno/features/customers/presentation/screens/customer_360_dashboard_screen.dart';
import 'package:zeno/features/customers/presentation/screens/crm_executive_dashboard.dart';
import 'package:zeno/features/customers/presentation/screens/campaign_dashboard_screen.dart';
import 'package:zeno/features/customers/presentation/screens/service_desk_screen.dart';
import 'package:zeno/features/customers/presentation/screens/quotation_command_center_screen.dart';
import 'package:zeno/features/customers/presentation/screens/opportunity_pipeline_screen.dart';
import 'package:zeno/features/customers/presentation/screens/customer_ai_hub_screen.dart';
import 'package:zeno/features/customers/presentation/screens/loyalty_program_screen.dart';

// --- BILLING / FINANCE ---
import 'package:zeno/features/billing/presentation/screens/new_bill_screen.dart';
import 'package:zeno/features/billing/presentation/screens/fnb_billing_screen.dart';
import 'package:zeno/features/billing/presentation/screens/invoice_list_screen.dart';
import 'package:zeno/features/finance/presentation/screens/banking_command_center_screen.dart';
import 'package:zeno/features/finance/presentation/screens/finance_dashboard_screen.dart';
import 'package:zeno/features/finance/presentation/screens/general_ledger_command_center_screen.dart';
import 'package:zeno/features/finance/presentation/screens/budget_command_center_screen.dart';
import 'package:zeno/features/finance/presentation/screens/fixed_asset_command_center_screen.dart';
import 'package:zeno/features/finance/presentation/screens/tax_management_hub_screen.dart';
import 'package:zeno/features/finance/presentation/screens/financial_closing_command_center_screen.dart';
import 'package:zeno/features/finance/presentation/screens/finance_intelligence_command_center_screen.dart';
import 'package:zeno/features/finance/presentation/screens/journal_entry_form_screen.dart';
import 'package:zeno/features/finance/presentation/screens/payables_command_center_screen.dart';

// --- HOME / OPS ---
import 'package:zeno/features/home/presentation/screens/personalized_dashboard_screen.dart';
import 'package:zeno/features/home/presentation/screens/planner_screen.dart';

// --- ORDERS ---
import 'package:zeno/features/orders/presentation/screens/orders_dashboard_screen.dart';
import 'package:zeno/features/orders/presentation/screens/order_list_screen.dart';
import 'package:zeno/features/orders/presentation/screens/sales_order_form_screen.dart';
import 'package:zeno/features/orders/presentation/screens/order_fulfillment_screen.dart';
import 'package:zeno/features/orders/presentation/screens/order_ai_hub_screen.dart';
import 'package:zeno/features/orders/presentation/screens/fnb_table_management_screen.dart';
import 'package:zeno/features/orders/presentation/screens/fnb_kds_screen.dart';
import 'package:zeno/features/orders/presentation/screens/fnb_reservation_screen.dart';

// --- PROCUREMENT / PURCHASE ---
import 'package:zeno/features/purchase/presentation/screens/purchase_order_command_center_screen.dart';
import 'package:zeno/features/purchase/presentation/screens/rfq_command_center_screen.dart';
import 'package:zeno/features/purchase/presentation/screens/vendor_bill_command_center_screen.dart';
import 'package:zeno/features/suppliers/presentation/screens/supplier_ai_hub_screen.dart';
import 'package:zeno/features/suppliers/presentation/screens/supplier_dashboard_screen.dart';

// --- REPORTS / BI ---
import 'package:zeno/features/reports/presentation/screens/unified_report_viewer_screen.dart';
import 'package:zeno/features/reports/presentation/screens/executive_bi_screen.dart';
import 'package:zeno/features/reports/presentation/screens/report_builder_screen.dart';

// --- HR / STAFF ---
import 'package:zeno/features/staff/presentation/screens/staff_list_screen.dart';
import 'package:zeno/features/staff/presentation/screens/attendance_hub_screen.dart';
import 'package:zeno/features/staff/presentation/screens/performance_dashboard_screen.dart';
import 'package:zeno/features/staff/presentation/screens/staff_ai_hub_screen.dart';
import 'package:zeno/features/staff/presentation/screens/payroll_command_center_screen.dart';
import 'package:zeno/features/staff/presentation/screens/leave_management_screen.dart';
import 'package:zeno/features/staff/presentation/screens/recruitment_hub_screen.dart';

// --- AUTOMATION ---
import 'package:zeno/features/automation/presentation/screens/automation_command_center_screen.dart';
import 'package:zeno/features/automation/presentation/screens/automation_builder_screen.dart';

// --- SETTINGS / MISC ---
import 'package:zeno/features/settings/presentation/screens/settings_main_screen.dart';

class ZenoRouter {
  static Widget getScreen(String route, {Map<String, dynamic>? params}) {
    switch (route) {
      // --- 1. HOME ---
      case 'home':
      case 'dashboard':
        return const PersonalizedDashboardScreen();
      case 'home/tasks':
        return const PlannerScreen();
      case 'home/approvals':
        return const AutomationCommandCenterScreen();
      case 'home/activity':
        return const CRMExecutiveDashboard();

      // --- 2. INVENTORY ---
      case 'inventory/products':
        return const ProductCommandCenterScreen();
      case 'inventory/studio':
        return const ProductStudioScreen();
      case 'inventory/categories':
        return const CategoryCommandCenterScreen();
      case 'inventory/brands':
        return const BrandCommandCenterScreen();
      case 'inventory/units':
        return const UnitCommandCenterScreen();
      case 'inventory/variants':
        return const VariantsCommandCenterScreen();
      case 'inventory/warehouses':
        return const WarehouseCommandCenterScreen();
      case 'inventory/rules':
        return const InventoryRulesCommandCenterScreen();
      case 'inventory/reorder':
        return const ProductListScreen(
            filterStatus: 'low_stock', title: 'Reorder Alerts');
      case 'inventory/transfers':
        return const StockOperationsCommandCenterScreen();
      case 'inventory/barcodes':
        return const BarcodeStudioCommandCenterScreen();
      case 'inventory/stock-count':
        return const PhysicalCountScreen();
      case 'inventory/intelligence':
        return const InventoryIntelligenceCommandCenterScreen();
      case 'inventory/reports':
        return const ReportListScreen();

      // --- 3. SALES ---
      case 'sales/new':
      case 'sales/pos':
        return const NewBillScreen();
      case 'sales/fnb-billing':
        return FnbBillingScreen(
          tableId: params?['tableId'] as String?,
          guestCount: params?['guestCount'] as int?,
        );
      case 'sales/history':
      case 'sales/invoices':
        return const InvoiceListScreen();
      case 'sales/dues':
        return const FinanceDashboardScreen();
      case 'sales/quotations':
        return const QuotationCommandCenterScreen();
      case 'sales/pricing':
        return const PriceManagementScreen(focusType: 'Cost');
      case 'sales/intelligence':
        return const OrderAIHubScreen();
      case 'sales/reports':
        return const UnifiedReportViewerScreen(
            reportTitle: "Sales Performance", module: 'sales');

      // --- 4. ORDERS ---
      case 'orders/dashboard':
        return const OrdersDashboardScreen();
      case 'orders/list':
        return const OrderListScreen();
      case 'orders/new':
        return const SalesOrderFormScreen();
      case 'orders/fulfillment':
        return const OrderFulfillmentScreen(stage: 'Picking');
      case 'orders/returns':
        return const UnifiedReportViewerScreen(
            reportTitle: "Sales Returns \u0026 RMA", module: 'sales');
      case 'orders/intelligence':
        return const OrderAIHubScreen();
      case 'orders/fnb/tables':
        return const FnbTableManagementScreen();
      case 'orders/fnb/kds':
        return FnbKdsScreen(station: params?['station'] as String? ?? "Main Kitchen");
      case 'orders/fnb/reservations':
        return const FnbReservationScreen();

      // --- 5. PROCUREMENT ---
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

      // --- 6. CRM ---
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

      // --- 7. HR ---
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

      // --- 8. REPORTS ---
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

      // --- 9. FINANCE ---
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

      // --- 10. AI ---
      case 'ai/home':
        return const AIChatScreen();
      case 'ai/risk':
        return const AIDashboardScreen();
      case 'ai/sales-forecast':
        return const AIDashboardScreen();
      case 'ai/stock-forecast':
        return const AIDashboardScreen();
      case 'ai/fraud':
        return const SecurityCenterScreen();
      case 'ai/automation':
        return const AutomationCommandCenterScreen();

      // --- 11. ADMIN ---
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
        return _buildUnderConstruction(route);
    }
  }

  static Widget _buildUnderConstruction(String route) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.construction, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            "Screen \u0027$route\u0027 is under construction",
            style: const TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
