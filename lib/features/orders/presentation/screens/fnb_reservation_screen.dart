import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_button.dart';

import 'package:zeno/core/di/service_locator.dart';
import '../controllers/fnb_reservation_controller.dart';

class FnbReservationScreen extends StatefulWidget {
  const FnbReservationScreen({super.key});

  @override
  State<FnbReservationScreen> createState() => _FnbReservationScreenState();
}

class _FnbReservationScreenState extends State<FnbReservationScreen> {
  late FnbReservationController controller;

  @override
  void initState() {
    super.initState();
    controller = FnbReservationController(sl());
    controller.loadReservations(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return ZenoWorkspace(
          header: ZenoHeader(
            title: "Table Reservations".toUpperCase(),
            subtitle: "ADVANCE BOOKING & CAPACITY MANAGEMENT",
            actions: [
              ZenoButton(label: "NEW RESERVATION", icon: Icons.add, size: ZenoButtonSize.sm, onPressed: () {}),
            ],
          ),
          body: Row(children: [
            Expanded(flex: 3, child: _buildCalendarView(colors)),
            const VerticalDivider(width: 1),
            Expanded(flex: 2, child: _buildReservationList(colors)),
          ]),
        );
      }
    );
  }

  Widget _buildCalendarView(ZenoSemanticColors colors) => Container(color: colors.bgTier1, child: Column(children: [
    Padding(padding: const EdgeInsets.all(16), child: Row(children: [Text("AUGUST 2026", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900)), const Spacer(), IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {}), IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {})])),
    Expanded(child: GridView.builder(padding: const EdgeInsets.all(16), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, childAspectRatio: 1.2), itemCount: 31, itemBuilder: (context, i) => _DateCell(day: i + 1, colors: colors))),
  ]));

  Widget _buildReservationList(ZenoSemanticColors colors) => Container(color: colors.bgTier2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(padding: const EdgeInsets.all(16), child: Text("SCHEDULE FOR ${controller.selectedDate.day}/${controller.selectedDate.month}", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1))),
    Expanded(child: controller.reservations.isEmpty 
      ? const Center(child: Text("NO RESERVATIONS", style: TextStyle(fontSize: 10, color: Colors.grey)))
      : ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: controller.reservations.length, itemBuilder: (context, i) {
          final r = controller.reservations[i];
          return _resItem(colors, r.customerName, "${r.startTime.hour}:${r.startTime.minute}", r.guestCount, r.tableId ?? 'TBA', r.status);
        })),
  ]));

  Widget _resItem(ZenoSemanticColors colors, String n, String t, int p, String tbl, String s) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: colors.bgTier1, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(n, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text("$t • $p PAX • $tbl", style: TextStyle(fontSize: 9, color: colors.textDisabled))]), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: s == "Confirmed" ? Colors.green.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)), child: Text(s.toUpperCase(), style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: s == "Confirmed" ? Colors.green : Colors.orange)))]));
}

class _DateCell extends StatelessWidget {
  final int day; final ZenoSemanticColors colors;
  const _DateCell({required this.day, required this.colors});
  @override
  Widget build(BuildContext context) => Container(margin: const EdgeInsets.all(4), decoration: BoxDecoration(border: Border.all(color: colors.borderSubtle), borderRadius: BorderRadius.circular(4), color: day == 15 ? colors.accentPrimary.withValues(alpha: 0.1) : null), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("$day", style: TextStyle(fontSize: 12, fontWeight: day == 15 ? FontWeight.w900 : FontWeight.bold)), if (day % 3 == 0) Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))]));
}
