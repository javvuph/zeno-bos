import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/rfq.dart';

/// RFQWorkspaceManifest v1.0
/// Tactical procurement decision center for ZENO BOS.
class RFQWorkspaceManifest extends ZenoWorkspaceManifest<RFQ> {
  const RFQWorkspaceManifest()
      : super(
          id: 'rfq_command_center',
          title: 'Procurement / RFQ',
          subtitle:
              'STRATEGIC PROCUREMENT HUB: REQUEST QUOTATIONS, COMPARE OFFERS, AND EXECUTE PURCHASING DECISIONS.',
          icon: Icons.compare_arrows_rounded,
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
            label: "⚡ New RFQ",
            icon: Icons.add_circle_outline_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Invite Suppliers",
            icon: Icons.group_add_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Compare Quotes",
            icon: Icons.analytics_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All RFQs", isSelected: true),
        const ZenoChip(label: "Open / Awaiting"),
        const ZenoChip(label: "Ready to Compare"),
        const ZenoChip(label: "High Priority"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Active RFQs", value: "24", icon: Icons.pending_actions),
        const ZenoKpiData(
            label: "Pending Responses",
            value: "142",
            icon: Icons.reply_all_rounded,
            color: Colors.orange),
        const ZenoKpiData(
            label: "Closing Today",
            value: "3",
            icon: Icons.timer_outlined,
            color: Colors.red),
        const ZenoKpiData(
            label: "AI Confidence",
            value: "94%",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<RFQ>> _getTableColumns(BuildContext context) => [
        ZenoTableColumn(
          label: "RFQ IDENTITY",
          width: 280,
          builder: (r) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(r.title.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 11)),
              Text(r.id,
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace')),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "CATEGORY",
          width: 140,
          builder: (r) => Text(r.category.toUpperCase(),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "RESPONSES",
          width: 140,
          builder: (r) => Row(
            children: [
              const Icon(Icons.forum_outlined, size: 12, color: Colors.blue),
              const SizedBox(width: 8),
              Text("${r.invitedSupplierIds.length} INVITED",
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "LIFECYCLE STATE",
          width: 180,
          builder: (r) => ZenoBadge(
            label: r.status.name.toUpperCase().replaceAll('_', ' '),
            color: _getStatusColor(r.status),
          ),
        ),
        ZenoTableColumn(
          label: "CLOSING",
          width: 150,
          builder: (r) => Text(r.closingDate.toString().substring(0, 10),
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B))),
        ),
        ZenoTableColumn(
          label: "PRIORITY",
          builder: (r) => ZenoBadge(
              label: r.priority.name.toUpperCase(),
              color:
                  r.priority == RFQPriority.urgent ? Colors.red : Colors.grey),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, RFQ? rfq) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("RFQ Core Data"))),
        const ZenoInspectorTab(
            label: "Requirements",
            icon: Icons.list_alt_rounded,
            child: Center(child: Text("Line Items & Specs"))),
        const ZenoInspectorTab(
            label: "Quotations",
            icon: Icons.request_quote_outlined,
            child: Center(child: Text("Supplier Offers"))),
        const ZenoInspectorTab(
            label: "AI Insights",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Neural Selection Logic"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH RFQ / SUPPLIER / ITEM...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "AI ADVISOR: ACTIVE", isActive: true),
        const ZenoStatusDot(label: "TENDER GATE: OPEN", isActive: true),
      ];

  static Color _getStatusColor(RFQStatus status) {
    switch (status) {
      case RFQStatus.open:
        return Colors.green;
      case RFQStatus.readyToCompare:
        return Colors.blue;
      case RFQStatus.closingSoon:
        return Colors.orange;
      case RFQStatus.converted:
        return Colors.indigo;
      case RFQStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
