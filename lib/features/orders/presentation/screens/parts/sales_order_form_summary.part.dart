part of '../sales_order_form_screen.dart';

class _HeaderBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  final VoidCallback? onPressed;
  const _HeaderBtn(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.colors,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {},
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgSurface,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final ZenoSemanticColors colors;
  const _SummaryRow(
      {required this.label,
      required this.value,
      this.isBold = false,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: ZenoTypography.bodyMD(colors.textSecondary)),
          Text(value,
              style: ZenoTypography.bodyMD(colors.textPrimary).copyWith(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
