import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_header.dart';

import 'package:zeno/core/di/service_locator.dart';
import '../controllers/fnb_table_controller.dart';

class FnbTableManagementScreen extends StatefulWidget {
  const FnbTableManagementScreen({super.key});

  @override
  State<FnbTableManagementScreen> createState() => _FnbTableManagementScreenState();
}

class _FnbTableManagementScreenState extends State<FnbTableManagementScreen> {
  String activeFloor = "Floor 1";
  late FnbTableController controller;

  @override
  void initState() {
    super.initState();
    controller = FnbTableController(sl());
    controller.loadTables("FL-01"); // Default floor
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return ZenoWorkspace(
          header: ZenoHeader(
            title: "Table Management".toUpperCase(),
            subtitle: "LIVE FLOOR PLAN & SERVICE STATUS",
            titleSuffix: _buildFloorSelector(colors),
          ),
          body: Column(children: [
            _buildSectionTabs(colors),
            Expanded(child: controller.isLoading ? const Center(child: CircularProgressIndicator()) : _buildFloorPlan(colors)),
            _buildStatusLegend(colors),
          ]),
        );
      }
    );
  }

  Widget _buildFloorSelector(ZenoSemanticColors colors) => Row(mainAxisSize: MainAxisSize.min, children: ["Floor 1", "Rooftop", "Outdoor"].map((f) => Padding(padding: const EdgeInsets.only(left: 8), child: ChoiceChip(label: Text(f, style: const TextStyle(fontSize: 10)), selected: activeFloor == f, onSelected: (s) => setState(() => activeFloor = f), selectedColor: colors.accentPrimary.withValues(alpha: 0.2), backgroundColor: colors.bgTier3))).toList());
  
  Widget _buildSectionTabs(ZenoSemanticColors colors) => Container(height: 36, color: colors.bgTier2, child: Row(children: ["Main Hall", "Private Cabins", "Smoking Zone"].map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 16), alignment: Alignment.center, decoration: BoxDecoration(border: Border(bottom: BorderSide(color: s == "Main Hall" ? colors.accentPrimary : Colors.transparent, width: 2))), child: Text(s, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: s == "Main Hall" ? colors.accentPrimary : colors.textDisabled)))).toList()));

  Widget _buildFloorPlan(ZenoSemanticColors colors) => Container(color: colors.bgTier1, child: Stack(children: 
    controller.tables.isEmpty 
      ? [const Center(child: Text("NO TABLES CONFIGURED", style: TextStyle(fontSize: 10, color: Colors.grey)))]
      : controller.tables.map((t) => _TableWidget(label: t.tableNumber, x: t.posX, y: t.posY, status: t.status, capacity: t.capacity)).toList()
  ));

  Widget _buildStatusLegend(ZenoSemanticColors colors) => Container(height: 40, padding: const EdgeInsets.symmetric(horizontal: 20), decoration: BoxDecoration(color: colors.bgTier2, border: Border(top: BorderSide(color: colors.borderSubtle))), child: Row(children: [
    _legendItem(Colors.grey, "EMPTY"), _legendItem(Colors.amber, "RESERVED"), _legendItem(Colors.blue, "SEATED"),
    _legendItem(Colors.green, "ORDERED"), _legendItem(Colors.orange, "BILLED"), _legendItem(Colors.red, "OOS"),
  ]));

  Widget _legendItem(Color c, String l) => Row(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle)), const SizedBox(width: 6), Text(l, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), const SizedBox(width: 16)]);
}

class _TableWidget extends StatelessWidget {
  final String label, status; final double x, y; final int capacity; final bool isLarge;
  const _TableWidget({required this.label, required this.status, required this.x, required this.y, required this.capacity}) : isLarge = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    Color statusColor = status == "empty" ? Colors.grey : status == "ordered" ? Colors.green : status == "billed" ? Colors.orange : status == "preparing" ? Colors.blue : Colors.amber;
    return Positioned(left: x, top: y, child: InkWell(onTap: () {
      // Bridge: Open F&B Billing Screen for this table
      Navigator.pushNamed(
        context,
        'sales/fnb-billing',
        arguments: {'tableId': label, 'guestCount': capacity},
      );
    }, child: Container(width: isLarge ? 120 : 80, height: 80, decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(8), border: Border.all(color: statusColor, width: 2), boxShadow: [BoxShadow(color: statusColor.withValues(alpha: 0.1), blurRadius: 10)]), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
      Text("$capacity PAX", style: TextStyle(fontSize: 8, color: colors.textDisabled)),
      const SizedBox(height: 4),
      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)), child: Text(status.toUpperCase(), style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900, color: statusColor))),
    ]))));
  }
}
