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
import 'package:zeno/features/inventory/presentation/screens/inventory_workspace_screen.dart';

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
import 'package:zeno/features/billing/presentation/screens/billing_studio_screen.dart';
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

part 'zeno_router_routes.dart';
part 'parts/zeno_router_routes_part2.part.dart';

class ZenoRouter {
  static Widget getScreen(String route, {Map<String, dynamic>? params}) {
    final screen1 = resolveRoutePart1(route, params);
    if (screen1 != null) return screen1;

    final screen2 = resolveRoutePart2(route, params);
    if (screen2 != null) return screen2;

    return _buildUnderConstruction(route);
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
