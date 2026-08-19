import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class GamingSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const GamingSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🎮 GAMING GEAR & CONSOLES",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "PLATFORM", value: p.gamingPlatform.isEmpty ? null : p.gamingPlatform, items: ["PS5", "Xbox", "Switch", "PC"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(gamingPlatform: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "EDITION", initialValue: p.gamingEdition, onChanged: (v) => controller.updateField(gamingEdition: v), hint: "e.g. Digital Edition")),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "STORAGE CAPACITY", initialValue: p.internalStorage, onChanged: (v) => controller.updateField(internalStorage: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CONTROLLER COUNT", initialValue: p.controllerCount.toString(), onChanged: (v) => controller.updateField(controllerCount: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "INCLUDED GAMES", initialValue: p.includedGames, onChanged: (v) => controller.updateField(includedGames: v))),
          ]),
        ]),
      ),
    ]);
  }
}
