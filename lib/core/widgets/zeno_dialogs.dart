import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';

class ZenoDialogs {
  static Future<bool?> showConfirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = "Confirm",
    String cancelLabel = "Cancel",
    bool isDangerous = false,
  }) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.bgTier1,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.lg)),
        title: Text(
          title.toUpperCase(),
          style: ZenoTypography.headlineSM(colors.textPrimary)
              .copyWith(fontWeight: FontWeight.w900),
        ),
        content: Text(
          message,
          style: ZenoTypography.bodyLG(colors.textSecondary),
        ),
        actions: [
          ZenoButton(
            label: cancelLabel,
            variant: ZenoButtonVariant.ghost,
            onPressed: () => Navigator.pop(context, false),
          ),
          ZenoButton(
            label: confirmLabel,
            variant: isDangerous
                ? ZenoButtonVariant.danger
                : ZenoButtonVariant.primary,
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  static void showInfo({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.bgTier1,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.lg)),
        title: Text(
          title.toUpperCase(),
          style: ZenoTypography.headlineSM(colors.textPrimary)
              .copyWith(fontWeight: FontWeight.w900),
        ),
        content: Text(
          message,
          style: ZenoTypography.bodyLG(colors.textSecondary),
        ),
        actions: [
          ZenoButton(
            label: "Got it",
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
