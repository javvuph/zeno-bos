import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/controllers/bi_mock_data.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

class PerformanceMatrixRow extends StatelessWidget {
  const PerformanceMatrixRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 360,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // LEFT: BUSINESS HEALTH MATRIX (50%)
          Expanded(
            child: _BusinessHealthMatrix(),
          ),
          SizedBox(width: 16),
          // RIGHT: TOP PRODUCT LEADERBOARD (50%)
          Expanded(
            child: _ProductLeaderboard(),
          ),
        ],
      ),
    );
  }
}

class _BusinessHealthMatrix extends StatelessWidget {
  const _BusinessHealthMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final scores = BIMockData.getBusinessHealthScores();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "DEPARTMENT HEALTH MATRIX",
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 88, // Spec: Fixed 88px height
              ),
              itemCount: 8, // Refined into top 8 metrics
              itemBuilder: (context, index) {
                final key = scores.keys.elementAt(index);
                final value = scores[key]!;
                return _HealthTile(label: key, score: value, colors: colors);
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
          horizontal: 12, vertical: 8), // Reduced vertical padding from 12 to 8
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
                    fontSize: 11, // Slightly reduced from 12 to save space
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A92A6),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(_getIconForLabel(label),
                  size: 12,
                  color: color.withValues(
                      alpha: 0.5)), // Reduced icon size from 14 to 12
            ],
          ),
          Text(
            "${score.toInt()}%",
            style: TextStyle(
              fontSize: 22, // Slightly reduced from 24
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: color,
              height: 1.1, // Tighten line height
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
        badgeColor = const Color(0xFF00F0FF); // Cyan
        break;
      case 'Finance':
        badge = "▲ +0.8%";
        text = "Audited";
        break;
      case 'Inventory':
        badge = "⚠️ -5.1%";
        text = "Low Stock Alert";
        badgeColor = const Color(0xFFF59E0B); // Amber
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
              horizontal: 4, vertical: 0.5), // Tighter vertical padding
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
                color: badgeColor), // Slightly smaller font
          ),
        ),
        const SizedBox(width: 4), // Reduced from 6
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 9.5,
                color: colors.textSecondary,
                fontFamily: 'Inter'), // Slightly smaller
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

class _ProductLeaderboard extends StatelessWidget {
  const _ProductLeaderboard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    // Mock data for leaderboard
    final List<Map<String, dynamic>> topProducts = [
      {
        "sku": "SKU-9021",
        "name": "Kids Daily Set",
        "units": 1240,
        "rev": 24800.00
      },
      {
        "sku": "SKU-4022",
        "name": "Cotton Wear Set",
        "units": 980,
        "rev": 19600.00
      },
      {
        "sku": "SKU-1055",
        "name": "Linen Summer Mix",
        "units": 850,
        "rev": 17000.00
      },
      {
        "sku": "SKU-7721",
        "name": "Premium Denim",
        "units": 720,
        "rev": 14400.00
      },
      {
        "sku": "SKU-3320",
        "name": "Active Run Gear",
        "units": 610,
        "rev": 12200.00
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bgTier4, // Spec: Deep Matte Base
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TOP PRODUCT LEADERBOARD",
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ZenoTable<Map<String, dynamic>>(
              items: topProducts,
              columns: [
                ZenoTableColumn(
                  label: "SKU",
                  width: 80,
                  builder: (p) => Text(p['sku'],
                      style:
                          TextStyle(fontSize: 11, color: colors.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "PRODUCT NAME",
                  builder: (p) => Text(p['name'],
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w700)),
                ),
                ZenoTableColumn(
                  label: "UNITS",
                  width: 70,
                  isNumeric: true,
                  builder: (p) => Text(p['units'].toString()),
                ),
                ZenoTableColumn(
                  label: "REVENUE",
                  width: 90,
                  isNumeric: true,
                  builder: (p) => Text("\$${p['rev'].toStringAsFixed(0)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colors.accentPrimary)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
