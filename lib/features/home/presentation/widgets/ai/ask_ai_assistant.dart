import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class AskAIAssistant extends StatelessWidget {
  const AskAIAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Ask ZENO AI",
      accentColor: ZenoTheme.neonCyan,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ZenoTheme.background.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: ZenoTheme.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _aiMessage(
                        "Hello! I'm ZENO. How can I help you analyze your business performance today?"),
                    const SizedBox(height: 16),
                    const Text("SUGGESTED ANALYTICS",
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: ZenoTheme.textSecondary,
                            letterSpacing: 1)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _suggestionChip("Why did sales drop today?"),
                        _suggestionChip("Predict next month revenue"),
                        _suggestionChip("Show inventory at risk"),
                        _suggestionChip("How to improve profit?"),
                        _suggestionChip("Compare with last year"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: ZenoTheme.surface,
                borderRadius: BorderRadius.circular(22),
                border:
                    Border.all(color: ZenoTheme.accent.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.psychology_outlined,
                      size: 18, color: ZenoTheme.neonCyan),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Type your business query here...",
                        hintStyle: TextStyle(
                            fontSize: 12, color: ZenoTheme.textSecondary),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_outlined,
                        size: 18, color: ZenoTheme.neonCyan),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aiMessage(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
              color: ZenoTheme.accent, shape: BoxShape.circle),
          child: const Icon(Icons.auto_awesome, size: 10, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                  fontSize: 11, height: 1.4, fontStyle: FontStyle.italic)),
        ),
      ],
    );
  }

  Widget _suggestionChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: ZenoTheme.border.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ZenoTheme.border),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 9, color: ZenoTheme.textPrimary)),
    );
  }
}
