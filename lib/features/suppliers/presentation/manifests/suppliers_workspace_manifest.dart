import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/features/suppliers/domain/models/supplier.dart';

/// SuppliersWorkspaceManifest v1.1
/// Enhanced 360° manifest for Strategic Supplier Relationship Management.
class SuppliersWorkspaceManifest extends ZenoWorkspaceManifest<Supplier> {
  const SuppliersWorkspaceManifest()
      : super(
          id: 'suppliers_360',
          title: 'Procurement / Suppliers',
          subtitle:
              'INTEGRATED VENDOR ECOSYSTEM: IDENTITY, PERFORMANCE, FINANCIALS, AND AI RISK INTELLIGENCE.',
          icon: Icons.factory_outlined,
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
            label: "⚡ Add Supplier",
            icon: Icons.person_add_alt_1_outlined,
            size: ZenoButtonSize.sm),
        ZenoButton(
            label: "Compare Vendors",
            icon: Icons.compare_arrows_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
        ZenoButton(
            label: "Active Contracts",
            icon: Icons.assignment_turned_in_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Vendors", isSelected: true),
        const ZenoChip(label: "Preferred", icon: Icons.star_rounded),
        const ZenoChip(label: "Strategic", icon: Icons.diamond_outlined),
        const ZenoChip(label: "At Risk", color: Colors.red),
        const ZenoChip(label: "Overdue AP"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Suppliers",
            value: "142",
            icon: Icons.factory_outlined),
        const ZenoKpiData(
            label: "Active Contracts",
            value: "28",
            icon: Icons.history_edu_outlined,
            color: Colors.blue),
        const ZenoKpiData(
            label: "Avg Lead Time",
            value: "3.8d",
            icon: Icons.timer_outlined,
            color: Colors.indigo),
        const ZenoKpiData(
            label: "Outstanding AP",
            value: "₹4.2M",
            icon: Icons.account_balance_wallet_outlined,
            color: Colors.orange),
        const ZenoKpiData(
            label: "AI Health Score",
            value: "94%",
            icon: Icons.auto_awesome,
            color: Colors.purple),
      ];

  static List<ZenoTableColumn<Supplier>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "Vendor identity",
          width: 300,
          builder: (s) => Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                    s.isStrategic
                        ? Icons.diamond_outlined
                        : Icons.business_outlined,
                    size: 16,
                    color: s.isStrategic
                        ? Colors.purple
                        : const Color(0xFF64748B)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(s.name.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 11)),
                    Text(s.supplierCode,
                        style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5)),
                  ],
                ),
              ),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Categorization",
          width: 150,
          builder: (s) => ZenoBadge(label: s.category, color: Colors.blueGrey),
        ),
        ZenoTableColumn(
          label: "Performance",
          width: 180,
          builder: (s) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RatingStars(score: s.rating.overallScore),
              const SizedBox(height: 4),
              Text("${(s.onTimeDeliveryPercent * 100).toInt()}% ON-TIME",
                  style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF64748B))),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Financial status",
          width: 180,
          isNumeric: true,
          builder: (s) => Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("₹${(s.outstandingBalance / 1000).toStringAsFixed(1)}K DUE",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      color: s.outstandingBalance > 0
                          ? Colors.red.shade700
                          : Colors.green.shade700)),
              Text("${s.creditDays} DAYS TERMS",
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Risk node",
          builder: (s) => Row(
            children: [
              if (s.isPreferred)
                const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.verified_user_rounded,
                        size: 14, color: Color(0xFF10B981))),
              ZenoBadge(
                  label: s.rating.overallScore > 0.8 ? "LOW RISK" : "MODERATE",
                  color: s.rating.overallScore > 0.8
                      ? Colors.green
                      : Colors.orange),
            ],
          ),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Supplier? s) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("360° Identity"))),
        const ZenoInspectorTab(
            label: "Contacts",
            icon: Icons.contact_phone_outlined,
            child: Center(child: Text("Stakeholder Registry"))),
        const ZenoInspectorTab(
            label: "Financial",
            icon: Icons.account_balance_outlined,
            child: Center(child: Text("Ledger & AP Details"))),
        const ZenoInspectorTab(
            label: "Performance",
            icon: Icons.speed_rounded,
            child: Center(child: Text("KPI Scorecard"))),
        const ZenoInspectorTab(
            label: "Documents",
            icon: Icons.description_outlined,
            child: Center(child: Text("Contract Vault"))),
        const ZenoInspectorTab(
            label: "Timeline",
            icon: Icons.history_rounded,
            child: Center(child: Text("Interaction Log"))),
        const ZenoInspectorTab(
            label: "AI Intel",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Predictive Risk & Analysis"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("TYPE COMMAND: /supplier, /risk, /compare...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "PTE: OPERATIONAL", isActive: true),
        const ZenoStatusDot(label: "AP LEDGER: SYNCED", isActive: true),
        const ZenoStatusDot(label: "AI RISK: REAL-TIME", isActive: true),
      ];
}

class _RatingStars extends StatelessWidget {
  final double score;
  const _RatingStars({required this.score});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          5,
          (i) => Icon(Icons.star_rounded,
              size: 12,
              color: i < (score * 5)
                  ? const Color(0xFFFFB800)
                  : Colors.grey.shade200)),
    );
  }
}
