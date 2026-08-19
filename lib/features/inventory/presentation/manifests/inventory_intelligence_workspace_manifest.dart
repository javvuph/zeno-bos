import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/features/inventory/domain/models/inventory_ledger_entry.dart';

/// InventoryIntelligenceWorkspaceManifest v1.0
/// Executive visibility into inventory health, turnover, and AI-driven forecasting.
class InventoryIntelligenceWorkspaceManifest
    extends ZenoWorkspaceManifest<InventoryLedgerEntry> {
  const InventoryIntelligenceWorkspaceManifest()
      : super(
          id: 'inventory_intelligence',
          title: 'Inventory / Inventory Intelligence',
          subtitle:
              'EXECUTIVE ANALYTICS, STOCK HEALTH SCORING, AND PREDICTIVE RESTOCK STRATEGIES.',
          icon: Icons.insights_rounded,
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
            label: "Run AI Analysis",
            icon: Icons.auto_awesome,
            size: ZenoButtonSize.sm),
        ZenoButton(
            label: "Export BI Data",
            icon: Icons.analytics_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Health Score", isSelected: true),
        const ZenoChip(label: "Dead Stock"),
        const ZenoChip(label: "Fast Movers"),
        const ZenoChip(label: "Valuation High"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Inventory Health",
            value: "92/100",
            icon: Icons.favorite_outline,
            color: Colors.green),
        const ZenoKpiData(
            label: "Global Valuation",
            value: "₹24.8M",
            icon: Icons.account_balance_wallet_outlined,
            change: "5%",
            isPositive: true),
        const ZenoKpiData(
            label: "Stock Turnover",
            value: "14.2x",
            icon: Icons.loop_rounded,
            color: Colors.indigo),
        const ZenoKpiData(
            label: "Potential Revenue",
            value: "₹38.4M",
            icon: Icons.trending_up,
            color: Colors.blue),
      ];

  static List<ZenoTableColumn<InventoryLedgerEntry>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "Stock Identity",
          width: 280,
          builder: (e) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(e.productId.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 11)),
              Text(e.id,
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "ABC Rank",
          width: 100,
          builder: (e) =>
              ZenoBadge(label: "A-GRADE", color: Colors.amber.shade700),
        ),
        ZenoTableColumn(
          label: "Turnover (30D)",
          width: 120,
          isNumeric: true,
          builder: (e) =>
              const Text("4.2x", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "Inventory Value",
          width: 150,
          isNumeric: true,
          builder: (e) => Text(
              "₹${(e.quantityOnHand * e.averageCost).toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.w900)),
        ),
        ZenoTableColumn(
          label: "AI Signal",
          builder: (e) => const Row(
            children: [
              Icon(Icons.auto_awesome, size: 12, color: Colors.indigo),
              SizedBox(width: 8),
              Text("RESTOCK SOON",
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo)),
            ],
          ),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, InventoryLedgerEntry? entry) =>
      [
        const ZenoInspectorTab(
            label: "Health Card",
            icon: Icons.monitor_heart_outlined,
            child: Center(child: Text("Stock Velocity & Fill Rate"))),
        const ZenoInspectorTab(
            label: "Financials",
            icon: Icons.price_check_outlined,
            child: Center(child: Text("Cost Basis & Valuation"))),
        const ZenoInspectorTab(
            label: "Forecasting",
            icon: Icons.online_prediction_outlined,
            child: Center(child: Text("AI Demand Projection"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("QUERY INVENTORY INTELLIGENCE...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "BI ENGINE: ACTIVE", isActive: true),
        const ZenoStatusDot(label: "ML MODELS: SYNCED", isActive: true),
      ];
}
