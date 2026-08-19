import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/customer.dart';

/// SalesWorkspaceManifest v1.0
/// Final Phase 8.1: Master Sales and Customer 360 Workspace for ZENO BOS.
class SalesWorkspaceManifest extends ZenoWorkspaceManifest<Customer> {
  const SalesWorkspaceManifest()
      : super(
          id: 'customer_360_hub',
          title: 'CRM / Customers',
          subtitle:
              'RELATIONSHIP CONTROL: MANAGE CUSTOMER LIFECYCLE, CREDIT EXPOSURE, AND AI-DRIVEN GROWTH.',
          icon: Icons.people_alt_rounded,
          toolbarActions: _getToolbarActions,
          filterActions: _getFilterActions,
          kpiMetrics: _getKpiMetrics,
          tableColumns: _getTableColumns,
          inspectorTabs: _getInspectorTabs,
          commandVessel: _getCommandVessel,
          statusBarIndicators: _getStatusBarIndicators,
        );

  static List<Widget> _getToolbarActions(BuildContext context) => [
        const ZenoButton(
            label: "⚡ New Customer",
            icon: Icons.person_add_alt_1_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Import",
            icon: Icons.file_upload_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Merge",
            icon: Icons.merge_type_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Customers", isSelected: true),
        const ZenoChip(label: "VIP Tier", color: Colors.amber),
        const ZenoChip(label: "Corporate", color: Colors.blue),
        const ZenoChip(label: "Credit Risk", color: Colors.red),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Customers",
            value: "4.2K",
            icon: Icons.group_outlined),
        const ZenoKpiData(
            label: "Outstanding",
            value: "₹2.8M",
            icon: Icons.pending_actions_rounded,
            color: Colors.red),
        const ZenoKpiData(
            label: "Retention",
            value: "94%",
            icon: Icons.loop_rounded,
            color: Colors.green),
        const ZenoKpiData(
            label: "Avg LTV",
            value: "₹45K",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<Customer>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "CUSTOMER IDENTITY",
          width: 250,
          builder: (c) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(c.name.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 11)),
              Text(c.customerCode,
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace')),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "TYPE",
          width: 120,
          builder: (c) => Text(c.type.name.toUpperCase(),
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
        ),
        ZenoTableColumn(
          label: "TIER",
          width: 100,
          builder: (c) => ZenoBadge(
            label: c.tier.name.toUpperCase(),
            color: _getTierColor(c.tier),
          ),
        ),
        ZenoTableColumn(
          label: "OUTSTANDING",
          width: 140,
          isNumeric: true,
          builder: (c) => Text("₹${c.outstandingBalance.toStringAsFixed(0)}",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: c.outstandingBalance > c.credit.creditLimit
                      ? Colors.red
                      : null)),
        ),
        ZenoTableColumn(
          label: "HEALTH",
          builder: (c) => Row(
            children: [
              Icon(Icons.auto_awesome,
                  size: 12,
                  color: c.aiHealthScore < 70 ? Colors.red : Colors.green),
              const SizedBox(width: 8),
              Text("${c.aiHealthScore.toInt()}%",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: c.aiHealthScore < 70 ? Colors.red : Colors.green)),
            ],
          ),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Customer? c) =>
      [
        const ZenoInspectorTab(
            label: "360 Overview",
            icon: Icons.radar_rounded,
            child: Center(child: Text("Aggregated Portfolio View"))),
        const ZenoInspectorTab(
            label: "Financials",
            icon: Icons.account_balance_wallet_outlined,
            child: Center(child: Text("Credit Limit & Outstanding"))),
        const ZenoInspectorTab(
            label: "Addresses",
            icon: Icons.location_on_outlined,
            child: Center(child: Text("Billing & Shipping List"))),
        const ZenoInspectorTab(
            label: "Sales History",
            icon: Icons.history_rounded,
            child: Center(child: Text("Orders & Lifetime Value"))),
        const ZenoInspectorTab(
            label: "AI Insights",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Churn Prediction & Upsell"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("ZENO AI: SEARCH CUSTOMER, ANALYZE RISK, /merge...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "KYC: VERIFIED", isActive: true),
        const ZenoStatusDot(label: "CREDIT MONITOR: ACTIVE", isActive: true),
      ];

  static Color _getTierColor(CustomerTier tier) {
    switch (tier) {
      case CustomerTier.vip:
        return Colors.amber;
      case CustomerTier.gold:
        return Colors.orange;
      case CustomerTier.silver:
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }
}
