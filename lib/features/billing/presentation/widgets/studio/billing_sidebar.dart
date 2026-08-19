import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_action_rail.dart';

class BillingSidebar extends StatelessWidget {
  const BillingSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return ZenoActionRail(
      sections: [
        ZenoActionRailSection(
          title: "CUSTOMERS",
          items: [
            ZenoActionRailItem(
              icon: Icons.person_add_rounded,
              label: "Add Customer",
              hint: "F2",
              color: const Color(0xFF10B981),
              onTap: () {},
            ),
            ZenoActionRailItem(
              icon: Icons.stars_rounded,
              label: "Loyalty Program",
              hint: "F3",
              color: const Color(0xFF8B5CF6),
              onTap: () {},
            ),
            ZenoActionRailItem(
              icon: Icons.wallet_rounded,
              label: "Customer Wallet",
              hint: "F4",
              color: const Color(0xFF3B82F6),
              onTap: () {},
            ),
          ],
        ),
        ZenoActionRailSection(
          title: "TOOLS",
          items: [
            ZenoActionRailItem(
              icon: Icons.qr_code_scanner_rounded,
              label: "Barcode Scan",
              hint: "F6",
              color: const Color(0xFF3B82F6),
              onTap: () {},
            ),
            ZenoActionRailItem(
              icon: Icons.pause_circle_filled_rounded,
              label: "Hold Bill",
              hint: "F7",
              color: const Color(0xFFEF4444),
              onTap: () {},
            ),
            ZenoActionRailItem(
              icon: Icons.calculate_rounded,
              label: "Calculator",
              hint: "F8",
              color: const Color(0xFF10B981),
              onTap: () {},
            ),
            ZenoActionRailItem(
              icon: Icons.percent_rounded,
              label: "Add Discount",
              hint: "F9",
              color: const Color(0xFFF59E0B),
              onTap: () {},
            ),
            ZenoActionRailItem(
              icon: Icons.print_rounded,
              label: "Print Receipt",
              hint: "F11",
              color: const Color(0xFF6366F1),
              onTap: () {},
            ),
            ZenoActionRailItem(
              icon: Icons.settings_remote_rounded,
              label: "Open Drawer",
              hint: "F12",
              color: const Color(0xFFF97316),
              onTap: () {},
            ),
            ZenoActionRailItem(
              icon: Icons.more_horiz_rounded,
              label: "More Tools",
              color: Colors.grey,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
