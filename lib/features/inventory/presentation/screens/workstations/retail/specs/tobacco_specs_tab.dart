import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class TobaccoSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const TobaccoSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🚬 TOBACCO & STATUTORY WARNING",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "TOBACCO TYPE", value: p.apparelCategory.isEmpty ? null : p.apparelCategory, items: ["Cigarette", "Cigar", "Shisha", "Vape"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'apparelCategory', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "PACK SIZE", initialValue: p.packageType, onChanged: (v) => controller.updateFieldById(p, 'packageType', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "STICK COUNT", initialValue: p.unitsPerStrip.toString(), onChanged: (v) => controller.updateFieldById(p, 'unitsPerStrip', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "NICOTINE %", initialValue: p.nicotineContent, onChanged: (v) => controller.updateFieldById(p, 'nicotineContent', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "EXCISE ID / QR", initialValue: p.ssccBarcode, onChanged: (v) => controller.updateFieldById(p, 'ssccBarcode', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "REGULATORY CODE", initialValue: p.hallmarkCert, onChanged: (v) => controller.updateFieldById(p, 'hallmarkCert', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "MANUFACTURER", initialValue: p.manufacturerName, onChanged: (v) => controller.updateFieldById(p, 'manufacturerName', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "COUNTRY OF ORIGIN", initialValue: p.countryOfOrigin, onChanged: (v) => controller.updateFieldById(p, 'countryOfOrigin', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("MANDATORY AGE GATE", p.posAgeGate, (v) => controller.updateFieldById(p, 'posAgeGate', v)),
            const SizedBox(width: 24),
            _toggle("HEALTH WARNING VERIFIED", p.mtcRequired, (v) => controller.updateFieldById(p, 'mtcRequired', v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
