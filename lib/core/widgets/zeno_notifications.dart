import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoNotifications {
  static void showToast(BuildContext context, String message,
      {bool isError = false}) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.toUpperCase(),
          style: ZenoTypography.micro(Colors.white)
              .copyWith(fontWeight: FontWeight.w900),
        ),
        backgroundColor: isError ? colors.statusDanger : colors.accentPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
        margin: const EdgeInsets.all(ZenoSpacing.md),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline_rounded,
                color: Colors.white, size: 16),
            const SizedBox(width: 12),
            Text(
              message.toUpperCase(),
              style: ZenoTypography.micro(Colors.white)
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        backgroundColor: colors.statusSuccess,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
        margin: const EdgeInsets.all(ZenoSpacing.md),
      ),
    );
  }
}
