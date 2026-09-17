import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/employee.dart';

/// HRWorkspaceManifest v1.0
/// Final Phase 10: Master Human Capital & Payroll Hub for ZENO BOS.
class HRWorkspaceManifest extends ZenoWorkspaceManifest<Employee> {
  const HRWorkspaceManifest()
      : super(
          id: 'hr_master_hub',
          title: 'HR / Employees',
          subtitle:
              'HUMAN CAPITAL CONTROL: MANAGE PERSONNEL, ATTENDANCE, PAYROLL, AND PERFORMANCE.',
          icon: Icons.badge_rounded,
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
            label: "⚡ Add Employee",
            icon: Icons.person_add_alt_1_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Run Payroll",
            icon: Icons.payments_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Attendance",
            icon: Icons.event_available_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Active Staff", isSelected: true),
        const ZenoChip(label: "On Leave", color: Colors.orange),
        const ZenoChip(label: "Probation", color: Colors.blue),
        const ZenoChip(label: "Terminated", color: Colors.red),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Employees",
            value: "156",
            icon: Icons.people_outline_rounded),
        const ZenoKpiData(
            label: "Present Today",
            value: "142",
            icon: Icons.check_circle_outline_rounded,
            color: Colors.green),
        const ZenoKpiData(
            label: "Payroll Due",
            value: "₹2.4M",
            icon: Icons.payments_outlined,
            color: Colors.red),
        const ZenoKpiData(
            label: "HR Health",
            value: "Stable",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<Employee>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "EMPLOYEE IDENTITY",
          width: 250,
          builder: (e) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(e.name.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 11)),
              Text(e.employeeCode,
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace')),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "DEPARTMENT",
          width: 160,
          builder: (e) => Text(e.departmentId.toUpperCase(),
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
        ),
        ZenoTableColumn(
          label: "STATUS",
          width: 140,
          builder: (e) => ZenoBadge(
            label: e.status.name.toUpperCase(),
            color: _getStatusColor(e.status),
          ),
        ),
        ZenoTableColumn(
          label: "JOINING DATE",
          width: 120,
          builder: (e) => Text(e.dateOfJoining.toString().substring(0, 10),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
        ZenoTableColumn(
          label: "PERFORMANCE",
          builder: (e) => const Row(
            children: [
              Icon(Icons.star_rounded, size: 12, color: Colors.amber),
              SizedBox(width: 4),
              Text("4.8", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Spacer(),
              ZenoBadge(label: "TOP TALENT", color: Colors.purple, isSolid: false),
            ],
          ),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Employee? e) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.radar_rounded,
            child: Center(child: Text("Employee 360° Profile Summary"))),
        const ZenoInspectorTab(
            label: "Employment",
            icon: Icons.business_center_outlined,
            child: Center(child: Text("Job, Shift \u0026 Reporting Hub"))),
        const ZenoInspectorTab(
            label: "Attendance",
            icon: Icons.event_available_outlined,
            child: Center(child: Text("Clock-in Logs \u0026 Roster"))),
        const ZenoInspectorTab(
            label: "Payroll",
            icon: Icons.payments_outlined,
            child: Center(child: Text("Salary Structure \u0026 Payslips"))),
        const ZenoInspectorTab(
            label: "Performance",
            icon: Icons.speed_rounded,
            child: Center(child: Text("Appraisals \u0026 Goal Tracking"))),
        const ZenoInspectorTab(
            label: "Documents",
            icon: Icons.description_outlined,
            child: Center(child: Text("Digital Contract Vault"))),
        const ZenoInspectorTab(
            label: "AI Insights",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Attrition Risk \u0026 Sentiment Analysis"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("HR AI: SEARCH STAFF, RUN PAYROLL, /leave...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "BIOMETRIC SYNC: ACTIVE", isActive: true),
        const ZenoStatusDot(label: "COMPLIANCE: VERIFIED", isActive: true),
      ];

  static Color _getStatusColor(EmployeeStatus status) {
    switch (status) {
      case EmployeeStatus.active: return Colors.green;
      case EmployeeStatus.probation: return Colors.blue;
      case EmployeeStatus.onLeave: return Colors.orange;
      case EmployeeStatus.suspended: return Colors.red;
      default: return Colors.grey;
    }
  }
}
