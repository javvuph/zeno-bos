import 'package:flutter/material.dart';

class ZenoMenuItem {
  final String label;
  final String? description;
  final IconData icon;
  final String? route;
  final bool isAI;
  final Color? color;

  const ZenoMenuItem({
    required this.label,
    this.description,
    required this.icon,
    this.route,
    this.isAI = false,
    this.color,
  });
}

class ZenoMenuColumn {
  final String title;
  final List<ZenoMenuItem> items;
  final Color? color;

  const ZenoMenuColumn({
    required this.title,
    required this.items,
    this.color,
  });
}

class ZenoMenuCategory {
  final String id;
  final String label;
  final IconData icon;
  final Color color;
  final List<ZenoMenuColumn> columns;
  final bool hasDropdown;

  const ZenoMenuCategory({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
    required this.columns,
    this.hasDropdown = true,
  });
}

class MenuRegistry {
  static const List<ZenoMenuCategory> all = [
    // --- 1. HOME ---
    ZenoMenuCategory(
      id: 'home',
      label: 'HOME',
      icon: Icons.home_rounded,
      color: Color(0xFF3B82F6), // Blue
      columns: [
        ZenoMenuColumn(
          title: 'STRATEGIC HUB',
          items: [
            ZenoMenuItem(
                label: 'Dashboard',
                icon: Icons.dashboard_rounded,
                route: 'dashboard'),
            ZenoMenuItem(
                label: 'My Tasks',
                icon: Icons.assignment_rounded,
                route: 'home/tasks'),
            ZenoMenuItem(
                label: 'Approvals',
                icon: Icons.verified_rounded,
                route: 'home/approvals'),
            ZenoMenuItem(
                label: 'Activity Feed',
                icon: Icons.sensors_rounded,
                route: 'home/activity'),
          ],
        ),
      ],
    ),

    // --- 2. INVENTORY ---
    ZenoMenuCategory(
      id: 'inventory',
      label: 'INVENTORY',
      icon: Icons.inventory_2_rounded,
      color: Color(0xFFF59E0B), // Amber
      columns: [
        ZenoMenuColumn(
          title: 'INVENTORY MASTER',
          items: [
            ZenoMenuItem(
                label: 'Products',
                icon: Icons.inventory_2_rounded,
                route: 'inventory/products'),
            ZenoMenuItem(
                label: 'Categories',
                icon: Icons.category_rounded,
                route: 'inventory/categories'),
            ZenoMenuItem(
                label: 'Brands',
                icon: Icons.branding_watermark_rounded,
                route: 'inventory/brands'),
            ZenoMenuItem(
                label: 'Units',
                icon: Icons.straighten_rounded,
                route: 'inventory/units'),
            ZenoMenuItem(
                label: 'Variants \u0026 Bundles',
                icon: Icons.account_tree_rounded,
                route: 'inventory/variants'),
            ZenoMenuItem(
                label: 'Warehouses',
                icon: Icons.warehouse_rounded,
                route: 'inventory/warehouses'),
            ZenoMenuItem(
                label: 'Inventory Rules',
                icon: Icons.rule_rounded,
                route: 'inventory/rules'),
            ZenoMenuItem(
                label: 'Reorder Alerts',
                icon: Icons.notification_important_rounded,
                route: 'inventory/reorder'),
            ZenoMenuItem(
                label: 'Stock Transfers',
                icon: Icons.swap_horiz_rounded,
                route: 'inventory/transfers'),
            ZenoMenuItem(
                label: 'Barcode Studio',
                icon: Icons.qr_code_scanner_rounded,
                route: 'inventory/barcodes'),
            ZenoMenuItem(
                label: 'Stock Count',
                icon: Icons.fact_check_rounded,
                route: 'inventory/stock-count'),
            ZenoMenuItem(
                label: 'Intelligence',
                icon: Icons.auto_awesome_rounded,
                route: 'inventory/intelligence'),
            ZenoMenuItem(
                label: 'Reports',
                icon: Icons.assessment_rounded,
                route: 'inventory/reports'),
          ],
        ),
      ],
    ),

    // --- 3. SALES ---
    ZenoMenuCategory(
      id: 'sales',
      label: 'SALES',
      icon: Icons.shopping_cart_rounded,
      color: Color(0xFF10B981), // Emerald
      columns: [
        ZenoMenuColumn(
          title: 'TACTICAL SALES',
          items: [
            ZenoMenuItem(
                label: 'New Sale',
                icon: Icons.add_shopping_cart_rounded,
                route: 'sales/new'),
            ZenoMenuItem(
                label: 'POS Terminal',
                icon: Icons.point_of_sale_rounded,
                route: 'sales/pos'),
            ZenoMenuItem(
                label: 'History',
                icon: Icons.history_rounded,
                route: 'sales/history'),
            ZenoMenuItem(
                label: 'Invoices',
                icon: Icons.description_rounded,
                route: 'sales/invoices'),
            ZenoMenuItem(
                label: 'Customer Dues',
                icon: Icons.account_balance_wallet_rounded,
                route: 'sales/dues'),
            ZenoMenuItem(
                label: 'Quotations',
                icon: Icons.request_quote_rounded,
                route: 'sales/quotations'),
            ZenoMenuItem(
                label: 'Pricing',
                icon: Icons.sell_rounded,
                route: 'sales/pricing'),
            ZenoMenuItem(
                label: 'Intelligence',
                icon: Icons.auto_awesome_rounded,
                route: 'sales/intelligence'),
          ],
        ),
      ],
    ),

    // --- 4. ORDERS ---
    ZenoMenuCategory(
      id: 'orders',
      label: 'ORDERS',
      icon: Icons.assignment_rounded,
      color: Color(0xFFF97316), // Orange
      columns: [
        ZenoMenuColumn(
          title: 'ORDER LIFECYCLE',
          items: [
            ZenoMenuItem(
                label: 'Dashboard',
                icon: Icons.dashboard_customize_rounded,
                route: 'orders/dashboard'),
            ZenoMenuItem(
                label: 'All Orders',
                icon: Icons.list_alt_rounded,
                route: 'orders/list'),
            ZenoMenuItem(
                label: 'New Order',
                icon: Icons.add_task_rounded,
                route: 'orders/new'),
            ZenoMenuItem(
                label: 'Fulfillment',
                icon: Icons.local_shipping_rounded,
                route: 'orders/fulfillment'),
            ZenoMenuItem(
                label: 'Returns \u0026 RMA',
                icon: Icons.assignment_return_rounded,
                route: 'orders/returns'),
            ZenoMenuItem(
                label: 'Order AI',
                icon: Icons.auto_awesome_rounded,
                route: 'orders/intelligence'),
          ],
        ),
      ],
    ),

    // --- 5. PROCUREMENT ---
    ZenoMenuCategory(
      id: 'procurement',
      label: 'PROCURE',
      icon: Icons.shopping_bag_rounded,
      color: Color(0xFFEF4444), // Rose
      columns: [
        ZenoMenuColumn(
          title: 'SUPPLY CHAIN',
          items: [
            ZenoMenuItem(
                label: 'Purchase Orders',
                icon: Icons.shopping_basket_rounded,
                route: 'procurement/orders'),
            ZenoMenuItem(
                label: 'Suppliers',
                icon: Icons.factory_rounded,
                route: 'procurement/suppliers'),
            ZenoMenuItem(
                label: 'RFQ Center',
                icon: Icons.compare_arrows_rounded,
                route: 'procurement/rfq'),
            ZenoMenuItem(
                label: 'Receiving',
                icon: Icons.input_rounded,
                route: 'procurement/receiving'),
            ZenoMenuItem(
                label: 'Vendor Bills',
                icon: Icons.receipt_long_rounded,
                route: 'procurement/bills'),
            ZenoMenuItem(
                label: 'Payables',
                icon: Icons.payments_rounded,
                route: 'procurement/payables'),
            ZenoMenuItem(
                label: 'Landed Cost',
                icon: Icons.calculate_rounded,
                route: 'procurement/landed-cost'),
            ZenoMenuItem(
                label: 'Intelligence',
                icon: Icons.auto_awesome_rounded,
                route: 'procurement/intelligence'),
          ],
        ),
      ],
    ),

    // --- 6. CRM ---
    ZenoMenuCategory(
      id: 'crm',
      label: 'CRM',
      icon: Icons.people_rounded,
      color: Color(0xFF8B5CF6), // Violet
      columns: [
        ZenoMenuColumn(
          title: 'RELATIONSHIP HUB',
          items: [
            ZenoMenuItem(
                label: 'Customers',
                icon: Icons.people_alt_rounded,
                route: 'crm/customers'),
            ZenoMenuItem(
                label: 'Leads Pipeline',
                icon: Icons.person_search_rounded,
                route: 'crm/leads'),
            ZenoMenuItem(
                label: 'Activities',
                icon: Icons.pending_actions_rounded,
                route: 'crm/activities'),
            ZenoMenuItem(
                label: 'Campaigns',
                icon: Icons.campaign_rounded,
                route: 'crm/campaigns'),
            ZenoMenuItem(
                label: 'Support Tickets',
                icon: Icons.support_agent_rounded,
                route: 'crm/tickets'),
            ZenoMenuItem(
                label: 'Loyalty',
                icon: Icons.star_rounded,
                route: 'crm/loyalty'),
            ZenoMenuItem(
                label: 'CRM Reports',
                icon: Icons.bar_chart_rounded,
                route: 'crm/reports'),
            ZenoMenuItem(
                label: 'AI Insights',
                icon: Icons.auto_awesome_rounded,
                route: 'crm/intelligence'),
          ],
        ),
      ],
    ),

    // --- 7. HR ---
    ZenoMenuCategory(
      id: 'hr',
      label: 'HR',
      icon: Icons.badge_rounded,
      color: Color(0xFFEC4899), // Pink
      columns: [
        ZenoMenuColumn(
          title: 'HUMAN CAPITAL',
          items: [
            ZenoMenuItem(
                label: 'Employees',
                icon: Icons.people_rounded,
                route: 'hr/staff'),
            ZenoMenuItem(
                label: 'Attendance',
                icon: Icons.event_available_rounded,
                route: 'hr/attendance'),
            ZenoMenuItem(
                label: 'Leave',
                icon: Icons.event_busy_rounded,
                route: 'hr/leave'),
            ZenoMenuItem(
                label: 'Payroll',
                icon: Icons.payments_rounded,
                route: 'hr/payroll'),
            ZenoMenuItem(
                label: 'Recruitment',
                icon: Icons.person_search_rounded,
                route: 'hr/recruitment'),
            ZenoMenuItem(
                label: 'Performance',
                icon: Icons.speed_rounded,
                route: 'hr/performance'),
            ZenoMenuItem(
                label: 'HR Reports',
                icon: Icons.assessment_rounded,
                route: 'hr/reports'),
            ZenoMenuItem(
                label: 'AI Insights',
                icon: Icons.auto_awesome_rounded,
                route: 'hr/intelligence'),
          ],
        ),
      ],
    ),

    // --- 8. REPORTS ---
    ZenoMenuCategory(
      id: 'reports',
      label: 'REPORTS',
      icon: Icons.bar_chart_rounded,
      color: Color(0xFF06B6D4), // Cyan
      columns: [
        ZenoMenuColumn(
          title: 'STRATEGIC BI',
          items: [
            ZenoMenuItem(
                label: 'Report Builder',
                icon: Icons.design_services_rounded,
                route: 'reports/builder'),
            ZenoMenuItem(
                label: 'Executive BI',
                icon: Icons.summarize_rounded,
                route: 'reports/executive'),
            ZenoMenuItem(
                label: 'Financial BI',
                icon: Icons.account_balance_wallet_rounded,
                route: 'reports/financial'),
            ZenoMenuItem(
                label: 'Sales BI',
                icon: Icons.trending_up_rounded,
                route: 'reports/sales'),
            ZenoMenuItem(
                label: 'Inventory BI',
                icon: Icons.inventory_rounded,
                route: 'reports/inventory'),
            ZenoMenuItem(
                label: 'Procure BI',
                icon: Icons.shopping_bag_rounded,
                route: 'reports/procurement'),
            ZenoMenuItem(
                label: 'HR BI',
                icon: Icons.badge_rounded,
                route: 'reports/hr'),
            ZenoMenuItem(
                label: 'CRM BI',
                icon: Icons.people_outline_rounded,
                route: 'reports/crm'),
          ],
        ),
      ],
    ),

    // --- 9. FINANCE ---
    ZenoMenuCategory(
      id: 'finance',
      label: 'FINANCE',
      icon: Icons.credit_card_rounded,
      color: Color(0xFF6366F1), // Indigo
      columns: [
        ZenoMenuColumn(
          title: 'ENTERPRISE LEDGER',
          items: [
            ZenoMenuItem(
                label: 'Ledger Hub',
                icon: Icons.account_balance_rounded,
                route: 'finance/ledger'),
            ZenoMenuItem(
                label: 'Journal Entry',
                icon: Icons.edit_note_rounded,
                route: 'finance/journal'),
            ZenoMenuItem(
                label: 'Payables Hub',
                icon: Icons.call_made_rounded,
                route: 'finance/payables'),
            ZenoMenuItem(
                label: 'Banking Hub',
                icon: Icons.account_balance_wallet_rounded,
                route: 'finance/banking'),
            ZenoMenuItem(
                label: 'Budgets Center',
                icon: Icons.pie_chart_rounded,
                route: 'finance/budget'),
            ZenoMenuItem(
                label: 'Asset Hub',
                icon: Icons.precision_manufacturing_rounded,
                route: 'finance/assets'),
            ZenoMenuItem(
                label: 'Tax Management',
                icon: Icons.gavel_rounded,
                route: 'finance/tax'),
            ZenoMenuItem(
                label: 'Financial Closing',
                icon: Icons.lock_clock_rounded,
                route: 'finance/closing'),
            ZenoMenuItem(
                label: 'Finance AI',
                icon: Icons.auto_awesome_rounded,
                route: 'finance/intelligence'),
          ],
        ),
      ],
    ),

    // --- 10. AI ---
    ZenoMenuCategory(
      id: 'ai',
      label: 'AI',
      icon: Icons.auto_awesome_rounded,
      color: Color(0xFFD946EF), // Fuchsia
      columns: [
        ZenoMenuColumn(
          title: 'INTELLIGENCE LAYER',
          items: [
            ZenoMenuItem(
                label: 'AI Copilot',
                icon: Icons.assistant_rounded,
                route: 'ai/home',
                isAI: true),
            ZenoMenuItem(
                label: 'Risk Forecast',
                icon: Icons.insights_rounded,
                route: 'ai/risk',
                isAI: true),
            ZenoMenuItem(
                label: 'Sales Online',
                icon: Icons.online_prediction_rounded,
                route: 'ai/sales-forecast',
                isAI: true),
            ZenoMenuItem(
                label: 'Inventory Pred',
                icon: Icons.inventory_rounded,
                route: 'ai/stock-forecast',
                isAI: true),
            ZenoMenuItem(
                label: 'Automation Hub',
                icon: Icons.smart_toy_rounded,
                route: 'ai/automation',
                isAI: true),
          ],
        ),
      ],
    ),

    // --- 11. ADMIN ---
    ZenoMenuCategory(
      id: 'admin',
      label: 'ADMIN',
      icon: Icons.settings_rounded,
      color: Color(0xFF475569), // Slate
      columns: [
        ZenoMenuColumn(
          title: 'GOVERNANCE',
          items: [
            ZenoMenuItem(
                label: 'Store Setup',
                icon: Icons.domain_rounded,
                route: 'admin/profile'),
            ZenoMenuItem(
                label: 'Security',
                icon: Icons.key_rounded,
                route: 'admin/security'),
            ZenoMenuItem(
                label: 'Workflows',
                icon: Icons.verified_rounded,
                route: 'admin/workflows'),
            ZenoMenuItem(
                label: 'Governance Hub',
                icon: Icons.gavel_rounded,
                route: 'admin/governance'),
            ZenoMenuItem(
                label: 'Automation Center',
                icon: Icons.smart_toy_outlined,
                route: 'admin/automation'),
            ZenoMenuItem(
                label: 'System Audit',
                icon: Icons.history_edu_rounded,
                route: 'admin/audit'),
            ZenoMenuItem(
                label: 'Backup \u0026 Data',
                icon: Icons.cloud_upload_rounded,
                route: 'admin/backup'),
            ZenoMenuItem(
                label: 'App Settings',
                icon: Icons.settings_applications_rounded,
                route: 'admin/settings'),
            ZenoMenuItem(
                label: 'Integrations',
                icon: Icons.cable_rounded,
                route: 'admin/integrations'),
          ],
        ),
      ],
    ),
  ];
}
