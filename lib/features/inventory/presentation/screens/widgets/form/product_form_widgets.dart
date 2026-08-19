import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_button.dart';

class FormErrorBar extends StatelessWidget {
  final String error;
  final ZenoSemanticColors colors;

  const FormErrorBar({super.key, required this.error, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: colors.statusDanger.withValues(alpha: 0.1),
        border: Border.all(color: colors.statusDanger.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: colors.statusDanger, size: 18),
          const SizedBox(width: 12),
          Text(error, style: TextStyle(color: colors.statusDanger, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}

class StudioPreviewCard extends StatelessWidget {
  final ZenoSemanticColors colors;

  const StudioPreviewCard({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ZenoCard(
      title: "STUDIO PREVIEW",
      child: Column(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.bgTier2,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.borderSubtle),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_search_rounded, size: 32, color: Colors.white10),
                SizedBox(height: 12),
                Text("NO MEDIA ATTACHED", style: TextStyle(fontSize: 9, color: Colors.white24, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ZenoButton(
            label: "Upload Product Assets",
            icon: Icons.cloud_upload_outlined,
            variant: ZenoButtonVariant.secondary,
            isFullWidth: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class AIAssistCard extends StatelessWidget {
  final ZenoSemanticColors colors;

  const AIAssistCard({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ZenoCard(
      title: "AI ENGINE ASSIST",
      color: colors.accentPurple.withValues(alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("SMART DESCRIPTIONS", style: ZenoTypography.caption(colors.accentPurple).copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          Text("I can optimize your product SEO and technical details.", style: TextStyle(fontSize: 11, color: colors.textSecondary)),
          const SizedBox(height: 16),
          ZenoButton(
            label: "Generate Descriptions",
            icon: Icons.auto_awesome,
            variant: ZenoButtonVariant.secondary,
            isFullWidth: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
