import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../domain/models/budget.dart';

class BudgetAiAdvisorPanel extends StatelessWidget {
  final Budget budget;
  const BudgetAiAdvisorPanel({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome,
                  size: 20, color: Color(0xFF00F0FF)),
              SizedBox(width: 12),
              Text("AI BUDGET ADVISOR",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 0.5)),
            ],
          ),
          const SizedBox(height: 24),
          _buildInsight(
              "SPENDING FORECAST",
              "Current trajectory suggests 104% utilization by Nov 12.",
              Icons.timeline_rounded,
              Colors.orange),
          const SizedBox(height: 16),
          _buildInsight(
              "OPTIMIZATION",
              "Redundant cloud instances detected in Project Alpha. Potential ₹12K monthly saving.",
              Icons.lightbulb_outline_rounded,
              Colors.green),
          const SizedBox(height: 16),
          _buildInsight(
              "RISK LEVEL",
              budget.isOverBudget
                  ? "CRITICAL: BUDGET BREACHED"
                  : "LOW: WITHIN TOLERANCE",
              Icons.gpp_maybe_rounded,
              budget.isOverBudget ? Colors.red : Colors.blue),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          const Text("ADVISOR RECOMMENDATION",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          const SizedBox(height: 8),
          Text(
            budget.isOverBudget
                ? "Immediately freeze discretionary spending for ${budget.name} and initiate a budget revision workflow."
                : "Maintain current spending rate. No optimization required at this stage.",
            style: const TextStyle(
                fontSize: 11, fontWeight: FontWeight.w600, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildInsight(String label, String value, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }
}
