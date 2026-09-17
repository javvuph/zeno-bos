import 'package:flutter/material.dart';
import '../../domain/models/product.dart';

class InventoryKpiCards extends StatelessWidget {
  final List<Product> products;
  const InventoryKpiCards({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    int totalStyles = products.length;
    int totalPhysicalUnits = 0;
    double totalInventoryValue = 0.0;
    int stockAtRisk = 0;
    int criticalAlerts = 0;

    for (final p in products) {
      final stockInt = p.stockLevel.round();
      totalPhysicalUnits += stockInt;

      final unitCost = p.baseCost > 0 ? p.baseCost : p.basePrice;
      totalInventoryValue += (stockInt * unitCost);

      if (stockInt == 0) {
        criticalAlerts++;
      } else if (stockInt <= p.reorderLevel || stockInt <= 2) {
        stockAtRisk++;
      }
    }

    return Row(
      children: [
        // 1. TOTAL PRODUCTS
        Expanded(
          child: _kpiCard(
            icon: Icons.inventory_2_outlined,
            iconBg: const Color(0xFFEEF2FF),
            iconColor: const Color(0xFF4F46E5),
            label: "TOTAL PRODUCTS",
            value: "$totalStyles",
            subtext: "$totalStyles Styles • $totalPhysicalUnits Units",
          ),
        ),
        const SizedBox(width: 12),
        // 2. INVENTORY VALUE
        Expanded(
          child: _kpiCard(
            icon: Icons.account_balance_wallet_outlined,
            iconBg: const Color(0xFFECFDF5),
            iconColor: const Color(0xFF059669),
            label: "INVENTORY VALUE",
            value: "₹${_formatCurrency(totalInventoryValue)}",
            subWidget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFD1FAE5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                "AT COST • LIVE",
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF047857)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // 3. STOCK AT RISK
        Expanded(
          child: _kpiCard(
            icon: Icons.warning_amber_rounded,
            iconBg: const Color(0xFFFEF3C7),
            iconColor: const Color(0xFFD97706),
            label: "STOCK AT RISK",
            value: "$stockAtRisk",
            subtext: "$stockAtRisk Styles below threshold",
            valueColor: stockAtRisk > 0 ? const Color(0xFFD97706) : Colors.black,
          ),
        ),
        const SizedBox(width: 12),
        // 4. CRITICAL ALERTS
        Expanded(
          child: _kpiCard(
            icon: Icons.error_outline_rounded,
            iconBg: const Color(0xFFFEE2E2),
            iconColor: const Color(0xFFDC2626),
            label: "CRITICAL ALERTS",
            value: "$criticalAlerts",
            subtext: "$criticalAlerts items out of stock",
            valueColor: criticalAlerts > 0 ? const Color(0xFFDC2626) : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _kpiCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required String value,
    String? subtext,
    Widget? subWidget,
    Color valueColor = const Color(0xFF1E293B),
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF64748B),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: valueColor,
                      ),
                    ),
                    if (subWidget != null) ...[
                      const SizedBox(width: 8),
                      subWidget,
                    ],
                  ],
                ),
                if (subtext != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtext,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF94A3B8),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double val) {
    if (val >= 100000) {
      return "${(val / 100000).toStringAsFixed(1)}L";
    }
    return val.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}

extension ProductHelper on Product {
  int roundStock(double stock) => stock.round();
}
