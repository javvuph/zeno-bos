part of '../payroll_dashboard_screen.dart';

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final ZenoSemanticColors colors;
  const _SummaryItem(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: ZenoSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: ZenoTypography.micro(colors.textDisabled)),
            const SizedBox(height: 2),
            Text(value,
                style: ZenoTypography.headlineMD(colors.textPrimary)
                    .copyWith(fontWeight: FontWeight.w900)),
          ],
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final ZenoSemanticColors colors;
  const _FilterChip(
      {required this.label,
      required this.count,
      this.isSelected = false,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: ZenoSpacing.md, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected
            ? colors.accentPrimary.withValues(alpha: 0.1)
            : colors.bgTier3,
        borderRadius: BorderRadius.circular(ZenoRadius.md),
        border: Border.all(
            color: isSelected
                ? colors.accentPrimary.withValues(alpha: 0.3)
                : colors.borderSubtle),
      ),
      child: Row(
        children: [
          Text(label,
              style: ZenoTypography.micro(
                  isSelected ? colors.accentPrimary : colors.textSecondary)),
          const SizedBox(width: 8),
          Text(count.toString(),
              style: ZenoTypography.micro(
                      isSelected ? colors.accentPrimary : colors.textDisabled)
                  .copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _PayrollButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  final VoidCallback? onPressed;
  const _PayrollButton(
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
      label: Text(label.toUpperCase(),
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String month;
  final String amount;
  final String status;
  final ZenoSemanticColors colors;
  const _HistoryItem(
      {required this.month,
      required this.amount,
      required this.status,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPayslipDialog(context, month),
      child: Container(
        margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
        padding: const EdgeInsets.all(ZenoSpacing.md),
        decoration: BoxDecoration(
          color: colors.bgTier3,
          borderRadius: BorderRadius.circular(ZenoRadius.md),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Row(
          children: [
            Icon(Icons.history_edu_outlined,
                size: 14, color: colors.textDisabled),
            const SizedBox(width: 12),
            Text(month,
                style: ZenoTypography.bodyMD(colors.textPrimary)
                    .copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text(amount,
                style: ZenoTypography.bodyMD(colors.textPrimary)
                    .copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(width: 24),
            Text(status,
                style: ZenoTypography.micro(colors.statusSuccess)
                    .copyWith(fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  void _showPayslipDialog(BuildContext context, String month) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.bgTier2,
        title: Text("PAYSLIP: $month",
            style: ZenoTypography.headlineSM(colors.textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PayslipLine(
                label: "BASIC SALARY", value: "\$2,500.00", colors: colors),
            _PayslipLine(
                label: "HOUSE RENT ALLOWANCE",
                value: "\$500.00",
                colors: colors),
            _PayslipLine(
                label: "SPECIAL ALLOWANCE", value: "\$500.00", colors: colors),
            const Divider(),
            _PayslipLine(
                label: "GROSS EARNINGS",
                value: "\$3,500.00",
                isBold: true,
                colors: colors),
            const SizedBox(height: 12),
            _PayslipLine(
                label: "PROFESSIONAL TAX",
                value: "(\$200.00)",
                colors: colors,
                color: colors.statusDanger),
            _PayslipLine(
                label: "INCOME TAX (TDS)",
                value: "(\$300.00)",
                colors: colors,
                color: colors.statusDanger),
            const Divider(),
            _PayslipLine(
                label: "NET DISBURSEMENT",
                value: "\$3,000.00",
                isBold: true,
                colors: colors,
                color: colors.statusSuccess),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CLOSE")),
          ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.print),
              label: const Text("PRINT")),
        ],
      ),
    );
  }
}

class _PayslipLine extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? color;
  final ZenoSemanticColors colors;

  const _PayslipLine(
      {required this.label,
      required this.value,
      this.isBold = false,
      this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: ZenoTypography.micro(colors.textSecondary)),
          Text(value,
              style: ZenoTypography.bodyMD(color ?? colors.textPrimary)
                  .copyWith(
                      fontWeight: isBold ? FontWeight.w900 : FontWeight.bold)),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final ZenoSemanticColors colors;
  const _ActionBtn({required this.label, required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colors.borderSubtle),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ZenoRadius.md)),
        ),
        child: Text(label,
            style: ZenoTypography.caption(colors.accentPrimary)
                .copyWith(fontWeight: FontWeight.w900, letterSpacing: 1)),
      ),
    );
  }
}

class _AIActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final ZenoSemanticColors colors;
  const _AIActionCard(
      {required this.title, required this.icon, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(ZenoRadius.lg),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: colors.accentPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 20, color: colors.accentPrimary),
          ),
          const SizedBox(width: ZenoSpacing.md),
          Expanded(
              child: Text(title.toUpperCase(),
                  style: ZenoTypography.caption(colors.textPrimary)
                      .copyWith(fontWeight: FontWeight.w900))),
          Icon(Icons.chevron_right, size: 14, color: colors.textDisabled),
        ],
      ),
    );
  }
}
