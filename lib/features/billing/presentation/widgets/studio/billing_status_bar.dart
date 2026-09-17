import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_status_bar.dart';
import 'package:zeno/core/widgets/zeno_status.dart';

class BillingStatusBar extends StatelessWidget {
  const BillingStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return ZenoStatusBar(
      leftActions: const [
        ZenoStatusBarIndicator(
            icon: Icons.home_filled, label: "SHIFT: MORNING"),
        ZenoStatusBarIndicator(
            icon: Icons.account_balance_wallet, label: "DRAWER: OPEN"),
        ZenoStatusDot(label: "PRINTER", isActive: true),
        ZenoStatusDot(label: "SCANNER", isActive: true),
        ZenoStatusDot(label: "SCALE", isActive: true),
        ZenoStatusDot(label: "INTERNET", isActive: true),
      ],
      rightActions: [
        const ZenoStatusDot(label: "CLOUD SYNC", isActive: true),
        Icon(Icons.wb_sunny_outlined, size: 12, color: colors.textDisabled),
      ],
    );
  }
}
