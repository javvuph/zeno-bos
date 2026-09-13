import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';

class AIFeature {
  final String title;
  final String description;
  final IconData icon;

  AIFeature(
      {required this.title, required this.description, required this.icon});
}

class AIInventoryHubScreen extends StatelessWidget {
  const AIInventoryHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AIFeature> features = [
      AIFeature(
          title: "Demand Forecast",
          description: "Predict future stock needs based on history.",
          icon: Icons.auto_graph),
      AIFeature(
          title: "Restock Prediction",
          description: "Automated replenishment suggestions.",
          icon: Icons.update),
      AIFeature(
          title: "Price Optimizer",
          description: "Dynamic pricing based on market trends.",
          icon: Icons.price_check),
      AIFeature(
          title: "Health Monitor",
          description: "Real-time audit of inventory data quality.",
          icon: Icons.health_and_safety),
      AIFeature(
          title: "Product Image Analysis",
          description: "Auto-tagging and quality check for images.",
          icon: Icons.image_search),
      AIFeature(
          title: "AI Inventory Assistant",
          description: "Natural language query for your stock.",
          icon: Icons.assistant),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "AI Inventory Hub".toUpperCase(),
          subtitle:
              "LEVERAGE NEURAL NETWORKS TO OPTIMIZE GLOBAL SUPPLY CHAIN NODES.",
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: ZenoDuration.std,
                  padding: const EdgeInsets.all(ZenoSpacing.xl),
                  decoration: BoxDecoration(
                    gradient: ZenoTheme.aiGlowGradient.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(ZenoRadius.xl),
                    border: Border.all(
                        color: ZenoTheme.cyan500.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                          color: ZenoTheme.cyan500.withValues(alpha: 0.05),
                          blurRadius: 40,
                          offset: const Offset(0, 20)),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome,
                          size: 48, color: ZenoTheme.cyan500),
                      const SizedBox(width: ZenoSpacing.xl),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("DYNAMIC INSIGHTS ENGINE",
                                style:
                                    ZenoTypography.headlineMD(ZenoTheme.cyan500)
                                        .copyWith(letterSpacing: 2)),
                            const SizedBox(height: 8),
                            Text(
                                "YOUR INVENTORY HEALTH IS AT 92%. WE FOUND 12 PRODUCTS THAT COULD BENEFIT FROM PRICE ADJUSTMENTS DUE TO HIGH DEMAND.",
                                style:
                                    ZenoTypography.bodyLG(ZenoTheme.textPrimary)
                                        .copyWith(height: 1.6)),
                          ],
                        ),
                      ),
                      const SizedBox(width: ZenoSpacing.xl),
                      const _ActionChip(label: "REVIEW INSIGHTS"),
                    ],
                  ),
                ),
                const SizedBox(height: ZenoSpacing.xl),
                Text("INTELLIGENT SYSTEMS",
                    style: ZenoTypography.micro(ZenoTheme.textSecondary)),
                const SizedBox(height: ZenoSpacing.lg),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: ZenoSpacing.lg,
                    mainAxisSpacing: ZenoSpacing.lg,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    final f = features[index];
                    return _AIFeatureCard(f: f);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AIFeatureCard extends StatefulWidget {
  final AIFeature f;
  const _AIFeatureCard({required this.f});

  @override
  State<_AIFeatureCard> createState() => _AIFeatureCardState();
}

class _AIFeatureCardState extends State<_AIFeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: ZenoDuration.fast,
        decoration: BoxDecoration(
          color: _isHovered ? colors.bgTier3 : colors.bgTier2,
          borderRadius: BorderRadius.circular(ZenoRadius.lg),
          border: Border.all(
              color: _isHovered
                  ? colors.accentPrimary.withValues(alpha: 0.5)
                  : colors.borderSubtle),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                      color: colors.accentPrimary.withValues(alpha: 0.1),
                      blurRadius: 20)
                ]
              : [],
        ),
        padding: const EdgeInsets.all(ZenoSpacing.lg),
        child: Row(
          children: [
            Icon(widget.f.icon,
                size: 28,
                color:
                    _isHovered ? colors.accentPrimary : colors.textSecondary),
            const SizedBox(width: ZenoSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.f.title.toUpperCase(),
                      style: ZenoTypography.bodyMD(colors.textPrimary)
                          .copyWith(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text(widget.f.description.toUpperCase(),
                      style: ZenoTypography.micro(colors.textSecondary)
                          .copyWith(fontSize: 8)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String label;
  const _ActionChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg, vertical: 10),
      decoration: BoxDecoration(
        color: colors.accentPrimary,
        borderRadius: BorderRadius.circular(ZenoRadius.full),
        boxShadow: [
          BoxShadow(
              color: colors.accentPrimary.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Text(label,
          style: ZenoTypography.caption(Colors.black)
              .copyWith(fontWeight: FontWeight.w900)),
    );
  }
}
