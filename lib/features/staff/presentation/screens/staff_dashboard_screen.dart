import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/staff_controller.dart';
import '../manifests/hr_workspace_manifest.dart';

class StaffDashboardScreen extends StatefulWidget {
  const StaffDashboardScreen({super.key});

  @override
  State<StaffDashboardScreen> createState() => _StaffDashboardScreenState();
}

class _StaffDashboardScreenState extends State<StaffDashboardScreen> {
  late final StaffController controller;
  final manifest = const HRWorkspaceManifest();

  @override
  void initState() {
    super.initState();
    controller = sl<StaffController>();
    controller.addListener(_onUpdate);
  }

  void _onUpdate() => setState(() {});

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ZenoHeader(
            title: "HR Executive Command Center",
            subtitle: "STRATEGIC WORKFORCE MONITOR: PERSONNEL, ATTENDANCE, AND PAYROLL ANALYTICS.",
          ),
          const SizedBox(height: 24),
          
          ZenoKpiHud(
            metrics: [
              ZenoKpiData(label: "Total Staff", value: "${controller.employees.length}", icon: Icons.people_outline_rounded),
              ZenoKpiData(label: "Present Today", value: "${controller.presentTodayCount}", icon: Icons.check_circle_outline_rounded, color: Colors.green),
              ZenoKpiData(label: "On Leave", value: "${controller.pendingLeaveCount}", icon: Icons.event_busy_outlined, color: Colors.orange),
              ZenoKpiData(label: "Payroll Due", value: "₹${(controller.monthlyPayrollAmount / 1000000).toStringAsFixed(1)}M", icon: Icons.payments_outlined, color: Colors.red),
            ],
          ),
          
          const SizedBox(height: 24),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ZenoCard(
                  title: "Attendance Trends",
                  child: Container(
                    height: 270,
                    alignment: Alignment.center,
                    child: const Text("ATTENDANCE HEATMAP - ACTIVE", 
                      style: TextStyle(color: Colors.white24, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ZenoCard(
                  title: "AI HR Insights",
                  child: Column(
                    children: [
                      _buildInsightItem("Attrition Risk Detected", "High probability for 3 personnel in DEPT-ENG", Icons.warning_rounded, Colors.red),
                      _buildInsightItem("Skill Gap Analysis", "Training recommended for 'Cloud Architecture'", Icons.school_outlined, Colors.blue),
                      _buildInsightItem("Overtime Anomaly", "Unusual hours logged in B-NORTH branch", Icons.timer_outlined, Colors.orange),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          ZenoCard(
            title: "Employee Lifecycle Timeline",
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.employees.length.clamp(0, 5),
              itemBuilder: (context, index) {
                final emp = controller.employees[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(emp.firstName[0])),
                  title: Text(emp.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  subtitle: Text("${emp.designationId.replaceAll('DES_', '')} - Joined ${emp.dateOfJoining.toString().substring(0, 10)}", style: const TextStyle(fontSize: 10)),
                  trailing: const Icon(Icons.chevron_right_rounded),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String title, String desc, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                Text(desc, style: const TextStyle(fontSize: 9, color: Colors.white54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
