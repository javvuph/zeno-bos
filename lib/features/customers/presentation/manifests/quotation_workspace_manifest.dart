import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/quotation.dart';
import '../../domain/models/quotation_status.dart';

/// QuotationWorkspaceManifest v1.0
/// Operational control center for Sales Quotations, Revisions, and Approvals.
class QuotationWorkspaceManifest extends ZenoWorkspaceManifest<Quotation> {
  const QuotationWorkspaceManifest()
      : super(
          id: 'sales_quotation_hub',
          title: 'Sales / Quotations',
          subtitle:
              'DEAL CONTROL: MANAGE QUOTE LIFECYCLE, VERSIONS, AND PRICING APPROVALS.',
          icon: Icons.request_quote_rounded,
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
            label: "⚡ New Quote",
            icon: Icons.add_chart_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Revision",
            icon: Icons.history_edu_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Compare",
            icon: Icons.compare_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Quotes", isSelected: true),
        const ZenoChip(label: "Drafts", color: Colors.grey),
        const ZenoChip(label: "Pending", color: Colors.orange),
        const ZenoChip(label: "Approved", color: Colors.green),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Open Quotes",
            value: "142",
            icon: Icons.open_in_new_rounded),
        const ZenoKpiData(
            label: "Pipeline Value",
            value: "₹8.5M",
            icon: Icons.account_balance_wallet_outlined,
            color: Colors.blue),
        const ZenoKpiData(
            label: "Avg Margin",
            value: "22%",
            icon: Icons.trending_up_rounded,
            color: Colors.green),
        const ZenoKpiData(
            label: "Win Probability",
            value: "68%",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<Quotation>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "QUOTE IDENTITY",
          width: 220,
          builder: (q) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(q.quotationNumber,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      fontFamily: 'monospace')),
              Text(q.customerId.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "VALUE",
          width: 140,
          isNumeric: true,
          builder: (q) => Text("₹${q.grandTotal.toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.w900)),
        ),
        ZenoTableColumn(
          label: "MARGIN",
          width: 100,
          isNumeric: true,
          builder: (q) => Text("${q.marginPercent.toInt()}%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: q.marginPercent < 15 ? Colors.orange : Colors.green,
              )),
        ),
        ZenoTableColumn(
          label: "STATUS",
          width: 140,
          builder: (q) => ZenoBadge(
            label: q.status.name.toUpperCase(),
            color: _getStatusColor(q.status),
          ),
        ),
        ZenoTableColumn(
          label: "EXPIRY",
          width: 120,
          builder: (q) => Text(q.expiryDate.toString().substring(0, 10),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
        ZenoTableColumn(
          label: "REV",
          width: 60,
          builder: (q) => Text("v${q.revision}",
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Colors.blueGrey)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Quotation? q) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Quote Summary & Terms"))),
        const ZenoInspectorTab(
            label: "Items",
            icon: Icons.list_alt_rounded,
            child: Center(child: Text("Line Item Detail"))),
        const ZenoInspectorTab(
            label: "Pricing & Margin",
            icon: Icons.calculate_outlined,
            child: Center(child: Text("Discount Approval Matrix"))),
        const ZenoInspectorTab(
            label: "Opportunity",
            icon: Icons.radar_rounded,
            child: Center(child: Text("Linked Deal Strategy"))),
        const ZenoInspectorTab(
            label: "AI Insights",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Win Probability Analysis"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH QUOTES: /revise, /approve, /convert...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "DISCOUNT ENGINE: ACTIVE", isActive: true),
        const ZenoStatusDot(label: "PDF GENERATOR: READY", isActive: true),
      ];

  static Color _getStatusColor(QuotationStatus status) {
    switch (status) {
      case QuotationStatus.approved:
        return Colors.green;
      case QuotationStatus.pendingApproval:
        return Colors.orange;
      case QuotationStatus.expired:
        return Colors.red;
      case QuotationStatus.converted:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
