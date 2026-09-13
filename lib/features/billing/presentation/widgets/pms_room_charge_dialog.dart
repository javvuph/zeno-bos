import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_button.dart';

class PmsRoomChargeDialog extends StatelessWidget {
  const PmsRoomChargeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return AlertDialog(
      backgroundColor: colors.bgTier2,
      title: const Text("PMS ROOM POST", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ZenoTextField(label: "ROOM NUMBER", hint: "Enter room number..."),
          const SizedBox(height: 16),
          ZenoTextField(label: "GUEST NAME", hint: "Enter guest name..."),
        ],
      ),
      actions: [
        ZenoButton(label: "Cancel", variant: ZenoButtonVariant.ghost, size: ZenoButtonSize.sm, onPressed: () => Navigator.of(context).pop()),
        ZenoButton(label: "VALIDATE \u0026 POST", size: ZenoButtonSize.sm, onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }
}
