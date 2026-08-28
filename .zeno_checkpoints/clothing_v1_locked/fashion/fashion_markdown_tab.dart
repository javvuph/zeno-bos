import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import '../../../controllers/product_studio_controller.dart';

class FashionMarkdownTab extends StatefulWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const FashionMarkdownTab({super.key, required this.controller, required this.colors});

  @override
  State<FashionMarkdownTab> createState() => _FashionMarkdownTabState();
}

class _FashionMarkdownTabState extends State<FashionMarkdownTab> {
  double discountPct = 30;
  DateTime effectiveDate = DateTime.now().add(const Duration(days: 15));
  String status = "DRAFT";

  Future<void> _propose() async {
    final p = widget.controller.product;
    await widget.controller.markdownApproval.proposeMarkdown(
      productId: p.id,
      currentPrice: p.sellingPrice,
      proposedPrice: p.sellingPrice * (1 - discountPct / 100),
      discountPct: discountPct,
      effectiveDate: effectiveDate,
      requestedBy: "CURRENT_USER",
      reason: "End of Season Clearance",
    );
    setState(() {
      status = "PENDING_APPROVAL";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ZenoCard(
        title: "📉 MARKDOWN & CLEARANCE SCHEDULING",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "MARKDOWN EVENT", value: "End of Season", items: ["End of Season", "Flash Sale", "Clearance", "Defective Stock"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) {})),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "DISCOUNT %", initialValue: discountPct.toString(), onChanged: (v) => setState(() => discountPct = double.tryParse(v) ?? 0), suffix: const Text("%"))),
            const SizedBox(width: 12),
            Expanded(child: _datePicker("EFFECTIVE DATE", effectiveDate, (d) => setState(() => effectiveDate = d ?? effectiveDate))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("APPLY TO ALL STORES", true, (v) {}),
            const SizedBox(width: 24),
            Text("STATUS: $status", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: status == "PENDING_APPROVAL" ? Colors.orange : Colors.grey)),
            const Spacer(),
            ZenoButton(label: "SUBMIT FOR APPROVAL", size: ZenoButtonSize.sm, onPressed: status == "DRAFT" ? _propose : null),
          ]),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "📦 AGING INVENTORY DETECTION",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          _agingRow("PARENT STYLE: ${widget.controller.product.title}", 120, "CRITICAL"),
          const Divider(),
          _agingRow("TOTAL AGING STOCK", 450, "HIGH"),
        ]),
      ),
    ]);
  }

  Widget _agingRow(String name, int days, String risk) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(children: [Text(name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)), const Spacer(), Text("$days DAYS IN STOCK", style: const TextStyle(fontSize: 9)), const SizedBox(width: 16), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: risk == "CRITICAL" ? Colors.red : Colors.orange, borderRadius: BorderRadius.circular(4)), child: Text(risk, style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w900)))]));
  Widget _datePicker(String l, DateTime? v, ValueChanged<DateTime?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: widget.colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: widget.colors.borderSubtle)), child: Row(children: [Text(v == null ? "Select Date" : "${v.day}/${v.month}/${v.year}", style: const TextStyle(fontSize: 11)), const Spacer(), const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey)])))]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: widget.colors.accentPrimary))]);
}
