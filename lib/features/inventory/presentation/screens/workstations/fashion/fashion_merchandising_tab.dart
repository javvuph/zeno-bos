import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

class FashionMerchandisingTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const FashionMerchandisingTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "📅 SEASONAL COLLECTION & LAUNCH",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "SEASON", value: p.season, items: ["Spring", "Summer", "Autumn", "Winter", "Festive"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(season: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "COLLECTION NAME", initialValue: p.collectionEdition, onChanged: (v) => controller.updateField(collectionEdition: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _datePicker("LAUNCH DATE", p.launchDate, (d) => controller.updateField(launchDate: d))),
            const SizedBox(width: 12),
            Expanded(child: _datePicker("DISCONTINUE DATE", p.discontinueDate, (d) => controller.updateField(discontinueDate: d))),
          ]),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "🏷️ MERCHANDISING STATUS",
        padding: const EdgeInsets.all(16),
        child: Wrap(spacing: 24, runSpacing: 16, children: [
          _toggle("CORE PRODUCT (STAPLE)", true, (v) {}),
          _toggle("SEASONAL PRODUCT", p.seasonalProduct, (v) => controller.updateField(seasonalProduct: v)),
          _toggle("NEW ARRIVAL FLAG", true, (v) {}),
          _toggle("MANDATORY CLEARANCE", false, (v) {}),
        ]),
      ),
    ]);
  }

  Widget _datePicker(String l, DateTime? v, ValueChanged<DateTime?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Text(v == null ? "Select Date" : "${v.day}/${v.month}/${v.year}", style: const TextStyle(fontSize: 11)), const Spacer(), const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey)])))]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
