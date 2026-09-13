import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/features/inventory/domain/models/inventory_rule.dart';

/// InventoryRulesWorkspaceManifest v1.0
/// Manifest for managing global and category-specific inventory behavior policies.
class InventoryRulesWorkspaceManifest
    extends ZenoWorkspaceManifest<InventoryRule> {
  const InventoryRulesWorkspaceManifest()
      : super(
          id: 'inventory_rules',
          title: 'Inventory / Inventory Rules',
          subtitle:
              'CONFIGURE SYSTEM-WIDE LOGIC FOR TRACKING, REORDERING, AND COMPLIANCE RULES.',
          icon: Icons.gavel_rounded,
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
            label: "⚡ New Policy",
            icon: Icons.add_moderator_rounded,
            size: ZenoButtonSize.sm),
        ZenoButton(
            label: "Export Rules",
            icon: Icons.ios_share_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Tracking", isSelected: true),
        const ZenoChip(label: "Reorder"),
        const ZenoChip(label: "Compliance"),
        const ZenoChip(label: "Global Only"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Active Policies",
            value: "18",
            icon: Icons.verified_user_outlined),
        const ZenoKpiData(
            label: "Global Rules",
            value: "6",
            icon: Icons.public,
            color: Colors.indigo),
        const ZenoKpiData(
            label: "Risk Level",
            value: "LOW",
            icon: Icons.security_rounded,
            color: Colors.green),
      ];

  static List<ZenoTableColumn<InventoryRule>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "Policy Name",
          width: 300,
          builder: (r) => Row(
            children: [
              const Icon(Icons.shield_outlined,
                  size: 16, color: Color(0xFF6366F1)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(r.name.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 11)),
                  Text(r.id,
                      style: const TextStyle(
                          fontSize: 8,
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Rule Type",
          width: 140,
          builder: (r) => ZenoBadge(label: r.typeLabel, color: Colors.blueGrey),
        ),
        ZenoTableColumn(
          label: "Enforcement",
          width: 250,
          builder: (r) => Wrap(
            spacing: 4,
            children: [
              if (r.requiresBatch)
                const ZenoBadge(
                    label: "BATCH", color: Colors.orange, isSolid: false),
              if (r.requiresExpiry)
                const ZenoBadge(
                    label: "EXPIRY", color: Colors.red, isSolid: false),
              if (r.requiresSerial)
                const ZenoBadge(
                    label: "SERIAL", color: Colors.blue, isSolid: false),
              if (r.allowNegativeStock)
                const ZenoBadge(
                    label: "NEG-STOCK", color: Colors.purple, isSolid: false),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Scope",
          builder: (r) => Text(
              r.isGlobal ? "GLOBAL" : "${r.targetCategories.length} CATEGORIES",
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, InventoryRule? rule) =>
      [
        const ZenoInspectorTab(
            label: "Logic",
            icon: Icons.psychology_outlined,
            child: Center(child: Text("Policy Logic & Flags"))),
        const ZenoInspectorTab(
            label: "Targets",
            icon: Icons.category_outlined,
            child: Center(child: Text("Applied Categories"))),
        const ZenoInspectorTab(
            label: "Audit",
            icon: Icons.history_rounded,
            child: Center(child: Text("Change Log"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH POLICIES / RULES...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "POLICY ENGINE: ACTIVE", isActive: true),
      ];
}
