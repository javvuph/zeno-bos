import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class DronesRoboticsSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const DronesRoboticsSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🚁 DRONES & ROBOTICS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "TAKEOFF WEIGHT (G)", initialValue: p.takeoffWeight, onChanged: (v) => controller.updateField(takeoffWeight: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "FLIGHT / RUNTIME", initialValue: p.flightTime, onChanged: (v) => controller.updateField(flightTime: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "TRANSMISSION RANGE", initialValue: p.transmissionRange, onChanged: (v) => controller.updateField(transmissionRange: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "REGISTRATION ID", initialValue: p.inspectionId, onChanged: (v) => controller.updateField(inspectionId: v))),
          ]),
          const SizedBox(height: 16),
          _toggle("OBSTACLE AVOIDANCE", p.obstacleAvoidance, (v) => controller.updateField(obstacleAvoidance: v)),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
