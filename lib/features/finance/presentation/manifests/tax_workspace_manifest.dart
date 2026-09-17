import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/tax_rule.dart';

/// TaxWorkspaceManifest v1.0
/// Operational control center for Enterprise Tax, GST/VAT Hub, and Compliance.
class TaxWorkspaceManifest extends ZenoWorkspaceManifest<TaxRule> {
  const TaxWorkspaceManifest()
      : super(
          id: 'tax_compliance_hub',
          title: 'Finance / Tax',
          subtitle:
              'COMPLIANCE CONTROL: MANAGE TAX RULES, GST RETURNS, AND INTERNATIONAL VAT OBLIGATIONS.',
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
            label: "⚡ New Tax Rule",
            icon: Icons.add_moderator_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "GST Returns",
            icon: Icons.assignment_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Tax Filing",
            icon: Icons.upload_file_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Rules", isSelected: true),
        const ZenoChip(label: "GST India", color: Colors.blue),
        const ZenoChip(label: "VAT International", color: Colors.purple),
        const ZenoChip(label: "TDS/TCS", color: Colors.orange),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "GST Collected",
            value: "₹1.5M",
            icon: Icons.account_balance_outlined),
        const ZenoKpiData(
            label: "GST Payable",
            value: "₹1.1M",
            icon: Icons.payments_outlined,
            color: Colors.red),
        const ZenoKpiData(
            label: "Compliance %",
            value: "100%",
            icon: Icons.verified_user_rounded,
            color: Colors.green),
        const ZenoKpiData(
            label: "Tax Risk",
            value: "Low",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<TaxRule>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "TAX CODE",
          width: 160,
          builder: (r) => Text(r.code,
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  fontFamily: 'monospace')),
        ),
        ZenoTableColumn(
          label: "TAX NAME",
          width: 250,
          builder: (r) => Text(r.name.toUpperCase(),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "JURISDICTION",
          width: 180,
          builder: (r) => Text(
              "${r.country} ${r.state ?? ''}".trim().toUpperCase(),
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
        ),
        ZenoTableColumn(
          label: "RATE",
          width: 100,
          isNumeric: true,
          builder: (r) => Text("${r.rate}%",
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  color: Colors.indigo)),
        ),
        ZenoTableColumn(
          label: "CATEGORY",
          width: 140,
          builder: (r) => ZenoBadge(
            label: r.category.name.toUpperCase(),
            color: Colors.grey,
          ),
        ),
        ZenoTableColumn(
          label: "STATUS",
          builder: (r) => const Row(
            children: [
              Icon(Icons.check_circle_rounded,
                  size: 12, color: Colors.green),
              SizedBox(width: 8),
              Text("ACTIVE",
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
            ],
          ),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, TaxRule? r) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Tax Rule Summary"))),
        const ZenoInspectorTab(
            label: "Returns",
            icon: Icons.history_rounded,
            child: Center(child: Text("Filing History for Category"))),
        const ZenoInspectorTab(
            label: "HSN/SAC",
            icon: Icons.category_rounded,
            child: Center(child: Text("Mapped Commodity Codes"))),
        const ZenoInspectorTab(
            label: "Accounting",
            icon: Icons.account_balance_rounded,
            child: Center(child: Text("GL Accounts: Input vs Output"))),
        const ZenoInspectorTab(
            label: "AI Compliance",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Legislative Update Alerts"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH TAX RULES / RETURNS / HSN...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "TAX ENGINE: SYNCED", isActive: true),
        const ZenoStatusDot(label: "FILING CALENDAR: CURRENT", isActive: true),
      ];
}
