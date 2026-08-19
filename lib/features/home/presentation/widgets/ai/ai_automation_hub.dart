import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/features/ai_center/domain/repositories/i_ai_repository.dart';
import 'package:zeno/features/ai_center/presentation/controllers/ai_controller.dart';
import 'package:zeno/features/ai_center/domain/models/ai_automation.dart';

class AIAutomationHub extends StatefulWidget {
  const AIAutomationHub({super.key});

  @override
  State<AIAutomationHub> createState() => _AIAutomationHubState();
}

class _AIAutomationHubState extends State<AIAutomationHub> {
  late final AIController controller;

  @override
  void initState() {
    super.initState();
    controller = AIController(sl<IAIRepository>());
    controller.loadAutomations();
    controller.addListener(_onUpdate);
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "AI Actionable Recommendations",
      accentColor: Colors.orange,
      child: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.automations.length,
              separatorBuilder: (_, __) =>
                  const Divider(color: ZenoTheme.border, height: 16),
              itemBuilder: (context, index) {
                final item = controller.automations[index];
                final Color color = _getStatusColor(item.status);

                return Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(_getTriggerIcon(item.trigger),
                          color: color, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 2),
                          Text(item.description,
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: ZenoTheme.textSecondary,
                                  height: 1.3)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color.withValues(alpha: 0.2),
                        foregroundColor: color,
                        elevation: 0,
                        side: BorderSide(color: color.withValues(alpha: 0.3)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        minimumSize: const Size(100, 32),
                      ),
                      child: Text(item.status.name.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 9, fontWeight: FontWeight.bold)),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Color _getStatusColor(AutomationStatus status) {
    switch (status) {
      case AutomationStatus.active:
        return Colors.green;
      case AutomationStatus.paused:
        return Colors.orange;
      case AutomationStatus.failed:
        return Colors.red;
      case AutomationStatus.draft:
        return Colors.grey;
      case AutomationStatus.completed:
        return Colors.blue;
    }
  }

  IconData _getTriggerIcon(AutomationTrigger trigger) {
    switch (trigger) {
      case AutomationTrigger.event:
        return Icons.event;
      case AutomationTrigger.schedule:
        return Icons.schedule;
      case AutomationTrigger.threshold:
        return Icons.trending_up;
      case AutomationTrigger.anomaly:
        return Icons.warning_amber_rounded;
      default:
        return Icons.bolt;
    }
  }
}
