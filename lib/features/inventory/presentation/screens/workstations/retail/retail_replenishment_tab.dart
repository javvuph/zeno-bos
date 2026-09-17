import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../../domain/services/replenishment_service.dart';

class RetailReplenishmentTab extends StatefulWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailReplenishmentTab({super.key, required this.controller, required this.colors});

  @override
  State<RetailReplenishmentTab> createState() => _RetailReplenishmentTabState();
}

class _RetailReplenishmentTabState extends State<RetailReplenishmentTab> {
  final ReplenishmentService _service = ReplenishmentService();
  double recommendedQty = 0;

  void _calculate() {
    setState(() {
      recommendedQty = _service.recommendOrderQuantity(
        currentStock: widget.controller.product.openingStock.toDouble(),
        avgDailySales: 12.5, // Mock historical data
        leadTimeDays: widget.controller.product.supplierLeadTime,
        safetyStock: widget.controller.product.safetyStock.toDouble(),
        moq: widget.controller.product.supplierMOQ,
        orderMultiple: widget.controller.product.caseMultiplier,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.controller.product;
    return Column(children: [
      ZenoCard(
        title: "🔄 REPLENISHMENT PARAMETERS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "REPLENISHMENT METHOD", value: "Min-Max", items: ["Min-Max", "Fixed Order Cycle", "Just-In-Time"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) {})),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MIN STOCK (SAFETY)", initialValue: p.safetyStock.toString(), onChanged: (v) => widget.controller.updateField(safetyStock: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MAX STOCK (CAPACITY)", initialValue: p.maxStock.toString(), onChanged: (v) => widget.controller.updateField(maxStock: int.tryParse(v)))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "REORDER TRIGGER LEVEL", initialValue: p.reorderLevel.toString(), onChanged: (v) => widget.controller.updateField(reorderLevel: double.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "ORDER MULTIPLE", initialValue: p.caseMultiplier.toString(), onChanged: (v) => widget.controller.updateField(caseMultiplier: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SUPPLIER LEAD TIME (DAYS)", initialValue: p.supplierLeadTime.toString(), onChanged: (v) => widget.controller.updateField(supplierLeadTime: int.tryParse(v)))),
          ]),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "📉 DEMAND & CALCULATED REPLENISHMENT",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            const Expanded(child: ZenoTextField(label: "AVG DAILY SALES (VELOCITY)", initialValue: "12.5", readOnly: true)),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "RECOMMENDED ORDER QTY", initialValue: recommendedQty.toString(), readOnly: true)),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            ZenoButton(label: "CALCULATE RECOMMENDATION", variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: _calculate),
            const SizedBox(width: 12),
            ZenoButton(label: "GENERATE PURCHASE REQUISITION", icon: Icons.add_shopping_cart, size: ZenoButtonSize.sm, onPressed: recommendedQty > 0 ? () {} : null),
          ]),
        ]),
      ),
    ]);
  }
}
