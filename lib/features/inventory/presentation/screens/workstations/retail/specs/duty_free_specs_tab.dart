import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class DutyFreeSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const DutyFreeSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "✈️ TRAVEL & CUSTOMS VERIFICATION",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "TRAVEL RETAIL CATEGORY", initialValue: p.importDutyClass, onChanged: (v) => controller.updateFieldById(p, 'importDutyClass', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "COUNTRY RESTRICTIONS", initialValue: p.countryRestrictions, onChanged: (v) => controller.updateFieldById(p, 'countryRestrictions', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "BASE CURRENCY", value: p.currency, items: ["USD", "EUR", "AED", "INR"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'currency', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "DUTY-FREE ALLOWANCE CLASS", initialValue: p.taxJurisdiction, onChanged: (v) => controller.updateFieldById(p, 'taxJurisdiction', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CUSTOMS REFERENCE", initialValue: p.complianceId, onChanged: (v) => controller.updateFieldById(p, 'complianceId', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "TRAVEL RETAIL PRICE", initialValue: p.onlinePrice.toString(), onChanged: (v) => controller.updateFieldById(p, 'onlinePrice', v), prefix: const Text("\$"))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("REQUIRE PASSPORT SCAN", p.passportVerificationRequired, (v) => controller.updateFieldById(p, 'passportVerificationRequired', v)),
            const SizedBox(width: 24),
            _toggle("REQUIRE BOARDING PASS SCAN", p.flightNumberRequired, (v) => controller.updateFieldById(p, 'flightNumberRequired', v)),
            const SizedBox(width: 24),
            Expanded(child: ZenoTextField(label: "PASSENGER ELIGIBILITY", initialValue: p.targetAudience, onChanged: (v) => controller.updateFieldById(p, 'targetAudience', v))),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
