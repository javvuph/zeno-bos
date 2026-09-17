import 'package:flutter/material.dart';
import 'menu_models.dart';

const List<ZenoMenuCategory> coreMenuCategories = [
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
];
