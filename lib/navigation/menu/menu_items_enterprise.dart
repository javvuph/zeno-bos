import 'package:flutter/material.dart';
import 'menu_models.dart';
import 'menu_items_governance_ai.dart';

const List<ZenoMenuCategory> enterpriseMenuCategories = [
  // --- 2. INVENTORY ---
  ZenoMenuCategory(
    id: 'inventory',
    label: 'INVENTORY',
    icon: Icons.inventory_2_rounded,
    color: Color(0xFFF59E0B),
    columns: [
      ZenoMenuColumn(
        title: 'INVENTORY MASTER',
        items: [
          ZenoMenuItem(
              label: 'Products',
              icon: Icons.inventory_2_rounded,
              route: 'inventory/products'),
          ZenoMenuItem(
              label: 'Product Studio',
              icon: Icons.auto_awesome_motion_rounded,
              route: 'inventory/studio'),
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

  // --- 5. PROCUREMENT ---
  ZenoMenuCategory(
    id: 'procurement',
    label: 'PROCURE',
    icon: Icons.shopping_bag_rounded,
    color: Color(0xFFEF4444),
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

  // --- 8. REPORTS ---
  ZenoMenuCategory(
    id: 'reports',
    label: 'REPORTS',
    icon: Icons.bar_chart_rounded,
    color: Color(0xFF06B6D4),
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
    color: Color(0xFF6366F1),
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

  ...governanceAndAiCategories,
];
