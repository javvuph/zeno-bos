import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class BillingStatusBar extends StatelessWidget {
  const BillingStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg),
      decoration: BoxDecoration(
        color: colors.bgTier4,
        border: Border(top: BorderSide(color: colors.borderSubtle, width: 0.5)),
      ),
      child: Row(
        children: [
          _buildStatusIndicator('SYSTEM READY', colors.statusSuccess, colors),
          const VerticalDivider(width: 32, indent: 10, endIndent: 10),
          _buildInfoItem(Icons.wifi, 'CLOUD SYNC ACTIVE', colors),
          const SizedBox(width: ZenoSpacing.lg),
          _buildInfoItem(Icons.update, 'LAST SYNC: 2m AGO', colors),
          const Spacer(),
          _buildKeyboardHints(colors),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(
      String label, Color color, ZenoSemanticColors colors) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
      IconData icon, String label, ZenoSemanticColors colors) {
    return Row(
      children: [
        Icon(icon, size: 12, color: colors.textDisabled),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
              color: colors.textDisabled,
              fontSize: 9,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildKeyboardHints(ZenoSemanticColors colors) {
    return Row(
      children: [
        _Hint('F2', 'Cust', colors),
        _Hint('F4', 'Hold', colors),
        _Hint('F10', 'Cash', colors),
        _Hint('F11', 'Card', colors),
        _Hint('↲', 'Pay', colors),
      ],
    );
  }
}

class _Hint extends StatelessWidget {
  final String keyLabel;
  final String actionLabel;
  final ZenoSemanticColors colors;

  const _Hint(this.keyLabel, this.actionLabel, this.colors);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: ZenoSpacing.md),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: keyLabel,
              style: TextStyle(
                  color: colors.accentPrimary,
                  fontSize: 9,
                  fontWeight: FontWeight.w900),
            ),
            const TextSpan(text: ' '),
            TextSpan(
              text: actionLabel.toUpperCase(),
              style: TextStyle(
                  color: colors.textDisabled,
                  fontSize: 9,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
