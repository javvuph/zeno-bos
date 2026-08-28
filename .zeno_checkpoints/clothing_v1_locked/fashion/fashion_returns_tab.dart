import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import '../../../controllers/product_studio_controller.dart';

class FashionReturnsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const FashionReturnsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ZenoCard(
        title: "🔄 RETURN & EXCHANGE HUB",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "INVOICE NUMBER", hint: "Scan or type invoice ID...")),
            const SizedBox(width: 12),
            ZenoButton(label: "LOAD INVOICE", variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () {}),
          ]),
          const SizedBox(height: 24),
          _buildItemRow("RETURNING: BLACK SHIRT L", "₹850.00", "REFUND"),
          const SizedBox(height: 12),
          _buildItemRow("EXCHANGING: BLUE JEANS 32", "₹1,200.00", "EXCHANGE FOR 34"),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "💰 SETTLEMENT",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          _summaryRow("TOTAL RETURN VALUE", "₹2,050.00"),
          _summaryRow("EXCHANGE VALUE", "₹1,200.00"),
          const Divider(),
          _summaryRow("NET REFUND DUE", "₹850.00", isTotal: true),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoButton(label: "REFUND TO STORE CREDIT", variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () {})),
            const SizedBox(width: 12),
            Expanded(child: ZenoButton(label: "REFUND TO ORIGINAL MODE", size: ZenoButtonSize.sm, onPressed: () {})),
          ]),
        ]),
      ),
    ]);
  }

  Widget _buildItemRow(String name, String price, String action) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8)), child: Row(children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)), Text(price, style: const TextStyle(fontSize: 9, color: Colors.grey))]), const Spacer(), Text(action, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF9333EA))), const SizedBox(width: 12), const Icon(Icons.chevron_right, size: 14)]));
  Widget _summaryRow(String l, String v, {bool isTotal = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(fontSize: 9, fontWeight: isTotal ? FontWeight.w900 : FontWeight.bold)), Text(v, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: isTotal ? const Color(0xFF9333EA) : null))]));
}
