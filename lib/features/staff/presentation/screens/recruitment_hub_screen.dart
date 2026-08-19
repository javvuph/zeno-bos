import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class RecruitmentHubScreen extends StatelessWidget {
  const RecruitmentHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Talent Acquisition \u0026 Recruitment Pipeline", 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                _buildPipelineColumn("Screening", 4),
                _buildPipelineColumn("Interview", 2),
                _buildPipelineColumn("Evaluating", 1),
                _buildPipelineColumn("Offered", 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineColumn(String label, int count) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(label.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 0.5)),
                const Spacer(),
                ZenoBadge(label: "$count", color: Colors.blueGrey, isSolid: false),
              ],
            ),
            const Divider(height: 24),
            // Mock Candidates
            const ZenoCard(title: "Arjun Singh", child: Text("Senior Developer\nScore: 84/100")),
            const SizedBox(height: 8),
            const ZenoCard(title: "Meera Nair", child: Text("UI Designer\nScore: 91/100")),
          ],
        ),
      ),
    );
  }
}
