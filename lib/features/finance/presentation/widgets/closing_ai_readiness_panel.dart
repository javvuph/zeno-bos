import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ClosingAiReadinessPanel extends StatelessWidget {
  final double score;
  const ClosingAiReadinessPanel({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF001A20), colors.bgTier2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: const Color(0xFF00F0FF).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, size: 20, color: Color(0xFF00F0FF)),
              SizedBox(width: 12),
              Text("AI READINESS ANALYSIS",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      color: Color(0xFF00F0FF))),
            ],
          ),
          const SizedBox(height: 24),
          _insightRow(
              "MISSING POSTINGS",
              "03 suspicious gaps in sequential journal numbering.",
              Icons.warning_amber_rounded,
              Colors.orange),
          const SizedBox(height: 16),
          _insightRow(
              "MATCHING ACCURACY",
              "99.4% probability of successful intercompany matching.",
              Icons.insights_rounded,
              Colors.green),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("CLOSING RECOMMENDATION",
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                const SizedBox(height: 8),
                Text(
                  score > 90
                      ? "Proceed with Hard Close. Financial integrity verified."
                      : "Complete remaining mandatory tasks. Anomaly detection flagged 03 items for review.",
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w600, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _insightRow(String label, String text, IconData icon, Color color) {
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
              Text(text,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }
}
