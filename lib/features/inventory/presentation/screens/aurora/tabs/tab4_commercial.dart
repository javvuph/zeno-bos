import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import '../aurora_field_renderer.dart';

class Tab4Commercial extends StatelessWidget {
  final ProductStudioController controller;
  const Tab4Commercial({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // 04 COMMERCIAL Î“Ã‡Ã¶ Cost -> Price -> Discount -> Margin (ZERO-SCROLL)
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ROW 1: COST FLOW
          ZenoCard(
            title: "â‰¡Æ’Ã†â–‘ COST FLOW (Purchase Î“Ã¶Ã‡Î“Ã¶Ã‡Î“Ã»â•‘ Landed)",
            padding: const EdgeInsets.all(12),
            child: AuroraFieldRenderer(
              controller: controller,
              fieldIds: const [
                "purchaseCost", "contractCost", "freight", "duty", "insurance", "handling", "landedCost"
              ],
              
            ),
          ),
          const SizedBox(height: 16),
          
          // ROW 2: SELLING PRICE
          ZenoCard(
            title: "â‰¡Æ’Ã†â•¡ SELLING PRICE",
            padding: const EdgeInsets.all(12),
            child: AuroraFieldRenderer(
              controller: controller,
              fieldIds: const [
                "mrp", "regularPrice", "sellingPrice", "priceFloorLock", "wholesalePrice"
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ROW 3: DISCOUNT & PROMOTION
          ZenoCard(
            title: "â‰¡Æ’Ã…â•–âˆ©â••Ã… DISCOUNT & PROMOTION",
            padding: const EdgeInsets.all(12),
            child: AuroraFieldRenderer(
              controller: controller,
              fieldIds: const [
                "discountType", "discountValue", "promoPrice", "promoStartDate", "promoEndDate", "promoType"
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ROW 4: LIVE COMMERCIAL RESULT (Metric Strip)
          _buildLiveResultStrip(context),
        ],
      ),
    );
  }

  Widget _buildLiveResultStrip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _ResultItem(label: "LANDED COST", value: "Î“Ã©â•£ 84.50", color: Colors.white),
          _ResultItem(label: "SELLING PRICE", value: "Î“Ã©â•£ 120.00", color: Color(0xFF38BDF8)),
          _ResultItem(label: "DISCOUNT", value: "10% / Î“Ã©â•£ 12", color: Color(0xFFFB7185)),
          _ResultItem(label: "PROFIT", value: "Î“Ã©â•£ 23.50", color: Color(0xFF4ADE80)),
          _ResultItem(label: "GROSS MARGIN", value: "18.4%", color: Color(0xFF4ADE80)),
          _ResultItem(label: "MARKUP", value: "22%", color: Color(0xFF4ADE80)),
        ],
      ),
    );
  }
}

class _ResultItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _ResultItem({required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Color(0xFF94A3B8), letterSpacing: 1.0)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: color, fontFamily: 'JetBrainsMono')),
      ],
    );
  }
}
