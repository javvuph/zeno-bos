import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/home_widgets.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class AICommandCenterScreen extends StatelessWidget {
  const AICommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZenoTheme.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.auto_awesome, color: ZenoTheme.neonCyan, size: 28),
                SizedBox(width: 16),
                Text(
                  "AI COMMAND CENTER",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2),
                ),
              ],
            ),
            const Text(
              "Centralized intelligence and automation control.",
              style: TextStyle(color: ZenoTheme.textSecondary),
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      CommandCenterWidget(
                        title: "AI Business Assistant",
                        accentColor: ZenoTheme.neonCyan,
                        child: GestureDetector(
                          onTap: () => NavigationController()
                              .navigateTo('ai/command/assistant'),
                          child: Container(
                            height: 400,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: ZenoTheme.border),
                            ),
                            child: Column(
                              children: [
                                const Expanded(
                                    child: Center(
                                        child: Text(
                                            "Interactive AI Chat Interface"))),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: ZenoTheme.surface,
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: ZenoTheme.border)),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.mic_none,
                                          size: 20,
                                          color: ZenoTheme.textSecondary),
                                      SizedBox(width: 16),
                                      Expanded(
                                          child: Text(
                                              "Ask AI for business insights...",
                                              style: TextStyle(
                                                  color:
                                                      ZenoTheme.textSecondary,
                                                  fontSize: 13))),
                                      Icon(Icons.send,
                                          size: 16, color: ZenoTheme.neonCyan),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                const Expanded(
                  child: Column(
                    children: [
                      CommandCenterWidget(
                        title: "Automation Suggestions",
                        accentColor: ZenoTheme.neonGreen,
                        child: Column(
                          children: [
                            _AutomationTile(
                                title: "Auto-reorder Low Stock",
                                desc: "Trigger when stock < 10%"),
                            _AutomationTile(
                                title: "Email Weekly Report",
                                desc: "Send to Exec at 08:00 AM Mon"),
                            _AutomationTile(
                                title: "Flag Fraudulent Billing",
                                desc: "Scan transactions for anomalies"),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      CommandCenterWidget(
                        title: "Smart Recommendations",
                        accentColor: Colors.amber,
                        child: Column(
                          children: [
                            _AIInsightRow(
                                text:
                                    "Promote 'X-Series' in the North Region."),
                            _AIInsightRow(
                                text: "Shift inventory to Downtown Warehouse."),
                            _AIInsightRow(
                                text:
                                    "Review contract with Logistics Provider."),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AutomationTile extends StatelessWidget {
  final String title;
  final String desc;

  const _AutomationTile({required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: ZenoTheme.border.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 10, color: ZenoTheme.textSecondary)),
              ],
            ),
          ),
          Switch(
              value: true,
              onChanged: (v) {},
              activeTrackColor: ZenoTheme.neonGreen),
        ],
      ),
    );
  }
}

class _AIInsightRow extends StatelessWidget {
  final String text;

  const _AIInsightRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb_outline, size: 14, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
