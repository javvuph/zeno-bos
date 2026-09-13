import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/reports_controller.dart';

class ExecutiveBIScreen extends StatefulWidget {
  const ExecutiveBIScreen({super.key});

  @override
  State<ExecutiveBIScreen> createState() => _ExecutiveBIScreenState();
}

class _ExecutiveBIScreenState extends State<ExecutiveBIScreen> {
  late final ReportsController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<ReportsController>();
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
            title: "Executive BI Command Center",
            subtitle: "STRATEGIC ANALYTICS LAYER: GLOBAL REVENUE, PROFITABILITY, AND BUSINESS HEALTH.",
          ),
          const SizedBox(height: 24),
          
          ZenoKpiHud(
            metrics: [
              ZenoKpiData(label: "Total Revenue", value: "₹${(controller.totalRevenue / 100000).toStringAsFixed(1)}L", icon: Icons.trending_up_rounded, color: Colors.green),
              ZenoKpiData(label: "Net Profit", value: "₹${(controller.netProfit / 100000).toStringAsFixed(1)}L", icon: Icons.account_balance_wallet_outlined, color: Colors.blue),
              ZenoKpiData(label: "Cash Position", value: "₹${(controller.cashPosition / 100000).toStringAsFixed(1)}L", icon: Icons.savings_outlined, color: const Color(0xFFFFD700)),
              ZenoKpiData(label: "Sales Growth", value: "+${controller.salesGrowth}%", icon: Icons.auto_graph_rounded, color: const Color(0xFF00F0FF)),
            ],
          ),
          
          const SizedBox(height: 24),
          
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ZenoCard(
                  title: "Revenue vs Profit Trend",
                  child: Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: const Text("MULTI-AXIS LINE CHART - ACTIVE", 
                      style: TextStyle(color: Colors.white24, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ZenoCard(
                  title: "Operational Efficiency",
                  child: Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: const Text("GAUGE WIDGET - ACTIVE", 
                      style: TextStyle(color: Colors.white24, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          ZenoCard(
            title: "Neural Business Health Audit",
            child: Column(
              children: [
                _buildAuditLine("Inventory Turnover", "Optimized", Icons.check_circle_outline, Colors.green),
                _buildAuditLine("Receivable Aging", "Risk Detected (12 days overdue)", Icons.warning_amber_rounded, Colors.orange),
                _buildAuditLine("Operating Margin", "Exceeding Target", Icons.trending_up, Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditLine(String label, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 12)),
        ],
      ),
    );
  }
}
