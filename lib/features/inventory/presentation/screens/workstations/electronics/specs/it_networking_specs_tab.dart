import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class ItNetworkingSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ItNetworkingSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🌐 IT & NETWORKING GEAR",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "DEVICE TYPE", value: p.networkingDeviceType.isEmpty ? null : p.networkingDeviceType, items: ["Router", "Switch", "Access Point", "Firewall"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(networkingDeviceType: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "PORT CONFIGURATION", initialValue: p.portConfig, onChanged: (v) => controller.updateField(portConfig: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "WIRELESS BANDWIDTH", initialValue: p.wirelessBandwidth, onChanged: (v) => controller.updateField(wirelessBandwidth: v))),
            const SizedBox(width: 12),
            _toggle("PoE SUPPORT", p.poeSupported, (v) => controller.updateField(poeSupported: v)),
            const SizedBox(width: 12),
            _toggle("RACK MOUNTABLE", p.rackMountable, (v) => controller.updateField(rackMountable: v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
