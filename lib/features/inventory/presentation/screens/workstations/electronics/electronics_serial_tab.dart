import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../controllers/registries/electronics_config.dart';

class ElectronicsSerialTab extends StatefulWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final ElectronicsCategoryConfig config;
  const ElectronicsSerialTab({super.key, required this.controller, required this.colors, required this.config});

  @override
  State<ElectronicsSerialTab> createState() => _ElectronicsSerialTabState();
}

class _ElectronicsSerialTabState extends State<ElectronicsSerialTab> {
  final TextEditingController _bulkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ZenoCard(
        title: "🔢 BULK SERIAL / IMEI ENTRY",
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("PASTE OR SCAN MULTIPLE SERIALS (Comma or Line Separated)", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 12),
          ZenoTextField(controller: _bulkController, maxLines: 5, hint: "Serial1, Serial2, Serial3..."),
          const SizedBox(height: 12),
          ZenoButton(label: "PROCESS & NORMALIZE", icon: Icons.auto_fix_high_rounded, variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () {}),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "📦 UNIT TRACKING LIST",
        padding: const EdgeInsets.all(0),
        child: Column(children: [
          _buildHeader(),
          const SizedBox(height: 100, child: Center(child: Text("No units scanned yet", style: TextStyle(fontSize: 10, color: Colors.grey)))),
        ]),
      ),
    ]);
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: widget.colors.bgTier3, border: Border(bottom: BorderSide(color: widget.colors.borderSubtle))),
      child: Row(children: [
        const Expanded(flex: 1, child: Text("UNIT #", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))),
        const Expanded(flex: 3, child: Text("SERIAL NUMBER", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))),
        if (widget.config.requiresImei) ...[
          const Expanded(flex: 3, child: Text("IMEI 1", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))),
          const Expanded(flex: 3, child: Text("IMEI 2", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))),
        ],
        const Expanded(flex: 2, child: Text("STATUS", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))),
        const Expanded(flex: 1, child: Text("ACTION", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))),
      ]),
    );
  }
}
