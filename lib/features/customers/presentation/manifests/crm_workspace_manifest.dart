import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/lead.dart';
import '../../domain/models/lead_status.dart';

/// CRMWorkspaceManifest v1.0
/// Final Phase 9: Master CRM Command Center for ZENO BOS.
class CRMWorkspaceManifest extends ZenoWorkspaceManifest<Lead> {
  const CRMWorkspaceManifest()
      : super(
          id: 'crm_master_hub',
          title: 'CRM / Leads',
          subtitle:
              'RELATIONSHIP CONTROL: MANAGE LEADS, CAMPAIGNS, AND CUSTOMER SERVICE OPERATIONS.',
          icon: Icons.hub_outlined,
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
            label: "⚡ New Lead",
            icon: Icons.person_add_alt_1_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Campaign",
            icon: Icons.campaign_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Convert",
            icon: Icons.transform_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Active Leads", isSelected: true),
        const ZenoChip(label: "Hot Leads", color: Colors.red),
        const ZenoChip(label: "Qualified", color: Colors.green),
        const ZenoChip(label: "In Service", color: Colors.blue),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Leads",
            value: "842",
            icon: Icons.person_search_rounded),
        const ZenoKpiData(
            label: "Qualified",
            value: "215",
            icon: Icons.verified_user_outlined,
            color: Colors.green),
        const ZenoKpiData(
            label: "Open Tickets",
            value: "14",
            icon: Icons.support_agent_rounded,
            color: Colors.orange),
        const ZenoKpiData(
            label: "CRM Health",
            value: "High",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<Lead>> _getTableColumns(BuildContext context) => [
        ZenoTableColumn(
          label: "LEAD IDENTITY",
          width: 250,
          builder: (l) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l.name.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 11)),
              Text(l.companyName?.toUpperCase() ?? "INDIVIDUAL",
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "SCORE",
          width: 80,
          isNumeric: true,
          builder: (l) => Text("${l.score.toInt()}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: l.score > 70 ? Colors.green : Colors.orange)),
        ),
        ZenoTableColumn(
          label: "STATUS",
          width: 140,
          builder: (l) => ZenoBadge(
            label: l.status.name.toUpperCase(),
            color: _getStatusColor(l.status),
          ),
        ),
        ZenoTableColumn(
          label: "SOURCE",
          width: 120,
          builder: (l) => Text(l.source?.toUpperCase() ?? "DIRECT",
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
        ),
        ZenoTableColumn(
          label: "CREATED",
          builder: (l) => Text(l.createdAt.toString().substring(0, 10),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Lead? l) =>
      [
        const ZenoInspectorTab(
            label: "Lead Detail",
            icon: Icons.person_pin_rounded,
            child: Center(child: Text("Lead Profiling \u0026 Qualification"))),
        const ZenoInspectorTab(
            label: "Activities",
            icon: Icons.pending_actions_rounded,
            child: Center(child: Text("Calls, Meetings \u0026 Tasks"))),
        const ZenoInspectorTab(
            label: "Campaigns",
            icon: Icons.campaign_rounded,
            child: Center(child: Text("Marketing Engagement"))),
        const ZenoInspectorTab(
            label: "Journey",
            icon: Icons.radar_rounded,
            child: Center(child: Text("Chronological Timeline"))),
        const ZenoInspectorTab(
            label: "AI CRM",
            icon: Icons.auto_awesome,
            child: Center(
                child: Text("Next Best Action \u0026 Churn Prediction"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("CRM AI: SEARCH LEADS, ANALYZE JOURNEY, /convert...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "MARKETING API: CONNECTED", isActive: true),
        const ZenoStatusDot(label: "SLA MONITOR: ACTIVE", isActive: true),
      ];

  static Color _getStatusColor(LeadStatus status) {
    switch (status) {
      case LeadStatus.new_lead:
        return Colors.blue;
      case LeadStatus.contacted:
        return Colors.orange;
      case LeadStatus.qualified:
        return Colors.green;
      case LeadStatus.lost:
        return Colors.red;
      case LeadStatus.converted:
        return Colors.indigo;
    }
  }
}
