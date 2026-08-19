import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../../domain/models/crm_activity.dart';
import '../controllers/crm_controller.dart';

class CRMExecutiveDashboard extends StatefulWidget {
  const CRMExecutiveDashboard({super.key});

  @override
  State<CRMExecutiveDashboard> createState() => _CRMExecutiveDashboardState();
}

class _CRMExecutiveDashboardState extends State<CRMExecutiveDashboard> {
  late final CRMController controller;

  @override
  void initState() {
    super.initState();
    controller = CRMController(sl<ICustomerRepository>());
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
            title: "CRM Executive Command Center",
            subtitle:
                "STRATEGIC RELATIONSHIP MONITOR: PIPELINE, SERVICE DESK, AND GROWTH ANALYTICS.",
          ),
          const SizedBox(height: 24),
          ZenoKpiHud(
            metrics: [
              ZenoKpiData(
                  label: "Total Leads",
                  value: "${controller.leads.length}",
                  icon: Icons.person_search_rounded),
              ZenoKpiData(
                  label: "Qualified",
                  value: "${controller.qualifiedLeadsCount}",
                  icon: Icons.verified_user_outlined,
                  color: Colors.green),
              ZenoKpiData(
                  label: "Open Tickets",
                  value: "${controller.openTicketsCount}",
                  icon: Icons.support_agent_rounded,
                  color: controller.slaBreachesCount > 0
                      ? Colors.red
                      : Colors.orange),
              ZenoKpiData(
                  label: "Activities Today",
                  value: "${controller.activitiesTodayCount}",
                  icon: Icons.calendar_today_rounded,
                  color: Colors.blue),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ZenoCard(
                  title: "Sales Pipeline Funnel",
                  subtitle: "DEAL FLOW FROM LEAD TO CONVERSION",
                  child: Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: const Text("PIPELINE VISUALIZATION ENGINE - ACTIVE",
                        style: TextStyle(
                            color: Colors.white24,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ZenoCard(
                  title: "AI CRM Insights",
                  subtitle: "NEXT BEST ACTION & RISK ALERTS",
                  child: Column(
                    children: [
                      _buildInsightItem(
                          "Follow-up with Vikram Singh",
                          "HIGH CONVERSION PROBABILITY (82%)",
                          Icons.call,
                          Colors.green),
                      _buildInsightItem(
                          "SLA Breach Alert: TKT-9901",
                          "CRITICAL SUPPORT DELAY DETECTED",
                          Icons.warning_rounded,
                          Colors.red),
                      _buildInsightItem(
                          "Upsell Opportunity: Amit Patel",
                          "LIFETIME VALUE EXPANSION READY",
                          Icons.auto_awesome,
                          Colors.amber),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ZenoCard(
            title: "Recent Communication Timeline",
            subtitle: "UNIFIED JOURNEY TOUCHPOINTS",
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.activities.length,
              itemBuilder: (context, index) {
                final act = controller.activities[index];
                return ListTile(
                  leading:
                      Icon(_getActivityIcon(act.type), color: Colors.blueGrey),
                  title: Text(act.title.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12)),
                  subtitle: Text(
                      "${act.type.name.toUpperCase()} - ${act.scheduledAt}",
                      style: const TextStyle(fontSize: 10)),
                  trailing: ZenoBadge(
                      label: act.status.name.toUpperCase(), color: Colors.blue),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(
      String title, String desc, IconData icon, Color color) {
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
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 11)),
                Text(desc,
                    style: const TextStyle(fontSize: 9, color: Colors.white54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getActivityIcon(ActivityType t) {
    switch (t) {
      case ActivityType.call:
        return Icons.phone;
      case ActivityType.meeting:
        return Icons.groups;
      case ActivityType.demo:
        return Icons.slideshow;
      default:
        return Icons.task_alt;
    }
  }
}
