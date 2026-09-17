part of '../performance_matrix_row.dart';

class _HealthTile extends StatelessWidget {
  final String label;
  final double score;
  final ZenoSemanticColors colors;

  const _HealthTile(
      {required this.label, required this.score, required this.colors});

  @override
  Widget build(BuildContext context) {
    Color color = _getScoreColor(label, score);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.bgTier1,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A92A6),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(_getIconForLabel(label),
                  size: 12,
                  color: color.withValues(alpha: 0.5)),
            ],
          ),
          Text(
            "${score.toInt()}%",
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: color,
              height: 1.1,
            ),
          ),
          _buildSubtext(label, color),
        ],
      ),
    );
  }

  Widget _buildSubtext(String label, Color color) {
    String badge = "";
    String text = "";
    Color badgeColor = color;

    switch (label) {
      case 'Overall':
        badge = "▲ +1.2%";
        text = "Target: 85%";
        break;
      case 'Sales':
        badge = "▲ +4.5%";
        text = "Target Met";
        badgeColor = const Color(0xFF00F0FF);
        break;
      case 'Finance':
        badge = "▲ +0.8%";
        text = "Audited";
        break;
      case 'Inventory':
        badge = "⚠️ -5.1%";
        text = "Low Stock Alert";
        badgeColor = const Color(0xFFF59E0B);
        break;
      default:
        return Text(
          "On Track",
          style: TextStyle(
              fontSize: 10, color: colors.textSecondary, fontFamily: 'Inter'),
        );
    }

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 4, vertical: 0.5),
          decoration: BoxDecoration(
            color: badgeColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
          ),
          child: Text(
            badge,
            style: TextStyle(
                fontSize: 8.5,
                fontWeight: FontWeight.w800,
                color: badgeColor),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 9.5,
                color: colors.textSecondary,
                fontFamily: 'Inter'),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color _getScoreColor(String label, double score) {
    if (score >= 90) return colors.accentPrimary;
    if (score >= 80) return colors.statusSuccess;
    if (score >= 60) return colors.statusWarning;
    return colors.statusDanger;
  }

  IconData _getIconForLabel(String label) {
    switch (label) {
      case 'Overall':
        return Icons.analytics;
      case 'Sales':
        return Icons.trending_up;
      case 'Finance':
        return Icons.account_balance;
      case 'Inventory':
        return Icons.inventory_2;
      case 'Customer':
        return Icons.people;
      case 'Operations':
        return Icons.settings_applications;
      case 'Delivery':
        return Icons.local_shipping;
      case 'HR':
        return Icons.badge;
      default:
        return Icons.info_outline;
    }
  }
}
