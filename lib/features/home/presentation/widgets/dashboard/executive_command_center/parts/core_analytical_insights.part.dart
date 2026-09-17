part of '../core_analytical_row.dart';

class _AIStrategicInsights extends StatelessWidget {
  const _AIStrategicInsights();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "✨ AI STRATEGIC INSIGHTS",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Real-Time Risk Radar",
            style: TextStyle(fontSize: 10, color: colors.textSecondary),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _AICard(
                  tag: "Warning • OpEx Spike",
                  message:
                      "Freight & shipping logistics increased +14% this week.",
                  actionLabel: "OPTIMIZE LOGISTICS ›",
                  color: colors.statusDanger,
                  colors: colors,
                ),
                const SizedBox(height: 12),
                _AICard(
                  tag: "Warning • Stock Depletion",
                  message:
                      "Flagship 'MacBook M3' stock will last only 5 days at current sales velocity.",
                  actionLabel: "RESTOCK NOW ›",
                  color: colors.statusDanger,
                  colors: colors,
                ),
                const SizedBox(height: 12),
                _AICard(
                  tag: "Opportunity • Revenue Growth",
                  message:
                      "Sales increased 18% compared to last month. North branch leads growth.",
                  actionLabel: "VIEW ANALYSIS ›",
                  color: colors.statusSuccess,
                  colors: colors,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "AI Status: Ready",
            style: TextStyle(fontSize: 10, color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _AICard extends StatelessWidget {
  final String tag;
  final String message;
  final String actionLabel;
  final Color color;
  final ZenoSemanticColors colors;

  const _AICard({
    required this.tag,
    required this.message,
    required this.actionLabel,
    required this.color,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.bgTier1,
        borderRadius: BorderRadius.circular(6),
        border: Border(
          left: BorderSide(color: color, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              tag.toUpperCase(),
              style: TextStyle(
                  fontSize: 9, fontWeight: FontWeight.w800, color: color),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
                fontSize: 11,
                color: colors.textPrimary.withValues(alpha: 0.9),
                height: 1.4),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: Text(
              actionLabel,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: colors.accentPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
