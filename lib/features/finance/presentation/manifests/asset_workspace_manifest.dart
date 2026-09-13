import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/fixed_asset.dart';
import '../../domain/models/asset_status.dart';
import '../widgets/asset_financial_panel.dart';
import '../widgets/asset_maintenance_panel.dart';

/// AssetWorkspaceManifest v1.0
/// Operational control center for Fixed Assets, Lifecycle, and Maintenance.
class AssetWorkspaceManifest extends ZenoWorkspaceManifest<FixedAsset> {
  const AssetWorkspaceManifest()
      : super(
          id: 'fixed_asset_control_hub',
          title: 'Finance / Fixed Assets',
          subtitle:
              'ASSET MANAGEMENT: TRACK CORPORATE ASSETS, MANAGE DEPRECIATION, AND OPTIMIZE LIFECYCLE HEALTH.',
          icon: Icons.precision_manufacturing_rounded,
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
            label: "⚡ New Asset",
            icon: Icons.add_business_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Depreciation",
            icon: Icons.trending_down_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Maintenance",
            icon: Icons.build_circle_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Assets", isSelected: true),
        const ZenoChip(label: "IT Hardware", color: Colors.blue),
        const ZenoChip(label: "Plant & Machinery", color: Colors.indigo),
        const ZenoChip(label: "Maintenance Due", color: Colors.orange),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Asset Value",
            value: "₹8.4M",
            icon: Icons.account_balance_wallet_outlined),
        const ZenoKpiData(
            label: "Book Value",
            value: "₹6.2M",
            icon: Icons.auto_graph_rounded,
            color: Colors.blue),
        const ZenoKpiData(
            label: "In Repair",
            value: "04",
            icon: Icons.settings_backup_restore_rounded,
            color: Colors.orange),
        const ZenoKpiData(
            label: "Health Index",
            value: "84%",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<FixedAsset>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "ASSET IDENTITY",
          width: 220,
          builder: (a) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(a.assetCode,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      fontFamily: 'monospace')),
              Text(a.name.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "CATEGORY",
          width: 140,
          builder: (a) => Text(a.categoryId.toUpperCase(),
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
        ),
        ZenoTableColumn(
          label: "ACQUISITION",
          width: 120,
          builder: (a) => Text(a.acquisitionDate.toString().substring(0, 10),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
        ZenoTableColumn(
          label: "BOOK VALUE",
          width: 140,
          isNumeric: true,
          builder: (a) => Text("₹${a.currentBookValue.toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.w900)),
        ),
        ZenoTableColumn(
          label: "STATUS",
          width: 140,
          builder: (a) => ZenoBadge(
            label: a.status.name.toUpperCase(),
            color: _getStatusColor(a.status),
          ),
        ),
        ZenoTableColumn(
          label: "HEALTH",
          builder: (a) => Row(
            children: [
              Icon(Icons.auto_awesome,
                  size: 12,
                  color: a.aiHealthScore < 70 ? Colors.red : Colors.green),
              const SizedBox(width: 8),
              Text("${a.aiHealthScore.toInt()}%",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: a.aiHealthScore < 70 ? Colors.red : Colors.green)),
            ],
          ),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, FixedAsset? a) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Asset Identity \u0026 Specs"))),
        if (a != null)
          ZenoInspectorTab(
              label: "Financial",
              icon: Icons.calculate_outlined,
              child: AssetFinancialPanel(asset: a)),
        if (a != null)
          ZenoInspectorTab(
              label: "Maintenance",
              icon: Icons.build_circle_outlined,
              child: AssetMaintenancePanel(asset: a, history: const [])),
        const ZenoInspectorTab(
            label: "Insurance",
            icon: Icons.verified_user_outlined,
            child: Center(child: Text("Policy Details \u0026 Expiry"))),
        const ZenoInspectorTab(
            label: "AI Insights",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Health and ROI Analysis"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH ASSETS: /transfer, /repair, /dispose...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "ASSET REGISTER: AUDITED", isActive: true),
        const ZenoStatusDot(label: "IOT TRACKING: ENABLED", isActive: true),
      ];

  static Color _getStatusColor(AssetStatus status) {
    switch (status) {
      case AssetStatus.active:
        return Colors.green;
      case AssetStatus.underMaintenance:
        return Colors.orange;
      case AssetStatus.disposed:
        return Colors.red;
      case AssetStatus.writtenOff:
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }
}
