import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';

class FnbKdsScreen extends StatelessWidget {
  final String station;
  const FnbKdsScreen({super.key, this.station = "Main Kitchen"});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ZenoWorkspace(
      header: ZenoHeader(
        title: "$station Display".toUpperCase(),
        subtitle: "LIVE KITCHEN PRODUCTION QUEUE",
        actions: [
          Row(children: [
            const Text("AUTO-REFRESH", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Transform.scale(scale: 0.6, child: Switch(value: true, onChanged: (v) {}, activeThumbColor: colors.accentPrimary)),
          ]),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.8),
        itemCount: 6,
        itemBuilder: (context, i) => _KdsTicket(colors: colors, index: i),
      ),
    );
  }
}

class _KdsTicket extends StatelessWidget {
  final ZenoSemanticColors colors; final int index;
  const _KdsTicket({required this.colors, required this.index});

  @override
  Widget build(BuildContext context) {
    bool isUrgent = index == 0;
    return ZenoCard(
      title: "ORDER #104${index + 1}",
      padding: EdgeInsets.zero,
      titleColor: isUrgent ? Colors.red : null,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(color: isUrgent ? Colors.red.withValues(alpha: 0.1) : colors.bgTier3, padding: const EdgeInsets.all(8), child: Row(children: [Text("TABLE T-0${index+1}", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900)), const Spacer(), Text("${index * 3 + 5}m", style: TextStyle(fontSize: 9, color: isUrgent ? Colors.red : colors.textDisabled))])),
        Expanded(child: ListView(padding: const EdgeInsets.all(12), children: [
          _itemRow("2x Margherita Pizza", "Extra Cheese"),
          _itemRow("1x Garlic Bread", "No Herbs"),
          _itemRow("3x Coke 300ml", ""),
        ])),
        _buildActions(),
      ]),
    );
  }

  Widget _itemRow(String n, String m) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(n, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), if (m.isNotEmpty) Text(m, style: const TextStyle(fontSize: 9, color: Colors.orange, fontWeight: FontWeight.w900))]));
  
  Widget _buildActions() => Row(children: [
    Expanded(child: InkWell(onTap: () {}, child: Container(height: 36, color: Colors.blue.withValues(alpha: 0.1), alignment: Alignment.center, child: const Text("PREPARE", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.blue))))),
    Expanded(child: InkWell(onTap: () {}, child: Container(height: 36, color: Colors.green.withValues(alpha: 0.1), alignment: Alignment.center, child: const Text("READY", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.green))))),
  ]);
}
