import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/core/widgets/zeno_action_rail.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/dialogs/billing_action_dialogs.dart';

class BillingSidebar extends StatelessWidget {
  const BillingSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BillingStudioController>();
    return ZenoActionRail(
      sections: [
        ZenoActionRailSection(title: "CUSTOMERS", items: [
          ZenoActionRailItem(icon: Icons.person_add_rounded, label: "Add Customer", hint: "F2", color: const Color(0xFF10B981), onTap: () => BillingActionDialogs.addCustomer(context)),
          ZenoActionRailItem(icon: Icons.stars_rounded, label: "Loyalty Program", hint: "F3", color: const Color(0xFF8B5CF6), onTap: () => BillingActionDialogs.loyalty(context)),
          ZenoActionRailItem(icon: Icons.wallet_rounded, label: "Customer Wallet", hint: "F4", color: const Color(0xFF3B82F6), onTap: () => BillingActionDialogs.wallet(context)),
        ]),
        ZenoActionRailSection(title: "TOOLS", items: [
          ZenoActionRailItem(icon: Icons.qr_code_scanner_rounded, label: "Barcode Scan", hint: "F6", color: const Color(0xFF3B82F6), onTap: () => BillingActionDialogs.scanner(context)),
          ZenoActionRailItem(icon: Icons.pause_circle_filled_rounded, label: "Hold Bill", hint: "F7", color: const Color(0xFFEF4444), onTap: () => controller.add(BillHoldRequested())),
          ZenoActionRailItem(icon: Icons.calculate_rounded, label: "Calculator", hint: "F8", color: const Color(0xFF10B981), onTap: () => BillingActionDialogs.calculator(context)),
          ZenoActionRailItem(icon: Icons.percent_rounded, label: "Add Discount", hint: "F9", color: const Color(0xFFF59E0B), onTap: () => BillingActionDialogs.discount(context)),
          ZenoActionRailItem(icon: Icons.print_rounded, label: "Print Receipt", hint: "F11", color: const Color(0xFF6366F1), onTap: () => BillingActionDialogs.printReceipt(context)),
          ZenoActionRailItem(icon: Icons.settings_remote_rounded, label: "Open Drawer", hint: "F12", color: const Color(0xFFF97316), onTap: () => BillingActionDialogs.drawer(context)),
          ZenoActionRailItem(icon: Icons.more_horiz_rounded, label: "More Tools", color: Colors.grey, onTap: () => showModalBottomSheet(context: context, builder: (_) => SafeArea(child: Wrap(children: [
            ListTile(leading: const Icon(Icons.undo), title: const Text('Undo'), onTap: () { controller.add(UndoRequested()); Navigator.pop(context); }),
            ListTile(leading: const Icon(Icons.redo), title: const Text('Redo'), onTap: () { controller.add(RedoRequested()); Navigator.pop(context); }),
            ListTile(leading: const Icon(Icons.lock), title: const Text('Toggle Bill Lock'), onTap: () { controller.add(LockBillRequested(!controller.state.activeBill.isLocked)); Navigator.pop(context); }),
            ListTile(leading: const Icon(Icons.delete_sweep), title: const Text('Clear Cart'), onTap: () { controller.add(ClearCartRequested()); Navigator.pop(context); }),
          ]))),
        ]),
      ],
    );
  }
}
