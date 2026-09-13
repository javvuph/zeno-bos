import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_button.dart';

import '../widgets/pms_room_charge_dialog.dart';

class FnbBillingScreen extends StatelessWidget {
  final String? tableId;
  final int? guestCount;
  
  const FnbBillingScreen({super.key, this.tableId, this.guestCount});

  @override
  Widget build(BuildContext context) {
    return ZenoWorkspace(
      header: ZenoHeader(
        title: "Table Billing: ${tableId ?? 'NEW ORDER'}".toUpperCase(),
        subtitle: "GUESTS: ${guestCount ?? 0} • STATION: MAIN KITCHEN",
        actions: [
          ZenoButton(label: "KOT", icon: Icons.restaurant_menu, variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () => _printKOT()),
          ZenoButton(label: "ROOM POST", icon: Icons.hotel, variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () => _showRoomCharge(context)),
          ZenoButton(label: "PRINT BILL", icon: Icons.print, size: ZenoButtonSize.sm, onPressed: () => _printBill()),
        ],
      ),
      body: const Center(child: Text("F&B Order Entry & Bill Items Flow (Integrated with KotEngine)")),
    );
  }

  void _printKOT() {
    // In a real implementation, this would use sl<IFnbPrinter>()
  }

  void _printBill() {
    // In a real implementation, this would use sl<IFnbPrinter>()
  }

  void _showRoomCharge(BuildContext context) {
    showDialog(context: context, builder: (context) => const PmsRoomChargeDialog());
  }
}
