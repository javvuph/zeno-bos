import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class Promotion {
  final String name;
  final String type;
  final String value;
  final String validity;

  Promotion(
      {required this.name,
      required this.type,
      required this.value,
      required this.validity});
}

class PromotionListScreen extends StatelessWidget {
  const PromotionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Promotion> items = [
      Promotion(
          name: "Black Friday Sale",
          type: "Store-wide",
          value: "20% OFF",
          validity: "Nov 24 - Nov 30"),
      Promotion(
          name: "BOGO Phones",
          type: "Product Specific",
          value: "Buy 1 Get 1",
          validity: "Dec 01 - Dec 15"),
      Promotion(
          name: "Welcome Coupon",
          type: "Voucher",
          value: "\$10.00 OFF",
          validity: "Permanent"),
    ];

    return Column(
      children: [
        const ZenoHeader(
          title: "Promotions & Discounts",
          subtitle:
              "Configure active offers, seasonal sales, and coupon codes.",
          actions: [
            _HeaderButton(
                label: "New Promotion",
                icon: Icons.campaign_outlined,
                isPrimary: true),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<Promotion>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Promotion Name",
                  builder: (p) => Text(p.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Type",
                  width: 150,
                  builder: (p) => Text(p.type,
                      style: const TextStyle(
                          fontSize: 13, color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Value",
                  width: 120,
                  builder: (p) =>
                      ZenoBadge(label: p.value, color: ZenoTheme.neonGreen),
                ),
                ZenoTableColumn(
                  label: "Validity",
                  width: 180,
                  builder: (p) =>
                      Text(p.validity, style: const TextStyle(fontSize: 12)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (p) => Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.analytics_outlined,
                              size: 16, color: ZenoTheme.accent),
                          onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 16),
                          onPressed: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;

  const _HeaderButton(
      {required this.label, required this.icon, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? ZenoTheme.accent : ZenoTheme.surface,
        foregroundColor: Colors.white,
      ),
    );
  }
}
