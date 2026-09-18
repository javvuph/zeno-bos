import 'package:flutter/material.dart';
import 'package:zeno/app/theme_colors.dart';
import 'package:zeno/features/inventory/domain/models/product_master_models.dart';

class InventoryKpiGrid extends StatelessWidget {
  final List<ProductMaster> products;

  const InventoryKpiGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final totalStyles = products.length;
    double totalUnits = 0.0;
    double totalValuationAtCost = 0.0;
    int stockAtRisk = 0;
    int count6M = 0;
    int count1Y = 0;

    for (final p in products) {
      final stock = p.totalStock;
      totalUnits += stock;
      totalValuationAtCost += (stock * p.cost);

      if (stock <= p.reorderLevel) {
        stockAtRisk++;
      }

      final aging = getAgingMeta(p.addedDate);
      if (aging.months >= 6 && aging.months < 12) count6M++;
      if (aging.months >= 12) count1Y++;
    }

    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    final border = colors?.borderSubtle ?? const Color(0xFFD9DFF2);
    final surface = colors?.bgSurface ?? Colors.white;
    final textPrimary = colors?.textPrimary ?? const Color(0xFF26324A);
    final textSecondary = colors?.textSecondary ?? const Color(0xFF64748B);

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1100
            ? 5
            : (constraints.maxWidth > 700 ? 3 : 1);

        return GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 2.1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildKpiCard(
              title: "TOTAL PRODUCTS",
              number: "$totalStyles",
              subtitle: "$totalStyles Styles • ${totalUnits.toStringAsFixed(0)} Units",
            ),
            _buildKpiCard(
              title: "INVENTORY VALUE",
              number: "₹${totalValuationAtCost.toStringAsFixed(0)}",
              subtitle: "At Cost • Live",
            ),
            _buildKpiCard(
              title: "STOCK AT RISK",
              number: "$stockAtRisk",
              subtitle: "Below threshold",
              numberColor: const Color(0xFFB45309),
            ),
            _buildKpiCard(
              title: "⏳ 6M+ AGING STOCK",
              number: "$count6M Styles",
              subtitle: "Needs clearance review",
              borderColor: const Color(0xFFFCD34D),
              gradientColors: const [Color(0xFFFFFBEB), Colors.white],
              titleColor: const Color(0xFF92400E),
              numberColor: const Color(0xFFB45309),
            ),
            _buildKpiCard(
              title: "🚨 1Y+ DEAD STOCK ALERT",
              number: "$count1Y Styles",
              subtitle: "Critical aged stock",
              borderColor: const Color(0xFFFCA5A5),
              gradientColors: const [Color(0xFFFEF2F2), Colors.white],
              titleColor: const Color(0xFF991B1B),
              numberColor: const Color(0xFFDC2626),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String number,
    required String subtitle,
    Color? borderColor,
    List<Color>? gradientColors,
    Color? titleColor,
    Color? numberColor,
  }) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    final surface = colors?.bgSurface ?? Colors.white;
    final border = colors?.borderSubtle ?? const Color(0xFFD9DFF2);
    final textPrimary = colors?.textPrimary ?? const Color(0xFF26324A);
    final textSecondary = colors?.textSecondary ?? const Color(0xFF64748B);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.86),
        gradient: gradientColors != null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              )
            : null,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor ?? border,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(15, 23, 42, 0.04),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: titleColor ?? textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            number,
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              color: numberColor ?? textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textSecondary.withValues(alpha: 0.72),
            ),
          ),
        ],
      ),
    );
  }
}
